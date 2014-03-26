Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1lp0139.outbound.protection.outlook.com ([207.46.163.139]:46502
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751314AbaCZCiQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Mar 2014 22:38:16 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>,
	"wim@iguana.be" <wim@iguana.be>,
	"w.sang@pengutronix.de" <w.sang@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] watchdog: imx2_wdt: Add big-endian support
Date: Wed, 26 Mar 2014 02:23:59 +0000
Message-ID: <aad28f70810b4f4b9086ba65e21327a2@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395740132-21396-1-git-send-email-Li.Xiubo@freescale.com>
 <1395740132-21396-3-git-send-email-Li.Xiubo@freescale.com>
 <533234DB.1030705@roeck-us.net>
In-Reply-To: <533234DB.1030705@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


> Subject: Re: [PATCH 2/2] watchdog: imx2_wdt: Add big-endian support
> 
> On 03/25/2014 02:35 AM, Xiubo Li wrote:
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> 
> There is no explanation for this patch in the headline.
> 
> Ultimately there are four cases
> 	CPU	HW
> 	little	little
This case for most IMX* and Vybird and the LS2 SoCs.



> 	little	 big
This case for LS1 SoC.



> 	big	little
Actually, this case hasn't ever occurs for this IP, but maybe in the
Feature, not now.



> 	big	big
This case maybe for the PowrPC SoCs.



> Current code handles big/big as well as little/little, and you are adding
> little/big to the list of supported combinations. Questions are
> 1) which combinations are possible ?
> 2) is big/little a combination which needs to be handled as well ?
> 

Yes, I originally intended to use the Regmap APIs, but it couldn't support
The 16bit registers accessing now, and also won't support the [bit  little]
case too.

So now this driver will only support the following three cases:
CPU        IP
Little     little
Little     big
Big        big

If there hasn't any other problems, I will resend this patches adding this
Information.



> The "big-endians" property is new and will have to be approved by the
> DT maintainers. If in fact needed, I would suggest to use "big-endian"
> as this seems to be more common.
>

Yes, There has other IP driver has been accepted by DT maintainers. So
After this I will send the DT patches to them.

 
Thanks very much,

Best Regards,
Xiubo



> Guenter
> 
> 
> >   drivers/watchdog/imx2_wdt.c | 40 +++++++++++++++++++++++++++++++---------
> >   1 file changed, 31 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> > index 1795922..c410981 100644
> > --- a/drivers/watchdog/imx2_wdt.c
> > +++ b/drivers/watchdog/imx2_wdt.c
> > @@ -30,6 +30,7 @@
> >   #include <linux/miscdevice.h>
> >   #include <linux/module.h>
> >   #include <linux/moduleparam.h>
> > +#include <linux/of.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/timer.h>
> >   #include <linux/uaccess.h>
> > @@ -64,9 +65,26 @@ static struct {
> >   	void __iomem *base;
> >   	unsigned timeout;
> >   	unsigned long status;
> > +	bool big_endian;
> >   	struct timer_list timer;	/* Pings the watchdog when closed */
> >   } imx2_wdt;
> >
> > +static inline u16 imx2_wdt_readw(void __iomem *addr)
> > +{
> > +	if (imx2_wdt.big_endian)
> > +		return ioread16be(addr);
> > +	else
> > +		return ioread16(addr);
> > +}
> > +
> > +static inline void imx2_wdt_writew(u16 val, void __iomem *addr)
> > +{
> > +	if (imx2_wdt.big_endian)
> > +		iowrite16be(val, addr);
> > +	else
> > +		iowrite16(val, addr);
> > +}
> > +
> >   static struct miscdevice imx2_wdt_miscdev;
> >
> >   static bool nowayout = WATCHDOG_NOWAYOUT;
> > @@ -87,7 +105,7 @@ static const struct watchdog_info imx2_wdt_info = {
> >
> >   static inline void imx2_wdt_setup(void)
> >   {
> > -	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
> > +	u16 val = imx2_wdt_readw(imx2_wdt.base + IMX2_WDT_WCR);
> >
> >   	/* Suspend timer in low power mode, write once-only */
> >   	val |= IMX2_WDT_WCR_WDZST;
> > @@ -100,17 +118,17 @@ static inline void imx2_wdt_setup(void)
> >   	/* Set the watchdog's Time-Out value */
> >   	val |= WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
> >
> > -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> > +	imx2_wdt_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> >
> >   	/* enable the watchdog */
> >   	val |= IMX2_WDT_WCR_WDE;
> > -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> > +	imx2_wdt_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> >   }
> >
> >   static inline void imx2_wdt_ping(void)
> >   {
> > -	__raw_writew(IMX2_WDT_SEQ1, imx2_wdt.base + IMX2_WDT_WSR);
> > -	__raw_writew(IMX2_WDT_SEQ2, imx2_wdt.base + IMX2_WDT_WSR);
> > +	imx2_wdt_writew(IMX2_WDT_SEQ1, imx2_wdt.base + IMX2_WDT_WSR);
> > +	imx2_wdt_writew(IMX2_WDT_SEQ2, imx2_wdt.base + IMX2_WDT_WSR);
> >   }
> >
> >   static void imx2_wdt_timer_ping(unsigned long arg)
> > @@ -143,12 +161,12 @@ static void imx2_wdt_stop(void)
> >
> >   static void imx2_wdt_set_timeout(int new_timeout)
> >   {
> > -	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
> > +	u16 val = imx2_wdt_readw(imx2_wdt.base + IMX2_WDT_WCR);
> >
> >   	/* set the new timeout value in the WSR */
> >   	val &= ~IMX2_WDT_WCR_WT;
> >   	val |= WDOG_SEC_TO_COUNT(new_timeout);
> > -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> > +	imx2_wdt_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> >   }
> >
> >   static int imx2_wdt_open(struct inode *inode, struct file *file)
> > @@ -192,7 +210,7 @@ static long imx2_wdt_ioctl(struct file *file, unsigned
> int cmd,
> >   		return put_user(0, p);
> >
> >   	case WDIOC_GETBOOTSTATUS:
> > -		val = __raw_readw(imx2_wdt.base + IMX2_WDT_WRSR);
> > +		val = imx2_wdt_readw(imx2_wdt.base + IMX2_WDT_WRSR);
> >   		new_value = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
> >   		return put_user(new_value, p);
> >
> > @@ -257,8 +275,12 @@ static struct miscdevice imx2_wdt_miscdev = {
> >
> >   static int __init imx2_wdt_probe(struct platform_device *pdev)
> >   {
> > -	int ret;
> > +	struct device_node *np = pdev->dev.of_node;
> >   	struct resource *res;
> > +	int ret;
> > +
> > +	if (np)
> > +		imx2_wdt.big_endian = of_property_read_bool(np, "big-endians");
> >
> >   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >   	imx2_wdt.base = devm_ioremap_resource(&pdev->dev, res);
> >
> 
> 

