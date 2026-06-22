Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9839B495;
	Mon, 22 Jun 2026 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119941; cv=none; b=UaeH4KmJQ5V1z2vV7bkJDHDZcjPDLVmLwWFmv27M0T2PLxA2xg0q0i0onC0IX2fwBJTiM5F3IZOarkVBjhIDegDok+VXBszrUmLUYdBAihanR0Y06TryFbTdGi3Yev0WQRQ6gBwsGXLuL5rL4CcKzRpnOImviGoxGSZNwVExf5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119941; c=relaxed/simple;
	bh=rNXWhIqCnCiuZjgJcEM9gRULbQI8ONKE9bL7itt2wxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPofWFICHngTC6I7rWZmKRp63Gj6SxHH1YIRKA+kTn8IaDjmzmw3ZlyDd06z53VN/xr545SGhV4xV7QxQz0fWztkpa45l5/Sf36+z1FQVVvJgHFCps/MzGoqjFw9In42d9cRtxE3mrlJmHfa2b8V7mCY6wJokK01a/vvq2Tzc9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEkQ9Xtm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEkQ9Xtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B789B1F000E9;
	Mon, 22 Jun 2026 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782119937;
	bh=rNXWhIqCnCiuZjgJcEM9gRULbQI8ONKE9bL7itt2wxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LEkQ9XtmIrZkFEhkooQbXgFQHG77Bd28aPmHUdYP5v2g93YlcLZxCQ2vX3rE+JXxB
	 ntQuYtwCXa9ZLKEX5W7dqzMS2dYd3zAkOHcWQq2cjbibjSw2BuwNsnhrJ96pfG8/da
	 /wM19OEfkOlPNCqm49mh0XV5/7e6MNE6SC43y6cPNqT6n+NDEB8LMTXxtSzB1FhCIA
	 7x4hQ8EtRWM8vFQpvVZlN0MS5TeqcxZ8moesBkezQEfKe6gnLp6Vw/1LlFeyYCBHon
	 xe1+Hk19xFNbMcBRriFpD9vSyaiQOSz/cpvV7QrNmBKd2xZNGBfW4Ly4Q8RfyMlis+
	 1K4mhSYXuW4gA==
Date: Mon, 22 Jun 2026 10:18:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-sound@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mfd: db8500-prcmu: Fold dbx500 header into db8500
Message-ID: <6a1c6e6f-b2a4-4953-878c-2f2f3744d320@sirena.org.uk>
References: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F21+nkoAYpsrTplW"
Content-Disposition: inline
In-Reply-To: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
X-Cookie: Now I am depressed ...


--F21+nkoAYpsrTplW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 19, 2026 at 10:27:10PM +0200, Linus Walleij wrote:
> Move the DBx500 PRCMU definitions into the DB8500 PRCMU
> header and delete the wrapper header.

Acked-by: Mark Brown <broonie@kernel.org>

--F21+nkoAYpsrTplW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo4/fkACgkQJNaLcl1U
h9BceAf+JnRRZo3CC7dY7ixwk7zpLhaOOcYrfPWC7UPLCHezOGDW4mYKWhJCKed4
opIBNonasXPS4Q3MuElsJo8eLwxS5HhDkmVX7k0CoEoPdeTGkbqih/6ZLU0vk0e/
PTbTPGGJFQj6ewMSK6TZMnor3CNuqVSYDhYD++Wtkpy2Bc+HM46Pj2xGADsWkAk5
rJTCldPiov2ztl7LN5YsUax/+xulcuqnxvw1yXrS1AExqFqnkLX3AEFdC1p3ycoh
Lbwo5s6c+lChx+Owkt5DeYeDJ9CQ3qrmiZRZUtHKLb1yd120zbWEXa7CXk5mk8e1
EGKSYIKOunlL6yCr6AOb+fsg9njECA==
=27Qz
-----END PGP SIGNATURE-----

--F21+nkoAYpsrTplW--
