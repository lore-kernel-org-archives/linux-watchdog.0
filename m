Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:56928 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753347AbeBLU7C (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Feb 2018 15:59:02 -0500
Date: Mon, 12 Feb 2018 21:58:58 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: Re: [PATCH v5 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
Message-ID: <20180212205857.54nmli2jnv4fxrwm@katana>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fwmxrfzpbjqoxo45"
Content-Disposition: inline
In-Reply-To: <1518457475-4480-13-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--fwmxrfzpbjqoxo45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 05:44:21PM +0000, Fabrizio Castro wrote:
> Due to commits:
> * "ARM: shmobile: Add watchdog support",
> * "ARM: shmobile: rcar-gen2: Add watchdog support", and
> * "soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2",
> we now have everything we needed for the watchdog to work on Gen2 and
> RZ/G1.
>=20
> This commit adds "renesas,rcar-gen2-wdt" as compatible string for R-Car
> Gen2 and RZ/G1, and since on those platforms the rwdt clock needs to be
> always ON, when suspending to RAM we need to explicitly disable the
> counting by clearing TME from RWTCSRA.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>
> ---
> v4->v5:
> * various improvements suggested by Wolfram
>=20

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--fwmxrfzpbjqoxo45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqCAA0ACgkQFA3kzBSg
KbbZ+w/9FyTriWtGeRWOvopVj5eil9PSeM1rjVIwx399i7/OiqC+180H214SwvrP
U6knmbhPDT5hK42DPyY9OXRcMAInFbkxdNNnCyOysYW95ukf5xWSG0A0s3NoUE0e
ALbzhebzjVNfvIPANTswz+Eykih+NEv0xlOCjbHos2aESJIfUcarrPQgcJXgubOt
06cX+fAV7f20g2dg/g1sqE9np0N8CPIrDTCHUVi4bsAd7iwpYvOKy6pDEWgnk09z
Q4bjFRY/xXbzjThl93n+RsuOQBEQtsfcGTeG7b2hMtQLyQ02QRmwsGT2BK829u3k
aIHtxmrm8O6uJLTCF/qaWIu3ZheVOvRuF4gbjdKTgDpv0hLV7OLLKp4lWpqAfJ+7
pVKxKdRPi5O+t3L36SngaYRXob751s1f+51ut89Nf1iCfLr7MfY0Yl/7gUTgP+ys
1kDAH7oWqstKspSRQkOw4MAyoUpWMMIjVLfzsG3i1zbn4T9iWlpKJb+teTd9pdfb
UnS7EjAa9ciggTwSadK5kfj/3l15lmmqRBJRHHC5P0c107NjjjPWdOYRYstTFlxF
20V+74xmZ8y1BJkvAox4gR6p6Ialldi99xduDMDfJ0YxhSV5WR8DGjWPOF+U80hw
NCcDCaxkFdvjmHJO4M4KyZqQS6vc+HW9kxh9WahzW/yZrzJamZY=
=YcjP
-----END PGP SIGNATURE-----

--fwmxrfzpbjqoxo45--
