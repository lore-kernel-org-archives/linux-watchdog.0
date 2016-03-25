Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47599 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbcCYRye (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Mar 2016 13:54:34 -0400
Date: Fri, 25 Mar 2016 09:23:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
	qca-upstream.external@qca.qualcomm.com,
	Wim Van Sebroeck <wim@iguana.be>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/17] watchdog: qcom: add option for standalone watchdog
 not in timer block
Message-ID: <20160325162326.GA25767@roeck-us.net>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-8-git-send-email-mmcclint@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458770712-10880-8-git-send-email-mmcclint@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 23, 2016 at 05:05:02PM -0500, Matthew McClintock wrote:
> Commit 0dfd582e026a ("watchdog: qcom: use timer devicetree binding") moved
> to use the watchdog as a subset timer register block. Some devices have the
> watchdog completely standalone with slightly different register offsets as
> well so let's account for the differences here.
> 
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> ---
>  drivers/watchdog/qcom-wdt.c | 69 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 20563cc..e46f18d 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -19,17 +19,37 @@
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
>  
> -#define WDT_RST		0x38
> -#define WDT_EN		0x40
> -#define WDT_BITE_TIME	0x5C
> +enum wdt_reg {
> +	WDT_RST,
> +	WDT_EN,
> +	WDT_BITE_TIME,
> +};
> +
> +static const u32 reg_offset_data_apcs_tmr[] = {
> +	[WDT_RST] = 0x38,
> +	[WDT_EN] = 0x40,
> +	[WDT_BITE_TIME] = 0x5C,
> +};
> +
> +static const u32 reg_offset_data_kpss[] = {
> +	[WDT_RST] = 0x4,
> +	[WDT_EN] = 0x8,

Does this work ? In the datasheet I have in front of me (APQ8064), the watchdog
at this address uses different bits. At address 0x40 (eg GSS_A5_APCS_WDT0_EN),
bit 0 is the enable bit, and bit 1 enables interrupts. At address 0x08 (eg
LPASS_QDSP6SS_WDOG_UNMASKED_INT_EN), bit 0 enables interrupts and bit 1 is
undefined. Or does "qcom,kpss-standalone" refer to some other watchdog ?

Thanks,
Guenter

> +	[WDT_BITE_TIME] = 0x14,
> +};
>  
>  struct qcom_wdt {
>  	struct watchdog_device	wdd;
>  	struct clk		*clk;
>  	unsigned long		rate;
>  	void __iomem		*base;
> +	const u32		*layout;
>  };
>  
> +static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
> +{
> +	return wdt->base + wdt->layout[reg];
> +}
> +
>  static inline
>  struct qcom_wdt *to_qcom_wdt(struct watchdog_device *wdd)
>  {
> @@ -40,10 +60,10 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>  
> -	writel(0, wdt->base + WDT_EN);
> -	writel(1, wdt->base + WDT_RST);
> -	writel(wdd->timeout * wdt->rate, wdt->base + WDT_BITE_TIME);
> -	writel(1, wdt->base + WDT_EN);
> +	writel(0, wdt_addr(wdt, WDT_EN));
> +	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
> +	writel(1, wdt_addr(wdt, WDT_EN));
>  	return 0;
>  }
>  
> @@ -51,7 +71,7 @@ static int qcom_wdt_stop(struct watchdog_device *wdd)
>  {
>  	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>  
> -	writel(0, wdt->base + WDT_EN);
> +	writel(0, wdt_addr(wdt, WDT_EN));
>  	return 0;
>  }
>  
> @@ -59,7 +79,7 @@ static int qcom_wdt_ping(struct watchdog_device *wdd)
>  {
>  	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>  
> -	writel(1, wdt->base + WDT_RST);
> +	writel(1, wdt_addr(wdt, WDT_RST));
>  	return 0;
>  }
>  
> @@ -82,10 +102,10 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>  	 */
>  	timeout = 128 * wdt->rate / 1000;
>  
> -	writel(0, wdt->base + WDT_EN);
> -	writel(1, wdt->base + WDT_RST);
> -	writel(timeout, wdt->base + WDT_BITE_TIME);
> -	writel(1, wdt->base + WDT_EN);
> +	writel(0, wdt_addr(wdt, WDT_EN));
> +	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(timeout, wdt_addr(wdt, WDT_BITE_TIME));
> +	writel(1, wdt_addr(wdt, WDT_EN));
>  
>  	/*
>  	 * Actually make sure the above sequence hits hardware before sleeping.
> @@ -112,14 +132,29 @@ static const struct watchdog_info qcom_wdt_info = {
>  	.identity	= KBUILD_MODNAME,
>  };
>  
> +static const struct of_device_id qcom_wdt_of_table[] = {
> +	{ .compatible = "qcom,kpss-timer", .data = reg_offset_data_apcs_tmr },
> +	{ .compatible = "qcom,scss-timer", .data = reg_offset_data_apcs_tmr },
> +	{ .compatible = "qcom,kpss-standalone", .data = &reg_offset_data_kpss},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
> +
>  static int qcom_wdt_probe(struct platform_device *pdev)
>  {
>  	struct qcom_wdt *wdt;
>  	struct resource *res;
>  	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *match;
>  	u32 percpu_offset;
>  	int ret;
>  
> +	match = of_match_node(qcom_wdt_of_table, np);
> +	if (!match) {
> +		dev_err(&pdev->dev, "Unsupported QCOM WDT module\n");
> +		return -ENODEV;
> +	}
> +
>  	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>  	if (!wdt)
>  		return -ENOMEM;
> @@ -170,6 +205,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>  	wdt->wdd.min_timeout = 1;
>  	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
>  	wdt->wdd.parent = &pdev->dev;
> +	wdt->layout = match->data;
>  
>  	/*
>  	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
> @@ -202,13 +238,6 @@ static int qcom_wdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id qcom_wdt_of_table[] = {
> -	{ .compatible = "qcom,kpss-timer" },
> -	{ .compatible = "qcom,scss-timer" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
> -
>  static struct platform_driver qcom_watchdog_driver = {
>  	.probe	= qcom_wdt_probe,
>  	.remove	= qcom_wdt_remove,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
