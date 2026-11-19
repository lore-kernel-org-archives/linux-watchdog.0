Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130234;
	b=bCePG/XkJtaHRn4Zf/SuSMxt28v86mY+XhMfycexFXZPvnAdS4tvmzqd2FMC+b7o7Z2X
	 YObyc52vwzUHL95pLDmgPigY2sWxVrgKTcHlP1qxyGK/UnVqGYQFJ5vbatOu7N32/NPaY
	 +QyKlePs5BLS1ukDKXFwQgZ8eyb/iOGKGlHN+Q9ZG5Bb88SwyKmEOYxwzqqgWFoD5Gc+y
	 OuBCMQR4adC+zB2q5qxHI+kF7O4LVVqJz7ZfOCm/Gv1ZulzqfiCTsa39ebWrqJxPP7HGV
	 9DEvAsi8+aYG5KObSXCp+KMOy15JTTtn0aaO6fsjKXKEWuTRzvh0wNSSwy1ukrkVLPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130234;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mIN+GuJ0CxxJX4/Fg/QOh4vbPOUP2Q53nLlfewKTqpg=;
	b=a+UeR5MBLAjhXPFSYe0xaa+Xy0kre3TJEw4Z2BjdmeVE9VOWcf48AFoeNPR+DU4Vc12L
	 j6N81VaJgyWcqmEYrgTUlwu/07OS9drcVeRf664Q2mYRaT8l/4aIL1Aik5PQkAmF/MhQj
	 Qfc7hV30Ukur3xZ40UUy/9MMk3jQ3GN8yBVuY8WCKzfSW+fqQM4fM0bzrGxGslZrsbHLr
	 G0Ms82kEgXZBiWip5p5Op3m27QWeqdqaYCJPf/Z6wb27sM9NAarm1KQtnRocLRzALdLRD
	 GTddeqatjyl2qmQNoRVBP1Z1A5ucVjsWzF3SJA821K9jebPBRoWmn4oFuLAHXs+GLYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIfBByFu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D1606A32A;
	Thu, 19 Nov 2026 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIfBByFu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D741F000C4;
	Thu, 19 Nov 2026 23:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795130233;
	bh=mIN+GuJ0CxxJX4/Fg/QOh4vbPOUP2Q53nLlfewKTqpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mIfBByFuXWlED77Mm3yjoekoO+LkGlK37Y+fsiY1HOhGXSlToyJHTGKwUkspI3SaK
	 MCqel5P+lXEaPECa3D6vyyQITVsY6sh/7hSL6hoZpF0VS3uNvjNb3Xo++8gtVV3q5s
	 vcgONmzPXPTklNMGGsK93cvH2n+GcWKCxMcIxZvIbIeG8zNHihPlooNpCgzPck0aZk
	 IvjantNbzS+MZyDotZrAYWLKiT3CQcjL+K9zLPCNxVgS5+JKITI2ZYqRcm2eALllsF
	 JXf/3NjTb9QeONkKHZi2xqEu4fD5zNdEqkyL92VJOof0bxNTrYFOXZgvwtnJyvoq7l
	 UlOE2h85DU5WA==
Date: Thu, 19 Nov 2026 17:17:11 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: linux-mediatek@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	Ben Grisdale <bengris32@protonmail.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: mediatek,mtk-wdt: fix mt6797
 compatible
Message-ID: <179513023005.1277256.7531724126207363611.robh@kernel.org>
References: <20261110-6797-wdt-v1-0-7f07755b6074@protonmail.com>
 <20261110-6797-wdt-v1-1-7f07755b6074@protonmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-6797-wdt-v1-1-7f07755b6074@protonmail.com>


On Tue, 10 Nov 2026 21:22:21 +0200, Roman Vivchar wrote:
> The TOPRGU reset bits on the mt6797 SoC do not match that of mt6589,
> therefore they are not compatible [1].
> 
> Deprecate the mt6589 fallback for mt6797 and add its own compatible
> string. Also add a new binding header for the actual watchdog resets on
> the SoC.
> 
> Link: https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Register_Table_Part_1.pdf [1]
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../bindings/watchdog/mediatek,mtk-wdt.yaml        |  6 +++++-
>  include/dt-bindings/reset/mediatek,mt6797-wdt.h    | 25 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

