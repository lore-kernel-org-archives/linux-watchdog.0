Return-Path: <wsa@the-dreams.de>
Return-path: <wsa@the-dreams.de>
Date: Sun, 9 Dec 2018 17:36:32 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [RFC] watchdog: renesas_wdt: don't keep timer value during
 suspend/resume
Message-ID: <20181209163632.GB1673@kunai>
References: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
 <476b6d6c-657d-7e10-d0a8-a7aafe61eae9@roeck-us.net>
 <20181207214528.GA2853@kunai>
 <eb86c5d7-ab13-df05-0d0f-9dad811a6a98@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb86c5d7-ab13-df05-0d0f-9dad811a6a98@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> > I can relate to the policy argument, though. Regardless of this patch, I
> > wonder if we can make it configurable from userspace. A draft:
> > 
> > #define	WDIOF_RESUME_OPTS	0x0800
> > 
> > #define	WDIOS_RESUME_KEEP	0x0008
> > #define	WDIOS_RESUME_RESET	0x0010
> > 
> > and then in watchdog_ioctl() under WDIOC_SETOPTIONS:
> > 
> > 	if (!(wdd->info->options & WDIOF_RESUME_OPTS))
> > 		err = -EOPNOTSUPP;
> > 		goto break;
> > 
> > 	if (val & WDIOS_RESUME_KEEP)
> > 		wdd->status |= WDOG_KEEP_TIMER_WHEN_RESUME;
> > 
> > 	if (val & WDIOS_RESUME_RESET)
> > 		wdd->status ~= ~WDOG_KEEP_TIMER_WHEN_RESUME;
> > 
> > So, drivers with WDIOF_RESUME_OPTS could act on the
> > WDOG_KEEP_TIMER_WHEN_RESUME flag.
> > 
> > Opinions?
> > 
> 
> Not entirely sure I understand the use case.

Well, as I mentioned before, I can understand the "isn't this policy?"
question from Fabrizio. Would be good to hear his opinion on this.

> Having said that, if we were to add this option, I think only a single
> flag would be needed - WDIOF_RESUME_KEEP. All we need to do is declare
> that a ping on resume shall be the default. Anything else would result
> in undefined per-driver default behavior.

I would very much love that. To be honest, I thought we already are in
the undefined per-driver behaviour; this is why I added two flags, to
not cause regressions. Declaring a default would be a great first step
IMHO, and then we can build the WDIOF_RESUME_KEEP option on top of it,
if needed. But for clarity, the first step seems to be a good idea in
any case, I'd say.

Thanks,

   Wolfram
