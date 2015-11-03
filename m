Return-path: <yibin.gong@freescale.com>
Date: Tue, 3 Nov 2015 12:55:02 +0800
From: Robin Gong <b38343@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/2] watchdog: imx2_wdt: add set_pretimeout interface
Message-ID: <20151103045501.GB26305@shlinux2>
References: <1446521367-25748-1-git-send-email-b38343@freescale.com>
 <1446521367-25748-2-git-send-email-b38343@freescale.com>
 <563835C0.5010204@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <563835C0.5010204@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Nov 02, 2015 at 08:19:12PM -0800, Guenter Roeck wrote:
> On 11/02/2015 07:29 PM, Robin Gong wrote:
> >Enable set_pretimeout interface and trigger the pretimeout interrupt before
> >watchdog timeout event happen.
> >
> >Signed-off-by: Robin Gong <b38343@freescale.com>
> >---
> >  drivers/watchdog/imx2_wdt.c | 67 ++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 66 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> >index 0bb1a1d..d3c6b07 100644
> >--- a/drivers/watchdog/imx2_wdt.c
> >+++ b/drivers/watchdog/imx2_wdt.c
> >@@ -24,7 +24,9 @@
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> >+#include <linux/interrupt.h>
> >  #include <linux/io.h>
> >+#include <linux/irq.h>
> 
> Are those two new includes both needed ?
>
Yes, irq.h is not needed.
> >  #include <linux/jiffies.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >@@ -52,12 +54,18 @@
> >  #define IMX2_WDT_WRSR		0x04		/* Reset Status Register */
> >  #define IMX2_WDT_WRSR_TOUT	(1 << 1)	/* -> Reset due to Timeout */
> >
> >+#define IMX2_WDT_WICR		0x06		/*Interrupt Control Register*/
> >+#define IMX2_WDT_WICR_WIE	(1 << 15)	/* -> Interrupt Enable */
> >+#define IMX2_WDT_WICR_WTIS	(1 << 14)	/* -> Interrupt Status */
> >+#define IMX2_WDT_WICR_WICT	(0xFF << 0)	/* Watchdog Interrupt Timeout */
> >+
> 
> "<< 0" doesn't really add any value here.
> 
Accept.
> >  #define IMX2_WDT_WMCR		0x08		/* Misc Register */
> >
> >  #define IMX2_WDT_MAX_TIME	128
> >  #define IMX2_WDT_DEFAULT_TIME	60		/* in seconds */
> >
> >  #define WDOG_SEC_TO_COUNT(s)	((s * 2 - 1) << 8)
> >+#define WDOG_SEC_TO_PRECOUNT(s)	(s * 2)		/* set WDOG pre timeout count*/
> >
> 					((s) * 2)
> 
> Ah yes, WDOG_SEC_TO_COUNT should also use (s).
> 

> >  struct imx2_wdt_device {
> >  	struct clk *clk;
> >@@ -80,7 +88,8 @@ MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> >
> >  static const struct watchdog_info imx2_wdt_info = {
> >  	.identity = "imx2+ watchdog",
> >-	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> >+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE
> >+		   | WDIOF_PRETIMEOUT,
> >  };
> >
> >  static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
> >@@ -207,12 +216,59 @@ static inline void imx2_wdt_ping_if_active(struct watchdog_device *wdog)
> >  	}
> >  }
> >
> >+static int imx2_wdt_check_pretimeout_set(struct imx2_wdt_device *wdev)
> >+{
> >+	u32 val;
> >+
> >+	regmap_read(wdev->regmap, IMX2_WDT_WICR, &val);
> >+	return (val & IMX2_WDT_WICR_WIE) ? 1 : 0;
> 
> I don't understand the point of this function.
> You check if IMX2_WDT_WICR_WIE is set,
>
Yes, looks no need check,just directly set this bit.
> >+}
> >+
> >+static int imx2_wdt_set_pretimeout(struct watchdog_device *wdog,
> >+				   unsigned int new_timeout)
> >+{
> >+	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> >+	u32 val;
> >+
> >+	regmap_read(wdev->regmap, IMX2_WDT_WICR, &val);
> >+	/* set the new pre-timeout value in the WSR */
> >+	val &= ~IMX2_WDT_WICR_WICT;
> >+	val |= WDOG_SEC_TO_PRECOUNT(new_timeout);
> >+
> 
> What is the time here ? Is pretimeout the number of seconds
> until the interrupt occurs, or the number of seconds before the actual
> timeout (as per API) ?
> 
The latter is.
> >+	if (!imx2_wdt_check_pretimeout_set(wdev))
> >+		val |= IMX2_WDT_WICR_WIE;	/*enable*/
> 
> if IMX2_WDT_WICR_WIE is not set, you set it,
> 
> >+
> >+	regmap_write(wdev->regmap, IMX2_WDT_WICR, val);
> >+
> 
> and write the result unconditionally. Unless I am missing something,
> 
> 	regmap_write, wdev->regmap, IMX2_WDT_WICR, val | IMX2_WDT_WICR_WIE);
> 
> would accomplish exactly the same.
> 
> >+	wdog->pretimeout = new_timeout;
> >+
> >+	return 0;
> >+}
> >+
> >+static irqreturn_t imx2_wdt_isr(int irq, void *dev_id)
> >+{
> >+	struct platform_device *pdev = dev_id;
> >+	struct watchdog_device *wdog = platform_get_drvdata(pdev);
> >+	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> >+	u32 val;
> >+
> >+	regmap_read(wdev->regmap, IMX2_WDT_WICR, &val);
> >+	if (val & IMX2_WDT_WICR_WTIS) {
> >+		/*clear interrupt status bit*/
> >+		regmap_write(wdev->regmap, IMX2_WDT_WICR, val);
> >+		dev_warn(&pdev->dev, "pre-timeout:%d, %d Seconds remained\n",
> >+			 wdog->pretimeout, wdog->timeout - wdog->pretimeout);
> 
> The idea here is that this should trigger a panic.
> 
Just add a print message, our customer will add what they want here.
> >+	}
> >+	return IRQ_HANDLED;
> >+}
> >+
> >  static const struct watchdog_ops imx2_wdt_ops = {
> >  	.owner = THIS_MODULE,
> >  	.start = imx2_wdt_start,
> >  	.stop = imx2_wdt_stop,
> >  	.ping = imx2_wdt_ping,
> >  	.set_timeout = imx2_wdt_set_timeout,
> >+	.set_pretimeout = imx2_wdt_set_pretimeout,
> >  };
> >
> >  static const struct regmap_config imx2_wdt_regmap_config = {
> >@@ -229,6 +285,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
> >  	struct resource *res;
> >  	void __iomem *base;
> >  	int ret;
> >+	int irq;
> >  	u32 val;
> >
> >  	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
> >@@ -253,6 +310,14 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
> >  		return PTR_ERR(wdev->clk);
> >  	}
> >
> >+	irq = platform_get_irq(pdev, 0);
> 
> This makes the irq mandatory. What if a platform doesn't have one configured ?
> 
> >+	ret = devm_request_irq(&pdev->dev, irq, imx2_wdt_isr, 0,
> >+			       dev_name(&pdev->dev), pdev);
> >+	if (ret) {
> >+		dev_err(&pdev->dev, "can't get irq %d\n", irq);
> 
> You got it, but you could not request it.
> 
> This is also a bit early, as the interrupt handler uses variables which are not yet
> initialized.
> 
Accept.
> >+		return ret;
> >+	}
> >+
> >  	wdog			= &wdev->wdog;
> >  	wdog->info		= &imx2_wdt_info;
> >  	wdog->ops		= &imx2_wdt_ops;
> >
> 
