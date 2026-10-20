Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792458087;
	b=nTDwOsvAaXp6WFLQvL/gfYoZ1IqH28xQl4d0j9X3TpJYqlbuRhmGx5V9v0QEQbei/6Zp
	 dplrC4K+7ZRVfX0cbdcSTnGVVh9IU2dipSWu106XSyCxG838resEhH7yl0s687jBg+CoN
	 ihc6JzLChopDaaTQl26JZ3TTUSRAsyvapuouRfQh1xa942dGfz+fiUof0rGnU0wdhkHVF
	 iGQLnW2wW7UI+1cLhT/0Aa5kWfX2uNaLcj5wzeeXaEjPsyOMliUNnJHrqVMU67YwiApTT
	 gVlTqdTGHe0mgcRyIm27Qwyc1dw6Z/7EsSTo9FKJQwc38oTxUXNd3RdiWpgXcAlatVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KbUzaN7i+ABYfLCgoI6H+WcWKnnggG4SJix4W7UMo8k=;
	b=sq9ERHKF4IomVZQoR6atM1bvj37Bnm6jQG9GL69Lr2Fg16uw0F1H1/mn9HXEmdOXe3Za
	 b1n/PNQNzaiRvrkQl+9Twfs1VXTIDq5/pW2dvjYJj8rEfyB4gtSzbDBX6oelDE/ZFyA8u
	 ZesMSQ7BG58B6ofQo9jCSCtP5BobSSeDaHxJsweeJdmUz7C1GYYE7vUob9y+mMx5p8cSE
	 kXw/MPbeh2tF7orDlkxoCqku+/DqfXSbO13sCKtgmKWDG/KkxDLVRecdaZMjBPx1yQFvW
	 uRGjSacDcnggmsNY50olfkzPbjsUcRmEWnnf8Hn6DuSqSaAjcfoDOvGyKtd6XHgX+dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VSyJsIfO;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C6606A31C
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A09C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VSyJsIfO
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so1796052a12.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792458086; x=1793062886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbUzaN7i+ABYfLCgoI6H+WcWKnnggG4SJix4W7UMo8k=;
        b=VSyJsIfO3pSe89RNvWwrrSLCK55i9HH4oDZjx3AxOmDCaDTLG+rG1NRWR9puCZMJXV
         iYtQYaGBBn6989y1bpMea2WVDt0NZT7UjaUDJ8zzVgV1T0o4zUIKICT8mEDjy7hijd1E
         N9uwq5J1EBRiwG5JxDkp37+R1/YH7enqPykYWVsawdhpufu2ptHIW1RoIsdvLjtcKjbe
         6JGQzAfRiBOCXp3FUKgR8Edb0iMDlMG2e9f8HdlSSR/Oc9nfNlD+HHgESdz/5iEtuQaG
         T56HosWDv0o+4dv1H//tKMjBS/CK1QOFEgad1xbX9umnz81JKeuQ9d67BJll5TAz7z8s
         Qy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792458086; x=1793062886;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KbUzaN7i+ABYfLCgoI6H+WcWKnnggG4SJix4W7UMo8k=;
        b=IXGUEaOZOKkRWrqrGxalUwHSgA96yT+rwfFM0VHfS5ZK8dDaHvoLqquAoeWQhacGfK
         IDrBxF655aWJtd1U1vYJV3ofJCEyclj8mQ+x/JwbfpPUw2f75Gab5d81zPkoTIiUvqgv
         Sm2anqjAia5aosMn1HyGOp/u08V2kGdYi2QJX8e6dvphiCUGlS9f8gLAMPW6zL81lJQb
         gEzmVWhi6Sgz8Vr5JPuSyakX6h8wZzJVJOoKV4mHdgXMtQMHS8W6qr8HhInFd6wt24BU
         h/ZzQaktkQvhexrJ3a54+lAx2RTIv3exDAiWau9oDAYh6BsdY5RNxNsJzLp+oEghow5/
         bJuQ==
X-Forwarded-Encrypted: i=1; AKwUvBx15mA5TTGR5JMq9XHHBMF4V1ZbaLxmD+pNut2sFYfQObH+qHSkRsYwnHk02bivTGueCKpRNVSd9q9K2zITdw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI0/yaABA+CjSd6KjLBn5mONlMfJE/O+/UuQmXbyizwIq7gHdOh
	9pubrR3gUAQnvVM3tI5olWhg6Q7fuWdbNenMs1vJ2KDE2O6qN/iKSup5
X-Gm-Gg: AYBFou0smtqhBtOpeWYgWf6eTipCbvHcoFa2Q6wLNAdWa68Nzr2D2Q3aGsCyJp5q9Lr
	pJcrumvim2qof5TnBhwCJDjhHhjJt5FJ02//IlaT+FUkIe3zLnGv5LNwdYfIhFxFUsnGQbXDr/8
	ll8Pg/mTG6/0SWQZk/h6roP6nkmZS+cysIxK4rT2xEOcNt+k6mJ7x5db5eoIYe5e3oWFOGiOqZT
	XdbND6e+dlGuQndfnDGxbvOb0sT11pkeRpoctfGYJYF2tNCtDMtCOLEfAEHkJ+u4gzpJJL/6XrD
	UPqS59uVdx87XEJ/5Zq8l8DAzBIEC7HpKk9LJQbFZZipch/WwIwD1dSCkWenGvssXjwI7DRZn6u
	2RfPwWGcexPZDBWT0TrT+PH9wHtorGY7s2jvxIO6b96IjJru2U1NSEiIVht8oQq6oYEGsXkEYMg
	X1Y+D6s7uWXHu3ZJVxhAoQjl+/KfM1VRzxpnpGgFVkrWETR9a8QcuriL0qkGNo9eQN5a0It0VVp
	rNRFkjeopxClv6pU1JGuk7zbnad82j/5xp1VI+SQ7xLwANQc0YvEgudMD0=
X-Received: by 2002:a05:6300:6ccf:20b0:3e2:325f:577b with SMTP id adf61e73a8af0-3e2325f58e4mr4058830637.60.1792458085904;
        Mon, 19 Oct 2026 18:01:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497f630sm4368568a12.8.2026.10.19.18.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 18:01:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6fdbb1c1-5572-42ab-9579-58e90111564d@roeck-us.net>
Date: Mon, 19 Oct 2026 18:01:23 -0700
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: watchdog: gpio: Describe minimum
 heartbeat intervals
To: Florian Fainelli <f.fainelli@gmail.com>, linux-mips@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Robert Marko <robert.marko@sartura.hr>,
 "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 manuel.lauss@gmail.com
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <20261016221617.2223004-3-f.fainelli@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261016221617.2223004-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 15:16, Florian Fainelli wrote:
> Some GPIO-controlled watchdogs require a minimum interval between input
> transitions. Add an optional hw-min-interval-ms property to describe this
> constraint, allowing the watchdog core to defer early keepalives.
> 
> Also remove the 16-bit limit on hw_margin_ms. The generic GPIO driver has
> no hardware register imposing this limit, and its heartbeat interval is
> stored in an unsigned int. The MTX-1 watchdog has a nominal 100-second
> hardware timeout and requires at least 1.6 seconds between transitions.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/linux,wdt-gpio.yaml  | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml b/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
> index 499f1b7e03f9..1adbfe5e5461 100644
> --- a/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
> @@ -36,7 +36,12 @@ properties:
>       description: Maximum time to reset watchdog circuit (milliseconds).
>       $ref: /schemas/types.yaml#/definitions/uint32
>       minimum: 2
> -    maximum: 65535
> +
> +  hw-min-interval-ms:
> +    description:
> +      Minimum time between watchdog resets in milliseconds. If omitted, the
> +      watchdog can be reset at any time. Must be less than hw_margin_ms.
> +    minimum: 1
>   
>     always-running:
>       type: boolean
> @@ -64,5 +69,7 @@ examples:
>           compatible = "linux,wdt-gpio";
>           gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
>           hw_algo = "toggle";
> -        hw_margin_ms = <1600>;
> +        hw_margin_ms = <100000>;
> +        hw-min-interval-ms = <1600>;
> +        always-running;
>       };

