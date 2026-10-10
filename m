Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982C23E334;
	Sat, 10 Oct 2026 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652586; cv=none; b=LyeP50bmlkJ1OtlSXbBU8EQAiiih26k2AiTChAmafUDM6dz3hXuqhcPTaieA3+yWxbwUi92GjsQNqzeLr0nK+PBOSdUEeBeSWLGlrrEfkC+6pn6MiL4MBrDmq+4T4J1yhf14+VaLhiwc+gLKhCIFTOBNeN4025BB1KkpJExCFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652586; c=relaxed/simple;
	bh=fFT7o06p/hJpnx4rIn/RIknyy1WZ3+/NPjr+b+yBgJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfPvpSY1Pe81AaQJeBIL5rrkvbFATCCUmyAygay3beKseyvNyV1FPtzyM78mK/AP9X73U+i4+i4Gu62lKvPk3e2ErglqobkSNZyy5lssLzYnJJH9uCSTWlK6l+ZiOZ9bB2+DDTXRVtPQQww54vcxn7VUP03FD9USCVLtDrbXUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=Zdm9Q81g; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="Zdm9Q81g"
Message-ID: <d3f9eb19-6d5f-4246-95e4-09e92e1d175f@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791652581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRcYQiuliJ1CdaOaqf97NB/suFRAHUr80VIP8a+WeIU=;
	b=Zdm9Q81gtriKJ0svM57CLsbj6ZQNDg4vjqskmZUts3SkfiRPgJiny0m0XLKpTabLpR68zS
	7382gHybp6exR5/EyyLipW3IzRAC6LCfAJv0QE+EEeKXJDXwzzQevxNdpZ1c3vgQ7Ia1gC
	9g3+Rs5C/R1BN1Fq+7kfV3YnlbsN8+c=
Date: Sat, 10 Oct 2026 19:16:21 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 02/10] dt-bindings: interrupt-controller: apple,aic2: Add
 t6041 compatible
To: Yureka Lilian <yureka@cyberchaos.dev>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hector Martin <marcan@marcan.st>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>,
 Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
 <20261010-apple-m4-pro-max-initial-devicetrees-v1-2-781fb3f2d9f6@cyberchaos.dev>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <20261010-apple-m4-pro-max-initial-devicetrees-v1-2-781fb3f2d9f6@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/26 18:59, Yureka Lilian wrote:
> The Apple t604x (M4 Pro/Max) SoCs use an AIC3 as interrupt controller,
> same as the previous M3-M4 SoCs.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Apologies, the Acked-by and Reviewed-by were wrongly copy & pasted from 
a previous commit. This commit was NOT acked or reviewed by anyone. I 
had noticed this a few days before but somehow ended up sending out the 
wrong version :/

> ---
>   Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
> index e3cadc5ad39d..fa9d89cb40b1 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
> @@ -37,6 +37,7 @@ properties:
>       oneOf:
>         - items:
>             - enum:
> +              # Do not add additional SoC to this list.
>                 - apple,t6000-aic
>                 - apple,t6020-aic
>                 - apple,t8112-aic
> @@ -45,6 +46,7 @@ properties:
>             - enum:
>                 - apple,t6030-aic3
>                 - apple,t6031-aic3
> +              - apple,t6041-aic3
>                 - apple,t8132-aic3
>                 - apple,t8140-aic3
>             - const: apple,t8122-aic3
> @@ -134,6 +136,7 @@ allOf:
>                 - apple,t6000-aic
>                 - apple,t6020-aic
>                 - apple,t6031-aic3
> +              - apple,t6050-aic3
>       then:
>         properties:
>           '#interrupt-cells':
>
