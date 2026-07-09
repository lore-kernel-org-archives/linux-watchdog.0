Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AC49690C;
	Thu,  9 Jul 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619267; cv=none; b=S29Rj+P8KOcOOsHGi1T2jlrrjhRabgAPqAKoTSKgN0lACHVh8ACRyc844ap2HhLQ5/+ESEGut56utOSXykPDTvHxIv3bqVibW+aXuXXe9kRqGpgcCqO00QQo0C/2LOXIv57YL7pykEGVHa+/R8ue4IfBSB54YDSjjVqX5F1ymIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619267; c=relaxed/simple;
	bh=V+A9BMRv9yHaVLHQkjFgdnp+jwn6wvcmIrFf0EkusFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrxFbWb7ReMXWDq4Ugl63eMIg2A6FzRGtLtLdP+S7Tu4NnpjagmYlzleVpoX2vw+U+Vrv3/7Ve2Je5xHchiN8qBS5CfPNkWItw0j+n2DyYefqPP9Os4lDql5eYLKf4kUMK+DZO/swUKupOOuBMVxzfV6fuvw7UgbpSKoNnoJOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJg2f5PA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJg2f5PA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1741F00A3A;
	Thu,  9 Jul 2026 17:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619266;
	bh=V+A9BMRv9yHaVLHQkjFgdnp+jwn6wvcmIrFf0EkusFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jJg2f5PA4HOWOSqPDmrQ6bzLA87RyF4lQvMnzYhNoLH2WGh9A6XR/AiOGtCj7qbU3
	 axg/3h20acUYf7cYdMtVX/swHgwT3zhD4k/wJfPXG0HZBA5T6xk45nRV1lmswKYjC9
	 1MoRed5+bWdPy5TiYJ9Iko6P8IX3/Gh9VK7VSF9K0ajeq9NnEd0HXoHGmL9L5SDAsf
	 UqPsaPEJ8srMoSsBOFQ06BOrxtzeneQEgcl7N4XIQXT+PfJilp2rQ5Um/1CqTp/qKo
	 DbENCi6KGtFYJ7q99hdkI4uCq6V3j5+Mb8k8Ph6w63lwmWn3nBjK+o0lkX1mLGWa5S
	 sTJQTfQeHloQw==
Date: Thu, 9 Jul 2026 18:47:40 +0100
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
Subject: Re: [PATCH 01/11] dt-bindings: arm: apple: Add M3 Pro/Max/Ultra
 devices (T603x)
Message-ID: <20260709-impeding-tingling-c5858eb0191d@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-1-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bxu5bU12IrhANRf8"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-1-55b305833123@jannau.net>

--Bxu5bU12IrhANRf8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Bxu5bU12IrhANRf8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/euwAKCRB4tDGHoIJi
0oaMAQDp6Y7KdZuOmjlVBWtA3Gpr3+7rjZ7sL4v4P+s/DitrvgEAqeppjCBkR3AA
0/ciCC4d5WbZN5gzHADvGfZ9RrIh2wI=
=GNtW
-----END PGP SIGNATURE-----

--Bxu5bU12IrhANRf8--
