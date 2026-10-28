Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194436;
	b=5jkZ71KSmJ1k6YGCEfTmQRRg7K8TqN4DfT3CD4/+5eYZXxQL2gjNQ/qPEJkMWM0rWI7d
	 b8xMpB8UPAd5xu64etsiSnTk1vJQ5w8h3cc9zvOit1w1fUHKaEWzVHQu8AeCg4FMsMnRY
	 ULZim2XJNmVSJVlfPE+WMK8LTcz1qmW5VRQ2eNBeyFZ0SL691q1fjUc+vY206IoMXCilJ
	 iNEvkxYOELOZfFlw+N6QFe2BlGICoQUVauZk8inwiz5D0ypX/g7Rhar6q1WfcfOyuYd3X
	 lVoZstOGLPTNoRbEWF37rSw49hSYwl7IhV+UOXMYskuPwk0o5JOPTXC0GD25Xa6DQbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194436;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DMsRiBknVoRDaECGgJaVBAV8VypoAXINin2meGoRvjI=;
	b=scN8QZrgcWOgwgQoCT+UDbUCfMImXPah1Vdc3hSPCb7wL+t7jp/WOV3ObqpIes4Nv8vI
	 oKmAwfEJgiFMBMrf4leugszard29opFUWqvBizETSBgEWyS7+KpJoGUeIbrt8NXQgGbnF
	 rt8u858RV9E6AH7UabPG4QuqUfeu+Xx8capIQz1TqVcf5IihjoQP38FP+LL1TR1wtA4K2
	 1PyzT67hKO9XR4U0n4EZp9pW/nDOA477ROWeeBRM5Wyp0Vz+cKjYHKdMugiiqj3+TGWtB
	 wQEnXZaMfadxE9WDqkuIRyTYslc34LcvEPcq+kPdjNSPl/NpwzFTZv/2/MNvFjjdFxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJLmeehF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5460A2636;
	Wed, 28 Oct 2026 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJLmeehF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2E41F031ED;
	Wed, 28 Oct 2026 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194435;
	bh=DMsRiBknVoRDaECGgJaVBAV8VypoAXINin2meGoRvjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TJLmeehFcs9qsZX9JOI7J+zshbl5pWfJS/NdnsI7OC4u2FQX2qAbqo5vQ3iqOzHL/
	 qjpQXTlbUVpTrkyHvNNb8ZL5rxZFKU+B5SQ7CR8o/+ZUsco+XjWEAHIc/cijE8snx5
	 VjQTlwCF69pqwcUMT3fWk3i7aAWpKAQXbfB2ADc2S9vyjLcM2Y82K9N93AFfANpmCa
	 Di89PaCA7lSyAe6O5qrg7mkdRDRaQ+BT6T3ZTAqVosuXkXB7rxJ3uxJ7VNUwiC17e0
	 4GcAQ624OZJEZ5KR+xD+X/ytTESDK4p9p34QWZ8ltu0rh5zHaPGhJz+DSfgE3Nbn3r
	 dk3NE8JGnc50g==
Date: Wed, 28 Oct 2026 14:33:52 +0100
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
Subject: Re: [PATCH 06/10] dt-bindings: pwm: apple,s5l-fpwm: Add t8142
 compatible
Message-ID: <20261028-aquatic-dainty-tamarin-9aeecb@quoll>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-6-1356181bc50d@cyberchaos.dev>
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
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-6-1356181bc50d@cyberchaos.dev>

On Tue, Oct 27, 2026 at 09:03:26AM +0100, Yureka Lilian wrote:
> The PWM controller on the Apple silicon t8142 (M5) SoC is compatible
> with t8103. Add "apple,t8142-fpwm" as SoC specific compatible under
> "apple,s5l-fpwm".
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

