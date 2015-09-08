Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40637 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbbIHVHg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Sep 2015 17:07:36 -0400
Date: Tue, 8 Sep 2015 14:07:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 2/9] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20150908210730.GA16357@roeck-us.net>
References: <1440876758-28047-1-git-send-email-linux@roeck-us.net>
 <1440876758-28047-3-git-send-email-linux@roeck-us.net>
 <20150908103325.GS14598@pengutronix.de>
 <55EEE6EE.90808@roeck-us.net>
 <20150908200332.GX14598@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150908200332.GX14598@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 08, 2015 at 10:03:32PM +0200, Uwe Kleine-König wrote:
> Hello Guenter,
> 
> On Tue, Sep 08, 2015 at 06:47:26AM -0700, Guenter Roeck wrote:
> > On 09/08/2015 03:33 AM, Uwe Kleine-König wrote:
> > >Hello,
> > >
> > 
> > >>[...]
> > >>+static long watchdog_next_keepalive(struct watchdog_device *wdd)
> > >>+{
> > >>+	unsigned int hw_timeout_ms = wdd->timeout * 1000;
> > >>+	unsigned long keepalive_interval;
> > >>+	unsigned long last_heartbeat;
> > >>+	unsigned long virt_timeout;
> > >>+
> > >>+	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(hw_timeout_ms);
> > >
> > >Just looking at this line this is wrong. It just happens to be correct
> > >here because hw_timeout_ms non-intuitively is set to wdd->timeout * 1000
> > >which might not reflect what is programmed into the hardware.
> > >
> > I don't see where the code is wrong. Sure, the variable name doesn't match
> > its initial use, but that doesn't make it wrong. I can pick a different variable
> > name if that helps (any suggested name ?).
> > 
> > >I'd write:
> > >
> > >	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(wdd->timeout * 1000);
> > >
> > >...
> > >
> > >>+	if (hw_timeout_ms > wdd->max_hw_timeout_ms)
> > >>+		hw_timeout_ms = wdd->max_hw_timeout_ms;
> > >
> > >	hw_timeout_ms = min(wdd->timeout * 1000, wdd->max_hw_timeout_ms);
> > >
> > 
> > The reason for writing the code as is was to avoid the double 'wdd->timeout * 1000'
> 
> The compile should be able to cope with that and only do the
> multiplication once.
> 
You sure ? msecs_to_jiffies() can be an external function.
I always thought that the compiler must not make such context
assumptions across function calls.

> > (and to avoid a line > 80 columns in the first line).
> 
> unsigned timeout_ms = wdd->timeout * 1000; ?
> 
Fine with me.

> > 
> > >>[...]
> > >>@@ -61,26 +143,27 @@ static struct watchdog_device *old_wdd;
> > >>
> > >>  static int watchdog_ping(struct watchdog_device *wdd)
> > >>  {
> > >>-	int err = 0;
> > >>+	int err;
> > >>
> > >>  	mutex_lock(&wdd->lock);
> > >>+	wdd->last_keepalive = jiffies;
> > >>+	err = _watchdog_ping(wdd);
> > >>+	watchdog_update_worker(wdd, false);
> > >
> > >Here the cancel argument could also be true, right? That's because after
> > >a ping (that doesn't modify the timeout) the result of
> > >watchdog_need_worker doesn't change and so either the worker isn't
> > >running + stopping it again doesn't hurt, or the timer is running and so
> > >it's not tried to be stopped.
> > >
> > Could, but it isn't necessary.
> > 
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
> > >>+	watchdog_update_worker(wdd, false);
> > >
> > >Here for the same reason you could pass true. So there is no caller that
> > >needs to pass false which allows to simplify the function. (i.e. drop
> > >the cancel parameter and simplify it assuming cancel is true)
> > >
> > 
> > There will be another call with 'false' added with a later patch, though
> > that could live with 'true'.
> > 
> > The function is executed by the worker, and since it is already executing
> > canceling it would not be necessary.
> > 
> > I don't know what happens if an attempt is made to cancel a worker from its
> > work function. I seem to recall that it causes a stall, but I may be wrong.
> > Any idea ?
> 
> No, I don't know if that works or not. But I would not expect any
> problems.
> 
I'll give it a try.

> > >>  	mutex_unlock(&wdd->lock);
> > >>-	return err;
> > >>  }
> > >>
> > >>  /*
> > >>[...]
> > >>@@ -119,8 +134,9 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
> > >>  /* Use the following function to check if a timeout value is invalid */
> > >>  static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
> > >>  {
> > >>-	return ((wdd->max_timeout != 0) &&
> > >>-		(t < wdd->min_timeout || t > wdd->max_timeout));
> > >
> > >Is this (old) code correct? watchdog_timeout_invalid returns false if
> > >wdd->max_timeout == 0 && t < wdd->min_timeout. I would have expected:
> > >
> > >	return (wdd->max_timeout != 0 && t > wdd->max_timeout) ||
> > >		t < wdd->min_timeout;
> > >
> > You are correct. However, that is a different problem, which I addressed in
> > 'watchdog: Always evaluate new timeout against min_timeout'.
> 
> I usually consider it nice to have the fixes first in the series. I
> didn't look into the later patches yet. This should be fixed for 4.3.
> 
Not sure if it is a fix. It does change semantics, after all.
No problems reordering the sequence, though.

> > >>+	return t > UINT_MAX / 1000 ||
> > >>+		(!wdd->max_hw_timeout_ms && wdd->max_timeout &&
> > >>+		 (t < wdd->min_timeout || t > wdd->max_timeout));
> > >
> > >So should this better be:
> > >
> > >	/* internal calculation is done in ms using unsigned variables */
> > >	if (t > UINT_MAX / 1000)
> > >		return 1;
> > >
> > >	/*
> > >	 * compat code for drivers not being aware of framework pings to
> > >	 * bridge timeouts longer than supported by the hardware.
> > >	 */
> > >	if (!wdd->max_hw_timeout && wdd->max_timeout && t > wdd->max_timeout)
> > >		return 1;
> > >
> > >	if (t < wdd->min_timeout)
> > >		return 1;
> > >
> > 
> > After all patches are applied, my code is
> > 
> > /* Use the following function to check if a timeout value is invalid */
> > static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
> > {
> >         return t > UINT_MAX / 1000 || t < wdd->min_timeout ||
> >                 (!wdd->max_hw_timeout_ms && wdd->max_timeout &&
> >                  t > wdd->max_timeout);
> > }
> > 
> > which is exactly the same (without the comments).
> 
> The comments make it a tad nicer though :-)
> 
POV :-) I prefer to have a single expression. How about adding
the comments on top of it ? Would that be ok with you ?

Thanks,
Guenter
