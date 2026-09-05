Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24D44C510
	for <linux-watchdog@vger.kernel.org>; Sat,  5 Sep 2026 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596750; cv=none; b=Rv2GFj2ZTcgHbhmKNH2RazmRKL4mCl2jtKg74JDpQHgMFOr0DPBmjTk42Tv/E83i3P4UERKo6dIFjMm0XpbsAJfQBdwK6EOhSoMVFkudtCbykyQLxq/rkmc6YtsjNXMXWE9Q5hxrRMsIpQnErtrD1wiPMbRsfV5gH8YRKcmjjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596750; c=relaxed/simple;
	bh=OviR5kaHs976PRzULV1vC0IpWTkvgJa0y9VkRRzLNZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+uUc07FXlBYqbZeQrFz5Z3ogTj616b5ajAs9TC04nnZSX8VDCcnEr4Sc1rZMDsOv8yMA8TNipmm0sKXSY+xOt+ByDTLZFLBlAsmn5EydwZpuNpDCOCvOjQbPwdbeG5qYlq+HST4IQA7nK5Q19vyE2/1yDWBvPJ8EnQW0bDCAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUzs1Vjh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUzs1Vjh"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so1198989a91.1
        for <linux-watchdog@vger.kernel.org>; Sat, 05 Sep 2026 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788596743; x=1789201543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4JWIpadkBBtpyHMGkKKLMv6w38PE5gnqdnr/RtDlQw=;
        b=cUzs1VjhW0s0igUPqsohFtn2jCWJ+jc187XwO03Ztix4UldNcRd5jQ10HbIHlsVe1I
         XrvkpTD2nBZ8UTwKwBYjEU73PCZD4LesdY/nFcdW2SsW09m7l7M3gzneZs8YiSI7VvfN
         RCM2CV5Tl0cQlU8GV0/2Vl9nszyE9BPFaad4zF5Qkg9Z+Ysqfhv81hqFHJ9TeATzLbUO
         Wq1f7V0i1VD9pZFOvn0Az2M45PAXfDrb45pnMVx5e/fv3RiN/JR9yQLhG6qC8vtRXwvk
         +abBPoEjSDz6dCGi5BJCwLje1twBF5epG6T6W43tmP4IRWC0bIjlEg982rRiUxjMrNrm
         yRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788596743; x=1789201543;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4JWIpadkBBtpyHMGkKKLMv6w38PE5gnqdnr/RtDlQw=;
        b=gM4BlZfeFOGSjgfShFgPOVfAMOclyKJFPxn3bsnmsuq6uxcdWKt6C3xdkONLOeZolg
         WazQb555FhH7hBmoLI99uJxetzmRyjwAQDpv0pVG5Veq0AETXNU48hVSnhTYE9yClW8z
         kaeKPAjLXylJa4HPApDJC+0YgzgnJJVqrko9WAk3IipskDH1SZoyiHVK7uQmW/8T8swo
         A9eWms5exql72JQQKPm8CyUEdDOI664Lb4hOT9agMHXNMC12RFI9kW+iYVeq15y3z8uU
         aiWYyPJV4Zn/mLGV3ihA/ms9fB4PQHY0U9lM2P1NXXaKp8RvQOzcF8bCxuhm+MEvCkWZ
         rbhA==
X-Forwarded-Encrypted: i=1; AKwUvBziZ0/cJ3BncbDkEC52LMOyJEz8nOBIRyyTxG+hPTzntMirlaFAyhdJSKHlP9X6Ls6HZmISTLUA8gvxuA7Nrw==@vger.kernel.org
X-Gm-Message-State: AFuF++ll1l7vhh90ClKma+oUBdZ7tMoZDzj06GIZM6T13Bd96y7rA/LM
	EtpEnoVIZiTQB+yT6OtAc1MKmpI1SlLrdjMEgsyYfqZsS+TMiqTGsuBt
X-Gm-Gg: AYBFou1oei6MG0OEGees/d48QBI3o80pz014gAVI9irBkAx5wvISNJZyVqL5ySeJzU1
	FfztiZlj9Svophtn+/Q8Xbs5CV0LsOoDS1z6h9bylZqN9m4CgrfbrkSrAcfV4zGO8CBNK9jxCpz
	QQWLH++6t+StsQxvoiP5SDFniPMVHhkT1pgTKdef0HGoegMdmZXyezXEKzWUqXA/zQjw3leWEBy
	8/rlXzT1kIWpT0h5aaSWOOGm4OvAFivEBwjyYJ9i0Al/TV82IbG9bhWy/5OobNRgHhFTw2omzWP
	Vvp6lb08GdZhpRdZiHIkewQoA/tNxGYQXXn+Cr88sofj4HrNAQEK0N7c2rdEXgWdiWgAcIWH8MZ
	UNQEzmFQJZinzZ9xkoJXdj7hoQdtbicElSHm0+WTugRlJqFz/d0MTAKHtXPh7DZ8xxJVyz0woem
	rgRCZIuY8ePPM6Z/eZ36crxej9tN3AoeR++HV6Etnsb4GJ1+4EbjRpregaSuHmi63pM0X9LRb1X
	elwhA==
X-Received: by 2002:a17:90b:17d0:b0:398:9bd4:d18 with SMTP id 98e67ed59e1d1-39b26298ba1mr15383737a91.23.1788596743161;
        Sat, 05 Sep 2026 01:25:43 -0700 (PDT)
Received: from [192.168.1.107] ([223.122.38.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm14262328eec.1.2026.09.05.01.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 01:25:42 -0700 (PDT)
Message-ID: <4e65ef39-cf1b-49d4-a899-da36acb442c2@gmail.com>
Date: Sat, 5 Sep 2026 16:25:36 +0800
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t8140 compatible
To: Yureka Lilian <yureka@cyberchaos.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
 <20260904-apple-a18-pro-initial-devicetrees-v1-4-0c25401d165d@cyberchaos.dev>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20260904-apple-a18-pro-initial-devicetrees-v1-4-0c25401d165d@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Yureka Lilian 於 2026/9/5 凌晨3:49 寫道:
> The Apple t8140 (A18 Pro) SoC uses an AIC3 as interrupt controller, same as
> the M1-M4 SoCs.
>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
> index 1cb886785173..e3cadc5ad39d 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
> @@ -46,6 +46,7 @@ properties:
>                - apple,t6030-aic3
>                - apple,t6031-aic3
>                - apple,t8132-aic3
> +              - apple,t8140-aic3

the title should be "... Add t8140 compatible" describing the hardware corresponding
to the added compatible since the compatible being added is not "apple,t8140".

(Alternatively, if you mention the compatible in title, say "...Add apple,t8140-aic3" as
"compatible" is already implied)


>            - const: apple,t8122-aic3
>        - const: apple,t8122-aic3
>  
>
