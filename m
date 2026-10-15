Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFC2857F0;
	Thu, 15 Oct 2026 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058923; cv=none; b=PMQ+nMi29RCaeMW+bJb+b3XyE/sHI4nxvvcKYdquangyuZdLvmBvM5MdQIXxAfaXRciF+yorYs2KRCrBdlm/li0Qtdup9cZx9vVHZVQJiHlfwStvV6m4XoMfzF1wf1EsbrGHE8fJkDtKV//kR+KG0oIKoqe3j1IcEjgeTg4rhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058923; c=relaxed/simple;
	bh=yCWdl3WO8JSoVl6uP2YoBzr+NSo/nu0w0OIoZWR80RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcNAp5S1X0aXMhP0jX4+S8Q+dAb93E6XBVz1edybSA5W/bu12aX2K839/bjmrmGvkRkRrqjz6Kqy684V/mbATuF1VLMmxWvkxWb1M34HeaFy7HSlXcxsfN+IB7jfBaqUZM25Gp+UDoGz/pJ0ZzMWEHqRVHTopsiuhI27op6GQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D59gDZme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D59gDZme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A451F000C4;
	Thu, 15 Oct 2026 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058921;
	bh=lM5799hYbOtl8BgA3ry1OiBiBY0Nyz/X3iGyGpn5EXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D59gDZmelu/o3/Ac+U0lCPgT+RcvOu3H816ykDIkMyX48jN/0babJH3w6r5VIww+C
	 koC7cB1guHUajCi+G1D4KIPh3qzffhdyBFRZ0yDBYPNV/m/Tf9/TjPQDzmKMdXsrXO
	 gTEGD6BCiU1WNsdeSqJDfvWyVtuYqjcYOckLJ/n2EMvUOyLRHi373b1mFKiLm5Crle
	 rXvLTD1R7RS4C3v3hkWWm6u8Q1E+1OBqBVdGF+MnBTy/bbyuNGY+HxtYfZD/44lEBQ
	 JHEJ9Tvmbxj/Q49j1JmdQnYsAIPRVgOe8z9M2f7+kGJ+Xmvt5EuyCvHY97WIKYK5qC
	 r3FiXQ14xDWSw==
Date: Thu, 15 Oct 2026 12:08:36 +0200
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
Subject: Re: [PATCH v2 01/10] dt-bindings: watchdog: apple,wdt: Add t6041
 compatible
Message-ID: <20261015-adept-supportive-anaconda-dd6fec@quoll>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-1-961edd8d661b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-1-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:08AM +0200, Yureka Lilian wrote:
> The watchdog on the Apple t604x (M4 Pro/Max) SoCs is compatible with the
> M1-M4 SoCs. Add "apple,t6041-wdt" as SoC specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

