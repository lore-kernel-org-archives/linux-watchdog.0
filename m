Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40036 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbeGJHnR (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jul 2018 03:43:17 -0400
Date: Tue, 10 Jul 2018 09:43:15 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] rtc: stmp3xxx: Don't reset the rtc in .probe() when
 watchdog is running
Message-ID: <20180710074315.3h47bhxypvsulyhb@ninjato>
References: <20180609064313.18763-1-u.kleine-koenig@pengutronix.de>
 <20180709083041.m3h3smfaahl4awq4@pengutronix.de>
 <20180709161924.GA4595@roeck-us.net>
 <20180710070643.gyxk2oc6qvo7fnk3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pcbst4b22ovrdhbf"
Content-Disposition: inline
In-Reply-To: <20180710070643.gyxk2oc6qvo7fnk3@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--pcbst4b22ovrdhbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> adding Wolfram to Cc who authored the watchdog bits in the rtc driver.

Yeah, but this was really long ago. I don't recall many details. It
could be that the only option back then was an MFD driver which seemed
overkill to me. We have more options these days (syscon?). Maybe a merge
makes sense as well. Do as you see fit, I don't mind.

Regards,

   Wolfram


--pcbst4b22ovrdhbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltEY48ACgkQFA3kzBSg
KbZ8EA//X57PXiEnZSfjG/QdsXZlIdOs7WmJPyuXha0Njdh+okyBoDFut8tlKgtS
HVGAgHFSa/cAdycpFpj94VEzTisvVZhd8BceSixTIsdh4R2KbyOHe8DYvjeDFi92
pDh5rHJqecsdZHTL+PB4dcKHX93dEsTMTeLgK2T+PCkXdbXg/W60Edcj5sIk8TTt
7HtA3PaJmDFJqgscFpAfRwbihem7ojB50kvzLPyXpuF3fIgP4fYqZjPZtdZODAyX
cq/LYURVfTtBrqRuXZ8ERWwUrt461s8AxerM3jvkMBq1X4TPhCPBhaVdHw739eLh
AtLVDpVmkFH0nJJfJu74uvu2s7V0hg2beZnEe30NnOOJAbZbW2UXA/tUCBYkp3cK
R1hhkZ/vYY0eFbwZ7ZKi/qjoleUKyn0+bkyGJ++ZVJuxeK7WhOeFLDcER6afYT3I
XCOFaf4NeOv95G/RAp9B67mk68tzUBsSWlQCMRZe9m2nRxiotkHKlDM+cJYumPgE
476roXxExRZRKd3bFwK5X97RfyWyGFB0en9CXgxfQbgN6vcS6qvPDhBCdfUDR6a8
W/GxRIrq7QLXFxukLdZ2XFSeELaqDOad97XnJnQHZKsh7euGuUYQUeXDSkQweM0y
OyZrqZOJx2lkvWPaim44XVBoiuRx3l4/xOFRb1GM3VeaZOUmRP4=
=7mLt
-----END PGP SIGNATURE-----

--pcbst4b22ovrdhbf--
