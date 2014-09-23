Return-path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "wim@iguana.be" <wim@iguana.be>, "groeck7@gmail.com" <groeck7@gmail.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH] watchdog: imx2_wdt: Add power management support.
Date: Tue, 23 Sep 2014 01:44:05 +0000
Message-ID: <53bb086e6ff04fdf9683293a150a481a@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <20140922195425.GA2071@roeck-us.net>
In-Reply-To: <20140922195425.GA2071@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

> Subject: Re: [PATCH] watchdog: imx2_wdt: Add power management support.
>=20
> On Mon, Sep 22, 2014 at 06:00:52PM +0800, Xiubo Li wrote:
> > Add power management operations(suspend and resume) as part of
> > dev_pm_ops for IMX2 watchdog driver.
> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  drivers/watchdog/imx2_wdt.c | 47
> +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> > index 68c3d37..941c36f 100644
> > --- a/drivers/watchdog/imx2_wdt.c
> > +++ b/drivers/watchdog/imx2_wdt.c
> > @@ -295,6 +295,52 @@ static void imx2_wdt_shutdown(struct platform_devi=
ce
> *pdev)
> >  	}
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +/* Disable watchdog if it is active during suspend */
> > +static int imx2_wdt_suspend(struct device *dev)
> > +{
> > +	struct watchdog_device *wdog =3D dev_get_drvdata(dev);
> > +	struct imx2_wdt_device *wdev =3D watchdog_get_drvdata(wdog);
> > +
> > +	imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
> > +	imx2_wdt_ping(wdog);
> > +
> > +	/* Watchdog has been stopped but IP block is still running */
> > +	if (!watchdog_active(&wdog) && imx2_wdt_is_running(wdev))
>=20
> Turns out this has a bug.
>=20
> s/&wdog/wdog/
>=20
> Please resubmit.
>=20

Found lost one commit about fixing this and other comments.

Thanks,

BRs


> Thanks,
> Guenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
