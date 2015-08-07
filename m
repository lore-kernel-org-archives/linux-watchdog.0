Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46931 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932072AbbHGPzs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 11:55:48 -0400
Date: Fri, 7 Aug 2015 17:55:35 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Lee Jones <lee.jones@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Darren Hart <dvhart@infradead.org>, linux-i2c@vger.kernel.org,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH v4 2/3] i2c: i801: Create iTCO device on newer Intel PCHs
Message-ID: <20150807155535.GA25357@katana>
References: <1438865186-25794-1-git-send-email-matt@codeblueprint.co.uk>
 <1438865186-25794-3-git-send-email-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <1438865186-25794-3-git-send-email-matt@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 01:46:25PM +0100, Matt Fleming wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog resources
> have been moved to reside under the i801 SMBus host controller whereas
> previously they were under the LPC device.
>=20
> In order to support the iTCO watchdog on newer PCHs we need to create the
> platform device here in the SMBus driver and pass all known resources usi=
ng
> platform data.
>=20
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: <linux-i2c@vger.kernel.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>

Dunno which tree this should go through (probably MFD or watchdog), but
doesn't look like I2C, so:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxNT3AAoJEBQN5MwUoCm2F8gP+wTXJQ4p8vFB/DHUyPwCclur
nYvZH1fYGVhDDX0clrdlGnVREgi0/7e99DHdJDGyUvDV9m8omJFxeezunOkYOhff
qRt61Ab86vAmWR03AGT38mUcIYJ7B4iZu0IpDBdOQoxNBaFQjyncDw3kbIp70bGD
DE08Fn1orWcjEcr+Ww5GgDX+8N8MZ9IXKXOuX3sfUkPERTiZOQfjt2KO7/Abb/it
0Ba/cvSw4SzO+LRIKKVmLq4oloL0kTQEc0Y1ON6ak9ZEaXYWcYLh8vAPYJkgs8Si
tRmQwL0Q9LIfVGqG1ZdWjwn5wsPbTQ6gjyWMIRArL8UOcLkhHzKBip/tQkctU1eB
KWoqV2EBZ41xXZIBBE+OM2HPfUEcEacbOhjSZq1BsVeQe1aKDq+uAKA836Y6tIui
gx5IH6zTjEBfWhOUeNcRdleJBNES7ftZ0S1IHsqT6jMsrvJcsaDKU9OI0788Fknz
n9KtNW6c+EKEzejF4V1fXYdgJtgRTPHag+b19mIvs+Lkwx6Hu6ANSPVJZE+imVDo
xAWTaoWIlEuE3MDI5UzXPdjjtNtwm/22dkUMxm7AQd1SJkDUxt686wbJZ1ZrXaPO
NzQ1b9AsgkOSNG85lYUo8tKcSDoLaDLy+9WIVb88n6OcYmUjMAAemdGz3JKQmTlo
r372suC/lms+U9IE8edi
=5Ju2
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
