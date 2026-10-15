Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165947668B;
	Thu, 15 Oct 2026 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059871; cv=none; b=CtJUg/cgFhjCyH6MW0BGkPYcrnYmk7YqZ/Nw/gERtyYYsf/mA6mG9v43uUBcjcZQ/+qS3K+MVsaqIka/77vY/oIh/FP7dKiR/q9HzsIXx76LnnzjUBaI9qbrREOgBbFWEbe1HpD5cB9/Br2tNRoD0wUBd9Vunfa9XJiHk7a/6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059871; c=relaxed/simple;
	bh=N0bbxB50mpo7/S0frewbfrh6WRs1DDRnK2wPT6C+sqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xporp1ktmhC8lAspu9c5TqV+XsnCcRdEUZIwe5Aq3D6qY2wEidNLVMGTT9yrDQp3BggJNsYDw+OUSa4UGBDyTWwskt/t2mum6JRliOEUEOQPhmQL/jslA42QNnbL19mKnOfuW+3nw9GjZ0tVMlgMJHGp0BHYGF3XFUrcNrERtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnM1gNwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnM1gNwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333B81F000C4;
	Thu, 15 Oct 2026 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792059870;
	bh=mYBfMwiTI0HuoRBpQtV8NM8t6EOqAZpyYmmAOuAh4mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jnM1gNwOFnII7fIg2tTDV029l5K3lKllCnkAkp0Q7uJ9lZORN29D/zL1mGmxmozL9
	 72ukYJ+Rg4qf/KtOmshXtCDEP/orbv7bacWVQ9bYMTEUQo3DG+m4EU6H/mIfdN1lBu
	 YFK81QgtgNEgVKUAdJZa+byVgrNsx3QqUv1R5I8uF/vxtBDUEWuSglUe2Sf1Swv+S/
	 gu438xESVRPuqT7w2OpmfH4Nqp9CuRkewAGKIERjeMWPg6jnkNhNs+QIJLPXczp5XS
	 asBGJOULBLOMN38pAM4OkFEfCSLCRQ1EBL2ScH/Fx2bnf/DN+Ghxqcep5kA4pPzvLT
	 BMY7dusPpuvZg==
Date: Thu, 15 Oct 2026 12:24:25 +0200
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
Subject: Re: [PATCH v2 09/10] dt-bindings: arm: apple: Add M4 Pro/Max based
 devices
Message-ID: <20261015-peach-quoll-of-intensity-b21ded@quoll>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-9-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-9-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:16AM +0200, Yureka Lilian wrote:
> These devices were offered with M4 Pro/Max SoCs.
> Add the corresponding compatibles:
> 
> - MacBook Pro (14-inch, M4 Pro, 2024)
> - MacBook Pro (14-inch, M4 Max, 2024)
> - MacBook Pro (16-inch, M4 Pro, 2024)
> - MacBook Pro (16-inch, M4 Max, 2024)
> - Mac mini (M4 Pro, 2024)
> - Mac Studio (M4 Max, 2025)
> 
> No iMac with M4 Pro/Max SoC was released, and the Mac Pro was not
> updated in this generation.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 27 ++++++++++++++++++++++++

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

