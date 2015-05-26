Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45596 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbbEZQuX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 12:50:23 -0400
Message-ID: <5564A44A.5000606@codeaurora.org>
Date: Tue, 26 May 2015 11:50:18 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com
Subject: Re: [PATCH v3 5/6] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1432548193-19569-1-git-send-email-fu.wei@linaro.org> <1432548193-19569-6-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432548193-19569-6-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/25/2015 05:03 AM, fu.wei@linaro.org wrote:

> +/*
> + * help functions for accessing 32bit registers of SBSA Generic Watchdog
> + */
> +static void sbsa_gwdt_cf_write(unsigned int reg, u32 val,
> +			       struct watchdog_device *wdd)
> +{
> +	struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
> +
> +	writel_relaxed(val, gwdt->control_base + reg);
> +}
> +
> +static void sbsa_gwdt_rf_write(unsigned int reg, u32 val,
> +			       struct watchdog_device *wdd)
> +{
> +	struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
> +
> +	writel_relaxed(val, gwdt->refresh_base + reg);
> +}
> +
> +static u32 sbsa_gwdt_cf_read(unsigned int reg, struct watchdog_device *wdd)
> +{
> +	struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
> +
> +	return readl_relaxed(gwdt->control_base + reg);
> +}

I don't understand the value of these functions.  You're just adding 
overhead to each read and write by dereferencing wdd every time.  I 
would get rid of them and just call readl_relaxed() and writel_relaxed() 
directly.

> +/*
> + * help functions for accessing 64bit WCV register
> + */
> +static u64 sbsa_gwdt_get_wcv(struct watchdog_device *wdd)
> +{
> +	u32 wcv_lo, wcv_hi;
> +
> +	do {
> +		wcv_hi = sbsa_gwdt_cf_read(SBSA_GWDT_WCV_HI, wdd);
> +		wcv_lo = sbsa_gwdt_cf_read(SBSA_GWDT_WCV_LO, wdd);
> +	} while (wcv_hi != sbsa_gwdt_cf_read(SBSA_GWDT_WCV_HI, wdd));

Please add a comment indicating that you're trying to read WCV atomically.

> +
> +	return (((u64)wcv_hi << 32) | wcv_lo);
> +}

How about defining this macro:

#define make64(high, low) (((u64)(high) << 32) | (low))

and using it instead?  That makes the code easier to read.

> +
> +static void sbsa_gwdt_set_wcv(struct watchdog_device *wdd, u64 value)
> +{
> +	u32 wcv_lo, wcv_hi;
> +
> +	wcv_lo = value & U32_MAX;
> +	wcv_hi = (value >> 32) & U32_MAX;

Use upper_32_bits() and lower_32_bits() instead.

> +
> +	sbsa_gwdt_cf_write(SBSA_GWDT_WCV_HI, wcv_hi, wdd);
> +	sbsa_gwdt_cf_write(SBSA_GWDT_WCV_LO, wcv_lo, wdd);
> +}
> +
> +static void reload_timeout_to_wcv(struct watchdog_device *wdd)

This should be sbsa_gwdt_reload_timeout_to_wcv()

> +{
> +	struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
> +	u64 wcv;
> +
> +	wcv = arch_counter_get_cntvct() +
> +		(u64)(wdd->timeout - wdd->pretimeout) * gwdt->clk;
> +
> +	sbsa_gwdt_set_wcv(wdd, wcv);

Shouldn't you program WCV and WOR together?

> +static int sbsa_gwdt_set_pretimeout(struct watchdog_device *wdd,
> +				    unsigned int pretimeout)
> +{
> +	struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
> +	u32 wor;
> +
> +	wdd->pretimeout = pretimeout;
> +	sbsa_gwdt_update_limits(wdd);
> +
> +	if (!pretimeout)
> +		/* gives sbsa_gwdt_start a chance to setup timeout */
> +		wor = gwdt->clk;
> +	else
> +		wor = pretimeout * gwdt->clk;
> +
> +	/* refresh the WOR, that will cause an explicit watchdog refresh */
> +	sbsa_gwdt_cf_write(SBSA_GWDT_WOR, wor, wdd);

Why not just ping the watchdog explicitely?

> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
> +{
> +	struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
> +	struct watchdog_device *wdd = &gwdt->wdd;
> +	u32 status;
> +
> +	status = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
> +
> +	if (status & SBSA_GWDT_WCS_WS0)

This should always be true.  Instead of reading WCS, I think you should 
just panic().

> +static int sbsa_gwdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sbsa_gwdt *gwdt;
> +	struct watchdog_device *wdd;
> +	struct resource *res;
> +	void *rf_base, *cf_base;
> +	int irq;
> +	u32 clk, status;
> +	int ret = 0;
> +	u64 first_period_max = U64_MAX;
> +
> +	/*
> +	 * Get the frequency of system counter from
> +	 * the cp15 interface of ARM Generic timer
> +	 */
> +	clk = arch_timer_get_cntfrq();
> +	if (!clk) {

You have

	depends on ARM_ARCH_TIMER

in your Kconfig, so you don't need to check the return of 
arch_timer_get_cntfrq().  It can never be zero.

Also, I would not use the variable name 'clk', because that's usually 
used for a "struct clk" object.  I would call this "freq" instead.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
