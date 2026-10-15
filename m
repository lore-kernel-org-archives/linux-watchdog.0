Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795547044B;
	Thu, 15 Oct 2026 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058947; cv=none; b=muITfXaF5Xq6Oa7pQjfbGlrw8sH/9VUWQAiagJIrQ7Sp7DjG9O5WYoUDJCQM2NoRg6jsZDC+1JMv1C8fBgEZoMpIM/lrz530xh9BfmZzAXJ1XBMZ2RxEpwfomP4RvNXAFgX89WN03YlSxu5LI/Gmg2o0vvxDwV+/14F5QGjHHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058947; c=relaxed/simple;
	bh=oii0SDni2bjnw1+lnDOwhqXJf2s4zMIPeEvgszhvxog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE+kotCJui3mEdoip+13HHAsrpLrz9EapFXbWdmPYtq4rrXpe+juhvaKoTlMbGtYRxUO94LPj3R++fTAvHQRAZyP48hLrXuGkkbHNfld6jF4Vhamb/1jEYDN/Y0J6s3q2Tda8VKUQPiKrBqjFZGMz5oMgCZOd1jZMLwFOWs8szA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmU7XA03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmU7XA03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2373D1F000C4;
	Thu, 15 Oct 2026 10:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058946;
	bh=QHtid+XkEJDH1sFeTyARS2z8ZkI836TbL20jIh9LMcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HmU7XA033MRi/BSHUylHulfgEVmIcwqJmFBZdwZQwgfuAUEjkrvYC35Jpl/2A8hcb
	 UIJ4DnS/UV/l/n+HNFOujGtGdzfZXQSfvMSIgeO669wCiagp+B5yeFXzbaMa/caWK0
	 r5P4h/WE6OUbFdebN5QiX8NE5fWpUALBMrVyIRQLg+qBvZS68cWaGwiC/28HvrzPze
	 k5qVbaaCXeT2fBN4rDt59zL0+QCBQTNKKqI++m90N0IdMm67lsEaO4MmYRBFXNdizT
	 X3IJ21WCOI2uJ6fc75R9GuEqgv+is0eo5Clr+sM/GeQiG7W12xLrRFFYT+M9Oy54V0
	 4F3dx/ZFPuBgg==
Date: Thu, 15 Oct 2026 12:09:01 +0200
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
Subject: Re: [PATCH v2 03/10] dt-bindings: arm: cpus: Add Apple M4 Pro/Max
 CPU core compatibles
Message-ID: <20261015-refined-lilac-caiman-cc989b@quoll>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-3-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-3-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:10AM +0200, Yureka Lilian wrote:
> Add "apple,brava-e" and "apple,brava-p" compatibles for the M4 Pro/Max
> efficiency and performance CPU cores respectively. As with the base M4
> cores, there is no longer a generational codename, so we assign the core
> compatible based on SoC codename ("Brava") plus core type (E-Core /
> P-Core).
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

