Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48768 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751526AbdHNIno (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 04:43:44 -0400
Date: Mon, 14 Aug 2017 10:43:41 +0200
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
Message-ID: <20170814084340.65morabelapfegph@ninjato>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
 <20170706070352.xdecvsnremwqed72@dell>
 <20170813133700.tv4ka7anvbzcplr7@ninjato>
 <20170814064247.qvggx4ito4vgjqvs@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lv6drd3t7p4u6slo"
Content-Disposition: inline
In-Reply-To: <20170814064247.qvggx4ito4vgjqvs@dell>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--lv6drd3t7p4u6slo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Given the triviality of the change for non-MFD subsystems, can we apply
> > this for 4.14?
>=20
> I can't apply anything without Acks for *all* of the subsystems above.

Well, there are cases when you can. Those should be exceptions and well
justified, of course.

> My suggestion would be to collect the Acks you've received up until
> this point and identify which SS's are still lacking in change log
> section of a RESEND.

I agree, though, that I can try a second round to get the acks.


--lv6drd3t7p4u6slo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmRYrkACgkQFA3kzBSg
KbZSwQ//SXeJiriQ1JXWeiiNv7W8RZlZDMhcZP2Y8iTfn2czEvOrh2tQ5RRPqzm5
tlAk7TjAmnnH+rRlRNNgJRtIoiDc9fDr3VPP6/5IXlKgq2P/ghEUHLei/Efgfae+
FByJTP7rbAtDZBfSsKVIhrCs8ut7pok4JrSIIKlAFbvz5jHe/acUchycFkd2IazJ
Xisflk0KWbWNpyFN/W+zlovipFi/DTI+ELNjRGENwtjnznFKTZRdTxGTYOg4pN9t
8MlaKBYwcobZ3hj6YO2gs0DZjdN8nftSk6Gi/JYoPhNhA1dpQ6tND/Z5VvJtvJxS
21E0ywdIMT7ELa5kDBA1MgL/TZZO4jG7/RdQtVOjOlB9GBmtrsrhRn9ETZmlT7kj
lh+D+gGkXigqldLUTKT7kJ3kLUjAhyfj75vAqJv+NMrgc9hALFDJUAhYk3LJsyUX
wHNt/+nRLhaHrLWcsY0spd35XAm9HAMxnofVqsyI9Tb98K+5nHh0D5ta3VlW5xrJ
HXTmYjoObJbP64EMx56As6FF5sjuGZ4MqI209FOiw1+6Ri0XMHmOxThMyBIRbBZk
HN1XZgoQ4yH3GpROpWEE278X7HrTiX2sujJ/8DfP6juca5tY7lUxf01w1ar40FMY
uWpd7+w0pyLmgqtS0S38XFy0+1l4JY2ybyfUbmx3xnDGLZd4gdE=
=TZvd
-----END PGP SIGNATURE-----

--lv6drd3t7p4u6slo--
