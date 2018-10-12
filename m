Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38727 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSPu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 12 Oct 2018 14:15:50 -0400
Date: Fri, 12 Oct 2018 12:43:58 +0200
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
Subject: Re: [PATCH v7 13/24] pwm: jz4740: Allow selection of PWM channels 0
 and 1
Message-ID: <20181012104358.GK9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-14-paul@crapouillou.net>
 <20181012104053.GG9162@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline
In-Reply-To: <20181012104053.GG9162@ulmo>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 12:40:53PM +0200, Thierry Reding wrote:
> On Tue, Aug 21, 2018 at 07:16:24PM +0200, Paul Cercueil wrote:
> > The TCU channels 0 and 1 were previously reserved for system tasks, and
> > thus unavailable for PWM.
> >=20
> > This commit uses the newly introduced API functions of the ingenic-timer
> > driver to request/release the TCU channels that should be used as PWM.
> > This allows all the TCU channels to be used as PWM.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >=20
> > Notes:
> >      v6: New patch
> >    =20
> >      v7: No change
> >=20
> >  drivers/pwm/pwm-jz4740.c | 28 ++++++++++++++++------------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

Technically this should be:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAeu4ACgkQ3SOs138+
s6HsGA/+OJEoG7dAfVGZx3RgpI7szDdd/ub5tyj8iEnxQJesIILP6jDs17mjzQ6g
jaDfYBESKsbVTJiOo/hpgekRsRFVmzZcDXwDAHM0w47OzDNNGT4NNBMNbg94ioki
hycEzI0w8Ty/K/uUBBpHfeswoBNAVrNn/xEE0Wp5ULvcak8AjfWj8gjkdSRgioB/
ghl5zGM0uVZzYjKKNCaQXEcCIO+aTPdvC/fHq5L6yBpfqwFh80OoxJlieK31uGMf
m59ZIkKQsPGvQSRZzuDZtwE6f9iQCBT+2BDebWwJjpUt4nC1oJS8biIEVC2UMEPX
94ltWiddkrj4DPpxZE8fqPhMFegd2cN1CmdB8WIkF6d+/K3LlvktsXmRULqWLI6z
7kF7mufd/s4KzIm35NkD+66+avzFcJYqGCvJMuk/aHAigqOXV8MVQo5zuHHLHl7/
C4KZaAQpXcuwfIt9blMHY+LxILA+vcWewhbIpE6397ICD1o8P//gKCBbQ2nQHAZE
+MtBHieUJMl6zjzsdT3PkifebmJxD0xXz9HdTH6xVR7l5tYrbaenGJwT1TsNYVnp
a+mpz7TXQozQTpXx0DoRrEgYa5Fx+arEMqsBctx9slWENPxwZWC2zyKCeHKYhrA1
vNUzJSXwmQozneec9SaJ6NKSqb/O9n1LOBC0rVV07OwrcuC5/cI=
=DqPs
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
