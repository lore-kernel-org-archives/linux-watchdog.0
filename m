Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35818 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbK0KDH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Nov 2015 05:03:07 -0500
Date: Fri, 27 Nov 2015 11:02:54 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	Wolfram Sang <wsa@the-dreams.de>, kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151127100254.GR19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
 <1444220352-20548-2-git-send-email-harald@ccbib.org>
 <20151126092526.GM19888@pengutronix.de>
 <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
> Hi Uwe,
>=20
> thanks for looking into this.
>=20
> Uwe Kleine-K=F6nig writes:
> > On Wed, Oct 07, 2015 at 12:19:12PM +0000, Harald Geyer wrote:
> > > This device doesn't provide any information about boot status.
> > > As workaround we use a persitent bit to track watchdog activity.
> >=20
> > Hmm, so you set a bit in a persistent register iff the watchdog is
> > running.  And if that bit is set during probe you assume the watchd=
og
> > reset the machine. But this also happens, when the user presses the
> > reset button which makes the detection unreliable.
>=20
> Yes, kind of. I'm using this driver on an imx233-olinuxino, where the
> reset button causes the device to power cycle and thus clears the
> persitent bit. So I can't test your case, but surely there are some p=
aths
> into reset, that don't clear the bit and cause false positives.

OK, I found a i.MX28 machine in our repository:

	barebox# mw 0x80056080 0xbabecafe
	barebox# boot
	...
	linux# reboot
	barebox# md 0x80056080+4
	80056080: babecafe

After a power cycle the value disappears (I didn't check the details, i=
f
there is a battery it might be empty).

> I have considered gathering some additional information from the
> power subsystem to refine the result, but decided that it's not
> worth the complexity. Since the power system is a different silicon
> block, we can't rely on it being available and would need to provide
> a fall back implementation anyway.

It would be really nice to get some details about boot rom usage of the
persistent flags in use. I'd expect that these allow to determine the
boot source.

> > >   */
> > > =20
> > >  static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 tim=
eout)
> > > @@ -93,16 +111,30 @@ static void stmp3xxx_wdt_set_timeout(struct =
device *dev, u32 timeout)
> > >  		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_SET)=
;
> > >  		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
> > >  		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_R=
EG_SET);
> > > +		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> > > +		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_R=
EG_SET);
> > >  	} else {
> > >  		writel(STMP3XXX_RTC_CTRL_WATCHDOGEN,
> > >  		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR)=
;
> > >  		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
> > >  		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_R=
EG_CLR);
> > > +		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> > > +		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_R=
EG_CLR);
> >=20
> > checkpatch tells:
> >=20
> > WARNING: line over 80 characters
> > #131: FILE: drivers/rtc/rtc-stmp3xxx.c:115:
> > +                      rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + ST=
MP_OFFSET_REG_SET);
> >=20
> > WARNING: line over 80 characters
> > #138: FILE: drivers/rtc/rtc-stmp3xxx.c:122:
> > +                      rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + ST=
MP_OFFSET_REG_CLR);
>=20
> I tried to follow the style of the surrounding code. If there is a cl=
ear
> statement about the preferred style for this driver from whoever is
> responsible, I will happily change my patch to whatever it is.

Yeah, I don't care much. I would have broken the newly introduced lines=
,
but I'd not go so far to nack your patch when you don't.

> > >  	}
> > >  }
> > > =20
> > > +static void stmp3xxx_wdt_clear_bootstatus(struct device *dev)
> > > +{
> > > +	struct stmp3xxx_rtc_data *rtc_data =3D dev_get_drvdata(dev);
> > > +
> > > +	writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> > > +	       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_RE=
G_CLR);
> > > +}
> > > +
> > >  static struct stmp3xxx_wdt_pdata wdt_pdata =3D {
> > >  	.wdt_set_timeout =3D stmp3xxx_wdt_set_timeout,
> > > +	.wdt_clear_bootstatus =3D stmp3xxx_wdt_clear_bootstatus,
> > > +	.bootstatus =3D 0,
> > >  };
> >=20
> > This is out of the scope of your patch, but IMHO wdt_pdata should b=
e
> > const in case it is used for >1 device.
>=20
> Hm, if you want to change wdt_pdata to const, then I can't add the
> bootstatus field. But I think you can't change this to const anyway,
> because the platform_data pointer of struct device is not a const voi=
d
> pointer. However didn't look into this in detail, so maybe I'm missin=
g
> something ...

Conceptually platform data should be const for a driver, not necessaril=
y
for the code that sets it up. So the right thing to do is to add a cons=
t
to struct device::platform_data. That is usually not in the way during
creation of the device, but stops drivers to modify it.

Then you can do in stmp3xxx_wdt_register:

	struct ... pdata =3D {
		.wdt_set_timeout =3D stmp3xxx_wdt_set_timeout,
		.bootstatus =3D whatever;
	};
	struct platform_device_info pdevinfo =3D {
		.parent =3D &rtc_pdev->dev;
		.data =3D pdata;
		.size_data =3D sizeof(pdata);
	}
	platform_device_register_full(&pdevinfo);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
