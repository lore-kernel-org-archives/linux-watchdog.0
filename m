Return-Path: <Li.Xiubo@freescale.com>
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>, "wim@iguana.be" <wim@iguana.be>,
	"w.sang@pengutronix.de" <w.sang@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2 2/2] watchdog: imx2_wdt: Add big-endian support
Date: Mon, 31 Mar 2014 04:18:33 +0000
Message-ID: <28375308b05f4cf4bc7d1559f2524c1b@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395800500-22655-1-git-send-email-Li.Xiubo@freescale.com>
 <1395800500-22655-3-git-send-email-Li.Xiubo@freescale.com>
 <5338E1E8.4030700@roeck-us.net>
In-Reply-To: <5338E1E8.4030700@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>



> Subject: Re: [PATCHv2 2/2] watchdog: imx2_wdt: Add big-endian support
>=20
> On 03/25/2014 07:21 PM, Xiubo Li wrote:
> > For the platforms that this IP driver now supports:
> > SoC        CPU        Watchdog     Need 'big-endian'?
> > ------------------------------------------------------
> > Vybird     little     little       No
> > LS1        little     big          Yes
> > LS2        little     little       No
> > IMX+       little     little       No
> >
> > So for the LS1 SoCs, we need to do the big endianness converting.
> >
> > And this will also support the following case, for example:
> > SoC        CPU        Watchdog     Need 'big-endian'?
> > ------------------------------------------------------
> > PowerPC    big        big          Yes
> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
>=20
> Is this patch intended to solve the problem generically ?
>=20
> http://www.spinics.net/lists/kernel/msg1714375.html
>

It's actually the following ones first, which will support 16-bits
Values for regmap-mmio:

https://patchwork.kernel.org/patch/3896321/
https://patchwork.kernel.org/patch/3896331/
https://patchwork.kernel.org/patch/3901021/

And the then the following one, which will support the LE endian:
http://www.spinics.net/lists/kernel/msg1714375.html


Thanks :)

BRs
Xiubo




=20
> Guenter
>=20
> > ---
> >   drivers/watchdog/imx2_wdt.c | 40 +++++++++++++++++++++++++++++++-----=
----
> >   1 file changed, 31 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> > index 1795922..32f8874 100644
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
> >   static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > @@ -87,7 +105,7 @@ static const struct watchdog_info imx2_wdt_info =3D =
{
> >
> >   static inline void imx2_wdt_setup(void)
> >   {
> > -	u16 val =3D __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
> > +	u16 val =3D imx2_wdt_readw(imx2_wdt.base + IMX2_WDT_WCR);
> >
> >   	/* Suspend timer in low power mode, write once-only */
> >   	val |=3D IMX2_WDT_WCR_WDZST;
> > @@ -100,17 +118,17 @@ static inline void imx2_wdt_setup(void)
> >   	/* Set the watchdog's Time-Out value */
> >   	val |=3D WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
> >
> > -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> > +	imx2_wdt_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> >
> >   	/* enable the watchdog */
> >   	val |=3D IMX2_WDT_WCR_WDE;
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
> > -	u16 val =3D __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
> > +	u16 val =3D imx2_wdt_readw(imx2_wdt.base + IMX2_WDT_WCR);
> >
> >   	/* set the new timeout value in the WSR */
> >   	val &=3D ~IMX2_WDT_WCR_WT;
> >   	val |=3D WDOG_SEC_TO_COUNT(new_timeout);
> > -	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> > +	imx2_wdt_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> >   }
> >
> >   static int imx2_wdt_open(struct inode *inode, struct file *file)
> > @@ -192,7 +210,7 @@ static long imx2_wdt_ioctl(struct file *file, unsig=
ned
> int cmd,
> >   		return put_user(0, p);
> >
> >   	case WDIOC_GETBOOTSTATUS:
> > -		val =3D __raw_readw(imx2_wdt.base + IMX2_WDT_WRSR);
> > +		val =3D imx2_wdt_readw(imx2_wdt.base + IMX2_WDT_WRSR);
> >   		new_value =3D val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
> >   		return put_user(new_value, p);
> >
> > @@ -257,8 +275,12 @@ static struct miscdevice imx2_wdt_miscdev =3D {
> >
> >   static int __init imx2_wdt_probe(struct platform_device *pdev)
> >   {
> > -	int ret;
> > +	struct device_node *np =3D pdev->dev.of_node;
> >   	struct resource *res;
> > +	int ret;
> > +
> > +	if (np)
> > +		imx2_wdt.big_endian =3D of_property_read_bool(np, "big-endian");
> >
> >   	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >   	imx2_wdt.base =3D devm_ioremap_resource(&pdev->dev, res);
> >
>=20
>=20
