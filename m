Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56441 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbaCCJjr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Mar 2014 04:39:47 -0500
Date: Mon, 3 Mar 2014 10:39:43 +0100
From: Markus Pargmann <mpa@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: core: module param to activate watchdog
Message-ID: <20140303093943.GC24953@pengutronix.de>
References: <1393604183-8755-1-git-send-email-mpa@pengutronix.de>
 <5312BD76.2080102@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <5312BD76.2080102@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 01, 2014 at 09:11:18PM -0800, Guenter Roeck wrote:
> On 02/28/2014 08:16 AM, Markus Pargmann wrote:
> >Many watchdog driver reset the watchdog device on initialization. This
> >is a problem if the watchdog is activated by the bootloader and should
> >be active the whole time until the userspace can write to it.
> >
>=20
> Shouldn't those watchdog drivers be fixed to keep the watchdog running
> if it was already active ? Otherwise there is still the time between
> driver initialization, which disables the watchdog, and it being re-enabl=
ed
> by watchdog registration.

Yes there is still a time between stopping watchdog and reenabling it.
But as mentioned in the other mail, I think this should be some generic
solution. Also the watchdog core would not know that the watchdog device
is active when the watchdog driver keeps it running.

>=20
> Also, does this affect or impact drivers which _do_ keep the watchdog
> enabled ?

I don't know of such a driver. However those drivers would have to
expect that they are started at some point through the watchdog core. At
least when someone opens the watchdog device and pings it.

>=20
> >This patch adds a module parameter (watchdog.activate_first) that
> >activates the first registered watchdog. Using this parameter it is
> >possible to have an active watchdog during the whole boot process.
> >
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >---
> >  drivers/watchdog/watchdog_core.c |  4 ++++
> >  drivers/watchdog/watchdog_core.h |  4 ++++
> >  drivers/watchdog/watchdog_dev.c  | 21 ++++++++++++++++++++-
> >  3 files changed, 28 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdo=
g_core.c
> >index cec9b55..6db16eb 100644
> >--- a/drivers/watchdog/watchdog_core.c
> >+++ b/drivers/watchdog/watchdog_core.c
> >@@ -43,6 +43,10 @@
> >  static DEFINE_IDA(watchdog_ida);
> >  static struct class *watchdog_class;
> >
> >+unsigned int activate_first =3D 0;
>=20
> Bad variable name for a global variable.
>=20
> >+module_param(activate_first, uint, 0);
> >+MODULE_PARM_DESC(activate_first, "Activation timeout for first watchdog=
 registered. 0 means no activation.");
> >+
>=20
> Does that _have_ to be in this file ? Would be much easier
> if it was in watchdog_dev.c, where it is used.

As far as I know, it has to be in this file, as this is the watchdog
module. Perhaps I can try to move it to watchdog_dev.c somehow.

I will fix the other comments if there is a second version of this
patch.

Thanks,

Markus


>=20
> >  static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
> >  {
> >  	/*
> >diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdo=
g_core.h
> >index 6c95141..4526170 100644
> >--- a/drivers/watchdog/watchdog_core.h
> >+++ b/drivers/watchdog/watchdog_core.h
> >@@ -28,6 +28,10 @@
> >
> >  #define MAX_DOGS	32	/* Maximum number of watchdog devices */
> >
> >+/* Activate first registered watchdog and set this as the timeout value
> >+ * (only !=3D 0) */
>=20
> Coding style.
>=20
> >+extern unsigned int activate_first;
> >+
> >  /*
> >   *	Functions/procedures to be called by the core
> >   */
> >diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog=
_dev.c
> >index 6aaefba..fe60fdc 100644
> >--- a/drivers/watchdog/watchdog_dev.c
> >+++ b/drivers/watchdog/watchdog_dev.c
> >@@ -553,8 +553,27 @@ int watchdog_dev_register(struct watchdog_device *w=
atchdog)
> >  			misc_deregister(&watchdog_miscdev);
> >  			old_wdd =3D NULL;
> >  		}
> >+
>=20
> Is that extra empty line really necessary ?
>=20
> >+		return err;
> >  	}
> >-	return err;
> >+
> >+	if (activate_first && watchdog->id =3D=3D 0) {
> >+		err =3D watchdog_set_timeout(watchdog, activate_first);
> >+		if (err && err !=3D -EOPNOTSUPP) {
> >+			pr_err("watchdog%d failed to set timeout for first activation\n",
> >+					watchdog->id);
> >+			return err;
> >+		}
> >+
> >+		err =3D watchdog_start(watchdog);
> >+		if (err) {
> >+			pr_err("watchdog%d failed to start first watchdog\n",
> >+					watchdog->id);
> >+			return err;
> >+		}
> >+	}
> >+
> >+	return 0;
> >  }
> >
> >  /*
> >
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTFE3fAAoJEEpcgKtcEGQQ8nsP/iQ3tqDUEIpEZpK2Ysel24Cb
hMPivhINjrbunJds03m00iDXqO88fzN1Gkx8rkikqDznQDnCBDAbdReG/g0A8+d+
HC0E85jFLk/e7sjQf4QQd2CFemEUVz/dz3gSYi035YjbxBe/mV4hH6tRWa9GF5TF
3PNzYdm+7HcFdhuckkF5r2K+Hzb3AFTq/MML7Kvs6c83TA7Y8snXNv18qEoZIOKc
yKZKjAm/UfcXlcRGA6D7b0o2OCDvKVabw/FU0zkeQU9AIIBrGKLYB+RjYQ0iGfTz
hMEIm01C6weWujkA7ZXQ3j4rIg9Q66Hef445QPV1BhVB99TkOCd/Q3wrewoRjSb8
snNtjCapine5V0ZEb6+OgW2Ihb0DY4JHLOnb6ahJyuESI2s94gWCiJ+DsMFTQqVn
AGkS2aN6DiQAdbhCfN6RlpFha40Y+hexYDuKsRtbN+Fsl6w4SgPZKcPSSstrmi7z
BBBrc109OlokVKtXoIMh2mpFi9EFVv3Ck0E/gQjXVYZuCKXhZDjULzUclnK07xog
UR1FHgDl0iDzRb5nYnUdkcoFXOXPzVTJPCS6iGE+jYM8zR0CMwB3cKZ+C8qCwAxi
e2Jm8CpJ2tmquJ80q03uGZDejAOnSm6w2MRWzDZnehhYTbO+q15LZh9ZMep1qHk7
DTiiUxUYIi94qRmMC8jh
=kZ0J
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
