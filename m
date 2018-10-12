Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51172 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJLSMp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 12 Oct 2018 14:12:45 -0400
Date: Fri, 12 Oct 2018 12:40:53 +0200
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
Message-ID: <20181012104053.GG9162@ulmo>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-14-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-14-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 07:16:24PM +0200, Paul Cercueil wrote:
> The TCU channels 0 and 1 were previously reserved for system tasks, and
> thus unavailable for PWM.
>=20
> This commit uses the newly introduced API functions of the ingenic-timer
> driver to request/release the TCU channels that should be used as PWM.
> This allows all the TCU channels to be used as PWM.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>      v6: New patch
>    =20
>      v7: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAejUACgkQ3SOs138+
s6FhYw/9FW8lZprZj6ntLye6m/IyGDHZalykPoLYefvS8bTuDn3qwMPId77gLA8m
t8XjWmPCnwAJlXJO6v4L9Ttix2VAGpApZ5fyIAK9pv9Q5XhwCVYVbgyrPOnz1at7
EsBxEwRNKMR79BkCA9JbT4eQy5tC/bpFadpItJxgRLyJAtTJX0kWa5piOvn3typ2
zPm3osA5C1Og8EIS8kk1SxlRP9+gOcollqUqkFDMsG+h82RAzWZqCMOU+c3kmyvr
v5EelQuSbw+H4Y6ZOZj6tEeIiyzUnedD07NbjRdkK33JUnE8xt33anbe5X/6P6e0
AhUlG4y8kqN0mxhkWgpgIrJh/VOEsjTj18gMCU4LFNBDzj1MLon0wukTaZ7mq4yg
lKMbQq0l+Il5Ii7JBKzz9LrbUzard4dVGDYQD2ChSQmLUTS5Yh0lAMzlYiIui+ja
/Hv5+KuxJnii1KcKenvxOgOlOyJMk6AmTfD57Wk/wM2wm3IotiV1TFhAUG8we//3
KAGPr83Uvpcx2oDhvcPplPK05TolV9W6b2QoxRaQfAcr4pEoSI3Fq7I4Mo1FvOT1
0k/zXI6YUADZY55+6B8b6oqMk+OM+lZxipHgtIQo3LmtI8JysGBzkpT+MTyQZSvI
/+neLH2EXccv9Ut5s5yYQw/uSq36oAO34Tu3zk+GsPx8XZB+Zqk=
=1+ye
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
