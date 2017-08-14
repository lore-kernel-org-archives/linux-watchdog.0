Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49987 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751538AbdHNQcZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 12:32:25 -0400
Date: Mon, 14 Aug 2017 18:32:21 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-i2c@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20170814163221.ef6rxfvtehmpq7qf@ninjato>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
 <20170706070352.xdecvsnremwqed72@dell>
 <20170813133700.tv4ka7anvbzcplr7@ninjato>
 <20170814064247.qvggx4ito4vgjqvs@dell>
 <20170814084340.65morabelapfegph@ninjato>
 <20170814162219.GX8569@atomide.com>
 <c5e65e34-f308-f601-ba0b-d96792591727@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5bnhd66xto22335"
Content-Disposition: inline
In-Reply-To: <c5e65e34-f308-f601-ba0b-d96792591727@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--r5bnhd66xto22335
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Added, thanks!


--r5bnhd66xto22335
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR0JUACgkQFA3kzBSg
Kbb3UBAAgndBbA09/crNsM5iaqnA/DYgD6njMNag0No8CkC8WzDc8c1dZ3mD3+/b
85cDD+WHMumbLsRhoqoiCMIk9izQTouKfop/DZZAA2pN0gEAcDJNyjL+4NuH/k2G
suO6XQnuKEuNzUOcXQIrY6W3GEvO8W9WVBD2thjcu8Uf3UYFELAtAMgexqlB7JPa
bvTGlLeCEhx8XcDz7utEjeiqJ/Ip1LjBXovQto0j/vioZ5BRaJWlfPJHDJquB9Uz
fxJm0G4VfmT1OszuWMSZv5gTlazDKNOAadsw7swrp5jmuf3qNjCKkmztcq6rVnkm
W5A8qOJcxjzPk9V/OmuLk/hlQAMrTHv9xmH4AuW/xnwP0OOrDb3lt9DnSGzW+pCi
NAZfPEe5DzVlqvQ+RYWG1aM4f2lgJdGrX3EzwcPymVpN9qi+PtB+3oYgqky6CSew
+X5sULm/xrwoh2zdgiVWTRKrdfthPtk/XfNSTpXOGtGf0ZZsUTMYrSuckTd6zmxW
TxuuZn4fPEx18Zfpy6uxof6nnrZbEZ6jGAF+s/nWHHAPCfn+aPPFOoIF6XsTkwyE
q6iUSzT7QIaKQ3G5p9zYzCdaWDWq5ks3mhsa9nivBKKM15V9OMBgrKAMJtl2HmYY
YQv+A1FOXchHAzSyKL/vhyCeu0gOValLeFdtzTIJZRjyYTvhtTk=
=ltAb
-----END PGP SIGNATURE-----

--r5bnhd66xto22335--
