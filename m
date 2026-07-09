Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CD4195A1;
	Thu,  9 Jul 2026 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619473; cv=none; b=X8SuQE9YIzP8WZzd3r5nJZTM2lZnfnmvifSWW2V0HvFwziP0DrA0JkPouX/+r0H2ZynHlaEJpu+zmQ9pYaPYCq8LFlumpZ61hXqBmyQGJ0BbrLYXq5cAD9FrOLaJqS8k9ds9B/z+QJnXXPJ89EYqhtANpwz40Rib5Mm4Y0eU170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619473; c=relaxed/simple;
	bh=IiYDP/Yr6tDyICcpBbS+CcUbgi9+awvr2U2UZfqYxH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMu3+dJXe9M9esAg336tsk1WGZnaN8E/6nvVMagjDe2pQwAHW6mM1ey8YOKFaaESyQFEvM4hrzKpxmqXVGLvNCTB1NBqKnvh7yEfOhIFP1Y7b5/PLbu64T6GnD4SKB2GsoI2Fy7J8u/Z7g71Rk0z4D676bipuTT2y4Okcs6hRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLB6FESS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLB6FESS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282001F000E9;
	Thu,  9 Jul 2026 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619472;
	bh=IiYDP/Yr6tDyICcpBbS+CcUbgi9+awvr2U2UZfqYxH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DLB6FESSA1rkHpOnbGOx3alYN6+UGaNFml6aKIm+F78m85Jf1z3XznAERRuPTIpOS
	 KmWCHLG7TUV2WZjHJG8hguNn8th/vh9Ra96QCCqZi/glbKAS/L/7HFy8/Gq6bn2cQz
	 6Nz8X+eEtsL2vxwKP9CxG4nsWWVB2osJ5RScksZTCQJhNJGYcQCp8ije06hTffIBP4
	 7y1sE1bEaxCgEQ/Bp+FF9WEmG0KNz6tO3rJ/K7o0N6EQHjBIGcmk2rWmgMLBgHjyWO
	 0W30p+KuUKVSOh/vuOmLvOwmNAizSUVe8BdfH7pMSdpvQPSWOZq/PMXw28zDODtLFS
	 anhZf4OVb78MA==
Date: Thu, 9 Jul 2026 18:51:06 +0100
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
Subject: Re: [PATCH 05/11] dt-bindings: power: apple,pmgr-pwrstate: Add t6030
 and t6031 compatibles
Message-ID: <20260709-uncross-frame-f4e1ee999cfd@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-5-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rc4vPyNuP2jKmDXT"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-5-55b305833123@jannau.net>

--rc4vPyNuP2jKmDXT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--rc4vPyNuP2jKmDXT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/figAKCRB4tDGHoIJi
0m3OAQDzIzOeSCHYVfxck/T7kMRYB4bIgW4uZxglmR4yesQBjgEAx1p4AOxloY8c
e7UgRCo5xhBddY6h7uja/dDb6wjmQAw=
=q2ig
-----END PGP SIGNATURE-----

--rc4vPyNuP2jKmDXT--
