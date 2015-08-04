Return-path: <ukl@pengutronix.de>
Date: Tue, 4 Aug 2015 17:52:20 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de
Subject: Re: [PATCH 2/8] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20150804155220.GV9999@pengutronix.de>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <1438654414-29259-3-git-send-email-linux@roeck-us.net>
 <20150804121816.GM9999@pengutronix.de>
 <55C0DADF.9050505@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55C0DADF.9050505@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Aug 04, 2015 at 08:31:43AM -0700, Guenter Roeck wrote:
> Hi Uwe,
> 
> On 08/04/2015 05:18 AM, Uwe Kleine-König wrote:
> >On Mon, Aug 03, 2015 at 07:13:28PM -0700, Guenter Roeck wrote:
> >>Introduce an optional hardware maximum timeout in the watchdog core.
> >>The hardware maximum timeout can be lower than the maximum timeout.
> >Is this only until all drivers are converted to make use of the central
> >worker? Otherwise this doesn't make sense, right?
> >
> >>Drivers can set the maximum hardare timeout value in the watchdog data
> >s/hardare/hardware/
> >
> Always those fat fingers ;-)
> 
> >>structure. If the configured timeout exceeds half the value of the
> >>maximum hardware timeout, the watchdog core enables a timer function
> >>to assist sending keepalive requests to the watchdog driver.
> >I don't understand why you want to halve the maximum hw-timeout. If my
> >watchdog has hw-max-timeout = 5s and userspace sets it to 3s there
> >should be no need for assistance?! I think the implementation is the
> >other way round?
> >
> It is supposed to reflect the _maximum_ timeout. That is different to
> the time between heartbeats, which is supposed to be less; using half
> the value of the maximum hardware timeout seemed to be a safe number.
Right, I got that. With hw-max-timeout = 5s the machine resets after 5s
not caring for the device. And so pinging repeatedly after 2.5s is fine.
But if userspace sets a timeout of 3s (probably with the intention to
ping with a frequency of 1/1.5s) there is no need for worker-assistance,
because the pings coming in each 1.5s provided by userspace are good
enough.

> >>+static inline bool watchdog_need_worker(struct watchdog_device *wdd)
> >>+{
> >>+	unsigned int hm = wdd->max_hw_timeout_ms;
> >>+	unsigned int m = wdd->max_timeout * 1000;
> >>+
> >>+	return watchdog_active(wdd) && hm && hm != m &&
> >>+		wdd->timeout * 500 > hm;
> >
> >I don't understand what max_timeout is now that there is max_hw_timeout.
> >So I don't understand why you need hm != m either.
> >
> 
> Backward compatibility. A driver which does not set max_hw_timeout_ms,
> or sets both to the same value, by definition expects to handle everything
> internally, and thus no worker is configured.
And a driver that does

	max_timeout = 5
	max_hw_timeout = 5125

falls through the cracks.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
