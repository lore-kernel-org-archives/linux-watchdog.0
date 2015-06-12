Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34222 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbbFLLFp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Jun 2015 07:05:45 -0400
Date: Fri, 12 Jun 2015 20:05:38 +0900
From: Wolfram Sang <wsa@the-dreams.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com,
	lee.jones@linaro.org, jdelvare@suse.de, linux-i2c@vger.kernel.org,
	wim@iguana.be, linux-watchdog@vger.kernel.org,
	jingoohan1@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/4] i2c: Add Congatec CGEB I2C driver
Message-ID: <20150612110537.GA4009@katana>
References: <1434055734-3602-1-git-send-email-christian.gmeiner@gmail.com>
 <1434055734-3602-3-git-send-email-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <1434055734-3602-3-git-send-email-christian.gmeiner@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Oh, this one again. Like last time, close to be ready.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/congatec-cgeb.h>

Please sort the includes.

> +struct cgeb_i2c_priv {
> +	struct cgeb_board_data          *board;
> +	struct i2c_adapter      adapter;
> +	int unit;
> +};

Only a single space for indentation

> +	ret = cgeb_i2c_set_speed(priv, 400000);

Not all slaves handle 400kHz. So, this might be a bit demanding. Then
again, it is probably fix which slaves are connected and they work
currently?

> +		/*
> +		 * not a critical error, we can continue with the default speed.
> +		 */

Single line comment, even if it is a little over 80 chars

> +	platform_set_drvdata(pdev, NULL);

Not needed.

> +
> +static struct platform_driver cgeb_i2c_driver = {
> +	.probe          = cgeb_i2c_probe,
> +	.remove         = __exit_p(cgeb_i2c_remove),

Leftover annotation?

> +	.driver = {
> +		.name   = "cgeb-i2c",
> +		.owner  = THIS_MODULE,

Owner not needed

> +	},
> +};
> +
> +static int __init cgeb_i2c_driver_init(void)
> +{
> +	return platform_driver_register(&cgeb_i2c_driver);
> +}
> +
> +static void __exit cgeb_i2c_driver_exit(void)
> +{
> +	platform_driver_unregister(&cgeb_i2c_driver);
> +}
> +
> +module_init(cgeb_i2c_driver_init);
> +module_exit(cgeb_i2c_driver_exit);

module_platform_driver?

> +
> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> +MODULE_DESCRIPTION("cgeb i2c driver");
> +MODULE_LICENSE("GPL");

GPL v2


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVer0BAAoJEBQN5MwUoCm2RxYP/39qRFjPQUgm+pmFyAGsDaUm
Kz4S+DEhT4LqccDmuwEiudZwS8zTfpao6J0qLfjH5njdKrxc30wAn1BcY2XupDSI
Lu6nJrZLVsq8VH1ifOu7uFnEoBESyMxX2/bubBEZkXfWMZFAYykrMCuncI5czajO
y8n4hKUy/ybRogimmmchkiyvEAz1Zo4FyQWenrolVQOtOhO3kNUcfco7Oc2j77DR
bOo66q83PKrHB4NA2wYCAZQnggojbO79cDOM/+t64SfqYXtF38jXgrslXtp1EW0N
5MLxTTS6x/taP5mVEDMjEIO2x/THr4HcIm3Qtee07xdtcwKy+P1TuAnXdguHRrij
RqcX4H67UO7+vM1DDdRBBZypxcv2u2FsweTGbD3CluFXyrrpgQaAxwvvWTF4pq9Y
yggbFyFefClrmQXRhzzV58iE1l+xYnAHp09YnxKJWHrAr8ybYa7CW3+zd2/8aiRX
aiBEGmkC5lUqyackxqP61PDk2MNjHNksUpIjUK7N/i/abA4gHC/06dEof7saQXrc
GNNvN7ia3cJCX7NtBU0h32JW32PdvHwATDD7ddoFpQu83yeNM9oQPpBaMGe5uPHm
WrLQiWld/AJWmYZFZ3o9hIsUyZfLL0Q3w39xtjRTA1lBi5XKlqPrXc5znHgIXW4o
tF38GbnbNGrprnVKADRr
=pORg
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
