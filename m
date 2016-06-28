Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40578 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbcF1Tr1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jun 2016 15:47:27 -0400
Date: Tue, 28 Jun 2016 12:47:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Pedersen <twp@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org,
	Matthew McClintock <mmcclint@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v2 2/3] watchdog: qcom: add option for standalone
 watchdog not in timer block
Message-ID: <20160628194723.GA1999@roeck-us.net>
References: <1467138921-3658-1-git-send-email-twp@codeaurora.org>
 <1467138921-3658-2-git-send-email-twp@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467138921-3658-2-git-send-email-twp@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 28, 2016 at 11:35:20AM -0700, Thomas Pedersen wrote:
> From: Matthew McClintock <mmcclint@codeaurora.org>
> 
> Commit 0dfd582e026a ("watchdog: qcom: use timer devicetree binding") moved
> to use the watchdog as a subset timer register block. Some devices have the
> watchdog completely standalone with slightly different register offsets as
> well so let's account for the differences here.
> 
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
> 
> ---
> v2:
> use of_device_get_match_data()
> ---
>  drivers/watchdog/qcom-wdt.c | 64 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index a043fa4..19a6cf0 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -18,19 +18,42 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
> +#include <linux/of_device.h>
>  
> -#define WDT_RST		0x38
> -#define WDT_EN		0x40
> -#define WDT_STS		0x44
> -#define WDT_BITE_TIME	0x5C
> +enum wdt_reg {
> +	WDT_RST,
> +	WDT_EN,
> +	WDT_STS,
> +	WDT_BITE_TIME,
> +};
> +
> +static const u32 reg_offset_data_apcs_tmr[] = {
> +	[WDT_RST] = 0x38,
> +	[WDT_EN] = 0x40,
> +	[WDT_STS] = 0x44,
> +	[WDT_BITE_TIME] = 0x5C,
> +};
> +
> +static const u32 reg_offset_data_kpss[] = {
> +	[WDT_RST] = 0x4,
> +	[WDT_EN] = 0x8,
> +	[WDT_STS] = 0xC,
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
> @@ -41,10 +64,10 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
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
> @@ -52,7 +75,7 @@ static int qcom_wdt_stop(struct watchdog_device *wdd)
>  {
>  	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>  
> -	writel(0, wdt->base + WDT_EN);
> +	writel(0, wdt_addr(wdt, WDT_EN));
>  	return 0;
>  }
>  
> @@ -60,7 +83,7 @@ static int qcom_wdt_ping(struct watchdog_device *wdd)
>  {
>  	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>  
> -	writel(1, wdt->base + WDT_RST);
> +	writel(1, wdt_addr(wdt, WDT_RST));
>  	return 0;
>  }
>  
> @@ -83,10 +106,10 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
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
> @@ -119,9 +142,16 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>  	struct qcom_wdt *wdt;
>  	struct resource *res;
>  	struct device_node *np = pdev->dev.of_node;
> +	const u32 *regs;
>  	u32 percpu_offset;
>  	int ret;
>  
> +	regs = of_device_get_match_data(&pdev->dev);
> +	if (!regs) {
> +		dev_err(&pdev->dev, "Unsupported QCOM WDT module\n");
> +		return -ENODEV;
> +	}
> +
>  	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>  	if (!wdt)
>  		return -ENOMEM;
> @@ -172,6 +202,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>  	wdt->wdd.min_timeout = 1;
>  	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
>  	wdt->wdd.parent = &pdev->dev;
> +	wdt->layout = regs;
>  
>  	if (readl(wdt->base + WDT_STS) & 1)
>  		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> @@ -208,8 +239,9 @@ static int qcom_wdt_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_wdt_of_table[] = {
> -	{ .compatible = "qcom,kpss-timer" },
> -	{ .compatible = "qcom,scss-timer" },
> +	{ .compatible = "qcom,kpss-timer", .data = reg_offset_data_apcs_tmr },
> +	{ .compatible = "qcom,scss-timer", .data = reg_offset_data_apcs_tmr },
> +	{ .compatible = "qcom,kpss-standalone", .data = &reg_offset_data_kpss},

Unnecessary '&'. Also, I'll have to look back at the earlier comments; it
seems to me that 'qcom,kpss-standalone' may be a less than optimal name
for this binding. Not sure if 'qcom,kpss-core' would be better (if that is
what it is). Either case, whatever we end up with, it will need to be
documented in the bindings.

Sorry, should have looked into it more deeply earlier.

Thanks,
Guenter

>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
