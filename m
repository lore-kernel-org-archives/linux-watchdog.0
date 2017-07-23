Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:52506 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbdGWO6v (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 23 Jul 2017 10:58:51 -0400
Date: Sun, 23 Jul 2017 16:58:48 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fabio Estevam <festevam@gmail.com>, wim@iguana.be,
        linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com,
        justinpopo6@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 1/2] watchdog: renesas-wdt: Check the return value from
 clk_prepare_enable()
Message-ID: <20170723145848.GA4074@tetsubishi>
References: <1500754979-19836-1-git-send-email-festevam@gmail.com>
 <20170722203159.GA6399@tetsubishi>
 <20170722212422.GB2969@roeck-us.net>
 <20170722212818.GA6979@tetsubishi>
 <20170722213011.GD2969@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20170722213011.GD2969@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2017 at 02:30:11PM -0700, Guenter Roeck wrote:
> On Sat, Jul 22, 2017 at 11:28:19PM +0200, Wolfram Sang wrote:
> >=20
> > > It won't need clk_prepare_enable() anymore ?
> >=20
> > Nope, RuntimePM does all the clock handling.
> >=20
> What if runtime PM is disabled ?

PM is selected by RENESAS_ARCH.


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZdLmoAAoJEBQN5MwUoCm2NpgQAJs47pTndsLqMQfszAc+My1+
/HbfKWeNCabsuxJsknmbpdcQOshZuylFHHLbC9C3hYkNkmpGJv5YcbcmVYAUinxs
yMtKYp+6a7xn6MGQTRVC1FoIxHWVg25jNi5NLnPa98inEvnlsBtNxmLVZuoYAoXg
N+ufjAMCW6nkGWoEfg64ln+xfKj2+RMQUp5MzUPeys1l/WuDGU2mE0WDH6iYUwxQ
68zVPHonlPYh012s9x26GjdNVtyjZhLa95fA3UBL0gUZ2n7b5u7lELm4NwTJ3b66
xjFL+ekqzwhygecLT7bJZqDPAa1dXC2pr5wV/A801TQA2nd9E1XKFUUioDIxDs2O
cgmgP5MIqHEnbHE5uzO7B3JZvWAXLm7QGYCJoYkgRHS1E8ZqyArQasP1hIWfESS1
4i/xSgP/TNEtD/DGDjhE+PbGdrZ+mutnMipcByzDPSjDEzincmEoVrFW+8uDNoN9
rlglX5xAwOKlGYO45/nk/PUESFjusgu7L7Wwg/4Fojs8EY2OeHaFit7bHGM/byAA
1cakOUo3uOsr0j30QNJyYe4nsfeo1lftsBW3s98CJEZKkR3q53CHKd1Y5RP0cpeZ
+Xc0PAxi/48Y+gq5605UWFXB9P8FpAza/TW7rIJ5e6PsD8LR6QU5G0cSnvKOO648
h468au8frgPWqyL3V/2R
=BCVJ
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
