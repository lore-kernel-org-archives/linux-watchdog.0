Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C64D990A;
	Thu,  9 Jul 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619394; cv=none; b=lozyrxaoFNKUELhgTLSc4CuHZKneXP6FpLFfT4VxvoN3SRhQv5TQqcTH4T8FMURkZBbwIaMiy8Iif1Qcfo4if8ne0aI94I0CiYtY6jAryEOLRih22I/NQ1clYkuuV2Vdx9YKitEpU8C+OXEAt3Zg3AI05Kb1ExpjWOulp8jHhhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619394; c=relaxed/simple;
	bh=hBd5FZlnvt8qVr2rngfOj7JDFYfjWL3zYZADR3eYLyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNjHDBz8PPjV8hDWULGz8/Am9XecsVbH2lWhd9p5GoST3f5VS74YSgY2yvVI1g4DO+gx+dnzQF0nm9xZRYzSm1rNvhwh8Ebf8OxxHlZ+qVhruBX9SUHzPIZckhNzJyN8kTTI1/8+za2Q6MNvmmzErN3RnoBrCZFmkN2FljIC4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEH1Ar+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEH1Ar+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A27C1F000E9;
	Thu,  9 Jul 2026 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619392;
	bh=hBd5FZlnvt8qVr2rngfOj7JDFYfjWL3zYZADR3eYLyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cEH1Ar+WKXKW6YA0WgeZ/lEsARR8htYetFG2gY3KS8ziCfticL5f4wReoaglGBy+a
	 qbMvDnS2oBoZTixdYA2WLV2UmBhpkoljeqcvFP8Qk/F9/W4BY0cKR0+gpW/yS7uQ2b
	 fatfF6XsyZrqqjB1VWF7VNXpvuaIbwUtXcNlhNzqP8bkj+IkdpFjctF0MSCwHqzxnl
	 9Xr60ctiYa8qZPUxWySkCuuCUNqk0Qdu+FtrA1VsJbzErP3b8Pv1aui/DzVrmtkGmk
	 9TgjiBk63COV6FrB7y2ChDEwuVvmNURMi+l7heD7UP2Gbv5pfkO6SixBYJLSMdFYUn
	 6Yx4TRXofoAUw==
Date: Thu, 9 Jul 2026 18:49:46 +0100
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
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t6031-aic3 compatible
Message-ID: <20260709-scaling-hazy-d36fb3250e7e@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-3-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YvWdE4NKYv9MtnVB"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-3-55b305833123@jannau.net>

--YvWdE4NKYv9MtnVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--YvWdE4NKYv9MtnVB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/fOgAKCRB4tDGHoIJi
0sWmAQDgI9YuXyIQ2dvOC29etmaIiA2e0+V2dcHZZj/zfXGaMgEA+iHj5g9V6QLu
EK0XK2Fi97uP+qZrW6GzdHciVlCoqQ0=
=BvyJ
-----END PGP SIGNATURE-----

--YvWdE4NKYv9MtnVB--
