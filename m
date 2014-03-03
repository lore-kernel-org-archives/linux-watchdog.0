Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37028 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbaCCLJf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Mar 2014 06:09:35 -0500
Date: Mon, 3 Mar 2014 12:09:32 +0100
From: Markus Pargmann <mpa@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: core: module param to activate watchdog
Message-ID: <20140303110932.GD24953@pengutronix.de>
References: <1393604183-8755-1-git-send-email-mpa@pengutronix.de>
 <20140302094323.GS1484@spo001.leaseweb.com>
 <20140303092747.GB24953@pengutronix.de>
 <20140303101940.GX1484@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <20140303101940.GX1484@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Mon, Mar 03, 2014 at 11:19:40AM +0100, Wim Van Sebroeck wrote:
> Hi Markus,
>=20
> > Hi Wim,
> >=20
> > On Sun, Mar 02, 2014 at 10:43:23AM +0100, Wim Van Sebroeck wrote:
> > > Hi Markus,
> > >=20
> > > > Many watchdog driver reset the watchdog device on initialization. T=
his
> > > > is a problem if the watchdog is activated by the bootloader and sho=
uld
> > > > be active the whole time until the userspace can write to it.
> > > >=20
> > > > This patch adds a module parameter (watchdog.activate_first) that
> > > > activates the first registered watchdog. Using this parameter it is
> > > > possible to have an active watchdog during the whole boot process.
> > > >=20
> > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > >=20
> > > NAK. It is the responsibility of the watchdog device driver to do this
> > > and not that of the core. The core can't know which device(s) are=20
> > > running and can't be turned off. So you can have more then 1 device=
=20
> > > that needs to keep going...
> > >=20
> > > The normal way do this is by using a timer. Take a look at=20
> > > at91sam9_wdt.c . We have a timer there that pings the watchdog if
> > > 1) the watchdog device is not active for userspace (so before opening
> > > /dev/watchdog and after clossing /dev/watchdog correctly)
> > > 2) pings 1/2 or 1/4 of the watchdog heartbeat time as long as the
> > > userspace ping keeps going. (Else it will expire and you trigger a=20
> > > reboot).
> > > (Note: the heartbeat is the period after which a watchdog hardware
> > > device will trigger a reboot, timeout is the period for userspace.
> > > So for most devices heartbeat and timeout are the same, but for=20
> > > devices where a timer is used (we also use it if the heartbeat value
> > > is too small (i.e. 1 second)) the values have a different meaning.)
> > >=20
> > > So the logic for a watchdog device driver is:
> > > at startup the watchdog device driver should make sure that a reboot
> > > can only occur when /dev/watchdog is open. This means that if a
> > > watchdog device is active at boot it should either be stopped (that's
> > > why most drivers have a stop in their init/probe function) or have a=
=20
> > > timer that pings the watchdog as long as it is not active for=20
> > > userspace (like at91sam9_wdt.c, via_wdt.c, pika_wdt.c, ...)
> >=20
> > My goal is different to those watchdog drivers. I want to use the
> > watchdog device to ensure that kernel and userspace work properly. If
> > one of them fails I want to reset the system and boot into a fallback
> > system. In this case, it doesn't make sense to ping the watchdog
> > through the kernel itself. This may work when the kernel is guaranteed
> > to boot successfully. But the kernel may as well never reach the
> > userspace because of some bug somewhere.
> >
> > Of course it is possible to add this behaviour to a single driver that
> > is used on this specific hardware. But I think the concept of an
> > active watchdog during the whole boot process is not so uncommon. For
> > example if you want to update embedded systems, you may want to have a
> > fallback kernel and rootfs.
>=20
> The goal of watchdog device drivers is to reboot when your system get's=
=20
> unstable. So when userspace is "up" and the system has booted correctly.
> What you want is something totaly different and not wanted for most=20
> systems because you are going to wreck filesystems: think about system
> booting, getting rebooted, fsck starts, system gets rebooted during fsck,
> ...=20
>=20
> To achieve what you want you should make sure that your "BIOS" starts
> with the watchdog enabled and with a very long watchdog heartbeat (so
> that it doesn't need to get pinged). Then the kernel can boot and=20
> userspace can start and then you can do the necessary with the
> /dev/watchdog functionality. Only thing you need to take care of is=20
> that you don't stop the watchdog (via a module param or something=20
> similar) during the probe/init of the driver.
> I believe we allready have a winbond driver doing that. Just checked:
> it's w83697hf_wdt.c with the early_disable module parameter.
>=20
> So, this is something that needs to be taken into account during
> probe/init of the driver and for each watchdog that needs it.
> And thus not for the first watchdog that get's registered.
> Furthermore: not all watchdog devices have a heartbeat that is long=20
> enough to achieve this functionality.

Okay, thanks for the clarification. So I will change the driver and add
an appropriate paramter to it instead as the winbond driver does.

Thanks,

Markus


--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTFGLrAAoJEEpcgKtcEGQQ140QAInQZImMFLOcnHAdID6koiXJ
/c1UKKw68WNKANzkBa0KWbh9/Ly+l22tFeBxDPvReJBEdUtq/mBgZ+vmVNLjOMdF
2JjlITWugX+QkizvWPNv7zPISCQD1fcdKtfMwpdm0mSbkNihdta/q0WPaIw//O4G
anSIu4bwJKd9fnpS50zC2JIEa/w9ZyMUqQVpXVJyGcV5pCSH8uZTMkPe8capEBaU
sa8pxyJ8h2XPGzNyW67KS76DlDSoU76xef2MD/5Waboz3vnh30H659sNy7gDzDfO
sPHGJ4+T7svF4TgkkQ2Cp0N/LQy+hU2uM4C5O8htKPbSLuvgU9J/0YFnPQsvN1Ul
r5UHbzbYqkuitJqLhI+t2LhtEUUWwe134xvWvKFJ50IMQMos/mZuFO3UVDH2dIgP
icMBG5yqb3iV5OMj1CpmFg9MtzBRnmw2Pn5Zx5nRCllu5ngW/I8czFHC3Dqnuj4p
KrOfrWT4gGJElOWByBaAFC9YbEuYBXCFRxodUGhMdUj1+M+Ue0VlHxSTTUh5/lMk
AkgPNayqDDeeSJfJ3Z8V08ZVAUOZYRUTT++J66qfrdb4A8CLOvSB8Bjk+jYV10BD
F7JIOVacU8HLeCFH4zt8SbbCqDZWpa/epUhHp7xdGbLqXYEVqTKkglqRqCQiyLNN
9GOifFajmPAX8UOtjAWr
=aAV2
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
