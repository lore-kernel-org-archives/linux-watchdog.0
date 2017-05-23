Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:32769 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966237AbdEWHVs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 May 2017 03:21:48 -0400
Date: Tue, 23 May 2017 09:21:43 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, rtc-linux@googlegroups.com,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-watchdog@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Message-ID: <20170523072143.njhh7mkbm2tt277l@ninjato>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170523071636.hiws54msfxpg6qkb@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7yzzt65nmxassi3y"
Content-Disposition: inline
In-Reply-To: <20170523071636.hiws54msfxpg6qkb@dell>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--7yzzt65nmxassi3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>=20
> I guess this will be going through the MFD tree?

I'd prefer that, yes. Thanks!


--7yzzt65nmxassi3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkj4wMACgkQFA3kzBSg
KbboAA/7BYWjzye3Zd9b4l7Uvdy3BTUglIU4h8PBWztw8snSPIIMd5ShjYZotX7x
qXKUqi92du010bqAANjftdAl2ej4Dl1OdMm2NuaBlfGIV3bf1s+f+mx6iubHg+gC
h3KYEBU3fUMc+dypGCd6xsM84DCtOLPcYmu/uaKKmvZLfyNvvsDaTFUOyUp15nup
y8I9DNOmbirzmQj7sFF+38//j3SWfMO4EWGDBDUuQgT/CNf6DyclYITi1TVuh5Z6
X4mJqOpMCE+GzPZvDe60b7oMDAJrVyrsyj3SjkgUNMegQwGW0ZFGdmyJf3I43FLx
RUKeN4o48TPW4LS1rX9hzDIOvTlL6ZUc814/9q84zHly0RP5y4uzyJ8bOuZA2BJa
O0Yu4Y+QL3OC1qGzktwbsBUHPVLUZZH7oRMY2haS+o+4rzOhiZbH9tZE4v2ALyfX
8oGKWd2RYn76zG0Su6C5QCA/4ck1t2Wr4CwastYmdKuhyBEAF85uTvwmBoaXJxbp
bea5aO2y2xBdvgTvSd0XkbMiJpqMFb9gFfoA7SMkIPVmgPHcX9ZqI7QT5nXi5ugy
ZUfn/VYQUh8TyXZiRrOwJ595KjykkGIyxq2xgGFZR5eJ60N9t7ZEDqv6FBfhoj5V
elD1t7D2bkdQm0hfSxal45Zedg/OquhGI+ktNbjMKWLBN70owfs=
=bddv
-----END PGP SIGNATURE-----

--7yzzt65nmxassi3y--
