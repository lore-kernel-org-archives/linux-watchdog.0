Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521004;
	b=LYXP/eGfpBuCu+T9pPlnJHcfo73fKu9LQvPm8NMVGYOQuxlO4rjwh2ZyuoVPbwph9B9v
	 grtwT4d+UbHKMJ49jNT3yU9ezPLOWxrEfDJTe/6m+LM2uEyX13jdM9SlH/yD789gQbtW/
	 vtfg3LtV0a0Qssl/PyxG4QCjQxEWW/7naUzDUqZQBR7B7qkBRbR7HeZL8/eyDTtrzoBQm
	 JSjtcvCmVFDHHxD+p7TxEbwiqJZUYqVJ0Q0WybVJouQlIhUDDqEC+5Y0FEOHrbCFqsZNH
	 8oA/WQ/QP1CIsb/oFekfZr0GRE3u5avE2z/zw+IIIgsMX93BXSW7S89jr2dt95ci/vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521004;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=I61vAeBsOWK2N+3xullrZ89EtvrlTdCPGmIPBmyybbM=;
	b=l6AaNmQ9WQkrxpuxH+XHp0vOeM/gxO31NJ1OvgBwV3fxKrLgVzw5vdtsC5+yNMESzGff
	 pGu7aj0JSG+mIxa7f4tgIrjSPELkQ/EODLbAf+fVGGcY0nQfpm0g3X7NhKYTXQn3+95n/
	 xBPLGCs7natojdjrMF3LDyxFV6APmpAbxQ+n3rMWU4RHueKVxyLgC4dO+6r7ssjPV6hCR
	 GzAYEj65AytXYdN1ekyCdzO4H4cDMLe9/koEYYiT2jXsH/D0djqzcFTOB+uPUi+HxQMhh
	 uWnmwqSMGM0KDxLtr7jroGEhqh0eWYyKoU3X8Vak52KPSnn92lC6JAO3MaqM05UGbEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO1qPL0z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDC606A31A;
	Tue, 20 Oct 2026 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO1qPL0z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8401F000C9;
	Tue, 20 Oct 2026 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521003;
	bh=I61vAeBsOWK2N+3xullrZ89EtvrlTdCPGmIPBmyybbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RO1qPL0za4UmrX0fRGPOOnAzFmWkfjRNmWrT6WsbNOKaEsjvgfZoQRQNUEV71nAIA
	 bZgqCZLg0ZtaYCGBeIphxQ72IxdLqf5pyHPi0w9kECEPjtOyZshV7GFNfknlcRvPjR
	 FHvqS5lTww6et5G1GF+FKQ8ZKHfvOwBMUy3u5Z/8k8dFcBRLGKRhElWSeGvXhb4ocr
	 O+9G6HolFBLMmc2g7+J0Cu2L239YRZnwA5ODmzGP5O5hFh1RKjF3o1qErJ3EjaydUl
	 HMzlOLei7927lLPrFPvdHGIbSzJZkddw6qD2WnZD0BIWGura46fS3DzX3QPs+XYiqw
	 qPOcBVQ9qomfQ==
Date: Tue, 20 Oct 2026 13:30:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 03/11] dt-bindings: gpio: Add Cortina Systems CS7542
 GPIO controller
Message-ID: <179252100225.709291.3157984607951047986.robh@kernel.org>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-3-181bb0d23f4c@gmail.com>
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
In-Reply-To: <20261013-b4-cs75xx-s2-v3-3-181bb0d23f4c@gmail.com>


On Tue, 13 Oct 2026 09:07:13 +0300, Fil Dunsky wrote:
> The Cortina Systems CS75xx SoCs have five banks of 32 GPIO lines. Each
> pin is shared between a GPIO line and a peripheral function, selected by
> the bank's GPIO_MUX register in the global control block, which is
> described as the second register region of the bank.
> 
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
>  .../bindings/gpio/cortina,cs7542-gpio.yaml         | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

