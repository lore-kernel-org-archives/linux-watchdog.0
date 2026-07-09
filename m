Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC764D990F;
	Thu,  9 Jul 2026 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619529; cv=none; b=b4OdsF9tN6EwmL04O5aURciDY5YUxut3M3rivhoRuk4lnGMyHYKjCq4PL4FLhbW4MaqwK9B9zFVNrRa7b5O2+/Ca8zQ7Tmn0zr3PD1QpOrVnKNpiOyk5/PG0vxCEd4tSvtRJ8l6cX4LlzkKKG+FSy/WrJYX03x9yp+tsBw7o4wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619529; c=relaxed/simple;
	bh=jSRVr3mVG/WM0RkLJ0D4COM5LH48es0m1ygffKe3q7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is1QMJzkVvaDgfXBahn6Y8g9+MoSY/SflT+Zi1wFAmx+pLf+iS28njO+waJjF39VWqB7Xgyq40XjWUGMYABCZMtMomY3CHJCEZZS02lINfd5AEMwdblp1PGxaQxGVzCPiIp74SJjAAuaNaHG6J8PLDnKTkBVvEyK3OAjIcr6zWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmHlLTcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmHlLTcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7471F000E9;
	Thu,  9 Jul 2026 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619528;
	bh=jSRVr3mVG/WM0RkLJ0D4COM5LH48es0m1ygffKe3q7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QmHlLTcdIYCm4zymeV+4lTtyXtLw6hgqvwvg6E5nqGWT4GyaWxXFhmLP5tYF5HZMs
	 ySyeJMp7LZhcf2NvvfHo8nau766SLQbpmv51cFkRmKX+0RgvSWiNdnKoS/BQTf9hLs
	 q25k664cffdvpwkAuonjQAVpYR77Or8TQSijuQbNXhLqHL6OtmJwrsd8/HkTiJtOCq
	 wzUx0tmV4UmUAtoQogzMg8FHKPBxLl8XbeYFGoDa3FaIQqVYL8/8Hnzp+ExYTctVWe
	 CbcAWBV2aBKZ1ojcxxOLrSzJQdVFW/n3TUI3ygn+a6EUf1TJEPW316Odq7n1n0rwvx
	 2OfMDnskLm1Og==
Date: Thu, 9 Jul 2026 18:52:02 +0100
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
Subject: Re: [PATCH 08/11] dt-bindings: i2c: apple,i2c: Add t6030 and t6031
 compatibles
Message-ID: <20260709-glamorous-fountain-c9a711c49c3a@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-8-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O4aR/EdwQxnboHwQ"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-8-55b305833123@jannau.net>

--O4aR/EdwQxnboHwQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--O4aR/EdwQxnboHwQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/fwgAKCRB4tDGHoIJi
0h4UAQDLZXrukjav+6e3/g/tTqQ1hoeVsM/ob/yl7Xknlxcg3wEAmHoelEAw5qmY
ustM/l0fikKADMksxJYFJRjkEdK4sAU=
=og7Q
-----END PGP SIGNATURE-----

--O4aR/EdwQxnboHwQ--
