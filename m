Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41589 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbaISEzK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 00:55:10 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XUqDt-002T7J-Et
	for linux-watchdog@vger.kernel.org; Fri, 19 Sep 2014 04:55:09 +0000
Message-ID: <541BB712.6020607@roeck-us.net>
Date: Thu, 18 Sep 2014 21:54:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Chen-Yu Tsai <wens@csie.org>, Wim Van Sebroeck <wim@iguana.be>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] watchdog: sunxi: support parameterized compatible
 strings
References: <1410878523-4924-1-git-send-email-wens@csie.org> <1410878523-4924-2-git-send-email-wens@csie.org>
In-Reply-To: <1410878523-4924-2-git-send-email-wens@csie.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/16/2014 07:42 AM, Chen-Yu Tsai wrote:
> This patch adds support for hardware parameters tied to compatible
> strings, so similar hardware can reuse the driver.
>
> This will be used to support the newer watchdog found in A31 and
> later SoCs. Differences in the new hardware include separate
> interrupt lines for each watchdog, and corresponding interrupt
> control/status registers. Watchdog control registers were also
> slightly rearranged.
>
You might also mention that you replace some iowrite32 with writel.

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Have you considered using regmap ? Seems to be an ideal candidate.

> ---
>   drivers/watchdog/sunxi_wdt.c | 101 ++++++++++++++++++++++++++++++++-----------
>   1 file changed, 76 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index 480bb55..a1f7113 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -23,6 +23,7 @@
>   #include <linux/moduleparam.h>
>   #include <linux/notifier.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/reboot.h>
>   #include <linux/types.h>
> @@ -30,15 +31,11 @@
>
>   #define WDT_MAX_TIMEOUT         16
>   #define WDT_MIN_TIMEOUT         1
> -#define WDT_MODE_TIMEOUT(n)     ((n) << 3)
> -#define WDT_TIMEOUT_MASK        WDT_MODE_TIMEOUT(0x0F)
> +#define WDT_TIMEOUT_MASK        0x0F
>
> -#define WDT_CTRL                0x00
>   #define WDT_CTRL_RELOAD         ((1 << 0) | (0x0a57 << 1))
>
> -#define WDT_MODE                0x04
>   #define WDT_MODE_EN             (1 << 0)
> -#define WDT_MODE_RST_EN         (1 << 1)
>
>   #define DRV_NAME		"sunxi-wdt"
>   #define DRV_VERSION		"1.0"
> @@ -46,15 +43,29 @@
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   static unsigned int timeout = WDT_MAX_TIMEOUT;
>
> +/*
> + * This structure stores the register offsets for different variants
> + * of Allwinner's watchdog hardware.
> + */
> +struct sunxi_wdt_reg {
> +	u8 wdt_ctrl;
> +	u8 wdt_cfg;
> +	u8 wdt_mode;
> +	u8 wdt_timeout_shift;
> +	u8 wdt_reset_mask;
> +	u8 wdt_reset_val;
> +};
> +
>   struct sunxi_wdt_dev {
>   	struct watchdog_device wdt_dev;
>   	void __iomem *wdt_base;
> +	const struct sunxi_wdt_reg *wdt_regs;
>   	struct notifier_block restart_handler;
>   };
>
>   /*
>    * wdt_timeout_map maps the watchdog timer interval value in seconds to
> - * the value of the register WDT_MODE bit 3:6
> + * the value of the register WDT_MODE at bits .wdt_timeout_shift ~ +3
>    *
>    * [timeout seconds] = register value
>    *
> @@ -82,19 +93,32 @@ static int sunxi_restart_handle(struct notifier_block *this, unsigned long mode,
>   						       struct sunxi_wdt_dev,
>   						       restart_handler);
>   	void __iomem *wdt_base = sunxi_wdt->wdt_base;
> +	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
> +	u32 val;
> +
> +	/* Set system reset function */
> +	val = readl(wdt_base + regs->wdt_cfg);
> +	val &= ~(regs->wdt_reset_mask);
> +	val |= regs->wdt_reset_val;
> +	writel(val, wdt_base + regs->wdt_cfg);
>
> -	/* Enable timer and set reset bit in the watchdog */
> -	writel(WDT_MODE_EN | WDT_MODE_RST_EN, wdt_base + WDT_MODE);
> +	/* Set lowest timeout and enable watchdog */
> +	val = readl(wdt_base + regs->wdt_mode);
> +	val &= ~(WDT_TIMEOUT_MASK << regs->wdt_timeout_shift);
> +	val |= WDT_MODE_EN;

I think it would make sense to also define WDT_MODE_EN and
WDT_TIMEOUT_MASK as configurable, even if not currently needed.
It is odd to have the shift configurable but not the mask,
and to have the mode register configurable but not the mode value.

> +	writel(val, wdt_base + regs->wdt_mode);
>
>   	/*
>   	 * Restart the watchdog. The default (and lowest) interval
>   	 * value for the watchdog is 0.5s.
>   	 */
> -	writel(WDT_CTRL_RELOAD, wdt_base + WDT_CTRL);
> +	writel(WDT_CTRL_RELOAD, wdt_base + regs->wdt_ctrl);
>
>   	while (1) {
>   		mdelay(5);
> -		writel(WDT_MODE_EN | WDT_MODE_RST_EN, wdt_base + WDT_MODE);
> +		val = readl(wdt_base + regs->wdt_mode);
> +		val |= WDT_MODE_EN;
> +		writel(val, wdt_base + regs->wdt_mode);
>   	}
>   	return NOTIFY_DONE;
>   }
> @@ -103,8 +127,9 @@ static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
>   {
>   	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
>   	void __iomem *wdt_base = sunxi_wdt->wdt_base;
> +	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
>
> -	iowrite32(WDT_CTRL_RELOAD, wdt_base + WDT_CTRL);
> +	writel(WDT_CTRL_RELOAD, wdt_base + regs->wdt_ctrl);
>
>   	return 0;
>   }
> @@ -114,6 +139,7 @@ static int sunxi_wdt_set_timeout(struct watchdog_device *wdt_dev,
>   {
>   	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
>   	void __iomem *wdt_base = sunxi_wdt->wdt_base;
> +	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
>   	u32 reg;
>
>   	if (wdt_timeout_map[timeout] == 0)
> @@ -121,10 +147,10 @@ static int sunxi_wdt_set_timeout(struct watchdog_device *wdt_dev,
>
>   	sunxi_wdt->wdt_dev.timeout = timeout;
>
> -	reg = ioread32(wdt_base + WDT_MODE);
> -	reg &= ~WDT_TIMEOUT_MASK;
> -	reg |= WDT_MODE_TIMEOUT(wdt_timeout_map[timeout]);
> -	iowrite32(reg, wdt_base + WDT_MODE);
> +	reg = readl(wdt_base + regs->wdt_mode);
> +	reg &= ~(WDT_TIMEOUT_MASK << regs->wdt_timeout_shift);
> +	reg |= wdt_timeout_map[timeout] << regs->wdt_timeout_shift;
> +	writel(reg, wdt_base + regs->wdt_mode);
>
>   	sunxi_wdt_ping(wdt_dev);
>
> @@ -135,8 +161,9 @@ static int sunxi_wdt_stop(struct watchdog_device *wdt_dev)
>   {
>   	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
>   	void __iomem *wdt_base = sunxi_wdt->wdt_base;
> +	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
>
> -	iowrite32(0, wdt_base + WDT_MODE);
> +	writel(0, wdt_base + regs->wdt_mode);
>
>   	return 0;
>   }
> @@ -146,6 +173,7 @@ static int sunxi_wdt_start(struct watchdog_device *wdt_dev)
>   	u32 reg;
>   	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
>   	void __iomem *wdt_base = sunxi_wdt->wdt_base;
> +	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
>   	int ret;
>
>   	ret = sunxi_wdt_set_timeout(&sunxi_wdt->wdt_dev,
> @@ -153,9 +181,16 @@ static int sunxi_wdt_start(struct watchdog_device *wdt_dev)
>   	if (ret < 0)
>   		return ret;
>
> -	reg = ioread32(wdt_base + WDT_MODE);
> -	reg |= (WDT_MODE_RST_EN | WDT_MODE_EN);
> -	iowrite32(reg, wdt_base + WDT_MODE);
> +	/* Set system reset function */
> +	reg = readl(wdt_base + regs->wdt_cfg);
> +	reg &= ~(regs->wdt_reset_mask);
> +	reg |= ~(regs->wdt_reset_val);
> +	writel(reg, wdt_base + regs->wdt_cfg);
> +
> +	/* Enable watchdog */
> +	reg = readl(wdt_base + regs->wdt_mode);
> +	reg |= WDT_MODE_EN;
> +	writel(reg, wdt_base + regs->wdt_mode);
>
>   	return 0;
>   }
> @@ -175,9 +210,25 @@ static const struct watchdog_ops sunxi_wdt_ops = {
>   	.set_timeout	= sunxi_wdt_set_timeout,
>   };
>
> +static const struct sunxi_wdt_reg sun4i_wdt_reg = {
> +	.wdt_ctrl = 0x00,
> +	.wdt_cfg = 0x04,
> +	.wdt_mode = 0x04,
> +	.wdt_timeout_shift = 3,
> +	.wdt_reset_mask = 0x02,
> +	.wdt_reset_val = 0x02,
> +};
> +
> +static const struct of_device_id sunxi_wdt_dt_ids[] = {
> +	{ .compatible = "allwinner,sun4i-a10-wdt", .data = &sun4i_wdt_reg },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
> +
>   static int sunxi_wdt_probe(struct platform_device *pdev)
>   {
>   	struct sunxi_wdt_dev *sunxi_wdt;
> +	const struct of_device_id *device;
>   	struct resource *res;
>   	int err;
>
> @@ -187,6 +238,12 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
>
>   	platform_set_drvdata(pdev, sunxi_wdt);
>
> +	device = of_match_device(sunxi_wdt_dt_ids, &pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
> +	sunxi_wdt->wdt_regs = device->data;
> +
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	sunxi_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
>   	if (IS_ERR(sunxi_wdt->wdt_base))
> @@ -242,12 +299,6 @@ static void sunxi_wdt_shutdown(struct platform_device *pdev)
>   	sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
>   }
>
> -static const struct of_device_id sunxi_wdt_dt_ids[] = {
> -	{ .compatible = "allwinner,sun4i-a10-wdt" },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
> -
>   static struct platform_driver sunxi_wdt_driver = {
>   	.probe		= sunxi_wdt_probe,
>   	.remove		= sunxi_wdt_remove,
>

