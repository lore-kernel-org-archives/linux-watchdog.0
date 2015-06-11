Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52908 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbbFKQis (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Jun 2015 12:38:48 -0400
Date: Thu, 11 Jun 2015 09:38:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fu Wei <fu.wei@linaro.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Subject: Re: [PATCH v5 4/8] Watchdog: introdouce "pretimeout" into framework
Message-ID: <20150611163843.GA23656@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1433943713-32466-1-git-send-email-fu.wei@linaro.org>
 <1433943713-32466-5-git-send-email-fu.wei@linaro.org>
 <5578641E.1060209@roeck-us.net>
 <CADyBb7uzf0CUop5q9V2xmzmNvxPr8b+OEaV-0GxjmVvxKvRCeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7uzf0CUop5q9V2xmzmNvxPr8b+OEaV-0GxjmVvxKvRCeA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jun 11, 2015 at 07:22:44PM +0800, Fu Wei wrote:
> Hi Guenter,
> 
[ ... ]
> 
> > value we are trying to set. Effectively the above accepts every pretimeout
> > if wdd->pretimeout is 0. It also accepts every pretimeout if
> > max_pretimeout == 0, even if wdd->timeout is set and t >= wdd->timeout.
> >
> > Try
> >
> >         return (wdd->max_pretimeout && (t < wdd->min_pretimeout ||
> >                                         t > wdd->max_pretimeout)) ||
> >                 (wdd->timeout && t >= wdd->timeout);
> >
> >>   }
> 
> /*
>  * Use the following function to check if a pretimeout value is invalid.
>  * It can be "0", that means we don't use pretimeout.
>  * This function returns 0, when pretimeout is 0.

returns false if pretimeout is 0.

>  */
> static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
>                            unsigned int t)
> {
>     return t && (wdd->max_pretimeout &&
>         (t < wdd->min_pretimeout || t > wdd->max_pretimeout)) ||
>            (wdd->timeout && t >= wdd->timeout);
> }
> 
Makes sense. Be careful with (), though. This evaluates to

	return t && (...) || (wdd->timeout && t >= wdd->timeout);

but it should probably be
	return t && ((...) || (wdd->timeout && t >= wdd->timeout));

That doesn't make a difference in practice (if t == 0, it is never >= timeout
if timeout is > 0), but it would be a bit cleaner.

> 
> >>
> >>   /* Use the following functions to manipulate watchdog driver specific
> >> data */
> >> @@ -132,11 +153,20 @@ static inline void *watchdog_get_drvdata(struct
> >> watchdog_device *wdd)
> >>   }
> >>
> >>   /* drivers/watchdog/watchdog_core.c */
> >> -extern int watchdog_init_timeout(struct watchdog_device *wdd,
> >> -                                 unsigned int timeout_parm, struct device
> >> *dev);
> >> +int watchdog_init_timeouts(struct watchdog_device *wdd,
> >> +                                 unsigned int pretimeout_parm,
> >> +                                 unsigned int timeout_parm,
> >> +                                 struct device *dev);
> >
> >
> > Please align continuation lines with '('.
> 
> Fixed , thanks
> 
> >
> >
> >>   extern int watchdog_register_device(struct watchdog_device *);
> >>   extern void watchdog_unregister_device(struct watchdog_device *);
> >>
> >> +static inline int watchdog_init_timeout(struct watchdog_device *wdd,
> >> +                                       unsigned int timeout_parm,
> >> +                                       struct device *dev)
> >> +{
> >> +       return watchdog_init_timeouts(wdd, 0, timeout_parm, dev);
> >> +}
> >> +
> >>   #ifdef CONFIG_HARDLOCKUP_DETECTOR
> >>   void watchdog_nmi_disable_all(void);
> >>   void watchdog_nmi_enable_all(void);
> >>
> >
> 
> 
> 
> -- 
> Best regards,
> 
> Fu Wei
> Software Engineer
> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
> Ph: +86 21 61221326(direct)
> Ph: +86 186 2020 4684 (mobile)
> Room 1512, Regus One Corporate Avenue,Level 15,
> One Corporate Avenue,222 Hubin Road,Huangpu District,
> Shanghai,China 200021
