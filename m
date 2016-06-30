Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33831 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbcF3NoW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Jun 2016 09:44:22 -0400
Subject: Re: [PATCH v3 2/3] watchdog: qcom: add option for standalone watchdog
 not in timer block
To: Thomas Pedersen <twp@codeaurora.org>,
	linux-watchdog@vger.kernel.org
References: <1467222602-18362-1-git-send-email-twp@codeaurora.org>
 <1467222602-18362-2-git-send-email-twp@codeaurora.org>
Cc: Matthew McClintock <mmcclint@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Russell King <linux@armlinux.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57752224.7020305@roeck-us.net>
Date: Thu, 30 Jun 2016 06:44:04 -0700
MIME-Version: 1.0
In-Reply-To: <1467222602-18362-2-git-send-email-twp@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/29/2016 10:50 AM, Thomas Pedersen wrote:
> From: Matthew McClintock <mmcclint@codeaurora.org>
>
> Commit 0dfd582e026a ("watchdog: qcom: use timer devicetree
> binding") moved to use the watchdog as a subset timer
> register block. Some devices have the watchdog completely
> standalone with slightly different register offsets as
> well so let's account for the differences here.
>
> The existing "kpss-standalone" compatible string doesn't
> make it entirely clear exactly what the device is so
> rename to "kpss-wdt" to reflect watchdog timer
> functionality. Also update ipq4019 DTS with an SoC
> specific compatible.
>
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
> use of_device_get_match_data()
>
> v3:
> rename kpss-standalone to kpss-wdt
> add ipq4019 specific compatible
> ---
>   .../devicetree/bindings/watchdog/qcom-wdt.txt      |  2 +
>   arch/arm/boot/dts/qcom-ipq4019.dtsi                |  2 +-
>   drivers/watchdog/qcom-wdt.c                        | 64 ++++++++++++++++------
>   3 files changed, 51 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> index 6b7b5ce..41aeaa2 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> @@ -7,8 +7,10 @@ Required properties :
>   			"qcom,kpss-wdt-msm8960"
>   			"qcom,kpss-wdt-apq8064"
>   			"qcom,kpss-wdt-ipq8064"
> +			"qcom,kpss-wdt-ipq4019"
>   			"qcom,kpss-timer"
>   			"qcom,scss-timer"
> +			"qcom,kpss-wdt"
>
>   - reg : shall contain base register location and length
>   - clocks : shall contain the input clock
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index 5c08d19..e625656 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -252,7 +252,7 @@
>   		};
>
>   		watchdog@b017000 {
> -			compatible = "qcom,kpss-standalone";
> +			compatible = "qcom,kpss-wdt", "qcom,kpss-wdt-ipq4019";
>   			reg = <0xb017000 0x40>;
>   			clocks = <&sleep_clk>;
>   			timeout-sec = <10>;
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index a043fa4..111e8a7 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -18,19 +18,42 @@
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
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
>   struct qcom_wdt {
>   	struct watchdog_device	wdd;
>   	struct clk		*clk;
>   	unsigned long		rate;
>   	void __iomem		*base;
> +	const u32		*layout;
>   };
>
> +static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
> +{
> +	return wdt->base + wdt->layout[reg];
> +}
> +
>   static inline
>   struct qcom_wdt *to_qcom_wdt(struct watchdog_device *wdd)
>   {
> @@ -41,10 +64,10 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
>   {
>   	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>
> -	writel(0, wdt->base + WDT_EN);
> -	writel(1, wdt->base + WDT_RST);
> -	writel(wdd->timeout * wdt->rate, wdt->base + WDT_BITE_TIME);
> -	writel(1, wdt->base + WDT_EN);
> +	writel(0, wdt_addr(wdt, WDT_EN));
> +	writel(1, wdt_addr(wdt, WDT_RST));
> +	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
> +	writel(1, wdt_addr(wdt, WDT_EN));
>   	return 0;
>   }
>
> @@ -52,7 +75,7 @@ static int qcom_wdt_stop(struct watchdog_device *wdd)
>   {
>   	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>
> -	writel(0, wdt->base + WDT_EN);
> +	writel(0, wdt_addr(wdt, WDT_EN));
>   	return 0;
>   }
>
> @@ -60,7 +83,7 @@ static int qcom_wdt_ping(struct watchdog_device *wdd)
>   {
>   	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>
> -	writel(1, wdt->base + WDT_RST);
> +	writel(1, wdt_addr(wdt, WDT_RST));
>   	return 0;
>   }
>
> @@ -83,10 +106,10 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>   	 */
>   	timeout = 128 * wdt->rate / 1000;
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
>   	/*
>   	 * Actually make sure the above sequence hits hardware before sleeping.
> @@ -119,9 +142,16 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>   	struct qcom_wdt *wdt;
>   	struct resource *res;
>   	struct device_node *np = pdev->dev.of_node;
> +	const u32 *regs;
>   	u32 percpu_offset;
>   	int ret;
>
> +	regs = of_device_get_match_data(&pdev->dev);
> +	if (!regs) {
> +		dev_err(&pdev->dev, "Unsupported QCOM WDT module\n");
> +		return -ENODEV;
> +	}
> +
>   	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>   	if (!wdt)
>   		return -ENOMEM;
> @@ -172,6 +202,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>   	wdt->wdd.min_timeout = 1;
>   	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
>   	wdt->wdd.parent = &pdev->dev;
> +	wdt->layout = regs;
>
>   	if (readl(wdt->base + WDT_STS) & 1)
>   		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> @@ -208,8 +239,9 @@ static int qcom_wdt_remove(struct platform_device *pdev)
>   }
>
>   static const struct of_device_id qcom_wdt_of_table[] = {
> -	{ .compatible = "qcom,kpss-timer" },
> -	{ .compatible = "qcom,scss-timer" },
> +	{ .compatible = "qcom,kpss-timer", .data = reg_offset_data_apcs_tmr },
> +	{ .compatible = "qcom,scss-timer", .data = reg_offset_data_apcs_tmr },
> +	{ .compatible = "qcom,kpss-wdt", .data = reg_offset_data_kpss },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
>

