Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9BD4195D0;
	Thu,  9 Jul 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619456; cv=none; b=iju0KBtTEP9kmjuwm6ZBv/sPHzpm1P1q+s5CfakfFR1kpGfoMGrvjWjw+YUSM7+CjIGTnmPqeDnFPfZFGpzmyzHtCxhFNWQB7sX5fLEaWRNo0/B+BeDODEUOId6YKWNBxFmT/P2PgZaXN7YHfKFfqZXmFvMHiE4uS+XoPVw5WnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619456; c=relaxed/simple;
	bh=XqYlCGQkHEH3g3g+Yv+VRcbCkPcS5wAw8lfoSbkViQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4Y3tfTVR/BOrOZWqT4cTYbzUvSl0IJhjfQ0GF7wRKMYNxpm5Qy+D5fgJoS1JP84uu/zeXPIwRBdIwDi1wAW0pBg8aKU5Dc1Z5K0bANVBFpw/Go5VFP0tOG7CuaxnBmLvF/UPLKhZKr5qgqnhwyiv+jc6uCXH3w7WqRXj5Onkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9UXRzOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9UXRzOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D091F000E9;
	Thu,  9 Jul 2026 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619455;
	bh=XqYlCGQkHEH3g3g+Yv+VRcbCkPcS5wAw8lfoSbkViQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D9UXRzOOuSKjLeYFVxX2GeI5ylc2TsiTyOXPRBgJXJuv8A9Tbwzisch6coRAUfJ8W
	 kRfP5MDyLjJuQ3az4i4UIeE/Id/UB8ND121AVROQhj+xAHZHavrL9BW+JcZHFtBf61
	 k4ypfR/a83/57WQu6BDt0zYOX37eWRD5pKd6lpzMqz+WtiUigvfpvlt0UeTZqJaJPT
	 RxRU2x3dfGtqdhUSP5EGpjNHz+dCme8gXJWu9XsBeNY3QQzg8AE/2vWmr9rEFAVDhU
	 ST8VbkydH5lPe9Iz4cBhpqrICh5Ut9SyA/HgTr++BQvBCbJhEaL7MzGDI3hNW+Kox+
	 uJdaZQDqW92dA==
Date: Thu, 9 Jul 2026 18:50:49 +0100
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
Subject: Re: [PATCH 04/11] dt-bindings: arm: apple: apple,pmgr: Add t6030 and
 t6031 compatibles
Message-ID: <20260709-shorthand-omission-b374f81f9795@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-4-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6gwO7udBqS0Uu2zF"
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-4-55b305833123@jannau.net>

--6gwO7udBqS0Uu2zF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--6gwO7udBqS0Uu2zF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/feQAKCRB4tDGHoIJi
0kyrAQDRJDX99fZIQTLV7Jo768Tdt9D6PgOT+gurSEO5Mve4KgD/SM0QvuuFDN5d
zgQdXXFDO3auhZDAfIUpYd8oSpOB3wQ=
=hiSY
-----END PGP SIGNATURE-----

--6gwO7udBqS0Uu2zF--
