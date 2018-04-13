Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48294 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbeDMPhG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 13 Apr 2018 11:37:06 -0400
Date: Fri, 13 Apr 2018 17:37:04 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
Subject: Re: [PATCH] watchdog: renesas-wdt: Add support for the R8A77965 WDT
Message-ID: <20180413153704.ku3shg4pk5fshcir@ninjato>
References: <20180413142526.9321-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdXUR7=67xkU1Hv=HV++t4n+xpFV6mVbc0Kcz6iWSGh3pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wfnqwaxedhf27non"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXUR7=67xkU1Hv=HV++t4n+xpFV6mVbc0Kcz6iWSGh3pA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--wfnqwaxedhf27non
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 04:54:17PM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 13, 2018 at 4:25 PM, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > Document support for the Watchdog Timer (WDT) Controller in the Renesas
> > R-Car M3N (R8A77965) SoC. No driver update is needed.
>=20
> M3-N

Do we have a de-facto reference for those namings? Sigh, I was kinda
sure M3N was agreed on.

So, it must be fixed in the patch as well...


--wfnqwaxedhf27non
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrQzpwACgkQFA3kzBSg
Kbbmhw/9HGVr7n93k+m62EA47vPbcaqjTgwNumaOhM4pbCycCrmcmptTnLZ64rn7
95g2Wb532wfyrCkFqJHo+B1Q+1TzQT+PNDC8sPj6zztL599wLw8C8XbaOfj4TXg8
OMlw8hAJXaokthxOY2mt0JzcaxTiBbHWjW/K0NTPpWYXzn71PRGOoQ4GmXj3dP9Q
ha7MKSFpWrz92bLwshz6feDTqaR/qX1sk6yXKEnkmHjKkxTaPMOvAkmA9uYMAQAP
5U43aYOy7Ul2rBr2TkbUwazyfKB8MamvoSFEL0VIGpx8uf8deLuGBZxpChY+UaFl
ocpDBZZ/g1Aass1o9qRVk+z7Kmh2okGEjHBPPMt3T0cOvEfUPtI4mjKKD9Ya3ZQm
FJ5a6Z+aqhOnf59PJqcniko5tDjunfWF1G7e8D1RUK0xFQd4YTeRm5jVQB759/Hd
8U3jUrhkuLqukb4STJDsMeW96ZgAgu9AVMf+mdgLuvqDJaYg/XnpihoFKtZqgmAw
vgPzqfv0jQWiZwRI5nbxLUsB94gmQaCW6uxoTFOYSQ+ZGs3jYfZGdhf/T2CvHW4J
Pu9wnMOBwHbxP6cuhv9Zrpe4Ec3EGrDssHcHwqeiKvqGjJ6LA6MZscMO2jLx4hTb
Kp5Y7dAMqzniKjglDT88kP/F2BbXdlSLxcsXWgG8vAhN1AG7hVE=
=5rwc
-----END PGP SIGNATURE-----

--wfnqwaxedhf27non--
