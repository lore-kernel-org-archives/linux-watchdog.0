Return-Path: <wimvs@spo001.leaseweb.com>
Date: Tue, 29 Oct 2013 17:36:21 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: Watchdog patches - overview.
Message-ID: <20131029163621.GD5261@spo001.leaseweb.com>
References: <20131029090458.GN19704@spo001.leaseweb.com> <20131029091139.GA20422@spo001.leaseweb.com> <20131029162143.GD9266@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131029162143.GD9266@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> > > 2) patches that I am reviewing or are on my radar:
> > > w83627hf-patches
> > > Orion-patches
> > > f81865_gpio.c
> > > [PATCH V2 0/4] Add watchdog DT nodes and parse it to read PMU registers addresses (Exynos+s3c2410_wdt)
> > > [PATCH v4 4/4] ARM: bcm4760: Add restart hook
> > > [PATCH] Documentation/watchdog: Update node name in samsung-wdt example
> > 
> > And also:
> > [PATCH v3] Enhanced support for MPC8xx/8xxx watchdog
> 
> I had not reviewed on this one, as I think that such enhancements
> should really start with a conversion to the watchdog infrastructure.
> That is just my personal opinion, of course.

I think the enhancement might be worthwhile, but not in it's present form.
I agree that it would be nice to have the conversion also, but it's two seperate things for the moment..

Kind regards,
Wim.
