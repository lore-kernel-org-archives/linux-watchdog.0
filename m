Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50497 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751314AbdGVV2W (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Jul 2017 17:28:22 -0400
Date: Sat, 22 Jul 2017 23:28:19 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fabio Estevam <festevam@gmail.com>, wim@iguana.be,
        linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com,
        justinpopo6@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 1/2] watchdog: renesas-wdt: Check the return value from
 clk_prepare_enable()
Message-ID: <20170722212818.GA6979@tetsubishi>
References: <1500754979-19836-1-git-send-email-festevam@gmail.com>
 <20170722203159.GA6399@tetsubishi>
 <20170722212422.GB2969@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20170722212422.GB2969@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> It won't need clk_prepare_enable() anymore ?

Nope, RuntimePM does all the clock handling.


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZc8NyAAoJEBQN5MwUoCm210oP/AuC07iFqcYC8AVJBx07dIt/
AuBdC+1kPZZePIwnntD0cN6wRfzo5CWAFKOehXxXdTCKV0JqfiDsDkK5PliSJeJG
/zPsbHXLSiN4eDYRZ6fYVqgB/jWlKBgfQ7C6Wzpr4OMIxYx+Fy9z6Rkt0dPYAk9T
c0Z1uWRuspkbo5PJOrVZTr1rgnrzs5XbuPyGt/yxP6im0CZ9GyO3/JooPD/xJyqw
C8lBHnfFDH7YmapwfxGBwjE6FA4LpEFBrBTn08RnrREB4w1DDjhnJDofuCwY8MNB
yoBxUlmC3gqlxODM7EpcEGyMvivKbMzQugu29oMuvORGu/ulA3E2WhiLk0WjUR/Z
CAUjpHZIlLGL37NscQkuztNrfnBScuoXRywHrwx4NkbmlJtyN0AXoB2Y/JOV5+9p
liNJkQFR2R5JhMSGTn5oGXTbibQCp04DKsnoSHvy6wVqjZm+1IE24QMYo6irUemG
zdLx1Nmt27Rn2KWjK4sRc94vd3TL5DGjN6SRX0IlkxlX8wfoYU0fILarQWQymkPg
Xatqlxr6pD1msbo3ODTFGUocpjGfx+RJWPjm6b6YsDxW5QFHeqM4WyTnSXWaSMYc
OCP46z4z/JejUyUBUTEQsEP+6YXShlHZu3TawuXGItax/WmoNfRJVKIRpkQujVSk
IWxIF3wI+Gm4mhxMANws
=rO0P
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
