Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46331 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbaCCJ1v (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Mar 2014 04:27:51 -0500
Date: Mon, 3 Mar 2014 10:27:48 +0100
From: Markus Pargmann <mpa@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: core: module param to activate watchdog
Message-ID: <20140303092747.GB24953@pengutronix.de>
References: <1393604183-8755-1-git-send-email-mpa@pengutronix.de>
 <20140302094323.GS1484@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20140302094323.GS1484@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Sun, Mar 02, 2014 at 10:43:23AM +0100, Wim Van Sebroeck wrote:
> Hi Markus,
>=20
> > Many watchdog driver reset the watchdog device on initialization. This
> > is a problem if the watchdog is activated by the bootloader and should
> > be active the whole time until the userspace can write to it.
> >=20
> > This patch adds a module parameter (watchdog.activate_first) that
> > activates the first registered watchdog. Using this parameter it is
> > possible to have an active watchdog during the whole boot process.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>=20
> NAK. It is the responsibility of the watchdog device driver to do this
> and not that of the core. The core can't know which device(s) are=20
> running and can't be turned off. So you can have more then 1 device=20
> that needs to keep going...
>=20
> The normal way do this is by using a timer. Take a look at=20
> at91sam9_wdt.c . We have a timer there that pings the watchdog if
> 1) the watchdog device is not active for userspace (so before opening
> /dev/watchdog and after clossing /dev/watchdog correctly)
> 2) pings 1/2 or 1/4 of the watchdog heartbeat time as long as the
> userspace ping keeps going. (Else it will expire and you trigger a=20
> reboot).
> (Note: the heartbeat is the period after which a watchdog hardware
> device will trigger a reboot, timeout is the period for userspace.
> So for most devices heartbeat and timeout are the same, but for=20
> devices where a timer is used (we also use it if the heartbeat value
> is too small (i.e. 1 second)) the values have a different meaning.)
>=20
> So the logic for a watchdog device driver is:
> at startup the watchdog device driver should make sure that a reboot
> can only occur when /dev/watchdog is open. This means that if a
> watchdog device is active at boot it should either be stopped (that's
> why most drivers have a stop in their init/probe function) or have a=20
> timer that pings the watchdog as long as it is not active for=20
> userspace (like at91sam9_wdt.c, via_wdt.c, pika_wdt.c, ...)

My goal is different to those watchdog drivers. I want to use the
watchdog device to ensure that kernel and userspace work properly. If
one of them fails I want to reset the system and boot into a fallback
system. In this case, it doesn't make sense to ping the watchdog
through the kernel itself. This may work when the kernel is guaranteed
to boot successfully. But the kernel may as well never reach the
userspace because of some bug somewhere.

Of course it is possible to add this behaviour to a single driver that
is used on this specific hardware. But I think the concept of an
active watchdog during the whole boot process is not so uncommon. For
example if you want to update embedded systems, you may want to have a
fallback kernel and rootfs.

Best regards,

Markus

>=20
> Kind regards,
> Wim.
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTFEsQAAoJEEpcgKtcEGQQCw0QAK0P11xuMz+a0FTtX7Ymx7/5
UahxbgsYIw4iX/RbI0iQLjGdSdObPbn137/pb+JWVKQIiptILRl8E7ucHs10GY6M
eIhr7lvmfmJzfjR/4FmdEF5yJRG+hiDdP9VNzyu0a/Qn7M/VNwq/DOVPK6s4tKuV
e/UaTGKMYnHhKivsnja8zieuiQ7umDWaX4tEhq0XQ7uRrr5zqbxOS+MMaU429uJx
DJdmWH92uF49+UT/A+Yf7bNJNVAdW2LlnehvGKDbBw/ncFU/gIOelS2jSIslKj3d
mmcgY3n/K7tKyKX8bS9+UxayyQE9H+qUveZiiTSLMNb3g4KTf7r+4JHymxNDVc0x
4RjxFzyoOPo5F/JWeKcJnHl/MJWzjEjooLd6bjcsFzCunYmx7z6Rlp9ZMWhx1UhS
eslUFku5ksEY3+jrkLdfumA3csXbwiLrYO4NCygEcwUWCBdRsI23V+o56+nGNI5k
LUvZt73rl4gPUJSOb8AWahMyAg6iP8kLdbnCqi9z/XosOidp48M7gXMCnSg6SpkT
5zqSu23QAehpkdvKAx7mKszci1Ct3YfK7uwxWAwv+CdHGg2TYVlK1q4y6Zhtya+l
HIKGLxsZoGcSKfNfl3kSMOZb5uuGgNreX1xE7T5dDR0kaMOCm63fs596thNr9x+b
kWk3FsfTsOA85tllUwq7
=zYfd
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
