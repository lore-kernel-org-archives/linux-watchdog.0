Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194423;
	b=LmR+2vywh3008RX/eYA8Ek2Alw1rZR8URO6fI+NYO+b2AkWinBVjz8n17p0lxdvO0KJd
	 +RGp2CUAIxLBbaXzA0fqCPsTWQb5/HtH0ivR+X1HVm/CxgDMO0QRlGheR/Jz6SKb1NKMa
	 4QSjkssPcfQiEjHxDCxU7PfmJtxPTUz8o9T8KacoM4ElKDWyrp14HY4OJHOznyZ6Eg39s
	 M332H2+8hX1Ca8ctFBKtd4Z1+ifPS5H1VydrjfHQ17Qd/wlH/x41qnTJt6yvqWOpotnmH
	 h1SE7AFgLiZSwyJbYgOvCQdL9E1ep/azUt5yHIgX4fSSRRz5vy/jlCv9UT9cRTmkpxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194423;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LH8YOyx4QS5RNezRx1gXoeqhHEy/U+7vjtN+dlNu8T0=;
	b=lg4UU+D7je/AGuBYpah5rFvwHonmBwFGMKeHZ+lXalXecLmYPr1D3MqY7u03I+Lm86j1
	 sF6z+uBAzEmWmBgCpqUa3HVb6p1ufj9tFkHYIuuRnIgbI831xfDLrenF4ItWgxsO0Kip5
	 5KgpVuqdHxqOeVU/yD4XtoCOjVsEgivabyzMVJURjvRTuHloscXCE4kh30hmu0tbuAaG9
	 G5REpFWeXFBjGrmhC+GUNEX3xi8Vb83kBubjPgKY6HGoqjM9RwYiMZPdAmnafMh7sX/FO
	 mrHg7smBgeF9DDK+f54WKqq3aCsLGccTAt/xrdReng1Ab4gOCl4BWAudWlazXAKj7Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XJ9B7B/t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52672606A31A;
	Wed, 28 Oct 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJ9B7B/t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DCB1F01825;
	Wed, 28 Oct 2026 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194423;
	bh=LH8YOyx4QS5RNezRx1gXoeqhHEy/U+7vjtN+dlNu8T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJ9B7B/tB8GpGL5IB76x+CLKeGq9cMegXjiR3sg9eMy9rdTJcsjGnCXqiuEkeTf2R
	 mCvpHlTAtDVSv/UIWwQ9K0n/4zMk2m+vKTVe930XOpuaE5vQrBCTtGmPBkaXvcd1rM
	 LDh3dwsq3uPhB53MEn4LJwsjs/cjR1DNDAHOniuQUudZhcp7EFQJGILI+9wbFeEjsu
	 sWzk9J3TBICXa1uRosOESnBhafD8IJIvrqxWKUjUzCDby3y/z2nZojXmxPhcVBLfZM
	 N/NLHB3F/bqr382Lfy2AvwAjLtfvyyiIrPnhTdfoAtwhRru2CLzunJBId1Zq4tY8Ov
	 gv0QK25QllpHw==
Date: Wed, 28 Oct 2026 14:33:39 +0100
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
Subject: Re: [PATCH 04/10] dt-bindings: arm: power: apple,pmgr-pwrstate: Add
 t8142 compatible
Message-ID: <20261028-prophetic-crouching-loris-ef41a2@quoll>
References: <20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev>
 <20261027-apple-m5-initial-devicetrees-v1-4-1356181bc50d@cyberchaos.dev>
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
In-Reply-To: <20261027-apple-m5-initial-devicetrees-v1-4-1356181bc50d@cyberchaos.dev>

On Tue, Oct 27, 2026 at 09:03:24AM +0100, Yureka Lilian wrote:
> The device power state management of the PMGR blocks on the Apple
> silicon M5 SoC (t8142) is compatible with the M1-M4 SoCs.
> Add "apple,t8142-pmgr-pwrstate" as M5 specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

