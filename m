Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266664;
	b=zQqdM8baKY/zLggWa96Q73Y5xgpcW1wsLFInyz///YP6oAioIKOPatTuEEM0JAHetvhP
	 oq5IFPfv7ZqrV1UGyOglmO1EWrq39Bfh9EcGs1zSYPfBXPHcgUUQl6sE01dP9pXfO7Bqx
	 oH/WHF3IpxPTxWUYKJZr4/mpZiTTFbdj8cRLx+G9qLPAyOV5XgMTSEZqo/pPf9b5fxh0U
	 tH9inBzFA8vxMRNI125AQe/wCQ2kdQdpiSu0JLo0SBoq1SAjd4xdyUQMA392XctSur85N
	 c7AekryQ/DJVibI2yrZ5/D3yimtJDWOT0Uqd89Rq6uVEdmTeYCaKkkvis46Y3H+OphQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266664;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DomZxbCEHeOiVNl5LrqiWWL35PejuwJXF1iKcbILqa8=;
	b=dOw51pwjcDfQSlxABDcqeAuU1I7JfG/U3hRWb94MkV5kfjafxTSeWn3ONpFuZDG77xLK
	 I2T0+u42/qpJMsJWEObdE1te1qRjU5s4cvVOE5Bg5g20vtuaWrJGS2Ie1SGHrMADhhh6P
	 4uDTGQxvFlsLQnZZ0nZPhxiEW7L7Lec4OxrOf0Vhg//s70UA5j4M3qXh0zt+NHrSfugZk
	 R0LdDy7UFcyYjlT4/gig/0YWdzYjSN3Or6f1nQ4dPwoo/E4ujWjvpCAUdZjnMkDmlP14U
	 jPOyCZIPKEQxy3dCmcYgDbfzP0/M3X7HSgL7ywGpEOetfjSPHX1ek2IS6mLNNWActcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsGPO7la;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE6606A31D;
	Thu, 29 Oct 2026 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsGPO7la
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB1F1F031E0;
	Thu, 29 Oct 2026 09:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266664;
	bh=DomZxbCEHeOiVNl5LrqiWWL35PejuwJXF1iKcbILqa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gsGPO7lacEUX5MrFqCCdGn6Q0ZLq5nBJWrRj3NLuUwNtIaruBtP5RmGgt0I8Vwy44
	 QFsCRnAtc85jPBzU6zInE8bW3LkkvCQmHqiNlk9EzzbrCfBOXF1TYToyjX7WePM9Oc
	 jACl4vKXITNhQLcWqTDCuZNKRVGgp1tg1D/8YmbktS6kY9yP3dPtELeEymKaYT/TWv
	 cmB2/CE5hdb2+lMWdw55GcPNy7HgF5/DROCwbNIkMdYOHZlz7uZnXDydutl+a6PhcA
	 C1RFWofQ7pbJKSsHDsRgbem6h09orRz+TiefxubDjpTiDM8x2kRip4vFBL9m/zCxjG
	 dPul5RwaR2MCQ==
Date: Thu, 29 Oct 2026 10:37:40 +0100
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
Subject: Re: [PATCH 02/10] dt-bindings: interrupt-controller: apple,aic2: Add
 t8142 compatible
Message-ID: <20261029-advanced-legendary-rat-f13ac0@quoll>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-2-1356181bc50d@cyberchaos.dev>
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
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-2-1356181bc50d@cyberchaos.dev>

On Tue, Oct 27, 2026 at 09:03:22AM +0100, Yureka Lilian wrote:
> The Apple t8142 (M5) SoC uses an AIC3 as interrupt controller, same as
> the M3-M4 SoCs.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

