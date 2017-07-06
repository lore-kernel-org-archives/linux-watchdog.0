Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36705 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdGFGpD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Jul 2017 02:45:03 -0400
Date: Thu, 6 Jul 2017 08:44:53 +0200
From: Thierry Reding <thierry.reding@gmail.com>
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
Message-ID: <20170706064453.GH16144@ulmo.fritz.box>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
In-Reply-To: <20170521220212.1404-4-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  arch/arm/mach-omap2/common.h            | 2 +-
>  arch/arm/mach-omap2/omap_twl.c          | 2 +-
>  drivers/gpio/gpio-twl4030.c             | 2 +-
>  drivers/iio/adc/twl4030-madc.c          | 2 +-
>  drivers/iio/adc/twl6030-gpadc.c         | 2 +-
>  drivers/input/keyboard/twl4030_keypad.c | 2 +-
>  drivers/input/misc/twl4030-pwrbutton.c  | 2 +-
>  drivers/input/misc/twl4030-vibra.c      | 2 +-
>  drivers/mfd/twl-core.c                  | 6 +++---
>  drivers/mfd/twl4030-audio.c             | 2 +-
>  drivers/mfd/twl4030-irq.c               | 2 +-
>  drivers/mfd/twl4030-power.c             | 2 +-
>  drivers/mfd/twl6030-irq.c               | 2 +-
>  drivers/phy/phy-twl4030-usb.c           | 2 +-
>  drivers/power/supply/twl4030_charger.c  | 2 +-
>  drivers/pwm/pwm-twl-led.c               | 2 +-
>  drivers/pwm/pwm-twl.c                   | 2 +-
>  drivers/regulator/twl-regulator.c       | 2 +-
>  drivers/regulator/twl6030-regulator.c   | 2 +-
>  drivers/rtc/rtc-twl.c                   | 2 +-
>  drivers/usb/phy/phy-twl6030-usb.c       | 2 +-
>  drivers/video/backlight/pandora_bl.c    | 2 +-
>  drivers/watchdog/twl4030_wdt.c          | 2 +-
>  include/linux/{i2c =3D> mfd}/twl.h        | 0
>  sound/soc/codecs/twl4030.c              | 2 +-
>  25 files changed, 26 insertions(+), 26 deletions(-)
>  rename include/linux/{i2c =3D> mfd}/twl.h (100%)

I didn't see this get applied yet, so just in case anyone was waiting
for me (this is trivial, so I don't think there's a need):

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld3GQACgkQ3SOs138+
s6GKZBAAnbaonsyjZHxBKy02VF3I7RgESdTVzw24ZuKTsTfvsFmc2CA381KfPjjt
Js7AMkJtv1xg+GEZo4NvX9YkJadeOsp1YDqdY+60JV/Zbc7fQKVq/FFxFNiC3+Xj
ZAUG9SDF3CqERuu89WLgpE612bUJr7xqBBp9e6tC8gClFNrgWpy5obN3dEU3hE/N
nJ9lDBIKVELG3YfqOHYC8ClAX1WIpPuXpJTVfEa25soRmyZc8HTXMxnQH8oYU9/i
jTn4MZZ8JukuvxgMsyJ1IHSFJE0qRzWIzbQekjVpagpOoNzx9Ghy4dzs/1at8dZq
CF3jQ9gdXOChmnFcVZWXcDDRrAk4h0AdcdSr6ZsL739XdUUVy+tKw+4G35fof6xU
0CBx/lOsbhto9Zc67SmrnwY5TuTj2E34KM5vbdWybd3vEuIVyq+vvJSvi4hCLgBT
b04xAUBruRDG3gjvRyInWU3E26UCsu4T5GTXmfgoxTBMEiGaeqHSi4J5Oa0mdCeS
js+bQxkau26nSwVrxXbSEPu37zaJFe/g+tZb7v3xTjq6JM/+yjbVzCu66SiGUZJr
mg+h/Qyl9v0m59/tHhde3QEaXGCPv1eMN/G92pIRId68wI+nYvlaBe3HkVT7pUj4
TurLCCSyBwJqn56Sf6711848LT3rcKRmFk16PleVEcWPqHMNTyA=
=MpPI
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
