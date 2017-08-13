Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46323 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbdHMNhE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 13 Aug 2017 09:37:04 -0400
Date: Sun, 13 Aug 2017 15:37:00 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
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
Message-ID: <20170813133700.tv4ka7anvbzcplr7@ninjato>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
 <20170706070352.xdecvsnremwqed72@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bf2u36sx3yv46k44"
Content-Disposition: inline
In-Reply-To: <20170706070352.xdecvsnremwqed72@dell>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--bf2u36sx3yv46k44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 08:03:52AM +0100, Lee Jones wrote:
> On Thu, 06 Jul 2017, Thierry Reding wrote:
>=20
> > On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> > > include/linux/i2c is not for client devices. Move the header file to a
> > > more appropriate location.
> > >=20
> > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > ---
> > >  arch/arm/mach-omap2/common.h            | 2 +-
> > >  arch/arm/mach-omap2/omap_twl.c          | 2 +-
> > >  drivers/gpio/gpio-twl4030.c             | 2 +-
> > >  drivers/iio/adc/twl4030-madc.c          | 2 +-
> > >  drivers/iio/adc/twl6030-gpadc.c         | 2 +-
> > >  drivers/input/keyboard/twl4030_keypad.c | 2 +-
> > >  drivers/input/misc/twl4030-pwrbutton.c  | 2 +-
> > >  drivers/input/misc/twl4030-vibra.c      | 2 +-
> > >  drivers/mfd/twl-core.c                  | 6 +++---
> > >  drivers/mfd/twl4030-audio.c             | 2 +-
> > >  drivers/mfd/twl4030-irq.c               | 2 +-
> > >  drivers/mfd/twl4030-power.c             | 2 +-
> > >  drivers/mfd/twl6030-irq.c               | 2 +-
> > >  drivers/phy/phy-twl4030-usb.c           | 2 +-
> > >  drivers/power/supply/twl4030_charger.c  | 2 +-
> > >  drivers/pwm/pwm-twl-led.c               | 2 +-
> > >  drivers/pwm/pwm-twl.c                   | 2 +-
> > >  drivers/regulator/twl-regulator.c       | 2 +-
> > >  drivers/regulator/twl6030-regulator.c   | 2 +-
> > >  drivers/rtc/rtc-twl.c                   | 2 +-
> > >  drivers/usb/phy/phy-twl6030-usb.c       | 2 +-
> > >  drivers/video/backlight/pandora_bl.c    | 2 +-
> > >  drivers/watchdog/twl4030_wdt.c          | 2 +-
> > >  include/linux/{i2c =3D> mfd}/twl.h        | 0
> > >  sound/soc/codecs/twl4030.c              | 2 +-
> > >  25 files changed, 26 insertions(+), 26 deletions(-)
> > >  rename include/linux/{i2c =3D> mfd}/twl.h (100%)
> >=20
> > I didn't see this get applied yet, so just in case anyone was waiting
> > for me (this is trivial, so I don't think there's a need):
>=20
> You're not the last. :)

Given the triviality of the change for non-MFD subsystems, can we apply
this for 4.14?


--bf2u36sx3yv46k44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmQVfwACgkQFA3kzBSg
KbanFg//dxik+zStgiZtWtrgtgSmpeUOGOsX3FXnRhJCPNTaXUuGOMuuhjFgK3p3
uDOXYfGtsdDPrnAGj3m8yjJI8JqQ1GI/9FtMxW9Jwcr3N6ZJ9dQYqzN7XMXwgnhd
prXN/iTZgkF/XT1ZOc6GMXne2jbqhJOuRY3sk+N40xQHsOBa8ThqxqssFyJbn0BF
jjSQP5TNp0KefTYS9ZyJGbnFxNZQhMb+AWHCMDgib2jCTQIIAQD5iMLH3aoCZEOn
rQDxnEHlOwcR+qYKdz8LVPU5tOR2uEsY16F4awUYVR+6lkx3KLKsBFHZr7tZ2QPn
+w0767Mr+wyphuuG77YoBvTLU8pDJxwSYR21XGYqvJvYNdwVHCy5Y4M+DTV3xG8g
DsY45lDHNspdDJvwBpZZRBO29uGPtqfCJfDgUpxvDllF99ES72urbNUXn5YrdvVy
sTrUzmgX4kiBRzA6mpyG4autZE9Z6q/xNslSrV/0ll0arUMbzpMmVFQwE6yRgRsB
1Ha3prXevF/UNZQcvnhHruUcakuzPgvK0hpdhirON2OTqXChTOHLKWquA+aYQ9lB
cBe7cZhAUXkimtWvNheqOYEg8ZStjW1uNup5eHujXNYw/HY8+3p/cr/9Jf05xvQz
H3Qawecv5x3sLjvuv0PuhEdFPr5dKQfLGoDZrLqmFLfYTJ3NWoE=
=hKZZ
-----END PGP SIGNATURE-----

--bf2u36sx3yv46k44--
