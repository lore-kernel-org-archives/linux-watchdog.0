Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35963 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab3H2DTm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Aug 2013 23:19:42 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so4039713qcq.15
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Aug 2013 20:19:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130821195502.GA815@spo001.leaseweb.com>
References: <1368536872-2189-1-git-send-email-21cnbao@gmail.com> <20130821195502.GA815@spo001.leaseweb.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 29 Aug 2013 11:19:21 +0800
Message-ID: <CAGsJ_4xHf43sWTD4SUG-PX4yhS2ntXFDj0r43aaHtNpN4W_zbA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: sirf: add watchdog driver of CSR SiRFprimaII
 and SiRFatlasVI
To: Wim Van Sebroeck <wim@iguana.be>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>,
	Xianglong Du <Xianglong.Du@csr.com>,
	Barry Song <Baohua.Song@csr.com>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

thanks for reviewing. xianglong, will you do some update according to
Wim's comments.

> >
> > +config SIRFSOC_WATCHDOG
> > +     tristate "SiRFSOC watchdog"
> > +     depends on ARCH_SIRF
>
> You are missing a:
>         select WATCHDOG_CORE
> here.

ok. it was done by changing defconfig:
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_CORE=y
but we can move to your solution.

> > +
> > +
> > +static unsigned int default_timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT;
> > +module_param(default_timeout, uint, 0);
> > +MODULE_PARM_DESC(default_timeout, "Default watchdog timeout (in seconds)");
>
> Preferred module parameter name is timeout .
>

ok.

> > +static unsigned int sirfsoc_wdt_gettimeleft(struct watchdog_device *wdd)
> > +{
> > +     u32 counter, match;
> > +     int time_left;
> > +
> > +     counter = readl(watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_COUNTER_LO);
> > +     match = readl(watchdog_get_drvdata(wdd) +
> > +             SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
> > +
> > +     if (match >= counter) {
> > +             time_left = match-counter;
> > +     } else {
> > +             /* rollover */
> > +             time_left = (0xffffffffUL - counter) + match;
> > +     }
>
> should be:
>         if (match >= counter)
>                 time_left = match-counter;
>         else
>                 /* rollover */
>                 time_left = (0xffffffffUL - counter) + match;
>
> according to coding style.

yes. need fix.

>
> > +
> > +     return time_left / CLOCK_TICK_RATE;
> > +}
> > +
> > +static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
> > +{
> > +     u32 counter, timeout_ticks;
> > +
> > +     timeout_ticks = wdd->timeout * CLOCK_TICK_RATE;
> > +
> > +     /* Enable the latch before reading the LATCH_LO register */
> > +     writel(1, watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_LATCH);
> > +
> > +     /* Set the TO value */
> > +     counter = readl(watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_LATCHED_LO);
> > +
> > +     if ((0xffffffffUL - counter) >= timeout_ticks) {
> > +             counter += timeout_ticks;
> > +     } else {
> > +             /* Rollover */
> > +             counter = timeout_ticks - (0xffffffffUL - counter);
> > +     }
>
> Same here (coding style).

agree.

>
> > +     writel(counter, watchdog_get_drvdata(wdd) +
> > +             SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
> > +
> > +     return 0;
> > +}
> > +
> > +static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
> > +{
> > +     sirfsoc_wdt_updatetimeout(wdd);
> > +
> > +     /*
> > +      * NOTE: If interrupt is not enabled
> > +      * then WD-Reset doesn't get generated at all.
> > +      */
> > +     writel(readl(watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_INT_EN)
> > +             | (1 << SIRFSOC_TIMER_WDT_INDEX),
> > +             watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_INT_EN);
> > +     writel(1, watchdog_get_drvdata(wdd) + SIRFSOC_TIMER_WATCHDOG_EN);
>
> Wouldn't it be better to define a local variable first that get's the value
> of watchdog_get_drvdata(wdd)? This would definitely improve readability.
> Goes also for other functions (like sirfsoc_wdt_gettimeleft and
> sirfsoc_wdt_disable).
>

ok

> > +
> > +static int sirfsoc_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
> > +{
> > +     if (to < SIRFSOC_WDT_MIN_TIMEOUT)
> > +             to = SIRFSOC_WDT_MIN_TIMEOUT;
> > +     if (to > SIRFSOC_WDT_MAX_TIMEOUT)
> > +             to = SIRFSOC_WDT_MAX_TIMEOUT;
>
> Hmm, since SIRFSOC_WDT_MIN_TIMEOUT and SIRFSOC_WDT_MAX_TIMEOUT are defined:
> setting the timeout will call watchdog_set_timeout and that function will do a:
> if (watchdog_timeout_invalid(wddev, timeout))
>                 return -EINVAL;
>
> with watchdog_timeout_invalid returning:
>         ((wdd->max_timeout != 0) && (t < wdd->min_timeout || t > wdd->max_timeout));
>
> So this will never happen...

so we will drop this.

>
>
> > +     wdd->timeout = to;
> > +     sirfsoc_wdt_updatetimeout(wdd);
> > +
> > +     return 0;
> > +}
> > +
> > +#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
> > +
> > +static const struct watchdog_info sirfsoc_wdt_ident = {
> > +     .options          =     OPTIONS,
> > +     .firmware_version =     0,
> > +     .identity         =     "SiRFSOC Watchdog",
> > +};
> > +
> > +static struct watchdog_ops sirfsoc_wdt_ops = {
> > +     .owner = THIS_MODULE,
> > +     .start = sirfsoc_wdt_enable,
> > +     .stop = sirfsoc_wdt_disable,
> > +     .get_timeleft = sirfsoc_wdt_gettimeleft,
> > +     .ping = sirfsoc_wdt_updatetimeout,
> > +     .set_timeout = sirfsoc_wdt_settimeout,
> > +};
> > +
> > +static struct watchdog_device sirfsoc_wdd = {
> > +     .info = &sirfsoc_wdt_ident,
> > +     .ops = &sirfsoc_wdt_ops,
> > +     .timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT,
> > +     .min_timeout = SIRFSOC_WDT_MIN_TIMEOUT,
> > +     .max_timeout = SIRFSOC_WDT_MAX_TIMEOUT,
> > +};
> > +
> > +static int sirfsoc_wdt_probe(struct platform_device *pdev)
> > +{
> > +     struct resource *res;
> > +     int ret;
> > +     void __iomem *base;
> > +
> > +     /* reserve static register mappings */
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res) {
> > +             dev_err(&pdev->dev, "sirfsoc wdt: could not get mem resources\n");
> > +             ret = -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     base = devm_ioremap_resource(&pdev->dev, res);
> > +     if (!base) {
> > +             dev_err(&pdev->dev, "sirfsoc wdt: could not remap the mem\n");
> > +             ret = -EADDRNOTAVAIL;
> > +             goto out;
> > +     }
> > +     watchdog_set_drvdata(&sirfsoc_wdd, base);
> > +
> > +     sirfsoc_wdd.timeout = default_timeout;
>
> You can consider using watchdog_init_timeout here.
> I would also advice to add watchdog_set_nowayout and use the nowayout functionality.

agree.

> > +
> > +MODULE_DESCRIPTION("SiRF SoC watchdog driver");
> > +MODULE_AUTHOR("Xianglong Du <Xianglong.Du@csr.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
>
> This alias can be removed if you have the platform alias (like listed in the following line).
>
> > +MODULE_ALIAS("platform:sirfsoc-wdt");

agree.


> > --
> > 1.7.4.1
>
> Kind regards,
> Wim.
>

-barry
