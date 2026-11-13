Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590267;
	b=DNmoICplBYdqGGJkxuFmeJPAQp0Vc1LKoMmFVBe74fsRGCegEPmcd1ZRG/dvOoSRJm4z
	 rIg73T5r/eMWKEjzYFts9scSWQ4qnPHibThP4PEpa2S2GStFkBXYcS75nPgZiEO3icqru
	 P2YZipt6g2+KgHeU5otlA980LTyAYplyU8zPMHQV+/UGRUSCzwbgI9WmbjY6dP8jZHTQF
	 x4zNahktSRxDnX1azsOzwUMJKz+HDlVxKHSqrlwvOYEr2Pj55/2XmMsT52BTbx9pHkDQf
	 QXHM9nBRWN+AhwOwiY+RnmRQy5pxj6C0M6nTz4K+P5yvOleo3TGhkYrO60S+pc3X2Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590267;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i8CkkTntkOlhXV5Oilne9I20OCwV11Hsyz0HqIrzxuE=;
	b=x/Dc7wjpIxAwUnqhE45eEMkfFPYhQWKLnTL04QNrymVGsUYhgn2lrC34NJckmt9VWOsu
	 Vo9ABbMAk0Td/JFnm5J17EcVf4bj6SmV6bcfSJxwqiWqNRE1rGnIbEfpiEyeWcugk9jZw
	 k16AsNRNXcUvCULw14s0ZMJ8nn95eQDd20JTFzYP2BJlKvZNoWQQiGLrfUhzrq5ud40fE
	 YNJOm9TIRCNrWhoJ2FYaDWqSg05YSFmbtLewX0L2haM+FaHRdsJVFlbFXZEQwjMDLawgl
	 C9OpWH6x+JHdZZU4B1Gr+qhOo7szzbgyY7Jmqk7HydYax/9MtTInewDHIpOLW+z+6Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOH29fXS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54360A382B;
	Fri, 13 Nov 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOH29fXS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A61F000C5;
	Fri, 13 Nov 2026 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590266;
	bh=i8CkkTntkOlhXV5Oilne9I20OCwV11Hsyz0HqIrzxuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YOH29fXSUnNZ2A04LI4D/SCONccdA2r939twFPoOtbC2fZw0ilnIcMKG8/OUiRhWP
	 qRYTzIjZEKOrGNsDjSRNO2ciYBbtp8ajTOS3LVGA6VwtFEHw30+LUvm6hX8dzVDhkx
	 SOzuwkBOpJrPVK19klp3Z7uf7z9xSApKN9/XazXzcNNR2TJdBAnVRwxSSvOeCe4Ixv
	 Kw8biNbtM669Z8PUBINvTIQfjvrg8OB0Rt66m/LuHtts/y3bgjFJGe/jOxGT3bdYKn
	 zhlz21BLROs5dbqYZhJFenh1exhBtiTy7HSto4QTeZfPjBd6/kMjtB2md8dPgWHewH
	 D0Tqv0RxUpYsA==
Date: Fri, 13 Nov 2026 17:17:42 +0000
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
Subject: Re: [PATCH v2 1/8] dt-bindings: watchdog: loongson,ls1x-wdt: Add
 compatible for Loongson-7A
Message-ID: <20261113-draw-bartender-f01f6750dee5@spud>
References: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
 <20261113-mips-ls7a-wdt-v2-1-e8abd6b2f77c@oss.cipunited.com>
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
	protocol="application/pgp-signature"; boundary="PeZS1+qn4TN7wAH8"
Content-Disposition: inline
In-Reply-To: <20261113-mips-ls7a-wdt-v2-1-e8abd6b2f77c@oss.cipunited.com>

--PeZS1+qn4TN7wAH8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--PeZS1+qn4TN7wAH8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavdGNQAKCRB4tDGHoIJi
0kv+AQCgzLIjLH+PyDc9xEH5g2bhY0OI6XA44G7ZKyaMTSqGfwEAkpPWqQn7sVw0
jGPVu/JWODAnLZAs49fZbzLQwaVpAgo=
=XT2f
-----END PGP SIGNATURE-----

--PeZS1+qn4TN7wAH8--
