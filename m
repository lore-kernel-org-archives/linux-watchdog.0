Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194345;
	b=41OcN64eRPYM/eizNLfjcBA3fjqa2PAcKvhORc2UCEd2HVZk21gFMpNowOuzBWrj1jh0
	 54Jl3UiwmDeTNuRDESyWhF5LKufMhbYGjMXCU+Opf8NryzH3UYLs6u07nLowUtWkh6oqX
	 Oa2vZbuudgIDcO2L28/Bj65L4zl4oYLCsZB7NzPVQFSIz9xKhnfTQOV5SBMLzTpfkwr71
	 Dpdj20hNJegwLzV8iSqeuUFi1n2IEepp7t4WuwsS62xuWNU1ABna1gLi7jkDiFEJ5Sv8o
	 Ohc0Noux5aM3cMsYpdYkymgT6liS3iHsOYtXaSK8ETJFFcTRljZQ95+OYdpkDky2jqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194345;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mgaExbvnghCg31gnn54x4d+C6t6alfhG7i2H1RjCe5A=;
	b=5D2swOJEty9tviZF/4nAsjIhHlxiImJ2PiZ3B3dC1BkWbxKrqwZR6oJO27rjdvFHyKEr
	 zlt2haW6L6ToMfRRf++lpT2ujiUjyqINHmNLTlOrGwHEfOeouaBen5EqhxwRODPhq3eub
	 jhajYN75a+IwBhKS9VXq/lMhr2r/cnPQAEZ8+p0WUxt56gskAfWdKbleQtryuMmzeFbtT
	 l4DRiwXKMveNZoyajdZc/CtShkAb+s1m0Mq+Mog0WetY/k/LhpaJLiSr5NH09K++a5bR6
	 huBadaHOn7+BQM8W+fZeveACSWUob9dJdn3ojUg4vud3Z1h+8lezMGgY6yfN/fsas5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOWvRrde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25124606A31D;
	Wed, 28 Oct 2026 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOWvRrde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CA51F01825;
	Wed, 28 Oct 2026 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194344;
	bh=mgaExbvnghCg31gnn54x4d+C6t6alfhG7i2H1RjCe5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bOWvRrdeUnHYioSZaC5f8If9tjlM+7mCemmNsVYNzXBDL81TIpncPRCB29Evee1i8
	 Ue1F+3otI1pxWLCjOvNwJ5MOH9KQ4JseVfWkue+Y1/EGGv1+Mj4MqHDMZIcHvv3atH
	 66f0/dMj95GeP+xU2+OWhNnZbgWRo5VuoD5pDmQqLm8ncAc+VeEIjl1JMCe0hAAzuE
	 tjROXmaSqoGiYkVP9dPvNc6QlmKXtP0pIrUteMqqlYumfWjSqvBdG/eVky1WWO2QKP
	 1dQOw9OWfaKwDWoxQJ+kMw6tTTcnsgD4a7K/SsQksCvc7nLEdsbCzgmB4dBxGfjzBZ
	 GU1AN1lunQ1BQ==
Date: Wed, 28 Oct 2026 14:32:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>, 
	Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: arm: cpus: Add Apple M5 CPU core
 compatibles
Message-ID: <20261028-stylish-thick-numbat-f4f8fc@quoll>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-3-1356181bc50d@cyberchaos.dev>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-3-1356181bc50d@cyberchaos.dev>

On Tue, Oct 27, 2026 at 09:03:23AM +0100, Yureka Lilian wrote:
> Add "apple,hidra-e" and "apple,hidra-p" compatibles for the M5
> efficiency and performance CPU cores respectively.
> The compatible strings are chosen based on SoC codename ("Hidra") plus
> core type (E-Core / P-Core).
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

