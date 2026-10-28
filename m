Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194385;
	b=MfLFCBY9dOwloAehsUW5CNZVW2tF5rgRKsrGcBlC61huBqf3zkngisgVn23lBjKVuCQ0
	 XOUHLvyH1vCdWqtpVBQtqXbhwBh1p2AIxXKLZp2yLm5ht22dxEliigkmTQXfBGIuDWcJJ
	 auIsjvW5YrC1rVWBLo1K32QldR11+Mp1ecPyHd59KXY7lCiIv5b5CCXM7y7ZS7pUZe1lY
	 4aQsAzHW0YAATFdw28V08Eh8KT1pE+OtElOXbM8A6yFiCq92bii+kvwKvkvQbHO31Kju2
	 BLK0z8Cmg2e56vWHYp9pzoIlC4gn1wqzzFqcgIGuQS56oyOcEmEDuq5hYX8+r2TxVog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194385;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vJiYJ2IsilIwmVzS1k6YMZ9rFUOVDWV3fT63vEQKSD4=;
	b=kJlPW5Q76Y84HDhzLcsw90SZFNodFC585NjzdNvDryVuUfLz0d8chzbqYwUZ8lgal1oL
	 kv1/zWaoMxxgbDxt4eF2fWfYvay7Gh1MqlMxIps9QAIHvFoQxJgE3bazJ9eYwktfxbhhc
	 YpsDsWa+PAfnU+GnHRhXnn+/japXE90wEY0DybRTYLVMMwTRwCcDz66BeOmcX9E6VAYk1
	 rLL8qsicTkPnPLDiSk3tOLAGGwsKj6XOtcRBa4XOwMfGq3mLtQUnYbMAaQ+djn3baBwcG
	 wWCj1xaJGfnxl890zT9v/qQppXrSDaU5GChomthAcLIR4jzOeGRfS5Y8W2c2i27lE3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsvG9Jr1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADA606A31A;
	Wed, 28 Oct 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsvG9Jr1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237661F01825;
	Wed, 28 Oct 2026 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194384;
	bh=vJiYJ2IsilIwmVzS1k6YMZ9rFUOVDWV3fT63vEQKSD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hsvG9Jr1y9pHMKOD1l+/76s8H2Lw4G48Da4qm361dB66ivZWYZ3PKRbNiqaMLXHcw
	 dmn8HBB/hRwkU3PXOD4h9SIMrCUgVQ/1T/K9dnEWKGHwnoIGS94/WAROZoRlylkk1q
	 RAH8vpd5yWhGtjqV60OyGF0rrVzH6uDHe8xPmAlzU5hPnC2B1Fii3owMiFi5z1wKx/
	 0YMIP/RvCebPbowQKvhgVWur5NnxdodCUoIxU22cB6JCsfy2EPKnCkH/HFo2NTU3Jv
	 iklkvckaSA5y6hbv1oALOTl3AODT7YZWT/wNB9wp+XAkyHXkmar5V0PGMSMDhcIJxl
	 hkQf6jFVXPkKw==
Date: Wed, 28 Oct 2026 14:33:01 +0100
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
Subject: Re: [PATCH 07/10] dt-bindings: pinctrl: apple,pinctrl: Add t8142
 compatible
Message-ID: <20261028-quizzical-proficient-stallion-ddeb59@quoll>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-7-1356181bc50d@cyberchaos.dev>
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
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-7-1356181bc50d@cyberchaos.dev>

On Tue, Oct 27, 2026 at 09:03:27AM +0100, Yureka Lilian wrote:
> The pin controller on the Apple Silicon T8142 (M5) SoCs is compatible
> with t8140. Add "apple,t8142-pinctrl" as SoC specific compatible under
> "apple,t8140-pinctrl".
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> index 0984e4e58af3..a4a15b117035 100644
> --- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> @@ -17,6 +17,9 @@ description: |
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - const: apple,t8142-pinctrl
> +          - const: apple,t8140-pinctrl

List should be after apple,t8103-pinctrl list, as entries are ordeded by
fallback compatible.

Best regards,
Krzysztof

