Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, wim@iguana.be, t.figa@samsung.com, devicetree@vger.kernel.org, dianders@chromium.org, linux-watchdog@vger.kernel.org, cpgs@samsung.com, sachin.kamat@linaro.org
Subject: Re: [PATCH V8 2/3] watchdog: s3c2410_wdt: add device tree support and use syscon regmap interface to configure pmu register
Date: Sat, 16 Nov 2013 00:57:32 +0100
Message-ID: <1624293.Me8KZc3LAK@flatron>
In-Reply-To: <52858BBE.5030800@roeck-us.net>
References: <1384238088-9862-1-git-send-email-l.krishna@samsung.com> <1384238088-9862-3-git-send-email-l.krishna@samsung.com> <52858BBE.5030800@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Thursday 14 of November 2013 18:49:34 Guenter Roeck wrote:
> On 11/11/2013 10:34 PM, Leela Krishna Amudala wrote:
> > Add device tree support and use syscon regmap interface to configure
> > AUTOMATIC_WDT_RESET_DISABLE and MASK_WDT_RESET_REQUEST registers of PMU
> > to mask/unmask enable/disable of watchdog in probe and s2r scenarios.
> >
> If the driver didn't support devicetree before, why did it have #ifdef CONFIG_OF, and
> why does its devicetree bindings file already exist ?
> 
> Seems to me the description does not match the patch; it appears that you are really
> adding Exynos5 support to the driver.

Yes, the driver did support Device Tree before. Patch description needs
to be corrected.

> > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> > index 23aad7c..ccf755d 100644
> > --- a/drivers/watchdog/s3c2410_wdt.c
> > +++ b/drivers/watchdog/s3c2410_wdt.c
[snip]
> > +
> > +static const struct platform_device_id s3c2410_wdt_ids[] = {
> > +	{
> > +		.name = "s3c2410-wdt",
> > +		.driver_data = (unsigned long)&pmu_config_s3c2410,
> > +	},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(platform, s3c2410_wdt_ids);
> > +
> 
> What is this second device ID and MODULE_DEVICE_TABLE for ?
> I assume it is to provide driver_data. If so, you should probably remove the
> platform MODULE_ALIAS at the end of the driver.

Yes. I suggested adding it to simplify the code a bit by having driver
data supplied even when booting without DT. Good catch with MODULE_ALIAS,
though.

> 
> >   /* watchdog control routines */
> >
> >   #define DBG(fmt, ...)					\
> > @@ -111,6 +166,30 @@ static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
> >   	return container_of(nb, struct s3c2410_wdt, freq_transition);
> >   }
> >
> > +static int s3c2410wdt_mask_and_disable_reset(struct s3c2410_wdt *wdt, bool mask)
> > +{
> > +	int ret;
> > +	u32 mask_val = 1 << wdt->pmu_config->mask_bit;
> > +	u32 val = 0;
> > +
> > +	if (mask)
> > +		val = mask_val;
> > +
> > +	ret = regmap_update_bits(wdt->pmureg,
> > +			wdt->pmu_config->disable_reg,
> > +			mask_val, val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(wdt->pmureg,
> > +			wdt->pmu_config->mask_reset_reg,
> > +			mask_val, val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> 
> The above code is identical to
> 	return ret;

I'd even say that the above code is identical to

	return regmap_update_bits(wdt->pmureg,
			wdt->pmu_config->mask_reset_reg,
			mask_val, val);

> 
> > +}
> > +
> >   static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
> >   {
> >   	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
> > @@ -332,6 +411,20 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
> >   }
> >   #endif
> >
> > +/* s3c2410_get_wdt_driver_data */
> > +static inline struct s3c2410_wdt_variant *
> > +get_wdt_drv_data(struct platform_device *pdev)
> > +{
> > +	if (pdev->dev.of_node) {
> > +		const struct of_device_id *match;
> > +		match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
> > +		return (struct s3c2410_wdt_variant *)match->data;
> > +	} else {
> > +		return (struct s3c2410_wdt_variant *)
> > +			platform_get_device_id(pdev)->driver_data;
> > +	}
> > +}
> > +
> >   static int s3c2410wdt_probe(struct platform_device *pdev)
> >   {
> >   	struct device *dev;
> > @@ -354,6 +447,16 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >   	spin_lock_init(&wdt->lock);
> >   	wdt->wdt_device = s3c2410_wdd;
> >
> > +	wdt->pmu_config = get_wdt_drv_data(pdev);
> > +	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> > +		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +							"samsung,syscon-phandle");
> > +		if (IS_ERR(wdt->pmureg)) {
> > +			dev_err(dev, "syscon regmap lookup failed.\n");
> > +			return PTR_ERR(wdt->pmureg);
> > +		}
> > +	}
> > +
> >   	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >   	if (wdt_irq == NULL) {
> >   		dev_err(dev, "no irq resource specified\n");
> > @@ -444,6 +547,14 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >   		 (wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
> >   		 (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
> >
> > +	if (wdt->pmu_config->quirks & QUIRK_NEEDS_PMU_CONFIG) {
> 
> Might be easier to check for wdt->pmureg in all those secondary conditionals.

IMHO not really much easier and less meaningful. Furthermore, in case of
other quirks showing up in future that wouldn't have alternative way
of checking, they will have consistent style of checks.

However, I think I missed to point out the ugly field name in my previous
reviews. Instead of calling it "pmu_config", "drv_data" would be much
better.

> 
> > +		ret = s3c2410wdt_mask_and_disable_reset(wdt, false);
> > +		if (ret < 0) {
> > +			dev_warn(wdt->dev, "failed to update pmu register");
> 
> Is this a warning or an error ?
> 
> If it is (only) a warning, why do you bail out ?
> 
> On a side note, I am not sure if all those errors can really happen in practice.
> Becasue if not, all you do is to increase code size with no real benefit.

Yes, that's a good point. I was under impression that returned error codes
should not be ignored, but maybe I was a bit too strict over this.

Generally on currently supported platforms that will end up as a simple
MMIO register access locked with a spinlock, so really no way to fail.

Anyway, a failure to write these PMU registers would end up with the
watchdog not generating the reset, so IMHO it would be an error.

Best regards,
Tomasz
