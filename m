Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55122 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbbKWVsW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 16:48:22 -0500
Date: Mon, 23 Nov 2015 13:48:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] watchdog: Introduce WDOG_RUNNING flag
Message-ID: <20151123214818.GA28794@roeck-us.net>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
 <1448248865-21684-3-git-send-email-linux@roeck-us.net>
 <20151123192606.GB19888@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20151123192606.GB19888@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 23, 2015 at 08:26:06PM +0100, Uwe Kleine-König wrote:
> Hello Guenter,
> 
> On Sun, Nov 22, 2015 at 07:20:59PM -0800, Guenter Roeck wrote:
> > diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> > index b535b02b1d7f..f0292d56caf0 100644
> > --- a/include/linux/watchdog.h
> > +++ b/include/linux/watchdog.h
> > @@ -108,6 +108,7 @@ struct watchdog_device {
> >  #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
> >  #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
> >  #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
> > +#define WDOG_RUNNING		5	/* True if HW watchdog running */
> >  	/* the following variables are for internal use only */
> >  	struct mutex lock;
> >  	unsigned long last_keepalive;
> > @@ -124,6 +125,12 @@ static inline bool watchdog_active(struct watchdog_device *wdd)
> >  	return test_bit(WDOG_ACTIVE, &wdd->status);
> >  }
> >  
> > +/* Use the following function to check whether or not the watchdog is running */
> 
> I'd like to have this comment more clear to distinguish between device
> state and userspace view. Maybe also call the flag WDOG_HW_RUNNING to
> make this more clear?
> 
Sure, I can make it WDOG_HW_RUNNING and watchdog_hw_running()
and clarify the comment.

Thanks,
Guenter
