Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48850 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdETQbF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 20 May 2017 12:31:05 -0400
Date: Sat, 20 May 2017 18:31:00 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCHv2] watchdog: core: add option to avoid early handling of
 watchdog
Message-ID: <20170520163100.b36l56k45jlylufu@earth>
References: <f38c7967-ac56-c188-2232-42544088edd8@roeck-us.net>
 <20170512120532.12986-1-sebastian.reichel@collabora.co.uk>
 <4a4c4de8-31e4-8e15-8c63-ebd4165a63bf@roeck-us.net>
 <878tlxpycf.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jpvywhe44e3ehluw"
Content-Disposition: inline
In-Reply-To: <878tlxpycf.fsf@rasmusvillemoes.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--jpvywhe44e3ehluw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 16, 2017 at 12:08:32AM +0200, Rasmus Villemoes wrote:
> On Sun, May 14 2017, Guenter Roeck wrote:
>=20
> > On 05/12/2017 05:05 AM, Sebastian Reichel wrote:
> >> On some systems its desirable to have watchdog reboot the system
> >> when it does not come up fast enough. This adds a kernel parameter
> >> to disable the auto-update of watchdog before userspace takes over
> >> and a kernel option to set the default. The info messages were
> >> added to shorten error searching on misconfigured systems.
> >>
> >> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >
> > Minor nitpicks below (which I fixed up in my watchdog-next branch).
> > Otherwise
>=20
> Guenter, Sebastian, can I pursuade you to take a (second) look at the
> patches [1] I sent 4 months ago that implement the same thing, except
> that they also give a .config and a boot-cmdline way to define what
> "fast enough" means - which is necessary in many cases where it's simply
> not realistic to have userspace up-and-running before the dog is hungry.
>=20
> [1] https://lkml.org/lkml/2017/1/9/408
>=20
> I'm of course happy to rebase and retest those on top of current master,
> but the implementation and semantics should be reviewable as-is.

I wasn't aware of your work. For the hardware I work with at
Collabora my patch is enough, since "fast enough" is defined by
correct watchdog configuration (done by the bootloader).

I guess something like your patch is required for systems, which do
not reach userspace in < 60 seconds (minus some safety margin). This
is not needed by us. OTOH your patches should also work for our use case.=
=20

-- Sebastian

--jpvywhe44e3ehluw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkgb0EACgkQ2O7X88g7
+prvkw//VaUbWCO/IHb2iL+yCZnHPb3aMCS98Z6SfcNiNBytPaVF2C3eikFQMi5R
LO2QHIP8+rMF4lkOhFpxnzuroSfP/l+gyQ5Wj56SDjdGGt/2zP3jBYqmW5TykBwD
C3Q6cfY3u6E9ntA15Gni5Deycm627OtCf/NbWL4arvjCftq0BplJAgS5m3/8lPmZ
exn/IcLzx5CrDaWVPPWKgj4pp8sRDnmtWCYTPlW7LuzhR08LUoqru1xMZSUlCEfr
DgzD1p5vr8wSOM9NyLB7i4gZnyjakQnI7ADYKGT6jP16T6SpMgogzNDNA9PecEUj
II0g+S6/fF5xIwn7oLH9ggPFzw9BA96MBEy6+NracQHhQXYreYFukKmb7bdRav4b
JtSoTu9PME+qiuMvEvBIrQJqi/f7dRekxU4qrc1gPgNycQNwPGbcDdBCQpmpUSIH
5JyuGPSLLzsG+SZVEv7v4OHLG2vPLcDTJ8J/iuuiyhJ4Jd27NqPjIrYiJcusEs4j
0194owkyDILMVeIxhhpuDZ1rYccTh12vSLpF+7JIjk90lJETLxegjAIWauKxwxE1
oo3tuoBFUaNSOZlK3sGwvA7KD7bAhN9XKXq/s+A64AMPD6hXjSL9cFq9ZRj+8kkm
7KJc1RS8vOwR09X8+2KgaOlsqPHi/CtwkjtIh8yek/PBhqxSI/k=
=X3wZ
-----END PGP SIGNATURE-----

--jpvywhe44e3ehluw--
