Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:38903 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114AbbKZJi3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Nov 2015 04:38:29 -0500
From: Harald Geyer <harald@ccbib.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	Wolfram Sang <wsa@the-dreams.de>, kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCHv3 1/2] watchdog: stmp3xxx: Stop the watchdog on system halt
In-reply-to: <20151126071011.GL19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org> <20151126071011.GL19888@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-ID: <1607.1448530696.1@stardust.g4.wien.funkfeuer.at>
Content-Transfer-Encoding: QUOTED-PRINTABLE
Date: Thu, 26 Nov 2015 10:38:17 +0100
Message-Id: <E1a1t0L-0000Px-5k@stardust.g4.wien.funkfeuer.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Uwe.

Uwe Kleine-K=C3=B6nig writes:
> Hello,
>=20
> On Wed, Oct 07, 2015 at 12:19:11PM +0000, Harald Geyer wrote:
> > This allows the system to actually halt even if userspace forgot to
> > disable the watchdog first. Old behaviour was that the watchdog for=
ced
> > the system to boot again.
> >=20
> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> > ---
> > Changes since v2:
> > * split this out as a separate patch
> >=20
> >  drivers/watchdog/stmp3xxx_rtc_wdt.c |   28 +++++++++++++++++++++++=
+++++
> >  1 file changed, 28 insertions(+)
> >=20
> > diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog=
/stmp3xxx_rtc_wdt.c
> > index 3ee6128..e09a01f 100644
> > --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> > +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/watchdog.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/stmp3xxx_rtc_wdt.h>
> > +#include <linux/notifier.h>
> > +#include <linux/reboot.h>
> > =20
> >  #define WDOG_TICK_RATE 1000 /* 1 kHz clock */
> >  #define STMP3XXX_DEFAULT_TIMEOUT 19
> > @@ -69,6 +71,28 @@ static struct watchdog_device stmp3xxx_wdd =3D {
> >  	.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS,
> >  };
> > =20
> > +static int wdt_notify_sys(struct notifier_block *nb, unsigned long=
 code,
> > +			  void *unused)
> > +{
> > +	struct device *dev =3D watchdog_get_drvdata(&stmp3xxx_wdd);
> > +	struct stmp3xxx_wdt_pdata *pdata =3D dev_get_platdata(dev);
> > +
> > +	switch (code) {
> > +	case SYS_DOWN:	/* keep enabled, system might crash while going do=
wn */
> > +		break;
> > +	case SYS_HALT:  /* allow the system to actually halt */
>=20
> <nitpick>
> You used a tab before the comment "keep enabled ...", but spaces for
> "allow the system ...".
> </nitpick>

Ok
=20
> > +	case SYS_POWER_OFF:
> > +		wdt_stop(&stmp3xxx_wdd);
> > +		break;
> > +	}
> > +
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block wdt_notifier =3D {
> > +	.notifier_call  =3D wdt_notify_sys,
>=20
> s/  / /

Ok

> > +};
> > +
> >  static int stmp3xxx_wdt_probe(struct platform_device *pdev)
> >  {
> >  	int ret;
> > @@ -84,6 +108,9 @@ static int stmp3xxx_wdt_probe(struct platform_de=
vice *pdev)
> >  		return ret;
> >  	}
> > =20
> > +	if (register_reboot_notifier(&wdt_notifier))
> > +		dev_warn(&pdev->dev, "cannot register reboot notifier\n");
>=20
> OK, you don't fail when registering the notifier fails, but ...
>=20
> >  	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
> >  			stmp3xxx_wdd.timeout);
> >  	return 0;
> > @@ -91,6 +118,7 @@ static int stmp3xxx_wdt_probe(struct platform_de=
vice *pdev)
> > =20
> >  static int stmp3xxx_wdt_remove(struct platform_device *pdev)
> >  {
> > +	unregister_reboot_notifier(&wdt_notifier);
>=20
> ... I think it's not ok to unconditionally unregister it then, is it?
> (Looking at how unregister_reboot_notifier is implemented it might wo=
rk
> as intended, but if that's only by chance I wouldn't rely on it.)

I'm not sure what you refer to by "how unregister_reboot_notifier is
implemented". The documentation for unregister_reboot_notifier says:
/**
  *      unregister_reboot_notifier - Unregister previously registered =
reboot notifier
  *      @nb: Hook to be unregistered
  *
  *      Unregisters a previously registered reboot
  *      notifier function.
  *
  *      Returns zero on success, or %-ENOENT on failure.
  */

If register_reboot_notifier failed, then unregister_reboot_notifier wil=
l
simply return -ENOENT, I don't see a problem here. As this is documente=
d
API I think we can rely on it.

Can you also have a look at the following patch (next in this series,
unfortunately I failed a formatting the subject prefix properly):
http://www.spinics.net/lists/linux-watchdog/msg07483.html

That one is particularly messy, as I don't have all the HW documentatio=
n
I wish I had, so I'd appreciate if somebody, who has experience with
the hardware, looked at it.

Thanks,
Harald

> Best regards
> Uwe
>=20
> >  	watchdog_unregister_device(&stmp3xxx_wdd);
> >  	return 0;
> >  }
> > --=20
> > 1.7.10.4
> >=20
> >=20
> >=20
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig   =
         |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |

--=20
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via bitcoin to 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
