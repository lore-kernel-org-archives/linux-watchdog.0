Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089697;
	b=o621oK3bL5SFPkl3+zWJMqWLw7dg1lEsVUE4Dg/DSuDlDfFppLr4YgY8yGktnu4im32v
	 hSj6UVVCKFwAAbexd+ZhyzGGal6411ZsWylNVOLmXr8PqGQYDoa0d/jcS5EjCGG7jiaZV
	 wj0oDSRXj/Dk33K9aeq62vo6vopwojFqMS9J7qkHXzxkA1Yil+aDmLdp/P4lmLHJTzsko
	 jR1/B3OeBFgzQhmLHEt8yAtEbvAPVviVBT+qhvXVWOuWyziVdYL1lilZ7DBGzv88neUTu
	 w6DrnjVH7G+FMq/jASenft6JAH67knsbzpfKzg4R7zv9RNImbzqnLYlquSywD/zv43g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089697;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YiGvfPO8lWPcTMujIOBDkGnAATfXB+3gMom+JivhP4I=;
	b=gLTBcdOOQcyoo691OvqhCKRI+GVCPlkd83BYnQuUnG70yDSPXRRDagnk1iDzhu7DyfIo
	 HBRi7PEZa2QnK1eKwTyZY8JmaRh+C8bhpM+KZlSOHy5GRoU4UBk/Z2+YyxZZ6Q1dXfOVX
	 Rvf9r+lxTyp08iZTUNxEz8K5VDtOpIjcK3CQNBe/0Vn32uqD4teBd4W1YuKndPZW8anjN
	 WVGrrjxrLFzTl0rcEjbp0cnYgtcmpiRODXmHmPIb1nQ9WuY/H6iuOb7V6xKLNSy4FzzNf
	 E/s2XZIRvLbrJ2+K9GVPVYvqIk03LBnyQEN3vLuJVZIA3NfTgWmThfy/ILga0ZLiyIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GDxOg+/O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E1913606A31B;
	Tue, 27 Oct 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDxOg+/O
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 040911F01825;
	Tue, 27 Oct 2026 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089696;
	bh=YiGvfPO8lWPcTMujIOBDkGnAATfXB+3gMom+JivhP4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GDxOg+/OidGDh+op4PZKFPmGJZX6FIqs1fNvpzf3+QrVikwfnnkRapy3E8/9MRtMn
	 +Z+0tXC+bGwAUE5882CibfYvjj25yCv04lmM1HY1v+hVl3mqeLEqwMIDv1x+BZak2W
	 DtH2WXyT4aFv96+qvfNQOuj5ICd8U6OaDj257AwsZCm2Rn4UqLC1hv1YtFzRVF08jJ
	 1LKDLEOY8npycHhNpORGGbiqp3jz5cICTkInnCurqB/JIIOycw//BlbqJ4k9En1nN9
	 QynPbMK3adqDOafKQ18jukHXpzkD9gxwvpSPZcKgHGvgiZVZk03Lxav6K7lOWbwdNU
	 xNIFHI4/uzTaw==
Date: Tue, 27 Oct 2026 09:28:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Sasha Finkelstein <k@chaosmail.tech>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH 06/10] dt-bindings: pwm: apple,s5l-fpwm: Add t8142
 compatible
Message-ID: <auBgZhx0qcbAgHnF@monoceros>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-6-1356181bc50d@cyberchaos.dev>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="osff576hwwbj3tks"
Content-Disposition: inline
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-6-1356181bc50d@cyberchaos.dev>


--osff576hwwbj3tks
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 06/10] dt-bindings: pwm: apple,s5l-fpwm: Add t8142
 compatible
MIME-Version: 1.0

Hello,

On Tue, Oct 27, 2026 at 09:03:26AM +0100, Yureka Lilian wrote:
> The PWM controller on the Apple silicon t8142 (M5) SoC is compatible
> with t8103. Add "apple,t8142-fpwm" as SoC specific compatible under
> "apple,s5l-fpwm".
>=20
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/=
Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> index 48cafd391ca2..7c9e148727a7 100644
> --- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
> @@ -20,6 +20,7 @@ properties:
>            - apple,t8112-fpwm
>            - apple,t8122-fpwm
>            - apple,t8132-fpwm
> +          - apple,t8142-fpwm
>            - apple,t6000-fpwm
>            - apple,t6020-fpwm
>            - apple,t6030-fpwm

Fine for me to let this go via apple-soc.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--osff576hwwbj3tks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrgYJsACgkQj4D7WH0S
/k4YKQf/eh5CHfao6qpCs5ensLJARYPiQLmM7MEnVTmuzRzfOmxDGCcz78bwmYPM
N1vos/TZlbRIBml0Ci+lx2nuJBKqCWVW3KqxHpSm3xaOoxExRuRKOeGhvgxsmnLO
AdAXkYxedLQvYEykoMB3S8m1c/e8dkF2Wt7jIx+NOMk3xVyTWIJttmYpCVQX6sdI
U6O9qXIfZz4S2Tza4z7IPQDPtO3sTH/pOCT7AUy71gfAgfxI8Kjl090c5dYGVtHI
3mzNK5S3Vfm/BanI5WdEV4WsU6oTxNjjE5DaG/f5yyod/dOYR3VT3O/8Fq92GNVB
hPx73VUJrqd3dTtu7nEkhJZgLopppw==
=9oZQ
-----END PGP SIGNATURE-----

--osff576hwwbj3tks--
