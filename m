Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4C42BEA4;
	Thu, 16 Jul 2026 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214695; cv=none; b=QgpZSiNOX/s8h1r+Pelc4BbAwHzFzmpttyCoSn5v/wcV3YoPrSF0ikJqAVyD6DeL8NUC3gn5RZoFm+/B50MN4J9cNz1VVWOJawiddjukPN7Ls0D9s1WfYZGsrfEvCGC//mivVfafGbw+YwoETJbGy2u1AnQF5h9lxnfl2K8RDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214695; c=relaxed/simple;
	bh=xb11w50PrrwCxaytA29Tp0Tnvc6ifD7BYBK04Wi7YLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSUKp1QwbBE356Nx2tTb0un70CI6CDgalWNF1mIgmdPVKBODbp9aVZ5hikzKTF7ScXnGHDLkWgIQyjBsIotmsSu4aFkwqGo0+Q/cCYrQERCYfK11Lc5R7mMH8sZxEGlVTQKmF4Pa5M65CQEaTWDYfL6NuJCReoulOXAo5GcCaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E00k9pQr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E00k9pQr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E17C11F000E9;
	Thu, 16 Jul 2026 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784214694;
	bh=bVtSUM22Plu56d+Hb0W2FSEGvxdgjVgxuQGtCapC4fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E00k9pQrY2EPdIVi3Vzlc6FdgbeQZxlehIu7+5cwAhes6/cUXhJiyniUFbLcrxLL7
	 0xxBQdroUg4YZ72l1b/38/rLLWUDb9eMbdOvCWavtv87rybDdW/6NLSI7zdVzzGI/E
	 nI4ufCMmHKr3VJitjfLgy43uRWonL40dtOa4N1EEBlInmDeSTpWMInAwfBb9D/WXID
	 B4TUZkRAAyuiVGfQbQt3JN+kRrZ1JU6K3qjV+wbIguEj3mtqfXoIeeMEy9PYKJgCzV
	 JCU2PflegFYnCZUQCG1AxoP/tphmd8tEtfpi8Wt+QSI3p52FeWf8G+R31bc04BbG5c
	 p1jITJ1+DjYIg==
Date: Thu, 16 Jul 2026 17:11:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 08/10] dt-bindings: pwm: apple,s5l-fpwm: Add t8132
 compatible
Message-ID: <alj0EbuIzZUa48di@monoceros>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-8-e5655ee56523@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hqzcajh75jsx3u4o"
Content-Disposition: inline
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-8-e5655ee56523@cyberchaos.dev>


--hqzcajh75jsx3u4o
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 08/10] dt-bindings: pwm: apple,s5l-fpwm: Add t8132
 compatible
MIME-Version: 1.0

Hello,

On Sun, Jul 05, 2026 at 03:17:27PM +0200, Yureka Lilian wrote:
> The PWM controller on the Apple silicon t8132 (M4) SoC is compatible
> with the existing driver. Add "apple,t8132-fpwm" as SoC specific
> compatible under "apple,s5l-fpwm" used by the driver.
>=20
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/=
Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> index 25ef04b60ca1..c85a2b85a66a 100644
> --- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> @@ -19,6 +19,7 @@ properties:
>            - apple,t8103-fpwm
>            - apple,t8112-fpwm
>            - apple,t8122-fpwm
> +          - apple,t8132-fpwm
>            - apple,t6000-fpwm
>            - apple,t6020-fpwm
>        - const: apple,s5l-fpwm

There is no merge plan specified in the cover letter, but I assume this
should go via arm-soc? In that case:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--hqzcajh75jsx3u4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpY9KEACgkQj4D7WH0S
/k4f2Qf/ejt+g4KhqmWnrNTPNMUcRtIQo1/q4Nj9sbE1bUT4MmNf6hqmRzkKK4Gj
YSZ3gk42eykehjK/cA+UvtNNu7sZa3aNPodcEwo5vN6Y2a5gDfRJDRb4yxwGKeEv
iEMFjStlA5uRrmk8gpLff0v8Q8pfkP4dqCgkeSdJWIdPR7bmDkYVQxMrKWpNxzZA
hndISXV63bd/4yidL0BHKqV/koZkVknTh6R7GhOSa9rp6NoJlT1MTgcLf8LxgvtF
1qi3MOXA9ZULItOGW+4MVhIt7xNLLecgGxHnNm6KAplOg1Cf1QLd3hQResk/x0N1
4Ow858dzNiSoNIZ6UorB/403BKV8Ow==
=z50O
-----END PGP SIGNATURE-----

--hqzcajh75jsx3u4o--
