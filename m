Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418995;
	b=I7qvZHeP2Tmap5JPrVr04VwroMbCFjwwX5nM9h13hKovVmbFF+hAO3fQTfWWoMVGeGMy
	 NiA3XuVnt2SmQxCV8wkE1BPyDEq6YEdjY7obXDytXc06ABo86hR8fR99HKfBaWhF+582s
	 iprWouDvvYefXuRxSeiRHZYCUYgnGBYmeZ898BGCNPMXe+50zU5lLfyfc9uKcNmBf/7Mp
	 Rd2L/ByAhIRmd3NEPCeEKzuoyeOSG0TzafSjnXQolb4VO0R0tlN8DxziUui3m2JklXgDz
	 qM/ho7ldNP2jlEoKk5vDyh0uAeL8e39L3qsvKf65YK0gSDfjl1TbkDZFdJ4oDLg7c+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418995;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u1s5rkPCeMxXLGpOkwm4W0sjwzd61X5pioztJG/wrP0=;
	b=k2tS8ccPNK4TotGyx5piKS+JwCMvwqDfDJWYZtIsQLheHKdh0Fd7OTbq0Es1vdZ30f/y
	 So5Bne8hlFxz/t+Y5hmM8Jwyxna9usecVHb9SRomzsn3WDzj6NHAG+vdy1eCGqC9NaLjF
	 1713zMgKt5ksT21gY5li8CMZSMH5G7tD4FFceGN1W8IIwduHt1qrZ4bN+2fbqbmkMGJwj
	 KtN5uIakUJBeF892TRLI5q+lLbZec8xUTqWZUSr+TMqXcEPBPLUzQcaYdi4Grhqj9nTw1
	 qGG8YxHRMkxF6hCvaTyQZQ2K10nXgWcqKQrJ68eyEhI7NjX12+WQE/HZ7M6UOe6S9WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I/mCXOuA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004EA606A321;
	Wed, 11 Nov 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I/mCXOuA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9B51F00A05;
	Wed, 11 Nov 2026 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418994;
	bh=u1s5rkPCeMxXLGpOkwm4W0sjwzd61X5pioztJG/wrP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I/mCXOuAMNT5zpb2utZopCT8CByLpH3Z/uKgQnosx8sd5tFK+YMXQ/ni3Hgp3ArBc
	 H5LrV3retAVvTH7jAt/heABIZ1E18wI6B8y2De77d8IbvKpiqT8tm2LclA6HGaHunk
	 md3ldu6kkQdkvKSo4iKD8+s+w+e51clIVf4LzOxpgJzXk33wn/v07/DBgkLAwPdA20
	 Y4PCEkRilqzOUgWI9BitIs9gl2hmz4yWwSF1wezsOacD3D1fQoP7cl/YjjFdxP44z7
	 cghZiXmqyMWbqDmIkVIXf6sZMuCnwdI+2oPzOEz/38db+pE+pkxZIsJhafgm/wzTfa
	 7Y4+F+ld8NWrg==
Date: Wed, 11 Nov 2026 17:43:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Rong Zhang <rongrong@oss.cipunited.com>
Cc: Keguang Zhang <keguang.zhang@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rong Zhang <i@rong.moe>, Yao Zi <me@ziyao.cc>,
	Icenowy Zheng <uwu@icenowy.me>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] MIPS: Loongson64: Add watchdog node for LS7A PCH
Message-ID: <20261111-unlucky-parrot-eb416eb0c794@spud>
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
 <20261110-mips-ls7a-wdt-v1-3-968bb85122e6@oss.cipunited.com>
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
	protocol="application/pgp-signature"; boundary="El6grj8KCEocYUnH"
Content-Disposition: inline
In-Reply-To: <20261110-mips-ls7a-wdt-v1-3-968bb85122e6@oss.cipunited.com>

--El6grj8KCEocYUnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 03:02:32PM +0800, Rong Zhang wrote:
> The Loongson-7A has a watchdog. With proper support added to the
> loongson1_wdt driver, wire it up by adding a watchdog node to
> ls7a-pch.dtsi.
>=20
> Tested on Loongson-LS3A4000-7A1000-NUC-SE and Lenovo KaiTian M530Z.
>=20
> Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
> ---
>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/d=
ts/loongson/ls7a-pch.dtsi
> index f304f99946f1..770c96e9b908 100644
> --- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> +++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> @@ -67,6 +67,12 @@ ls7a_uart3: serial@10080300 {
>  			no-loopback-test;
>  		};
> =20
> +		watchdog: watchdog@100d0030 {
> +			compatible =3D "loongson,ls7a-wdt";
> +			reg =3D <0 0x100d0030 0 0xc>;

The style here is weird, usually we like to have the whole property in
hex BTW.

> +			clock-frequency =3D <50000000>;
> +		};
> +
>  		rtc0: rtc@100d0100 {
>  			compatible =3D "loongson,ls7a-rtc";
>  			reg =3D <0 0x100d0100 0 0x78>;
>=20
> --=20
> 2.55.0

--El6grj8KCEocYUnH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavSpKgAKCRB4tDGHoIJi
0uh8AQD94th9BfopVZyqRbIZD31gY1VVmL6TqtnSFDsxE0d5BwD/YfeALYRNnFP3
ncDWkx77DWCCWzkm8mNqiRG4oFQnagU=
=mk3p
-----END PGP SIGNATURE-----

--El6grj8KCEocYUnH--
