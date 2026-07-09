Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99C4195D0;
	Thu,  9 Jul 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619418; cv=none; b=NtdhRZLZeOVlLcwKgMyGk1JxFiNhP3DXFD9KJl6VcSPxwMG9Zob59bWxBUEkb+hZJqPzND4NFStqEoXeDpR3ayZX6p+jhAYqq09KjrHJmAFHraMgqV7Se1nU6QjacG35sOY+h/hETJCnbkVnvBupachkvao99f+yfoyHTW9m7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619418; c=relaxed/simple;
	bh=fMzGtFG8sajsnLHWl1lHh8gsBbPiUDwZ61eEP13vpu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJHVJYRd1H4zXshUev6qfem2QAVQatldM5L1EqFBRacd3XWh8731jZsXXWi7xWT+e2mhh46BCVJI+SO09Im0kMIBix3tEqJ/FSHF/UFX4EZOc5nTjBoxb6NOOmf7U1AMhj+apdL3xZ8Ejbf7bwYhNoPALe/TJix4vZoazUNgFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB+wtT9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB+wtT9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF22A1F000E9;
	Thu,  9 Jul 2026 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619417;
	bh=fMzGtFG8sajsnLHWl1lHh8gsBbPiUDwZ61eEP13vpu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NB+wtT9JQ0SHManTBvYWYMb9t79Eo6NCEtla19MxdwR9FHjw+RetxZzOZxRpU5jqt
	 cueoK1QrH9M9tA1LsFAUMEQEzdce0COUZ2gXu5H9o+sYYD5HYWLo93QHDjKVL6TYxO
	 7STj84HaJdGsMUst61aNBpj8Hb8MnfNNhvuPEYbi8hwi8fdCwT9ME5GKHcQ7yAM8uX
	 dV50Iav5nkV4mLISbxojRk1CHxIyHf4YHj5OuZNUrsRV4KJMcB47O0qN3/bqeTyRa1
	 sBkzBQueNdypLRdkz5ysKziu0db8aFRCkQ/71YFPjxlU0lqviJGL4KweSee1aPRX0S
	 5VRsh7Bev2eSQ==
Date: Thu, 9 Jul 2026 18:50:11 +0100
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
Message-ID: <20260709-unflawed-humorist-918325879ab6@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-1-55b305833123@jannau.net>
 <20260709-impeding-tingling-c5858eb0191d@spud>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VXR0uJe6BRvVu9jb"
Content-Disposition: inline
In-Reply-To: <20260709-impeding-tingling-c5858eb0191d@spud>

--VXR0uJe6BRvVu9jb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2026 at 06:47:40PM +0100, Conor Dooley wrote:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable


Actually, sashiko complaint looks valid here?

--VXR0uJe6BRvVu9jb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/fUwAKCRB4tDGHoIJi
0h6jAQCRkdoCjcZVRfdOhVVCPGjDz9q56/rC1wfgPdgTHwlLcgD9Fp64DGtobS1L
8mZoKmKNHw0fTD2YNcrtlBHM/Ag4wQ4=
=rCUn
-----END PGP SIGNATURE-----

--VXR0uJe6BRvVu9jb--
