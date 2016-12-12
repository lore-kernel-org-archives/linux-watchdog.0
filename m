Return-path: <eric@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, linux-watchdog@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: bcm2835_wdt: set WDOG_HW_RUNNING bit when appropriate
In-Reply-To: <1481536123-9279-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1481536123-9279-1-git-send-email-rasmus.villemoes@prevas.dk>
Date: Mon, 12 Dec 2016 09:46:55 -0800
Message-ID: <87oa0h3ur4.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-watchdog@vger.kernel.org>

--=-=-=
Content-Type: text/plain

Rasmus Villemoes <rasmus.villemoes@prevas.dk> writes:

> A bootloader may start the watchdog device before handing control to
> the kernel - in that case, we should tell the kernel about it so the
> watchdog framework can keep it alive until userspace opens
> /dev/watchdog0.

I don't believe our current bootloaders (the closed firmware or u-boot)
set up the watchdog, but this seems reasonable since they might want to
later.

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlhO4o8ACgkQtdYpNtH8
nuiqcg//Y18nOX1rLbqX8+IO0YT4SUMiYmhnjNR7vZJQHwub5D9uf0MDb9j1dlht
pRuSOqcC22N1nhzvOg0Kf2sVjcfJGg2ch9i1ScRZyjd17aWZ011P4hrwgMV1f+og
GKOsPdx5VDlzjBzhVb5RarH6yjkWb7p3Jl2axrXXVqg1MosN6SovtT1eBskwRpt0
3GaFVnMV4kaRDAD1q1LTbvrGUL6zurgrE/HEmaxbVwjfmcrK/2vXsKPBBm5GygdJ
j3A1gyKE39tIQrYJmiNYO2h1BDFPre8hdyyGF1VpsZi8DFJSedx9lX2OhSbsMS76
OX5J+GijXFUmXRhOWcwIaO7TKNuaJTXEx+5OyzmP7cA3n5TENLciuj3Kn4ZCFzld
Ca8wp2FCcOqTkDWeo/nvJAJbBPkcyOHxqbiQl1XwGAZJmLBRl8jbzrdC1IaIAUHE
ycMlPmeQBR3AjJvzJDYrejuRwjlpI8ufGhqstKsQhkU/KVr/FDD4FhOd/56ZpgQg
IBYzWZOtGMEibvSFJW6rARVg9HOe/ui80ugdq57b2xSxJxXESLrAV0HpIQLgmp5u
NOcmjNzhVnqK10v60gRpxUPb0G1cFxQBvrKDiwhuJpJiad8ZEEIJ2Yd9Si1/C32l
tOGmapZV6lfddpOsl1cNMpthuCVW73rKoUSm43kvQdRLbxxOcMk=
=caI4
-----END PGP SIGNATURE-----
--=-=-=--
