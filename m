Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F33F20FD
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Mar 2026 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179990; cv=none; b=bYPSqSdKtyMwbXbaJ0qdH1vglyuKPYHgyWxDk9EUAwzo7ZXTOWRUGdsgFMAkQEzYVnyKqoRommHcuDKvtob/kumksozbokkQ2Bn9uAdDX/klQzUT40/Vog+O/SzMqnhV5qOmZjd1J7tZtWLUaf46DmxlochjPhli3/Q7HxB71AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179990; c=relaxed/simple;
	bh=/YeGWB9oc7O8AA1akAsfiN+5RGMmexVob0+4KmRyzxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpSvgPpevVfDu3LONkhab+vmCgnVtjaj2RtRCqcEg4Tjcckdax9/64F1LbOQfw1qoDi6XmkiUzCYICwgf5VOEZDEgUEZZXCnpGbEknAy6Vnzp0UKQN5x1ENslavhpFgXq4PUsuk1dHUdccLlin86mZvSKAiFKyQbSz9GLElpJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mQjQs8H0; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mQjQs8H0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=6O0p
	tGpA6us9oqpqFz8mGRim2bmGuDcoP2CRwTmZzpE=; b=mQjQs8H0tX7w5SncIAki
	dNw7X9PlmsNIBtTcqyqI3nWQClN/XQfB3vYCx/Y+skFChTqYZ/7cpgbgz1GHu/RR
	tUIDIruXFrcjRW7EJwrOUlSRDZalRo2hersel96Y6AZNrcpQ0HOgqU16q2+e3Npw
	rssryH919aWgXoOtQHpNCWqN9Qx0Bn2oToolE/7+w1Za+F8qj6DSS8oszoPowoKf
	3L3AgDpXSkkOFL0z9pZLhOo5eYxe5NaSvoPiAQDAfQ3xpVPar4jLJTI6T+b+rsbQ
	+uWTc38hSDpltF4oAkudG1bp75EqOeaAYojXIMiJGwNvi2ubno/lkMJ9rwJgdu0q
	hw==
Received: (qmail 3383014 invoked from network); 10 Mar 2026 22:53:03 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Mar 2026 22:53:03 +0100
X-UD-Smtp-Session: l3s3148p1@a2Qri7JMJu4ujntP
Date: Tue, 10 Mar 2026 22:53:01 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/5] watchdog: rzn1: Add support for direct hardware reset
Message-ID: <abCSvdToaQG20uWT@shikoro>
References: <20260310173249.161354-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slnxGfaK/KqUypIu"
Content-Disposition: inline
In-Reply-To: <20260310173249.161354-1-herve.codina@bootlin.com>


--slnxGfaK/KqUypIu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Herve,

> On timeout, the watchdog also asserts its dedicated reset line. This
> reset line is connected to the reset controller (part of sysctrl) and,
> if this line is enabled as a possible reset source at the reset
> controller level, it initiates a system reset.

Okay, this seems similar to R-Car SoCs, so multiple things to add from
my side:

* I agree with Krzysztof that the renesas-vendor-binding is not the way
  to go. The information could be either deduced from the register range
  or you could have a link to the syscon describing somehow which reset
  to allow.

But:

* On R-Car, we require the firmware to correctly setup which resets are
  allowed. Only in cases of broken firmware, we override it in the
  system controller driver. The latter could probably be argued here.
  The firmware is old and will probably be not updated anymore.

* If the watchdog driver kind of unconditionally allows its own reset,
  we could keep it very simple and just unconditionally allow watchdog
  resets when probing the sysctrl driver?

* If you don't like this, you could also parse the DT for enabled
  watchdogs when probing the sysctrl driver and act upon findings?

Happy hacking,

   Wolfram


--slnxGfaK/KqUypIu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmwkroACgkQFA3kzBSg
KbbmLg/+OeUZerBrTF1ZxtcrfFFw8YZX5GHblMhKK9GGpfWCnCgk0Py+8Yzfz3hn
F6rQ81eD2T3X7+4MVWw+fXP/c0MhFdXS61cqAW7gqCpqrwk8k11pvMJisJFUV71W
8zyVR8iOGxQX9D6ngf8loTjewE/9zPOqz06XzynDm6zcg/e6kiUW5ApFEH0RgF34
BiM6DOYADem/e0E3s0/Ger77sNxC8vdp+8l7DqytBX1+ovuhbuEHBD0Ll8f2Ll/F
LHvok84w4k6cIEv25a817tnmLePXQxzMW+yVRyrI/49ya/1DQRci9ez2U+vpZZh9
TJb+GgKCjqpE1kjq+ku+T2B2KlhsN/T2HWH8zCNoLHTlG32ZoWezPtkmqCPnILNb
665I9MpYjMeQemqvRxyROm1kQe5whoqMO8pqxZf4Ae7ju1449TyGBYZPU/ik/t68
K3vRpK9HN78VehOx+yVbKHCL2LZz7tIr0BP2eN7aR+qNBvw3RGt3xTcbiaCpMlag
vJrAta1CAi7+h/S1w3odiSX4m/WR2pKQ9rmlPuT1/KRv8L/OzgNs8B6rauAgB4Fu
oQVxdR2YZ4rAU6N7qrQVamh/tHnVDqU7gSD6XI5CJcHpGvojHWtK3lp7XtI21iA2
YwFEWezHmGeGzctie8G1b58JPj9HnMs8u0TUi5nr3SPU2ukGpAE=
=YPCo
-----END PGP SIGNATURE-----

--slnxGfaK/KqUypIu--
