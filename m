Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56592 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758853AbbFBPh5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Jun 2015 11:37:57 -0400
Message-ID: <556DCDCB.4000808@roeck-us.net>
Date: Tue, 02 Jun 2015 08:37:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
	wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
	rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1433217907-928-1-git-send-email-fu.wei@linaro.org> <1433217907-928-6-git-send-email-fu.wei@linaro.org> <556DCC95.806@codeaurora.org>
In-Reply-To: <556DCC95.806@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/02/2015 08:32 AM, Timur Tabi wrote:
> On 06/01/2015 11:05 PM, fu.wei@linaro.org wrote:
>
>> +/*
>> + * help functions for accessing 32bit registers of SBSA Generic Watchdog
>> + */
>> +static void sbsa_gwdt_cf_write(unsigned int reg, u32 val,
>> +                   struct watchdog_device *wdd)
>> +{
>> +    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +    writel_relaxed(val, gwdt->control_base + reg);
>> +}
>> +
>> +static void sbsa_gwdt_rf_write(unsigned int reg, u32 val,
>> +                   struct watchdog_device *wdd)
>> +{
>> +    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +    writel_relaxed(val, gwdt->refresh_base + reg);
>> +}
>> +
>> +static u32 sbsa_gwdt_cf_read(unsigned int reg, struct watchdog_device *wdd)
>> +{
>> +    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +    return readl_relaxed(gwdt->control_base + reg);
>> +}
>
> I still think you should get rid of these functions and just call readl_relaxed() and writel_relaxed() every time, but I won't complain again if you keep them.
>
>> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>> +{
>> +    struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
>> +    struct watchdog_device *wdd = &gwdt->wdd;
>> +
>> +    if (wdd->pretimeout)
>> +        /* The pretimeout is valid, go panic */
>> +        panic("SBSA Watchdog pre-timeout");
>> +    else
>> +        /* We don't use pretimeout, trigger WS1 now*/
>> +        sbsa_gwdt_set_wcv(wdd, 0);
>
> I don't like this.  The triggering of the hardware reset should never depend on an interrupt being handled properly.  You should always program WCV correctly in advance.  This is especially true since pre-timeout will probably rarely be used.  So what happens if the CPU is totally hung and this interrupt handler is never called?  When will the timeout occur?
>
>> +static int sbsa_gwdt_probe(struct platform_device *pdev)
>> +{
>> +    u64 first_period_max = U64_MAX;
>> +    struct device *dev = &pdev->dev;
>> +    struct watchdog_device *wdd;
>> +    struct sbsa_gwdt *gwdt;
>> +    struct resource *res;
>> +    void *rf_base, *cf_base;
>> +    int ret, irq;
>> +    u32 status;
>> +
>> +    gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
>> +    if (!gwdt)
>> +        return -ENOMEM;
>> +    platform_set_drvdata(pdev, gwdt);
>
> You should probably do this *after* calling platform_get_irq_byname().
>
>> +
>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "refresh");
>> +    rf_base = devm_ioremap_resource(dev, res);
>> +    if (IS_ERR(rf_base))
>> +        return PTR_ERR(rf_base);
>> +
>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
>> +    cf_base = devm_ioremap_resource(dev, res);
>> +    if (IS_ERR(cf_base))
>> +        return PTR_ERR(cf_base);
>> +
>> +    irq = platform_get_irq_byname(pdev, "ws0");
>> +    if (irq < 0) {
>> +        dev_err(dev, "unable to get ws0 interrupt.\n");
>> +        return irq;
>> +    }
>> +
>> +    /*
>> +     * Get the frequency of system counter from the cp15 interface of ARM
>> +     * Generic timer. We don't need to check it, because if it returns "0",
>> +     * system would panic in very early stage.
>> +     */
>> +    gwdt->clk = arch_timer_get_cntfrq();
>> +    gwdt->refresh_base = rf_base;
>> +    gwdt->control_base = cf_base;
>> +
>> +    wdd = &gwdt->wdd;
>> +    wdd->parent = dev;
>> +    wdd->info = &sbsa_gwdt_info;
>> +    wdd->ops = &sbsa_gwdt_ops;
>> +    watchdog_set_drvdata(wdd, gwdt);
>> +    watchdog_set_nowayout(wdd, nowayout);
>> +
>> +    wdd->min_pretimeout = 0;
>> +    wdd->max_pretimeout = U32_MAX / gwdt->clk;
>> +    wdd->min_timeout = 1;
>> +    do_div(first_period_max, gwdt->clk);
>> +    wdd->max_timeout = first_period_max;
>> +
>> +    wdd->pretimeout = DEFAULT_PRETIMEOUT;
>> +    wdd->timeout = DEFAULT_TIMEOUT;
>> +    watchdog_init_timeouts(wdd, pretimeout, timeout, dev);
>> +
>> +    status = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
>> +    if (status & SBSA_GWDT_WCS_WS1) {
>> +        dev_warn(dev, "System reset by WDT(WCV: %llx)\n",
>> +             sbsa_gwdt_get_wcv(wdd));
>
> "System was previously reset via watchdog" is much clearer.
>
>> +        wdd->bootstatus |= WDIOF_CARDRESET;
>> +    }
>> +    /* Check if watchdog is already enabled */
>> +    if (status & SBSA_GWDT_WCS_EN) {
>> +        dev_warn(dev, "already enabled!\n");
>
> "watchdog is already enabled".  Never use exclamation marks in kernel messages.
>
>> +        sbsa_gwdt_keepalive(wdd);
>> +    }
>> +
>> +    /* update pretimeout to WOR */
>> +    sbsa_gwdt_set_pretimeout(wdd, wdd->pretimeout);
>> +
>> +    ret = devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
>> +                   pdev->name, gwdt);
>> +    if (ret) {
>> +        dev_err(dev, "unable to request IRQ %d\n", irq);
>> +        return ret;
>> +    }
>> +
>> +    ret = watchdog_register_device(wdd);
>> +    if (ret)
>> +        return ret;
>> +
>> +    dev_info(dev, "Initialized with %ds timeout, %ds pretimeout @ %u Hz\n",
>> +         wdd->timeout, wdd->pretimeout, gwdt->clk);
>
> if (wdd->pretimeout)
>      "watchdog initialized to %us timeout and %us pre-timeout at %u Hz\n", wdd->timeout, wdd->pretimeout, gwdt->clk
> else
>      "watchdog initialized to %us timeout at %u Hz\n", wdd->timeout, gwdt->clk
>
> I think it's unlikely that users will use pre-timeout, so your code should treat pre-timeout as a special case, not the normal usage.
>
+1 to all your comments.

Guenter

