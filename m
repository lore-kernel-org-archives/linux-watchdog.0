Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58542 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdFFTCw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Jun 2017 15:02:52 -0400
Date: Tue, 6 Jun 2017 20:02:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Message-ID: <20170606190231.abhgfavfg6cvmkfy@sirena.org.uk>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
 <ac0c9c0edf9a3a48d8de7a5c07b16b771871796e.1495546845.git.stwiss.opensource@diasemi.com>
 <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
 <20170524083243.5rhritb2tvmycfc6@dell>
 <20170524101057.v2fqwki4fopx5k7y@sirena.org.uk>
 <20170530091759.tkajnmlyel6h3djw@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qdheveixqstjem2l"
Content-Disposition: inline
In-Reply-To: <20170530091759.tkajnmlyel6h3djw@dell>
Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
 driver
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--qdheveixqstjem2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2017 at 10:17:59AM +0100, Lee Jones wrote:
> On Wed, 24 May 2017, Mark Brown wrote:

> > On Wed, May 24, 2017 at 09:32:43AM +0100, Lee Jones wrote:

> > > Plan is to push this through the MFD tree.

> > Great, thanks.

> Just taking a look at this now.  It looks like the dependency:

>   656211b1dfb9 mfd: Add support for DA9061

> ... is now in Mainline.  Therefore it should be okay to take this
> directly through the Regulator repo.

OK, can you resend please Steve?

--qdheveixqstjem2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk2/EYACgkQJNaLcl1U
h9A03Af/Roh0PLgP0x8PVW2nb/wQPKt46BrQkVeMMZpI1ZkTynNtL2cnXC6+tUi2
hkGqWxM6inmjOlIlCjTJSsNBt7qORcJfZHy8x381n2nGowpirNJ7W6EaIJpXAkCI
rXMnYbRo4Wqi+UDbKKS/d6QBMZTLBCKyMKXcEaOznNNLFDTHY6hq7AuVwJn7zAMt
6DMWCi23nwY1NVl6Z6kym5eEn6x4Ye4OT7zHjjm0xRfMKW4HBVgIDbCK2RYephYj
tKcmEmWQ7FEmw+jAEzyg+4B2nG3/vokmBgsNDuX6HLmfq3kvn/UL2KossPCti8Sv
iuUFsKSCjCmGSbu3qBt6fk7ZzA+3JQ==
=09LB
-----END PGP SIGNATURE-----

--qdheveixqstjem2l--
