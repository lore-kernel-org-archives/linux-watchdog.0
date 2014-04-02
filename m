Return-Path: <shawn.guo@linaro.org>
Date: Wed, 2 Apr 2014 21:08:17 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
CC: <linux@roeck-us.net>, <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 2/2] watchdog: imx2_wdt: convert to use regmap API.
Message-ID: <20140402130812.GD8558@dragon>
References: <1396327598-28535-1-git-send-email-Li.Xiubo@freescale.com>
 <1396327598-28535-3-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1396327598-28535-3-git-send-email-Li.Xiubo@freescale.com>
Return-Path: shawn.guo@linaro.org
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Apr 01, 2014 at 12:46:38PM +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

We should probably have some commit log to explain why we need to move
to use regmap API.

Shawn

> ---
>  drivers/watchdog/imx2_wdt.c | 50 +++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 1795922..76fa724 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -31,6 +31,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/timer.h>
>  #include <linux/uaccess.h>
>  #include <linux/watchdog.h>
> @@ -61,7 +62,7 @@
>  
>  static struct {
>  	struct clk *clk;
> -	void __iomem *base;
> +	struct regmap *regmap;
>  	unsigned timeout;
>  	unsigned long status;
>  	struct timer_list timer;	/* Pings the watchdog when closed */
> @@ -87,7 +88,9 @@ static const struct watchdog_info imx2_wdt_info = {
>  
>  static inline void imx2_wdt_setup(void)
>  {
> -	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
> +	u32 val;
> +
> +	regmap_read(imx2_wdt.regmap, IMX2_WDT_WCR, &val);
>  
>  	/* Suspend timer in low power mode, write once-only */
>  	val |= IMX2_WDT_WCR_WDZST;
> @@ -100,17 +103,17 @@ static inline void imx2_wdt_setup(void)
>  	/* Set the watchdog's Time-Out value */
>  	val |= WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
>  
> -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> +	regmap_write(imx2_wdt.regmap, IMX2_WDT_WCR, val);
>  
>  	/* enable the watchdog */
>  	val |= IMX2_WDT_WCR_WDE;
> -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> +	regmap_write(imx2_wdt.regmap, IMX2_WDT_WCR, val);
>  }
>  
>  static inline void imx2_wdt_ping(void)
>  {
> -	__raw_writew(IMX2_WDT_SEQ1, imx2_wdt.base + IMX2_WDT_WSR);
> -	__raw_writew(IMX2_WDT_SEQ2, imx2_wdt.base + IMX2_WDT_WSR);
> +	regmap_write(imx2_wdt.regmap, IMX2_WDT_WSR, IMX2_WDT_SEQ1);
> +	regmap_write(imx2_wdt.regmap, IMX2_WDT_WSR, IMX2_WDT_SEQ2);
>  }
>  
>  static void imx2_wdt_timer_ping(unsigned long arg)
> @@ -143,12 +146,8 @@ static void imx2_wdt_stop(void)
>  
>  static void imx2_wdt_set_timeout(int new_timeout)
>  {
> -	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
> -
> -	/* set the new timeout value in the WSR */
> -	val &= ~IMX2_WDT_WCR_WT;
> -	val |= WDOG_SEC_TO_COUNT(new_timeout);
> -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> +	regmap_update_bits(imx2_wdt.regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
> +			   WDOG_SEC_TO_COUNT(new_timeout));
>  }
>  
>  static int imx2_wdt_open(struct inode *inode, struct file *file)
> @@ -181,7 +180,7 @@ static long imx2_wdt_ioctl(struct file *file, unsigned int cmd,
>  	void __user *argp = (void __user *)arg;
>  	int __user *p = argp;
>  	int new_value;
> -	u16 val;
> +	u32 val;
>  
>  	switch (cmd) {
>  	case WDIOC_GETSUPPORT:
> @@ -192,7 +191,7 @@ static long imx2_wdt_ioctl(struct file *file, unsigned int cmd,
>  		return put_user(0, p);
>  
>  	case WDIOC_GETBOOTSTATUS:
> -		val = __raw_readw(imx2_wdt.base + IMX2_WDT_WRSR);
> +		regmap_read(imx2_wdt.regmap, IMX2_WDT_WRSR, &val);
>  		new_value = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
>  		return put_user(new_value, p);
>  
> @@ -255,15 +254,30 @@ static struct miscdevice imx2_wdt_miscdev = {
>  	.fops = &imx2_wdt_fops,
>  };
>  
> +static struct regmap_config imx2_wdt_regmap_config = {
> +	.reg_bits = 16,
> +	.reg_stride = 2,
> +	.val_bits = 16,
> +	.max_register = 0x8,
> +};
> +
>  static int __init imx2_wdt_probe(struct platform_device *pdev)
>  {
> -	int ret;
>  	struct resource *res;
> +	void __iomem *base;
> +	int ret;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	imx2_wdt.base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(imx2_wdt.base))
> -		return PTR_ERR(imx2_wdt.base);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	imx2_wdt.regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
> +						    &imx2_wdt_regmap_config);
> +	if (IS_ERR(imx2_wdt.regmap)) {
> +		dev_err(&pdev->dev, "regmap init failed\n");
> +		return PTR_ERR(imx2_wdt.regmap);
> +	}
>  
>  	imx2_wdt.clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(imx2_wdt.clk)) {
> -- 
> 1.8.4
> 
> 
