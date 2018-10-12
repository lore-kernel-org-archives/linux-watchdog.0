Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40443 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeJLSOX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 12 Oct 2018 14:14:23 -0400
Date: Fri, 12 Oct 2018 12:42:31 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 15/24] pwm: jz4740: Remove unused devicetree
 compatible strings
Message-ID: <20181012104231.GI9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-16-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-16-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:26PM +0200, Paul Cercueil wrote:
> Right now none of the Ingenic-based boards probe this driver from
> devicetree. This driver defined three compatible strings for the exact
> same behaviour. Before these strings are used, we can remove two of
> them.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v5: New patch
>    =20
>      v6: No change
>    =20
>      v7: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAepcACgkQ3SOs138+
s6HYNA/+ONd+BCqmE0Z29A+IoPCHFyLIVoy/aZWszgeBoqk9D9PAKKbi2eHSBBL2
Iq0GqudniRWhko8hmM9NU0XhYgDm8sq98sTAQReqW1ctn7/Fx5FNwM9Rtxe9yKfx
EWELqIPbypO7nHU/6kC9ekdf7KI+a35Envx+/8oOdgF//KqzzVMQsuVCFlnzPCvp
tXHT+2zHxrxMnaDVSxJQsXC5lnrFeP+lAE6+XN0W/d9x+wAtL56Nh0DOO8OJIfpm
aJYZHN8hmZxTMxNUV5j3gip0uF4+m9iumnwAXAY1SZH84NPBviqGho5P/I9NqCwO
GvncripVWrqlJVAGYfh5c/2Vg6mEGTE3gqjDumEpvPh6nyqAS4U/rmiB9wr2pE7u
FlmbeqgUe8FBm9gm/uaP7iMxkeH2ChSsQ3OKtYUv+frGhte1iCbpe4RSIK4q4FGN
Wxc5rJcOzud1GGhbrPmARDE9RzjX68N7XlIZtpDsxDLakwkmh1rJLk5wHWSLkYeh
nGRXMhOm1R5jTaipnpJ6C+h14xp7+5N4ccXHa+2Uu1x8wn01L1SL2jg4JpfidAnO
9z5i5OjGgs8ZsJOR0u3zaZSKq/fdgkw+CGXxvz3sQXRvZ/HjOpdXAXvDeweO87Ax
7H9hEhbaGvSzmyBSP0Sn5KxlE+5xfOpajThQsJhWBASaWaTlKUk=
=81jk
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--
