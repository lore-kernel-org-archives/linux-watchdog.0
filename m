Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56695 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbbKWVzY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 16:55:24 -0500
Date: Mon, 23 Nov 2015 13:55:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 1/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20151123215519.GB28794@roeck-us.net>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-2-git-send-email-linux@roeck-us.net>
 <20151123075304.GA5369@pengutronix.de>
 <56533B80.4030400@roeck-us.net>
 <20151123182608.GA19888@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20151123182608.GA19888@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On Mon, Nov 23, 2015 at 07:26:08PM +0100, Uwe Kleine-König wrote:
> Hello Guenter,
> 
> On Mon, Nov 23, 2015 at 08:14:56AM -0800, Guenter Roeck wrote:
> > On 11/22/2015 11:53 PM, Uwe Kleine-König wrote:
> > >On Sun, Nov 22, 2015 at 07:20:58PM -0800, Guenter Roeck wrote:
> > >>@@ -160,7 +176,11 @@ they are supported. These optional routines/operations are:
> > >>    and -EIO for "could not write value to the watchdog". On success this
> > >>    routine should set the timeout value of the watchdog_device to the
> > >>    achieved timeout value (which may be different from the requested one
> > >>-  because the watchdog does not necessarily has a 1 second resolution).
> > >>+  because the watchdog does not necessarily have a 1 second resolution).
> > >>+  Drivers implementing hw_max_timeout_ms set the hardware watchdog timeout
> > >>+  to the minimum of timeout and hw_max_timeout_ms. Those drivers set the
> > >
> > >Actually this is something that the wdg core could abstract for drivers.
> > >Oh well, apart from hw_max_timeout_ms having ms accuracy.
> > >
> > Not that sure. about the abstraction. The actual timeout to set depends on
> > the hardware, and may have an unknown granularity. The watchdog core can
> 
> What I wanted to say is that the driver core can do (ignoring scaling
> due to different units):
> 
> 	if (timeout > wdd->hw_max_timeout_ms)
> 		wdd->set_timeout(wdd->hw_max_timeout_ms);
> 	else
> 		wdd->set_timeout(timeout)
> 
> So that the device specific driver can assume that timeout passed to its
> set_timeout callback is always less than or equal to hw_max_timeout_ms.
> And so it doesn't need to compare against hw_max_timeout_ms again.
> 
I catually tried that at some point, but gave up since it ended up adding a lot
of complexity.

Problem is that the set_timeout function in the driver code sets wdd->timeout
based on the parameter it receives, and it can be different from both 'timeout'
and wdd->hw_max_timeout_ms. On top of that, we have to deal with the changed
units, which would either require a different callback function or we would
have to change all drivers to milli-seconds.

I would prefer to get the patchset accepted, and then someone can spend time
trying to clean this up further.

> > not predict what that granularity would be. We can play with it, and try
> > if it can be done, but I really would like this to be a separate patch.
> > 
> > hw_max_timeout is in ms because some watchdogs have a very low maximum
> > HW timeout.
> > 
> > >>+  timeout value of the watchdog_device either to the requested timeout value
> > >>+  (if it is larger than hw_max_timeout_ms), or to the achieved timeout value.
> > >>    (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
> > >>    watchdog's info structure).
> > >>  * get_timeleft: this routines returns the time that's left before a reset.
> > >>diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> > >>index 56a649e66eb2..1dba3f57dba3 100644
> > >>--- a/drivers/watchdog/watchdog_dev.c
> > >>+++ b/drivers/watchdog/watchdog_dev.c
> > >>[...]
> > >>+static long watchdog_next_keepalive(struct watchdog_device *wdd)
> > >>+{
> > >>+	unsigned int timeout_ms = wdd->timeout * 1000;
> > >>+	unsigned long keepalive_interval;
> > >>+	unsigned long last_heartbeat;
> > >>+	unsigned long virt_timeout;
> > >>+	unsigned int hw_timeout_ms;
> > >>+
> > >>+	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(timeout_ms);
> > >
> > >I think it's sensible to store
> > >
> > >	last_keepalive + timeout
> > >
> > >(i.e. the expected expiration time) in struct watchdog_device instead of
> > >last_keepalive. This moves the (maybe expensive) calculation to a
> > >context that has userspace interaction anyhow. On the other hand this
> > >complicates the set_timeout call. Hmm.
> > >
> > 
> > I would rather keep the code simple. It is not as if this is called
> > all the time. Also, I need last_keepalive later in the series
> > to determine if the minimum timeout between hardware pings has elapsed,
> > so we would need both.
> 
> I'm not sure my suggestion improves the situation, but I will keep my
> idea in mind and check once the dust settled.
> 
> > >>+	hw_timeout_ms = min(timeout_ms, wdd->max_hw_timeout_ms);
> > >>+	keepalive_interval = msecs_to_jiffies(hw_timeout_ms / 2);
> > >>+
> > >>+	/*
> > >>+	 * To ensure that the watchdog times out wdd->timeout seconds
> > >>+	 * after the most recent ping from userspace, the last
> > >>+	 * worker ping has to come in hw_timeout_ms before this timeout.
> > >>+	 */
> > >>+	last_heartbeat = virt_timeout - msecs_to_jiffies(hw_timeout_ms);
> > >>+	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
> > >>+}
> > >>[...]
> > >>@@ -61,26 +137,25 @@ static struct watchdog_device *old_wdd;
> > >>
> > >>  static int watchdog_ping(struct watchdog_device *wdd)
> > >>  {
> > >>-	int err = 0;
> > >>+	int err;
> > >>
> > >>  	mutex_lock(&wdd->lock);
> > >>+	wdd->last_keepalive = jiffies;
> > >>+	err = _watchdog_ping(wdd);
> > >>+	mutex_unlock(&wdd->lock);
> > >>
> > >>-	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
> > >>-		err = -ENODEV;
> > >>-		goto out_ping;
> > >>-	}
> > >>+	return err;
> > >>+}
> > >>
> > >>-	if (!watchdog_active(wdd))
> > >>-		goto out_ping;
> > >>+static void watchdog_ping_work(struct work_struct *work)
> > >>+{
> > >>+	struct watchdog_device *wdd;
> > >>
> > >>-	if (wdd->ops->ping)
> > >>-		err = wdd->ops->ping(wdd);	/* ping the watchdog */
> > >>-	else
> > >>-		err = wdd->ops->start(wdd);	/* restart watchdog */
> > >>+	wdd = container_of(to_delayed_work(work), struct watchdog_device, work);
> > >>
> > >>-out_ping:
> > >>+	mutex_lock(&wdd->lock);
> > >>+	_watchdog_ping(wdd);
> > >>  	mutex_unlock(&wdd->lock);
> > >>-	return err;
> > >
> > >Calling this function might come after last_keepalive + timeout in which
> > >case the watchdog shouldn't be pinged.
> > >
> > Unless the code is wrong, the last time this function is called should be
> > at (timeout - max_hw_timeout), ie well before the timeout elapsed.
> > Given that, I don't think this is something to be concerned about.
> 
> Depends on max_hw_timeout and the load of the machine if that can
> happen. And thinking again, if the ping didn't come in until
> last_keepalive + timeout, the machine is reset anyhow ...
> 
If the worker (which is, after all, running at high priority) doesn't
get time to run by the time the watchdog expires, the system is really in
bad trouble. And, yes, you are right, if the watchdog is working we should
never hit that situation to start with.

Thanks,
Guenter
