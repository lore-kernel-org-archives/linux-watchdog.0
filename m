Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234974DA539;
	Thu,  9 Jul 2026 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619488; cv=none; b=d/4+gVyx6Rg6EYEvQHmPkxCBv0iFzW4oeo1A3LO94UEpIONeY3Avn2vFS4J1txyDk0FGx08yvfExLG5BnYOY2awAQ4ti/2CirXOjf9TEAEOVMzFJZF+mqUxgh9+vssyfyh604WJVVyXDnHXr096z+SM52C4wKHP5MioqByjQDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619488; c=relaxed/simple;
	bh=li3QA5jhePh5FJCxsTGQ3mc/L/J+Cb7RuE1tD5BgUSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCmgbFvXximN/yGy/IjUjC+lNv8Lq8aIBI6kuRjmWmZQRPNiMqcFrQpBKZwsZbp5FppPDTXQzsNScSibj82XRU+IKY+1suuf85fEJN2oVMUO/GxnPvyq4kXCPfingpPu7wJl92te2cdTxUbL/h7P5n7oilOkcw15klMjE5ugMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYZLgxCo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYZLgxCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C591F00A3F;
	Thu,  9 Jul 2026 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619487;
	bh=li3QA5jhePh5FJCxsTGQ3mc/L/J+Cb7RuE1tD5BgUSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kYZLgxCo8ArpgvaVdVnstF1nHe1zJCI0CXN/jhl95TUoHlnLT5PPYpNrDy70SsLOf
	 M0iE5R4tMTDHgdxD/HeOxhM9/ZnhgIH0WRG3m8IyQOEaUFKB1WmzPTBAL4ET2nlQb8
	 X4nbb/lX8ALo0T42hyoGjTONe+vMnd1ODGXFkuwTDGATWyKo6/E2usOq5CNznwicuM
	 3wogAkwrJMBFzJ8VrdDoCLtpkHNMWOILfDHHprnsPqElmmQUjfLPKB6cen+s6Cx5Po
	 1zBrTLoH+09oUQvZKD7ur+JhoZURcq/HMg2mLXxkGmrY5B1+UV4SJdfDnQ29pY1BBV
	 UpXDf7S6wINxA==
Date: Thu, 9 Jul 2026 18:51:21 +0100
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
Subject: Re: [PATCH 06/11] dt-bindings: watchdog: apple,wdt: Add t6030 and
 t6031 compatibles
Message-ID: <20260709-food-marry-ffaa9d371d44@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-6-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZLhkp4lHQ2mZG5Ob"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-6-55b305833123@jannau.net>

--ZLhkp4lHQ2mZG5Ob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ZLhkp4lHQ2mZG5Ob
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/fmQAKCRB4tDGHoIJi
0m3zAQDv3jl6UL9b1Ac5LSnukLJWGHoT9ZgCYKH6bKOFw+YEuQEA0fQcrc0ZAUEt
9DluIdhfKw+qVQyFlfQFkY8iCPHESgI=
=3wLF
-----END PGP SIGNATURE-----

--ZLhkp4lHQ2mZG5Ob--
