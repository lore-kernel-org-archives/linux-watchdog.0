Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35279 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933863AbdJQLgG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 17 Oct 2017 07:36:06 -0400
Message-ID: <1508240158.24322.16.camel@aj.id.au>
Subject: Re: [PATCH v2 4/4] watchdog: aspeed: Move init to arch_initcall
From: Andrew Jeffery <andrew@aj.id.au>
To: Joel Stanley <joel@jms.id.au>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 17 Oct 2017 22:05:58 +1030
In-Reply-To: <CACPK8Xdz1iK-4bqZfmfTUYw3zDLxCniwt6LupJq5mo-CCca3XQ@mail.gmail.com>
References: <20170920053020.6860-1-andrew@aj.id.au>
         <20170920053020.6860-5-andrew@aj.id.au>
         <CACPK8Xdz1iK-4bqZfmfTUYw3zDLxCniwt6LupJq5mo-CCca3XQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-jY4S5v9IgRxn0LWWmsEZ"
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--=-jY4S5v9IgRxn0LWWmsEZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-09-20 at 15:43 +0930, Joel Stanley wrote:
> > On Wed, Sep 20, 2017 at 3:00 PM, Andrew Jeffery <andrew@aj.id.au> wrote=
:
> > Probing at device_initcall time lead to perverse cases where the
> > watchdog was probed after, say, I2C devices, which then leaves a
> > potentially running watchdog at the mercy of I2C device behaviour and
> > bus conditions.
> >=20
> > Load the watchdog driver early to ensure that the kernel is patting it
> > well before initialising peripherals.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>=20
> I agree that we need to make sure the watchdog driver is loaded
> earlier. I think this is the correct method, but I'll defer to Guenter
> on this one.

Just following up on Joel's comments: Is there anything else I need to
address?

Cheers,

Andrew
--=-jY4S5v9IgRxn0LWWmsEZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ5esfAAoJEJ0dnzgO5LT5BfQP/izJPdvy7HsiMTr/51oUwhWQ
zKfVa2ubmVOoHYeEJyerDKIAj8wMBPZNHPsYd2/MLZ5u6PwrrRQ08dQehPy3giKU
1pPtkgdYl+GMvfjzU/IPaaA80yObzwZC4/oXpq28peLQCJZKx9zpx4q1IUVG1f6R
c4rYxovSHDt4993ZA5TGBw1W+EPR6yZ1dGNvpfK8skpRpqs7/ZkwfIoHD6BLiih1
RupCrKlZGwGfwoXdizDhbmGxI5cXEsysLPFzLq8oXqFLiijE08oWGECqjkLf2UvM
yjDap9mhPK11LAy3G7OIxsRD2MRKh2VfyJ0fv6fEX6Ep5hnlWyuUzN2IlQyb61VV
UTaucK/H1F0EK1XJ4kTXB5Biza2X3ifo2ni7HG0Fp68U5L7bSDpCz+jFsRvR5A0D
kGLwNRtHe3NqTCqT6VjifawunceIU3yPcPfd0I5A8a4w57R5zvR+vfVpnGLyyb+H
lZv3joZcImFmmG9Wg2c1eY7oulaleBjrL1vqXjcjhFHu7+CMquQoo47A6NuYR9nY
dFbolNXvfsHOiz8aKGCpJDydGav6VrCTXfpEVCKrQPFsKRuDOfI3IRMf1VZQh2ak
Uahikn8ReA/yvRQW+OwvKjiwzHjfUyreT330g/JXDUUTnBy2KV0c6y0Xls6Ssk28
h06lPSnD2GTHgletGOpW
=aupq
-----END PGP SIGNATURE-----

--=-jY4S5v9IgRxn0LWWmsEZ--

