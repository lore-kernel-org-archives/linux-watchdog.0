Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471250276B;
	Thu, 15 Oct 2026 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059818; cv=none; b=lg6wBuFAKbi9zuHKrr2zwqaB5oR9RZhVRaG5cwa06ZjIRvqeh9sQ69opvWFftXLypvYY2TprPKuEyZjdlu6Kdol+R2dKknTDRGMk0L+59uFggmUzExZ/nqg+k4KFhMD9nSQcFQs6tZjSbcNDVTguHurdmXJryXMC0m2D1yBI3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059818; c=relaxed/simple;
	bh=zDYAg4eAr+csBvslyqXmXjuMWtVmLBOKBuVQyQD+yKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGfhqiUJa+TousrfDrCK/EwL6D3X3aoY4EyZEI3D82mbz7CPlyc0uslM0a/AFEJXTTAliJYUI/yi5gBaSdCsHf8kBv5VUkABg2X0a5tQ77kOwKg7wPO2Kb09FhCpHOnFwEyUQN/IPerCf2Xw/nubaP8PFTB/sMHLoqg9lx0qvws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh0U/zW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh0U/zW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEC51F000C4;
	Thu, 15 Oct 2026 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792059817;
	bh=oZNzHE19mN9ZPlKLE+9F5Pf2M335AMCg0mWZd6cuQOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kh0U/zW3Q5NUsLJJGoPaP3oyojNyEBmT604tlxiRpzHM+5suIBaSpBmuHepA9r+PF
	 Uq2Gp4XtkJyzxAiVLXVz+RIphSvEh/VgTsCI6OfP0RukW055CC+e43j5nrt/3Ct9g3
	 u5XKGHyj3mA/97BycDiV+PmvbmcDB35ZblWKYP242PmgQGLqkUTL8ePrITFAwN/lL0
	 65Rx6BHmY+lXXq/p4PabsGKmWOiY/Pt6k96OMBxO1/9gkpgmk2yfhZ0NDMMLtkJ+OM
	 +mW54gU3FLOJTA+qHT7pgUiB52SpTK7jvNkFYciPQmQApXupwEI3iA57s4RHp1fuc5
	 terQDrocurTQA==
Date: Thu, 15 Oct 2026 12:23:30 +0200
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
Subject: Re: [PATCH v2 08/10] dt-bindings: i2c: apple,i2c: Add t6041
 compatible
Message-ID: <20261015-fair-tan-viper-7ba5c2@quoll>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-8-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-8-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:15AM +0200, Yureka Lilian wrote:
> The i2c block on the Apple Silicon T604x (M4 Pro/Max) SoCs is compatible
> with t8103. Add "apple,t6041-i2c" as SoC specific compatible under
> "apple,t8103-i2c".
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

