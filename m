Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195304;
	b=sxbUY61GLiZAZiJrnxO8wrDujJahH600/KlBqQ0xFodZJTbRG63mT2chUdF7MsnEdvzf
	 I4O3fpg7RvYVDfMdc1nLUByBB8yNWb6aZWEY0A/cFt5orMjEfWcBHMR2hikAUCVrVwpcB
	 zd+RuJZlIZiigV3GlLoz+mm+gC39eFzD2pnhOLanNwNeuPJ1pQ1Yt8G+tcu/hQsQDZ/qB
	 /MBvbfHYohVHg4WzmA7ao69ifTRdAE0NOd+UvspaekcjVKmgv45+7QwepJ6XxAgJAXWnO
	 jEstTuAbchMjXcA695kM15LKSsyLbefMEOQ3MNs03rT3gE249StXKrfBd0LzaKTP0lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195304;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0ooKXWeY0e7A+cuVjpBUsBgmOIh24PcaXz1sFnrQ4fM=;
	b=JxIMsemiXj7GeTDKOixOFOAEKiIeI4Zoulp5jg3G5kgAjXlp0xdqHDp4wxkMaLvyN4+c
	 7hrOO7PVFKhMWObil257RVD1ggXIlZbfXaAmjogNfork9JNv29q8TRgfbnARpgvlO79j5
	 eFxL5VhZFj6dde/uckLSH0e8l/OhIFyanrNWDrf+V3+FkMtisV8+MVAG5ibF7cHxZ/F1y
	 nB+2Qa5UZ4KfIztM13XVbZ8/kiZsxbeYp9SvNGL49xT/lLgnW6rWnHqGsC/EFa3WH3RQ6
	 rxTt7eoH9GauLUkDZCffrvansuS22uWa/8no3B5LC/oSBfnXylo1YPYiphWurmJEq+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5vpilQ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBDA606A31D;
	Wed, 28 Oct 2026 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5vpilQ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC59A1F01825;
	Wed, 28 Oct 2026 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195303;
	bh=0ooKXWeY0e7A+cuVjpBUsBgmOIh24PcaXz1sFnrQ4fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z5vpilQ7PNSjA4l86QAE5jE8wKTYRLOPm7/ETBRqj1umF13SyEZF+5ffwObn95W2I
	 91KPJsJFPk4c7uJHp5Ft7YqOdgbFFXrCNXac9BMTpKtJUDe2L+ElpMh24tgFHcNFLd
	 UABIfjaEnkTC0jAC9luDzwM7U8IplIjMBPMHxQmsCb4hsGlDksNErQSchPfymWDhe3
	 MGil62ygEofOw5L/XFCGblF01lC2kk0r5m+UhZ0fgLH7BuQqLxFJOy8IJ4cLz9RuKg
	 8ST+NaVvnbgKjYlfcZwk1QPXWJTphCq5QmVogKv6J5EMwJY8tZ4ZZbreWXtXudW6j4
	 Qb4wzMwhLE8NQ==
Date: Wed, 28 Oct 2026 14:48:20 +0100
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
Subject: Re: [PATCH 09/10] dt-bindings: arm: apple: Add M5 based devices
Message-ID: <20261028-teal-boa-of-attraction-dc0381@quoll>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-9-1356181bc50d@cyberchaos.dev>
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
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-9-1356181bc50d@cyberchaos.dev>

On Tue, Oct 27, 2026 at 09:03:29AM +0100, Yureka Lilian wrote:
> Only the MacBook Pro (14-inch) and MacBook Air (13/15-inch) were offered
> with the M5 (t8142) SoC. Add the corresponding compatibles.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

