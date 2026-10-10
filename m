Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F6D3BE633;
	Sat, 10 Oct 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652306; cv=none; b=hGoWoK+sypHPuE+6ENXwmEPzjTpxaHGkoIXHj6k5l2WsELax1s1JVuiyo1d+Npws+lI0QgnmLijWmsMzcfYYepJB6rG84vZ+SeijbN8ATHQei1S20uMewUqMo3Pob4wJuskiaU5JLHs5v3zN24Mge1CVUZy7iseTVahrvEb+DEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652306; c=relaxed/simple;
	bh=8QGjyTRLdTBhk4Iz3QJMepcprxh+1GRSW1VXMEPmScI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qm21V41UiYvBj6cpoPrAVferpgOR+JPVPkMPP5nUAW11zxxwVZbO9i+e7cV2E0v7/AEpYINhNBdfNC7lwk7JBgPFsQGVZVVE2WHRUZz+eZj1CWdJgT95g2f/9cchT4C2zX4GvTXnDX2gsy0BnTlQf7zwrqjx+Q5kjTD36DKPlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=maHCfN9r; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="maHCfN9r"
Message-ID: <119cdaf0-e631-4d33-a7a1-85d10b87d78f@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791652303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5fZ9xMeWb13PFHx7PqGpTj4Gd+/TFWRgOl7WsIogwE=;
	b=maHCfN9rFLAqX/oqjbAa8JPK8g5ikCzI3UD1ufj0d5LNm5EzndRpozUExeYoxkTEYtsYNu
	Em7JvCyAm+KFKzUfeT5DtkovgSo+XLSmbvoO54148bxTtYAaH2LWNVg6l9oN3Midef0bpr
	vrj2HAVqxD3XrtMVYnuC+SFZFwVHU6g=
Date: Sat, 10 Oct 2026 19:11:39 +0200
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

As noted by Sashiko, this hunk does not belong in this commit. However, 
apple,t6041-aic3 is intentionally not listed here, as there are no 
multi-die t604x SoCs.

>       then:
>         properties:
>           '#interrupt-cells':
>
