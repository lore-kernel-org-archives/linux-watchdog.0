Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3F3A872D;
	Sat,  9 May 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778350443; cv=none; b=SPUxDVOm1DHlXXUU+agwJElKmaRSEZYbbiDMF1oM40DWcoSt7xDnPQuTxFV3zDqAtF6G6znv49b8G0idIiBtmeZPsINPw9oj/mZASS6sRXA5TaSnlc0NuKKOq/1yfPH9DJj3HP07emN+UtxYf2yfFbMgNQDSJvCvXoZyAY9esRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778350443; c=relaxed/simple;
	bh=G9TFV1PVG6NI2S0qJ0aNxwi2yPtCxcKvJP/Wz5wBgCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llSwFdscCSXrv84GF8xSBg+XOnFBGVp3g+VNY5EUKHDBorjA7WovlXlx++Q7Gyyrw/5af2FTCaohXe8rK4uW8OSMx6UuQcZevf7DO2VMxyrnNQ+KMpyf5QFEIGMBtPI+Jrvn2jCJZWQ0hGVA8RSLfEtLCTM58ppKzHE6hKY57Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bil5B/Vp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bil5B/Vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490E5C2BCB2;
	Sat,  9 May 2026 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778350443;
	bh=G9TFV1PVG6NI2S0qJ0aNxwi2yPtCxcKvJP/Wz5wBgCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bil5B/VpKYyaWF3T8uSzF81XU7g6N90Q8E/CUl4XA5KN1AbiEhW2vuAJFysqnTI2W
	 Ef730hSOr6ifnPzm5U+igrdMFPYn38cnQyvndz5RJigQ0p0/8MqndrZom2xR+ZPvlW
	 EhhFYRCY29/5hfjQ1sSaQZPU5b3CQIsojXxxFJ+wsrb7j1OTgpGX9oxOk33tm/bpon
	 DnpFfPSESpJdM5mMAxyB7x6VIBmGRDXrQj8jMRqGAyGNtMcnhY8yj8cWtEH28ib6Ce
	 5MXTwiTnT/IJBW1p0EMtgqWel6x45Wf0j4Fol5PUAjVEYDYZQef1LcSk0kznE32MDj
	 2RPCiwfkjWYLQ==
Date: Sat, 9 May 2026 19:13:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Rustam Adilov <adilov@disroot.org>
Cc: Sander Vanheule <sander@svanheule.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: watchdog: realtek,otto-wdt: add
 compatible for RTL9607C
Message-ID: <20260509-rebuild-snowboard-e82a3adc5a27@spud>
References: <20260509163101.722793-1-adilov@disroot.org>
 <20260509163101.722793-3-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GJ7OXt7j0wXpFDPp"
Content-Disposition: inline
In-Reply-To: <20260509163101.722793-3-adilov@disroot.org>


--GJ7OXt7j0wXpFDPp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2026 at 09:31:00PM +0500, Rustam Adilov wrote:
> Add the realtek,rtl9607-wdt compatible to the Realtek Otto watchdog
> binding.
>=20
> Signed-off-by: Rustam Adilov <adilov@disroot.org>
> ---
>  Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> index 1f5390a67cdb..ac9db40b12dc 100644
> --- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> @@ -30,6 +30,7 @@ properties:
>        - realtek,rtl8390-wdt
>        - realtek,rtl9300-wdt
>        - realtek,rtl9310-wdt
> +      - realtek,rtl9607-wdt

Please explain in your commit message why this new device is not
compatible with the existing ones, particularly given the driver patch
implies that it would be.
pw-bot: changes-requested

Thanks,
Conor.

> =20
>    reg:
>      maxItems: 1
> --=20
> 2.54.0
>=20

--GJ7OXt7j0wXpFDPp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaf95ZgAKCRB4tDGHoIJi
0o6OAQCmzeGTVLvkC5psIwzzWEXpbBK/URfjZld6Pi9R36QWEAEAiBHJIndQhn9N
/NL2deuI90wXkiZsQrFlqgA0ER+MvQ8=
=BZXH
-----END PGP SIGNATURE-----

--GJ7OXt7j0wXpFDPp--
