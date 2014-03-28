Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "wim@iguana.be" <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        Shawn Guo <Shawn.Guo@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: FW: [PATCHv2 2/2] watchdog: imx2_wdt: Add big-endian support
Date: Fri, 28 Mar 2014 04:15:41 +0000
Message-ID: <46a95056197146bcaef0acafc4ab6877@BY2PR03MB505.namprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Forward to Shawn,

Thanks,



> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Wednesday, March 26, 2014 10:22 AM
> To: wim@iguana.be; w.sang@pengutronix.de; linux-watchdog@vger.kernel.org;
> linux@roeck-us.net
> Cc: linux-kernel@vger.kernel.org; Xiubo Li-B47053
> Subject: [PATCHv2 2/2] watchdog: imx2_wdt: Add big-endian support
> 
> For the platforms that this IP driver now supports:
> SoC        CPU        Watchdog     Need 'big-endian'?
> ------------------------------------------------------
> Vybird     little     little       No
> LS1        little     big          Yes
> LS2        little     little       No
> IMX+       little     little       No
> 
> So for the LS1 SoCs, we need to do the big endianness converting.
> 
> And this will also support the following case, for example:
> SoC        CPU        Watchdog     Need 'big-endian'?
> ------------------------------------------------------
> PowerPC    big        big          Yes
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/imx2_wdt.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 1795922..32f8874 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -30,6 +30,7 @@
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/timer.h>
>  #include <linux/uaccess.h>
> @@ -64,9 +65,26 @@ static struct {
>  	void __iomem *base;
>  	unsigned timeout;
>  	unsigned long status;
> +	bool big_endian;
>  	struct timer_list timer;	/* Pings the watchdog when closed */
>  } imx2_wdt;
> 
> +static inline u16 imx2_wdt_readw(void __iomem *addr)
> +{
> +	if (imx2_wdt.big_endian)
> +		return ioread16be(addr);
> +	else
> +		return ioread16(addr);
> +}
> +
> +static inline void imx2_wdt_writew(u16 val, void __iomem *addr)
> +{
> +	if (imx2_wdt.big_endian)
> +		iowrite16be(val, addr);
> +	else
> +		iowrite16(val, addr);
> +}
> +
>  static struct miscdevice imx2_wdt_miscdev;
> 
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -87,7 +105,7 @@ static const struct watchdog_info imx2_wdt_info = {
> 
>  static inline void imx2_wdt_setup(void)
>  {
> -	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
> +	u16 val = imx2_wdt_readw(imx2_wdt.base + IMX2_WDT_WCR);
> 
>  	/* Suspend timer in low power mode, write once-only */
>  	val |= IMX2_WDT_WCR_WDZST;
> @@ -100,17 +118,17 @@ static inline void imx2_wdt_setup(void)
>  	/* Set the watchdog's Time-Out value */
>  	val |= WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
> 
> -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> +	imx2_wdt_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> 
>  	/* enable the watchdog */
>  	val |= IMX2_WDT_WCR_WDE;
> -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> +	imx2_wdt_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
>  }
> 
>  static inline void imx2_wdt_ping(void)
>  {
> -	__raw_writew(IMX2_WDT_SEQ1, imx2_wdt.base + IMX2_WDT_WSR);
> -	__raw_writew(IMX2_WDT_SEQ2, imx2_wdt.base + IMX2_WDT_WSR);
> +	imx2_wdt_writew(IMX2_WDT_SEQ1, imx2_wdt.base + IMX2_WDT_WSR);
> +	imx2_wdt_writew(IMX2_WDT_SEQ2, imx2_wdt.base + IMX2_WDT_WSR);
>  }
> 
>  static void imx2_wdt_timer_ping(unsigned long arg)
> @@ -143,12 +161,12 @@ static void imx2_wdt_stop(void)
> 
>  static void imx2_wdt_set_timeout(int new_timeout)
>  {
> -	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
> +	u16 val = imx2_wdt_readw(imx2_wdt.base + IMX2_WDT_WCR);
> 
>  	/* set the new timeout value in the WSR */
>  	val &= ~IMX2_WDT_WCR_WT;
>  	val |= WDOG_SEC_TO_COUNT(new_timeout);
> -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> +	imx2_wdt_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
>  }
> 
>  static int imx2_wdt_open(struct inode *inode, struct file *file)
> @@ -192,7 +210,7 @@ static long imx2_wdt_ioctl(struct file *file, unsigned int
> cmd,
>  		return put_user(0, p);
> 
>  	case WDIOC_GETBOOTSTATUS:
> -		val = __raw_readw(imx2_wdt.base + IMX2_WDT_WRSR);
> +		val = imx2_wdt_readw(imx2_wdt.base + IMX2_WDT_WRSR);
>  		new_value = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
>  		return put_user(new_value, p);
> 
> @@ -257,8 +275,12 @@ static struct miscdevice imx2_wdt_miscdev = {
> 
>  static int __init imx2_wdt_probe(struct platform_device *pdev)
>  {
> -	int ret;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct resource *res;
> +	int ret;
> +
> +	if (np)
> +		imx2_wdt.big_endian = of_property_read_bool(np, "big-endian");
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx2_wdt.base = devm_ioremap_resource(&pdev->dev, res);
> --
> 1.8.4
> 
