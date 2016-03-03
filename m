Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54711 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932284AbcCCIMu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2016 03:12:50 -0500
Date: Thu, 3 Mar 2016 09:12:42 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 6/6] watchdog: tangox_wdt: test clock rate to avoid
 division by 0
Message-ID: <20160303081242.GA1552@katana>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
 <1456958018-7849-7-git-send-email-wsa@the-dreams.de>
 <20160303042618.GB4578@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20160303042618.GB4578@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +	if (!dev->clk_rate)
> > +		return -EINVAL;
>=20
> May be a nitpick, but clk_disable_unprepare() is missing.

Oh, definately not a nitpick in my book, will resend! Thanks!


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1/H6AAoJEBQN5MwUoCm2V8gP/AvRodpXFwxiQnHaq5yRzK3f
w21tUDNQkh8QNXISkASyd8oH/LDuPXUNQDc4OWCiT+HHFAnwr2hDuSbDMW3JfzZX
NFqwvjtHKcZPGF0nvjEMMIzlgff6t1sRPe9V20yPEYlb9WwWEBybwaXqg48r9CmC
xk05SHNsDhudZRoEFSWcJjwNq+My8mA5GV8xU2soj33KUFylKQ8Q1GHKnKhrp+Z/
1/CO4Ay/CjP43qqlG73pajK//Xlea01k82MMikajNn6j5//wYKFDtlBT6ZBdPNeQ
F3Cb/VvImAWhCHJoBTpB4kyoDCCPj/LvHiBajUGysQFSF/2FqK3kn7EkehPmv6rn
LtDGtkmRLgSMPWYO0wuyIOUxWgfGOv8GkpCBHY1spirkUPA6oi/kkyQy/e7mXBT6
4YIhf4SXdSMs9yjX7D3IKWuroljdGULeE2huzTMBxzll2DSoYOOMxl9CwS0fEDg2
tzMyvA5W8hPV51Zh9BLxKZyjvfl7Mrd+1zr6x+H3mLCfPCJUkDhWEexp/LOMJiCl
j+Dz7ckc7KZr0NenbcMcphswd22hluqdLwWJbKjdPy9xWSdwkq6sOA+EVemZt7x1
GnxL9UpdUOgTg7tcaL2y72tv191704/UAKrYgPl/6JpEGPGref04pvqKiFESGGL/
T9dLBuDlwjx0W4XzwKh9
=4Ipb
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
