Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49671 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbKCHsb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 02:48:31 -0500
Subject: Re: [PATCH v2 2/2] watchdog: imx2_wdt: add set_pretimeout interface
To: Robin Gong <b38343@freescale.com>, wim@iguana.be
References: <1446531084-15365-1-git-send-email-b38343@freescale.com>
 <1446531084-15365-2-git-send-email-b38343@freescale.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <563866CD.1080306@roeck-us.net>
Date: Mon, 2 Nov 2015 23:48:29 -0800
MIME-Version: 1.0
In-Reply-To: <1446531084-15365-2-git-send-email-b38343@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/02/2015 10:11 PM, Robin Gong wrote:
> Enable set_pretimeout interface and trigger the pretimeout interrupt before
> watchdog timeout event happen.
>
> Signed-off-by: Robin Gong <b38343@freescale.com>
> ---
>   drivers/watchdog/imx2_wdt.c | 58 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 0bb1a1d..bd42857 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -24,6 +24,7 @@
>   #include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/init.h>
> +#include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/jiffies.h>
>   #include <linux/kernel.h>
> @@ -52,12 +53,18 @@
>   #define IMX2_WDT_WRSR		0x04		/* Reset Status Register */
>   #define IMX2_WDT_WRSR_TOUT	(1 << 1)	/* -> Reset due to Timeout */
>
> +#define IMX2_WDT_WICR		0x06		/*Interrupt Control Register*/
> +#define IMX2_WDT_WICR_WIE	(1 << 15)	/* -> Interrupt Enable */
> +#define IMX2_WDT_WICR_WTIS	(1 << 14)	/* -> Interrupt Status */
> +#define IMX2_WDT_WICR_WICT	(0xFF)	/* Watchdog Interrupt Timeout */

Unnecessary ( )

> +
>   #define IMX2_WDT_WMCR		0x08		/* Misc Register */
>
>   #define IMX2_WDT_MAX_TIME	128
>   #define IMX2_WDT_DEFAULT_TIME	60		/* in seconds */
>
>   #define WDOG_SEC_TO_COUNT(s)	((s * 2 - 1) << 8)
> +#define WDOG_SEC_TO_PRECOUNT(s)	((s) * 2)	/* set WDOG pre timeout count*/
>
>   struct imx2_wdt_device {
>   	struct clk *clk;
> @@ -80,7 +87,8 @@ MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
>
>   static const struct watchdog_info imx2_wdt_info = {
>   	.identity = "imx2+ watchdog",
> -	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> +	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE
> +		   | WDIOF_PRETIMEOUT,
>   };
>
>   static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
> @@ -207,12 +215,49 @@ static inline void imx2_wdt_ping_if_active(struct watchdog_device *wdog)
>   	}
>   }
>
> +static int imx2_wdt_set_pretimeout(struct watchdog_device *wdog,
> +				   unsigned int new_timeout)
> +{
> +	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +	u32 val;
> +
> +	regmap_read(wdev->regmap, IMX2_WDT_WICR, &val);
> +	/* set the new pre-timeout value in the WSR */
> +	val &= ~IMX2_WDT_WICR_WICT;
> +	val |= WDOG_SEC_TO_PRECOUNT(new_timeout);

Looking into this, I think we need more information in the first patch.
Specifically, we need a value for max_pretimeout and validate it
(new_timeout must be smaller than 128 to avoid overflows, independent
of the maximum timeout).

> +
> +	regmap_write(wdev->regmap, IMX2_WDT_WICR, val | IMX2_WDT_WICR_WIE);
> +
> +	wdog->pretimeout = new_timeout;
> +
> +	return 0;
> +}
> +
> +static irqreturn_t imx2_wdt_isr(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	struct watchdog_device *wdog = platform_get_drvdata(pdev);
> +	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +	u32 val;
> +
> +	regmap_read(wdev->regmap, IMX2_WDT_WICR, &val);
> +	if (val & IMX2_WDT_WICR_WTIS) {
> +		/*clear interrupt status bit*/
> +		regmap_write(wdev->regmap, IMX2_WDT_WICR, val);
> +		panic("pre-timeout:%d, %d Seconds remained\n", wdog->pretimeout,

"seconds" - no capital 'S'.

> +		      wdog->timeout - wdog->pretimeout);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static const struct watchdog_ops imx2_wdt_ops = {
>   	.owner = THIS_MODULE,
>   	.start = imx2_wdt_start,
>   	.stop = imx2_wdt_stop,
>   	.ping = imx2_wdt_ping,
>   	.set_timeout = imx2_wdt_set_timeout,
> +	.set_pretimeout = imx2_wdt_set_pretimeout,
>   };
>
>   static const struct regmap_config imx2_wdt_regmap_config = {
> @@ -229,6 +274,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   	struct resource *res;
>   	void __iomem *base;
>   	int ret;
> +	int irq;
>   	u32 val;
>
>   	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
> @@ -294,6 +340,16 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   		goto disable_clk;
>   	}
>
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq > 0) {
> +		ret = devm_request_irq(&pdev->dev, irq, imx2_wdt_isr, 0,
> +				       dev_name(&pdev->dev), pdev);
> +		if (ret) {
> +			dev_err(&pdev->dev, "can't get irq %d\n", irq);
> +			goto disable_clk;
> +		}
> +	}
> +
>   	wdev->restart_handler.notifier_call = imx2_restart_handler;
>   	wdev->restart_handler.priority = 128;
>   	ret = register_restart_handler(&wdev->restart_handler);
>

