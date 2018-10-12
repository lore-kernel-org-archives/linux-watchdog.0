Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43361 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSQE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 12 Oct 2018 14:16:04 -0400
Date: Fri, 12 Oct 2018 12:44:13 +0200
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
Subject: Re: [PATCH v7 14/24] pwm: jz4740: Drop dependency on MACH_INGENIC,
 use COMPILE_TEST
Message-ID: <20181012104413.GL9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-15-paul@crapouillou.net>
 <20181012104150.GH9162@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline
In-Reply-To: <20181012104150.GH9162@ulmo>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 12:41:50PM +0200, Thierry Reding wrote:
> On Tue, Aug 21, 2018 at 07:16:25PM +0200, Paul Cercueil wrote:
> > Depending on MACH_INGENIC prevent us from creating a generic kernel that
> > works on more than one MIPS board. Instead, we just depend on MIPS being
> > set.
> >=20
> > On other architectures, this driver can still be built, thanks to
> > COMPILE_TEST. This is used by automated tools to find bugs, for
> > instance.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >=20
> > Notes:
> >      v5: New patch
> >    =20
> >      v6: No change
> >    =20
> >      v7: No change
> >=20
> >  drivers/pwm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

Again, technically:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAevwACgkQ3SOs138+
s6GelQ/+IO3/3WkTMSnpQ2QJHnzotuHHGdyWg9WiVsJXTCWZBd3gXvHrg8HwLrDH
DrxXd4eh/0ZJLoY5/HO0UdtsWcSkCm5DyL3UrZ8WeIYjxZAQGTnxsHGip1yMnOtN
grZXhj171MGsvyJlnjULrWYRjOKQaHlMNusp1J54zLH9gsfKAiv3kjhunxPTCfWT
5yxsy7dAlKp2mlwKg5nT3PFEJvRIk803EvKcivowpSIzhiK5uijW0vWYM/KpyGUJ
1zHK1HJsm097AJrb1d7MXbVx72uMjclZTmVk8RXgqESYGOSHqt5LdenA2xlqUwZ5
Myp5bbr2I0F45H8A8NCw7BYQwXUkSLoCLw+Up9U142QAEjG02rV09vgBzC2gAbxB
piSs6XMY5IHmf6oR7ujMLM/14epj1BdrGPwG/VH7dSKt+VERC6QZ4eNYdyOUzkHr
RtdrCk2Vol8cedHbk70hdWQMMSY8sB3QurTCYaTg/ZIIyViUxR/lu2Zf3xwFqbt7
w/+ICttqjsY750sU/aFUv7lIS40skAgYEIPXxu3Nj95nkaWmrEtfvFQ7YJ+GkPgT
5j4g6cStKFoJ498CDkZGThTGD8Eyb5vJZGFMS768xKdlRkXajXOwoP9cSuqBJGaS
/IbRlVmrzOy7/VYQzJNWzwfEUz+6a5CUi51+6na99M/eT0xsBDE=
=yYfr
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--
