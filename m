Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF2472766
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998853; cv=none; b=XE4x8XOLspUhdVkEjKAzFrpcwQgGl2NREhwK3cHbMUkFir9CadvyzcUDzZFvkAE3jtOnDki4blWnM8HdTq+8OsZq/HaDVwEeY0Lk2orOqMcROdh5MgWmx3Ysia2JkMzU+M8IIHlQdklNgD92/TAxsl55s+l7EeXmxUR0yRBbfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998853; c=relaxed/simple;
	bh=wrA+PLIetpYeKZ8zBcJQ/y6ub5lPQ0p5kSVE01rnDbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NU0jYith+bECFh9pnGZpffj7/jdKt+MRhFCU7Hk+yC5Iu6XQ1yrp4YNvRhDiOZ72fZHulf1OK31E4kMtcFJvYRGM8tm/l1w6eijJpUtSfQvGRonemzse6KrA9CxGsRE/do1K2p8l7tODqGTV+jFWjJrH/8imvAcBATTx3uTdC8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcsxH8+A; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcsxH8+A"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9f10fa7a3so18082355ad.0
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782998851; x=1783603651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HkJV4t2Q3WumemKSNghv3Qs16wNZXjcG2O2QWDXDG/4=;
        b=CcsxH8+Ahr3WN3VSQHeL3vxdNawIk+c3rJYIlVzhiC2api0x5aLo2KK7iyn/IBn5m0
         VOFlNLabYctMbGDCRrhDk9rWKSdEm6jqoJG4atVK00aRULghSC/Yz7P7ZwH0mjspUxNQ
         9HRVYGsGb5uJOPkIQbK46RBjCE8/iSnsr2eOUF5IIQsl28ngNrWH6vPoypN2cAT3knL+
         tjnEQRHOdYobxn/EwmKwkvf18aW5/mK/W9rlh7o05BA96TBX3RI0Ju5J7z2Ac7e+v7CY
         NQEV4Rt4YwqH8ztAQJ0SLHOaXy2js2i8Y3hWNpxwfYS+IIz/6pn/zPb64IZ9shr4+vy8
         e/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782998851; x=1783603651;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkJV4t2Q3WumemKSNghv3Qs16wNZXjcG2O2QWDXDG/4=;
        b=OH97ldfD+6Js8Zils4mpco7avEawcrhtWwJ6UR+SX1Ts3S/vMM2Ta1NKvalneIQI1+
         i6tGhTDs8w0ETkHh3GzJWjwqZeOxy4w+VF0hG/9hLIONkxxuNQHFj3pexJX9jqngLPL0
         tYQ5c977oJ1+hm7Z7qDNrWcd0bf/Nuy2BsD6aTacjC2Q/U4YKxATxOs/3bCzOB/qrHC8
         nuLW0rfsGWg48fvN1xDseiuko+74G8+IGYRw7J6Z9DG7KJ9G5yEHa9iynniT4eBsfDeX
         5yqgn7xidyomfshGBQJ6+36hRrYFWBgPkL7KOWQeDvddO5KFKbTYf1GHstirSkabgqYh
         LWaA==
X-Forwarded-Encrypted: i=1; AHgh+Rr72dFQQ/vh3bjhxP5DHD3O70KRxarR1pbBufYKlHAohE9SGKuc5vygr0MPl1WsZpI8kgQwvTxYi7insMQPJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyULMHd975vlGeVux3KUDVkDobX8VxgTvm/U4xZPtQO9SxIluFY
	EcuRK4s5k48lNgePEtOChyUAUknMaSuu/ctcuJowr1sCQTkZr6OCLAp1
X-Gm-Gg: AfdE7cnQN4hHPZPE9HU2V5GosnBBqtGownCezl2VGKAp+m3mfaOoDH7nONchPKqKxdu
	STuSubDj+RZA7//oNVwvA9AcWqZyvhK9z2Z5BvuO5WLpc4J7eyQFsUsMkitzqMCAZK1YXzwD2tw
	S22vnfQkYmWI6JWhSocy+z+LZlyzY15k8RnDoFEU+hWkVE9dATSfBxu9c5pDlM0+IIezSHpIlH9
	tEyF2N426D4cMsbvQy9fWehwohD2GBa1ikG+mghTb0xZ2Par9xTAZtxEDeTY8T0VSQbXlVqnmuv
	Js8iD9szUCQ2byGBPp4w3+kKPS1+61GkKywpawWW8JwNKkF1iaohz0gVoim8DHrt8NlNjSBwZxc
	cdhXdaqtZIaQxmMKyn7TAG8MkiAMLeSoHGcTOwrBhUGhKrIBY1+qeWXzGpbEqDRfQ3xHQRTcvqd
	qpNKJRQLEcmWdj6hRaRhcmBGmPyG7swV1FfvTFh1CwOYC/owV0vbDlejh5YijUKQ==
X-Received: by 2002:a17:903:284:b0:2ca:1ad7:2ce6 with SMTP id d9443c01a7336-2ca7e75b9admr63943555ad.27.1782998850612;
        Thu, 02 Jul 2026 06:27:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9ce5d9sm13600845ad.51.2026.07.02.06.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 06:27:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c3ef312a-4c26-498c-90c8-118c6dc035a0@roeck-us.net>
Date: Thu, 2 Jul 2026 06:27:28 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 7/9] watchdog: rzv2h: Add syscon support for RZ/T2H
 and RZ/N2H WDT control register
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Magnus Damm <magnus.damm@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260702123112.161160-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260702123112.161160-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/26 05:31, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> On RZ/T2H and RZ/N2H SoCs the WDTDCR register resides in the second
> region of the System Controller (SYS) block at 0x81290000, which is
> shared with other peripherals. A dedicated SYS driver now manages this
> region and exposes it via a syscon regmap interface, making direct
> mapping of the WDTDCR register by the WDT driver no longer viable.
> 
> Update the WDT driver to support both access methods to maintain
> backward compatibility with old device trees that use direct mapping:
> 

WHy don't you convert the driver to use regmap first and then just
update the regmap pointer for syscon support ? If that is not possible
for some reason, I would expect to see a detailed explanation.

Thanks,
Guenter

>    New binding (syscon):
>      reg = <0 0x80082800 0 0x400>;
>      renesas,sys = <&sys1 2>;
> 
>    Old binding (direct mapping):
>      reg = <0 0x80082800 0 0x400>,
>            <0 0x81295108 0 0x04>;
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - No change.
> ---
>   drivers/watchdog/Kconfig     |  1 +
>   drivers/watchdog/rzv2h_wdt.c | 96 +++++++++++++++++++++++++++++-------
>   2 files changed, 79 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 08cb8612d41f..c48293f93ff5 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1007,6 +1007,7 @@ config RENESAS_RZV2HWDT
>   	depends on ARCH_RENESAS || COMPILE_TEST
>   	depends on PM || COMPILE_TEST
>   	select WATCHDOG_CORE
> +	select MFD_SYSCON
>   	help
>   	  This driver adds watchdog support for the integrated watchdogs in the
>   	  Renesas RZ/{G3E,V2H(P)} SoCs. These watchdogs can be used to reset a
> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index e9545b8f5fd0..e14ff853a4e9 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c
> @@ -8,10 +8,12 @@
>   #include <linux/delay.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>   #include <linux/reset.h>
>   #include <linux/units.h>
>   #include <linux/watchdog.h>
> @@ -45,6 +47,10 @@
>   
>   #define WDT_DEFAULT_TIMEOUT	60U
>   
> +#define RZT2H_WDT_MAX_INSTANCES	6
> +
> +#define RZT2H_WDTDCR_OFFSET(n)	(0x5100 + (n) * 4)
> +
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> @@ -65,6 +71,11 @@ struct rzv2h_of_data {
>   	bool wdtdcr;
>   };
>   
> +struct rzv2h_sys_wdtdcr {
> +	struct regmap *regmap;
> +	unsigned int offset;
> +};
> +
>   struct rzv2h_wdt_priv {
>   	void __iomem *base;
>   	void __iomem *wdtdcr;
> @@ -73,6 +84,7 @@ struct rzv2h_wdt_priv {
>   	struct reset_control *rstc;
>   	struct watchdog_device wdev;
>   	const struct rzv2h_of_data *of_data;
> +	struct rzv2h_sys_wdtdcr sysc;
>   };
>   
>   static int rzv2h_wdt_ping(struct watchdog_device *wdev)
> @@ -89,9 +101,18 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
>   	return 0;
>   }
>   
> -static void rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
> +static int rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
>   {
> -	u32 reg = readl(priv->wdtdcr + WDTDCR);
> +	struct rzv2h_sys_wdtdcr *sysc = &priv->sysc;
> +	u32 reg;
> +
> +	if (sysc->regmap) {
> +		return regmap_update_bits(sysc->regmap, sysc->offset,
> +					  WDTDCR_WDTSTOPCTRL,
> +					  start ? 0 : WDTDCR_WDTSTOPCTRL);
> +	}
> +
> +	reg = readl(priv->wdtdcr + WDTDCR);
>   
>   	if (start)
>   		reg &= ~WDTDCR_WDTSTOPCTRL;
> @@ -99,16 +120,18 @@ static void rzt2h_wdt_wdtdcr_count_ctrl(struct rzv2h_wdt_priv *priv, bool start)
>   		reg |= WDTDCR_WDTSTOPCTRL;
>   
>   	writel(reg, priv->wdtdcr + WDTDCR);
> +
> +	return 0;
>   }
>   
> -static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
> +static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
>   {
> -	rzt2h_wdt_wdtdcr_count_ctrl(priv, false);
> +	return rzt2h_wdt_wdtdcr_count_ctrl(priv, false);
>   }
>   
> -static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
> +static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
>   {
> -	rzt2h_wdt_wdtdcr_count_ctrl(priv, true);
> +	return rzt2h_wdt_wdtdcr_count_ctrl(priv, true);
>   }
>   
>   static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
> @@ -158,8 +181,14 @@ static int rzv2h_wdt_start(struct watchdog_device *wdev)
>   	rzv2h_wdt_setup(wdev, of_data->cks_max | WDTCR_RPSS_100 |
>   			WDTCR_RPES_0 | of_data->tops);
>   
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_start(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret = rzt2h_wdt_wdtdcr_count_start(priv);
> +		if (ret) {
> +			reset_control_assert(priv->rstc);
> +			pm_runtime_put(wdev->parent);
> +			return ret;
> +		}
> +	}
>   
>   	/*
>   	 * Down counting starts after writing the sequence 00h -> FFh to the
> @@ -179,8 +208,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
>   	if (ret)
>   		return ret;
>   
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_stop(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret = rzt2h_wdt_wdtdcr_count_stop(priv);
> +		if (ret) {
> +			reset_control_deassert(priv->rstc);
> +			return ret;
> +		}
> +	}
>   
>   	pm_runtime_put(wdev->parent);
>   
> @@ -196,9 +230,10 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
>   			     unsigned long action, void *data)
>   {
>   	struct rzv2h_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	bool active = watchdog_active(wdev);
>   	int ret;
>   
> -	if (!watchdog_active(wdev)) {
> +	if (!active) {
>   		ret = clk_enable(priv->pclk);
>   		if (ret)
>   			return ret;
> @@ -242,8 +277,17 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
>   	rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
>   			WDTCR_RPES_75 | WDTCR_TOPS_1024);
>   
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_start(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret = rzt2h_wdt_wdtdcr_count_start(priv);
> +		if (ret) {
> +			if (!active) {
> +				reset_control_assert(priv->rstc);
> +				clk_disable(priv->oscclk);
> +				clk_disable(priv->pclk);
> +			}
> +			return ret;
> +		}
> +	}
>   
>   	rzv2h_wdt_ping(wdev);
>   
> @@ -264,21 +308,37 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
>   static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
>   				 struct rzv2h_wdt_priv *priv)
>   {
> +	struct device_node *np = pdev->dev.of_node;
>   	int ret;
>   
> -	priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(priv->wdtdcr))
> -		return PTR_ERR(priv->wdtdcr);
> +	if (of_property_present(np, "renesas,sys")) {
> +		struct rzv2h_sys_wdtdcr *sysc = &priv->sysc;
> +		unsigned int wdt_index;
> +
> +		sysc->regmap = syscon_regmap_lookup_by_phandle_args(np, "renesas,sys",
> +								    1, &wdt_index);
> +		if (IS_ERR(sysc->regmap))
> +			return PTR_ERR(sysc->regmap);
> +
> +		if (wdt_index >= RZT2H_WDT_MAX_INSTANCES)
> +			return -EINVAL;
> +
> +		sysc->offset = RZT2H_WDTDCR_OFFSET(wdt_index);
> +	} else {
> +		priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(priv->wdtdcr))
> +			return PTR_ERR(priv->wdtdcr);
> +	}
>   
>   	ret = pm_runtime_resume_and_get(&pdev->dev);
>   	if (ret)
>   		return ret;
>   
> -	rzt2h_wdt_wdtdcr_count_stop(priv);
> +	ret = rzt2h_wdt_wdtdcr_count_stop(priv);
>   
>   	pm_runtime_put(&pdev->dev);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int rzv2h_wdt_probe(struct platform_device *pdev)

