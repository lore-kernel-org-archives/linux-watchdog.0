Return-Path: <wsa@the-dreams.de>
Return-path: <wsa@the-dreams.de>
Date: Fri, 7 Dec 2018 22:45:29 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [RFC] watchdog: renesas_wdt: don't keep timer value during
 suspend/resume
Message-ID: <20181207214528.GA2853@kunai>
References: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
 <476b6d6c-657d-7e10-d0a8-a7aafe61eae9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <476b6d6c-657d-7e10-d0a8-a7aafe61eae9@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter, all,

> > After discussing this mail thread [1] again, we concluded that giving
> > userspace enough time to prepare is our favourite option. So, do not
> > keep the time value when suspended but reset it when resuming.
> > 
> > [1] https://patchwork.kernel.org/patch/10252209/
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Above exchange says it all, no need to repeat.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks.

I can relate to the policy argument, though. Regardless of this patch, I
wonder if we can make it configurable from userspace. A draft:

#define	WDIOF_RESUME_OPTS	0x0800

#define	WDIOS_RESUME_KEEP	0x0008
#define	WDIOS_RESUME_RESET	0x0010

and then in watchdog_ioctl() under WDIOC_SETOPTIONS:

	if (!(wdd->info->options & WDIOF_RESUME_OPTS))
		err = -EOPNOTSUPP;
		goto break;

	if (val & WDIOS_RESUME_KEEP)
		wdd->status |= WDOG_KEEP_TIMER_WHEN_RESUME;

	if (val & WDIOS_RESUME_RESET)
		wdd->status ~= ~WDOG_KEEP_TIMER_WHEN_RESUME;

So, drivers with WDIOF_RESUME_OPTS could act on the
WDOG_KEEP_TIMER_WHEN_RESUME flag.

Opinions?

Thanks,

   Wolfram
