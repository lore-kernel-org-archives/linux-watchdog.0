Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195284;
	b=xi9xwFf4CaCKuY0DGh5ymNm8QgMuxgzz1/zQt4I9pW6us+wsUYfYd+3vbgvzKxgQd+Wi
	 f2mfVf0TDdr4YNRdoGddSx4KdhACKPJmDy269H4X+tROrqZKbmDm4KZ+nK07F6XOIihcT
	 wsTiK61VJPLWArKNnpmB3weHxiR2soTdeYYBwPMW4+4lQ8doFznHQnBshP+zQmQPKsTJs
	 /kDDNsNuUptvYbHd96Zgv8VY9XGKnSNvQ1PSe8oDv0XVp+2nYq07DNBb5JskxKDo2qAgb
	 yMijIjrnZPENz+kD7FKA7BYnm8gH69liNuZIm58KFIaYKby9WVsOqSyCJmsp6ay6/eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195284;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EK+K9qrLcWGfFuyJXBU9FNLXhFL/gszCgTQEAYirt60=;
	b=ZjJAcqVcfg3QX56AvAqBWMYwo2OCf7BOs+4h0Txx8u7RtR7QG9M+z/o4E9tigm7ubdjy
	 9SlU/zm0vUXVGhc1AG3aZWErhIFFPtEs//iPFcmCpDOK1wlkAX2idHrYlrnoywM3Kn4O0
	 3u6D1WW1y8PWSMhZ+wgjC09miOfhsrhPIsSN4BvRJCZ0tA/PbalLvW0gJwQRIaY3ocLvj
	 xKsFvFzODo3RXJ1p5FMR+4yttOw4gKI50r7t58Wq69pU2KHCGMdyWy4diL9T3BI1THE1+
	 zveG9rk6MvkoQwnsBrbix+h5fJ8j+PK57xG2759++sgiNtwVCB6DBm5tXFAk5ieeZng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyWASZTF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70E606A321;
	Wed, 28 Oct 2026 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyWASZTF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ABA1F01828;
	Wed, 28 Oct 2026 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195283;
	bh=EK+K9qrLcWGfFuyJXBU9FNLXhFL/gszCgTQEAYirt60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EyWASZTF9xJvCW12+5wPYsP5WXMRB6HGXmkJ9i0tu6Jxheh4z/m2T+wjtCwI762t8
	 Ovg9kHQlhk3x0vDq7ZlVQh+fPds4V/l+Jn7XVXmjkKzS12pildNSZyDN18mqUOaCZL
	 SRnypw0hQLY5g3mN7pG4Kt/lbgm9FxNKHtwSKFAWw5FXGRHtwOoh15HHzGT6fxOr/k
	 Zsai9a1LsxJ7gzOMn6uIhE+HJZohtTqSyVfeVwsaKrGBeL+DAPjolfg4wboT6ABv5W
	 GUY2VN7SmwkMQlYLESoTxVXNi9OIRYWy+oPoySD+Mapj0f3YTGdXagozPthHoUjObD
	 w5LTkpyuDSXkw==
Date: Wed, 28 Oct 2026 14:47:59 +0100
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
Subject: Re: [PATCH 05/10] dt-bindings: arm: apple: apple,pmgr: Add t8142
 compatible
Message-ID: <20261028-teal-platypus-of-poetry-a2febf@quoll>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-5-1356181bc50d@cyberchaos.dev>
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
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-5-1356181bc50d@cyberchaos.dev>

On Tue, Oct 27, 2026 at 09:03:25AM +0100, Yureka Lilian wrote:
> The PMGR blocks on the Apple Silicon M5 SoC (t8142) are compatible
> with the M1-M4 SoCs. Add "apple,t8142-pmgr" as M5 specific
> compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

