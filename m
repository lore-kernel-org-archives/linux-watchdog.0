Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360483;
	b=Wp6SKPVu+cS80qbCTS802oGk3qyDdqWkkZlljZbas6Yba+d/2hjeREwhRyOpBvh4mNku
	 s1qmzhH8iI5CPVyLTCeOZdSWQWJdLrgBj/JOFj/B1oiaHKEj4WuOQK8r/RJMQLY2cr4ED
	 NAMqL5WLTSvyhoc0l5HGURWLtxqf+j+U+X90TWTuxtAvhOC3RBHMLoFTkePovYALcrVGS
	 Qr3yBUxJriw7sB3jX/9r1wyJ5Itb76RxdAcVE0EmJJgLeRVHajqs87zD+/85MurbjXizy
	 oda7VicBPG0PKSlYuQ4j66av/6Kty/ahCUIlhh9VdV9JFejNAmpgyl6/6D+Hx50Ow0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360483;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R9Z06nwI23pV6jyKk26IbTV0XX63QRea5+o94SPS5Mo=;
	b=Hvnwt+bQm/mpCOhtE4/9pBSJV/fhvoYUhCgp0c9h0Q131gLGz0QxqWcdjw/2OlzN0iW5
	 xYswntlvgpWSvJQTFodPuUEtB8x7uoadhUCLtbQkxVumHSKNMO/9nzIUidrexvo3ijYS+
	 3/Dskk+P5yJLs7/BSGWUpVCjXKpgl35Zq5P56zPNyIFVS5pd84+wCz3rqStVrZbeUOR7P
	 7a3lTVNLbe5/SkLGty8XsyGyPTDywDvTvvxKrId30Ec3V3mCe/KADF/DC3cjM9heOAZ4V
	 iefWo9sSYf75hs6IIw57eMFsFcQZnic6Ble1ct+tQagW9u7QnkYePQ8T7I25F7p1QkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuFCCzg7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB383606A31A;
	Fri, 30 Oct 2026 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuFCCzg7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54F41F000C1;
	Fri, 30 Oct 2026 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360482;
	bh=R9Z06nwI23pV6jyKk26IbTV0XX63QRea5+o94SPS5Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EuFCCzg7qSH2rwb5AhcERkxTRFvdWBprEseUvqeBMJ2BtzV3100oIFr2dojcC5I3e
	 6lze9XLQcibxf/EL1CYm2lVI+9sMihhPcbs0mQf+BZ2hu+xXAetf6rTaFUw6J8eX0P
	 ZNIaNtWmwj1eGWo6kqyTSRUn26lysrQCYpgS94gHHJJls7xE+7qErpQ8oiuysqyZLZ
	 knlRzIgHgdDzTHx0W48QA8hHpkKdCAPCB9s8jQBdMDfXhNSykBYkpXa/SgED99DgxN
	 ZxCgJlftjXOABBdLNCW5kcWHsPHJJN3j6/JOJHd3dLp90MxkirRUQM7mD464xJjafL
	 IAOV3Eq0gEgIw==
Date: Fri, 30 Oct 2026 12:41:19 +0100
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
Subject: Re: [PATCH 01/10] dt-bindings: watchdog: apple,wdt: Add t8142
 compatible
Message-ID: <20261030-formidable-bulky-husky-bb5f75@quoll>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-1-1356181bc50d@cyberchaos.dev>
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
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-1-1356181bc50d@cyberchaos.dev>

On Tue, Oct 27, 2026 at 09:03:21AM +0100, Yureka Lilian wrote:
> The watchdog on the Apple t8142 (M5) SoC is compatible with the M1-M4
> SoCs. Add "apple,t8142-wdt" as SoC specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

