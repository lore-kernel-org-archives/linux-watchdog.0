Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35620 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758197AbbCDRSL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 12:18:11 -0500
Date: Wed, 4 Mar 2015 18:17:58 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/9] power: reset: Add AT91RM9200 reset driver
Message-ID: <20150304171758.GA8717@earth>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-5-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <1425478897-27322-5-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Mar 04, 2015 at 03:21:32PM +0100, Alexandre Belloni wrote:
> AT91RM9200 uses the watchdog from the system timer to reset.
> [...]
> +	regmap_write(regmap_st, AT91_ST_WDMR,
> +		     AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> +	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
> +
> +	mdelay(2000);

At pity that you have to write into two registers, otherwise you
could have used the syscon-reboot driver.

> [...]
> +module_platform_driver(at91rm9200_reset_driver);

Apart from missing module metadata (MODULE_AUTHOR(),
MODULE_LICENSE(), ...) the driver looks fine to me.

-- Sebastian


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU9z5DAAoJENju1/PIO/qaXg0QAKpChPsGoef+NkvgnwuAuN2E
I2t0doMHJ05wXCajrAFhvQ71iI6dt707ovhQ2NVNWKBy+45dSZ5F5OxC+rYT8XH5
oMNTIE2SCyvH7QwAkAGgdziehS8QCKiu3KbJSX1CnJv4L3OGY7gORAoxNO8Q6ILi
tLKNa0rphISZVPXVRA2EzVRuSvKs+A2B1ONfqnTSfknPs1GanGyKZtQPd6vT7Gh0
uPNTObmsSvlatPM6+E5un/B6AZewsLfKf/FXzCILxT870xaFJnxf4teQBEzOyPC7
4cn75sAxPsClhJiEA0DgIybajPWoycpti8sgfaMKZSK1IQJzgnqj4qAyTtCsHP1V
PyClUytQN6O2KVtDV2CGEQh0ihHasHy43bHAWlT6BN9iylspQl07/DpkXG1RK5vJ
rX71PlUVq46GSBEHDIyRg6Wh0hLOa+o8xiwjKuzMtdPbbrqQU/Tt+j0+UBLV3YJk
HSl4ri4gn1ZEQWoFWPUNSmC/YBHC4DzOq74/xw+D9QKavYISsFoiaSw7Yj5TtThU
uyvQ+KCd4dq6eX3TyeLn6Gx0kOalrAJvRR3+8N6NJ5wbWsiq64cfAuqG4c4co+uX
/+3zUGMmq11c/MkawvKxHTr7wgQimqYBEYI3GTUSb23EzIBL+WpAK7gD1GFOgaqp
rHFlqOrYpxDLWjmWGneQ
=xYBX
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
