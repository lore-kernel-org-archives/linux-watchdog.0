Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986840;
	b=Jpa9BukgLwZ17SmSK94eGffYqpBHKSTLkDTO+87upXUZA35sLvnkclImNH7sZXHA5BUz
	 DSkXltaIuo+K60rfsMYJROOvCPe0ia+lLxkxguB0PqGLxUNMqicjWZFtAag0yA32gaXqC
	 tE/4UOdhxeLQIWi5moI2l/o8gjencdLf0cheBjxVQqS2fcrnF3O272dOdxdqGP8oZzYlN
	 TJdODuv5LmLQyTG3Vmy3VROPno1i9P3Tlvug5LHY1QcLQcTQce9Ue8OK9L3J2l73Eg2+N
	 OE04BJwKQ5kwx7v2VvzLyzHSVSRDUpoyQ0tgXWdZHh+XO5IwoNK3aeK+LsMkMpK67eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ItAKBk/a6HZLA+n/bMMub1+ytthQppN9B9c92bnvYeU=;
	b=X53RBFDLcE114H3ks8190MgTewox4D14Vjo43IY1XqyD9REVUajuBMiWvHNqVMfTVsaI
	 BXenyNoq2mu/9afF634kVsvchtUEYXgrygcXHcGzcmHovb9SZUhaf+2ZXkHB6gID5SN60
	 pp+cl9LahtjDrDw+DiBMRe7i2NMAMf57AlcNsHWFhUFR6KVkKmxkknD4pzy0I9QiyErp2
	 oil2d8kcbMjPQh6S4y6U19KoLShLUZErQ73bAPvgk4K8rYkanPmzMlfD9gDn+YHDMa6F4
	 jyRQXnLKDtIdw92duM7yK4cgUTuHL4wN+UZqUsVceUzrbs8OTQ5wR+b8pNRmhGWmGdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2LuHxPN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27917606A326;
	Fri,  6 Nov 2026 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2LuHxPN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422861F0089F;
	Fri,  6 Nov 2026 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986839;
	bh=ItAKBk/a6HZLA+n/bMMub1+ytthQppN9B9c92bnvYeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B2LuHxPNeiH/42/5p2bVdvdN4g8Xf0QnWJODS2LViTKuagTwOMmpvzJOwgazsygu1
	 gQVFuPJi37wvoVjfoIYoElwU4/Eo9X7uAlsVgul/QBNsglcY4XYuyedNvQjmqNbV9X
	 sIPygIA57yJJY/9b3ORKTkTPbqSSdMkOWU4JObRFCAlJzUHRWnIkbolUhiA2BZgPgV
	 awBODHnuxAOiUaMe0sh2jmHP6sYPMslQK33XJm0jE7GrabLcatnxL7/ZoXuO44UFhq
	 gj3w7UXVra4fcuISF7wzPAq6Zdb3OJ8WvXoSF8jVHEHAdjXTu9iAm21SNbuM3dwony
	 waVpJu0pnvh+w==
Date: Fri, 6 Nov 2026 17:40:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexander Letuchiy <asalde.le1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6895
Message-ID: <20261106-headlamp-trekker-f522f951e18d@spud>
References: <20261105210622.523747-1-asalde.le1@gmail.com>
 <20261105210622.523747-4-asalde.le1@gmail.com>
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
	protocol="application/pgp-signature"; boundary="4YGTUr4yo0rugW2E"
Content-Disposition: inline
In-Reply-To: <20261105210622.523747-4-asalde.le1@gmail.com>

--4YGTUr4yo0rugW2E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--4YGTUr4yo0rugW2E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4REwAKCRB4tDGHoIJi
0iRGAP9bW6Ptz/epY1NELu2GY325xNrBXBp/aRVP70BOQXB2HAEAoee+mfPvFvfe
upnlk0d4fbPXgPYBCxrJauWqlU1Y/Q4=
=DIWD
-----END PGP SIGNATURE-----

--4YGTUr4yo0rugW2E--
