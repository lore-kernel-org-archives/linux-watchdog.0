Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5974195D0;
	Thu,  9 Jul 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619513; cv=none; b=Mp0VnBYpAGAyVT0O1EVp6I4XbzV4i4jDf2sqRFCmFNGUBXujLnWfo1qwOZ6ggNvPW2ZLmA5Abonhwko05yuxcBoMECE8KUO2DLMM3TvDKxXceNjIqlkB5BKubOcI5moTzSs85IISlNFaK+0+HZODJaiI98ZTt0LkeBTqwmv4H74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619513; c=relaxed/simple;
	bh=bx3BgTooTYL0guog1felYiO9mnTJvslWy+4ToQynP7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njLqkB0Am1yGIMO83I+19t3v8IsqdHjAYtrQk2Np08r4WPfX/3dNvdhh7AF5RUjQwtFp6MkzETd4oriikPaSgWlXvh6y60Wu+D+mgggIqeisR9EKenxjs43FlUwqKtklRw//VYeYQLkawFQCfiBJq8jeuvR2X41+G18/trtO4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXPYedCg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXPYedCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A4D1F000E9;
	Thu,  9 Jul 2026 17:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619512;
	bh=bx3BgTooTYL0guog1felYiO9mnTJvslWy+4ToQynP7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SXPYedCgYxx+7Oz66PS7V4uJNe1HUgHWtmdZ7FXSz2knXusHkYeD/tDagMm8xulv8
	 HnPx/rhrkBt/GlL9jEdrJaLA2ZEbafVRG5FZaOB26zAaf+SRlml60zpCWd50C6w0WV
	 njYvcYHTfZ5+FAYnmUwRBNBLKd2c9o8lxAYh2FFnK1NRfl6cfmTrQ5HIdamepb7UOi
	 ip0XZkyGBELNrufpyVDD258/AUwyyPrPTKS4EIP/OUcymDCN4HHko4TRx3qFfvToS/
	 0SBArDG62xAMBH0c+DYYRmI3d4KhcNAYS3WJZcUelZ1r5WPaygONrcGzEDUYPF7u4C
	 y9DrCbpShqQzw==
Date: Thu, 9 Jul 2026 18:51:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 07/11] dt-bindings: pinctrl: apple,pinctrl: Add t6030 and
 t6031 compatibles
Message-ID: <20260709-maturely-bucket-bdb783907d7d@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-7-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mL34U3tBDTFKGQuD"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-7-55b305833123@jannau.net>

--mL34U3tBDTFKGQuD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--mL34U3tBDTFKGQuD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/fsgAKCRB4tDGHoIJi
0lqNAP9xEFlSW0nO0NS0vr3KdZBfkVat1bW2xZSZFs9UkfkbQwD/TiAy3NUYm5Ky
zpK3kdm0OXNFnGRZR72FovJM0JtTtw4=
=hXy3
-----END PGP SIGNATURE-----

--mL34U3tBDTFKGQuD--
