Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D83AA1BA;
	Wed,  8 Jul 2026 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499830; cv=none; b=Nlryt/ojILy5sXvjOqm1RBxklWttA5ECdwYfYj2iodyfPBwJiAp1AZUQr09tBrKujMRUC5rZRgV+4Ez23NpwX3Wc3KFp36pxZwN8SSHLahMWPO1GDa2xH1nnbuDQQjgvr4BLEkE3xdjUYKGd9r+jTaJBCZdex+FaafSRZKmChkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499830; c=relaxed/simple;
	bh=UxTDl/YP/0x5ZI2P4lDj4sSdnWrvWKruAhRnB/cafOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhdw7XsiPpi1D3ZJTSNeakmP4Ehd73qr5rXtKmhql+Udt/1GrBBzdlqqQbxXJ2w4+tJtV04RaY/E41KQcwkneCqy/Pi/EbwJlb3g6H7Mh64gjVV0kE7ebPULRWPElCG879XPCan6BBTwhf+WZhlmknUQZ7TZc3cX6wNov6LzKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnvx+knC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnvx+knC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC411F000E9;
	Wed,  8 Jul 2026 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783499829;
	bh=vYW55XLHCFJgarGHlK8rdPs4cxOeLL3xFE4MYa42nnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bnvx+knCUJGGa/+vbkoEIot6or+TnOlVO/lWt4cbsKUITIz8l9gX6FIPizpok2Sb+
	 EkJW1JvrgXvaTjco1LSiQ3zAjeLLHpAzvBVjA18bhARz3WR2eYjXThPyREoglq6JeK
	 UL/yGMDmP2n1Ip+KfDJuYLvVsWAhHbn6aVOo8Mj8gGN8Kac6ztDapDbYPcOQ5+gWvl
	 DIK26PUNn3rWTFqCMODwmT+U8nCsVVXf8QqlthPR8fpQzJyKC0BtsAu1UFuOlD/Eti
	 l/CjedmhUbdNm7Rauew0rHocOAgyOtmLb4oaSWyxKl6e3XlxxzmpYOz/2DueHjtOJ9
	 h1cZRErSyIEIg==
Date: Wed, 8 Jul 2026 10:37:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: arm: apple: apple,pmgr: Add t8132
 compatible
Message-ID: <20260708-chubby-fuzzy-dragon-ab8ab2@quoll>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-4-e5655ee56523@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-4-e5655ee56523@cyberchaos.dev>

On Sun, Jul 05, 2026 at 03:17:23PM +0200, Yureka Lilian wrote:
> The PMGR blocks on Apple silicon M4 SoCs (t8132) are compatible with the
> M1/M2/M3 predecessors. Add "apple,t8132-pmgr" as M4 specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

