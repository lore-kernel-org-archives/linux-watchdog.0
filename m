Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59600 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbIIH7R (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Sep 2015 03:59:17 -0400
Date: Wed, 9 Sep 2015 09:59:12 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 2/9] watchdog: Introduce hardware maximum timeout in
 watchdog core
Message-ID: <20150909075912.GE14598@pengutronix.de>
References: <1440876758-28047-1-git-send-email-linux@roeck-us.net>
 <1440876758-28047-3-git-send-email-linux@roeck-us.net>
 <20150908103325.GS14598@pengutronix.de>
 <55EEE6EE.90808@roeck-us.net>
 <20150908200332.GX14598@pengutronix.de>
 <20150908210730.GA16357@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150908210730.GA16357@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Guenter,

On Tue, Sep 08, 2015 at 02:07:30PM -0700, Guenter Roeck wrote:
> On Tue, Sep 08, 2015 at 10:03:32PM +0200, Uwe Kleine-König wrote:
> > On Tue, Sep 08, 2015 at 06:47:26AM -0700, Guenter Roeck wrote:
> > > On 09/08/2015 03:33 AM, Uwe Kleine-König wrote:
> > > >>+	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(hw_timeout_ms);
> > > >
> > > >Just looking at this line this is wrong. It just happens to be correct
> > > >here because hw_timeout_ms non-intuitively is set to wdd->timeout * 1000
> > > >which might not reflect what is programmed into the hardware.
> > > >
> > > I don't see where the code is wrong. Sure, the variable name doesn't match
> > > its initial use, but that doesn't make it wrong. I can pick a different variable
> > > name if that helps (any suggested name ?).

As there are two different semantics for the variable there is no good
name.

> > > 
> > > >I'd write:
> > > >
> > > >	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(wdd->timeout * 1000);
> > > >
> > > >...
> > > >
> > > >>+	if (hw_timeout_ms > wdd->max_hw_timeout_ms)
> > > >>+		hw_timeout_ms = wdd->max_hw_timeout_ms;
> > > >
> > > >	hw_timeout_ms = min(wdd->timeout * 1000, wdd->max_hw_timeout_ms);
> > > >
> > > 
> > > The reason for writing the code as is was to avoid the double 'wdd->timeout * 1000'
> > 
> > The compile should be able to cope with that and only do the
> > multiplication once.
> > 
> You sure ? msecs_to_jiffies() can be an external function.
> I always thought that the compiler must not make such context
> assumptions across function calls.

The function with the helper variable timeout_ms looks as follows:

	unsigned timeout_ms = wdd->timeout * 1000;
	unsigned long virt_timeout;

	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(timeout_ms);

	hw_timeout_ms = min(timeout_ms, wdd->max_hw_timeout_ms);

	...

so there is nothing done twice even in the source code. And otherwise
msecs_to_jiffies is inlined (alternatively it should be marked const).

> > > >>  	mutex_unlock(&wdd->lock);
> > > >>-	return err;
> > > >>  }
> > > >>
> > > >>  /*
> > > >>[...]
> > > >>@@ -119,8 +134,9 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
> > > >>  /* Use the following function to check if a timeout value is invalid */
> > > >>  static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
> > > >>  {
> > > >>-	return ((wdd->max_timeout != 0) &&
> > > >>-		(t < wdd->min_timeout || t > wdd->max_timeout));
> > > >
> > > >Is this (old) code correct? watchdog_timeout_invalid returns false if
> > > >wdd->max_timeout == 0 && t < wdd->min_timeout. I would have expected:
> > > >
> > > >	return (wdd->max_timeout != 0 && t > wdd->max_timeout) ||
> > > >		t < wdd->min_timeout;
> > > >
> > > You are correct. However, that is a different problem, which I addressed in
> > > 'watchdog: Always evaluate new timeout against min_timeout'.
> > 
> > I usually consider it nice to have the fixes first in the series. I
> > didn't look into the later patches yet. This should be fixed for 4.3.
> > 
> Not sure if it is a fix. It does change semantics, after all.
Right, fixing bugs usually introduces changes :-)

> > > >>+	return t > UINT_MAX / 1000 ||
> > > >>+		(!wdd->max_hw_timeout_ms && wdd->max_timeout &&
> > > >>+		 (t < wdd->min_timeout || t > wdd->max_timeout));
> > > >
> > > >So should this better be:
> > > >
> > > >	/* internal calculation is done in ms using unsigned variables */
> > > >	if (t > UINT_MAX / 1000)
> > > >		return 1;
> > > >
> > > >	/*
> > > >	 * compat code for drivers not being aware of framework pings to
> > > >	 * bridge timeouts longer than supported by the hardware.
> > > >	 */
> > > >	if (!wdd->max_hw_timeout && wdd->max_timeout && t > wdd->max_timeout)
> > > >		return 1;
> > > >
> > > >	if (t < wdd->min_timeout)
> > > >		return 1;
> > > >
> > > 
> > > After all patches are applied, my code is
> > > 
> > > /* Use the following function to check if a timeout value is invalid */
> > > static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
> > > {
> > >         return t > UINT_MAX / 1000 || t < wdd->min_timeout ||
> > >                 (!wdd->max_hw_timeout_ms && wdd->max_timeout &&
> > >                  t > wdd->max_timeout);
> > > }
> > > 
> > > which is exactly the same (without the comments).
> > 
> > The comments make it a tad nicer though :-)
> > 
> POV :-) I prefer to have a single expression. How about adding
> the comments on top of it ? Would that be ok with you ?

With separate expressions for each case the comments are attached to the
right line respectively which makes it more readable. For you while
writing the code it doesn't make much difference, but for someone who
should understand the code later it's easier to have several easy
expressions than a single more complicated one.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
