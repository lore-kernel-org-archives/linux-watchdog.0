Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34046 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757672AbdEVJzU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 22 May 2017 05:55:20 -0400
Date: Mon, 22 May 2017 10:52:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
Message-ID: <20170522095243.ff5uygzzrvo57jkd@sirena.org.uk>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tvcs7s5pzwvwzc4b"
Content-Disposition: inline
In-Reply-To: <20170521220212.1404-4-wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--tvcs7s5pzwvwzc4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.

Acked-by: Mark Brown <broonie@kernel.org>

I'm missing the rest of the series and/or the cover letter...

--tvcs7s5pzwvwzc4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkitOoACgkQJNaLcl1U
h9DNBQf/W6MueE4T2MQLhzjv1GsoGBNNokoFrcJbPchpAPhw/DczZsF29IdybRFZ
VacP62GRSx1hZcxR8/ydv0S6rRUXv9jTVnL04MI6lRCMEI+PisoVGYTW+M3TmvUF
hfX/HTza1pis1bd5u5qpRJcV2MSK+cJ/tAHKgTIaZvt5u3LeF7JodmA1zYq03M8n
xdpgRf00NHikCcSgfyuf1chUpvBz4/HBA3QCNC3UpTieY16B67ZQAr17TZLuUD1G
eT9Jgt2hQHnRwzUQ6IlnO58hyFI4Q3DHJGgPCWqEp4FKTZjx1HSdXKjbDIZJeBR5
SJ58jl2BjAjeGhP2am4Xcd+Vfqr1IQ==
=pkjm
-----END PGP SIGNATURE-----

--tvcs7s5pzwvwzc4b--
