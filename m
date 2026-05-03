Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D90379980
	for <linux-watchdog@vger.kernel.org>; Sun,  3 May 2026 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777845222; cv=none; b=VtMkTNhz49TeMCPwvn1coGvGhNvo9JtAcpzy9REgvx59MyXOcced/Gu/Tkv/izHa9Ca4v6aMsfVYa4lh638CECsUPU0MYcGUrSWv+R1xiMJxm8PZPjtucgeapa8ztoWxsfzr5t7wwVNK8Z/RWHsm4MKYqWiGwbZW1qom0meymtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777845222; c=relaxed/simple;
	bh=fTtGqNMdFelOu14dthX73QF8HCqA9HjnKR2prLWlCP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTBi98vF0BMjfmSfw2YoIsm0bHl7ReH0OBkL+7e9QrbwDD3/TTtTqKCtSQ7vacYBlkCMbmV4JgnxveFEruK/lu1Eeaei08nznOEILc8S8I+XBamDCeoFV91gAX1RswIVmOvh9hFPL2Oovm3rFSJKiBZdCwYq3oap4hmnSDoMLgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjyK6M+3; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjyK6M+3"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12713e56abdso2382889c88.1
        for <linux-watchdog@vger.kernel.org>; Sun, 03 May 2026 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777845221; x=1778450021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=poYCsPvXRtKql1L5Wl6xAyIyawTEFN7CU3G3S8BTqeQ=;
        b=kjyK6M+3T1mPZstuoPJ25zB0n/8LShR79rli0Y7vgGAs7LCbIIUegJRDCMopMZy0/+
         U+U/ugqGKovPzFoZYa+156zTqgpX2Zkc0DQjjHSyCigX5hGIVAR5SwrhZN1gP7xB/N9k
         v+vnwQQ1ahrfeEATILDdcb9RQy4kEPFTLKXCIipVsH+3aa72daaFnJCRej/B9+SmDj8l
         dgaddAESJUD2X8AEwyfs0B9/dfV6rjgRR9cFhfmdhNUhs4tv02YEIFmIEcnm0bXON76L
         IncMzUns1SsxOJt7+nAztO3HIEXVYX9pxNlrb2qud1+KYNoruF+i4n0BM1xJxz7e6Kcd
         bRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777845221; x=1778450021;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poYCsPvXRtKql1L5Wl6xAyIyawTEFN7CU3G3S8BTqeQ=;
        b=Ac+TPZe3hFgDKVg2+8Zn7s+nBW0MH1vwkD4qy9cYE5CQEMhxQ2tYwkAvCUrU7Wqv9g
         CZNjWafc0Ul/s8LBuwzEbWH0fo+VEeaHVRhC4nZZXTLU4FUZZNCpu7qh7EiufvARsEWn
         yZ9zB8aKWU9u95f1drbiHYsLPvDlJiKzSOG141keIaxeDjnriMus+27CzCXW7PlYSruS
         ZlvtaJr9MtvUtXpPQtQqXNYVCq+OzI1GTfLPqGP2pqb9gtltQB95+H3o7wtSuSaZOwO9
         iEtCEgNbGO5aLxw/cBH7SD7G582yuOb9bxx6lFbk26k9ZpfSt/Nd3vRo+qzOYFdJeFht
         197A==
X-Forwarded-Encrypted: i=1; AFNElJ8QCWjW9a+eZ+YMwpU/q85FmDF+zqvcn0duSLLvB2hxSs8aFKmKigv93Cw/Khj77VE1eoPHuqEeZd67qMH3Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAHZIiFOUPH7WCfyn0q4a/03owRPORMSHvu5Ir02JbyPSye6AR
	1bZou6gpzjzbBAxsbztSU59TrJpKBpjMqPngoZ7I2w3yznkCEXXR6lKK
X-Gm-Gg: AeBDieuyQmmEdQnJkY4DPfAEvy6iu2uTB1T0tnQ7g13tnLN1Y1yCVL2uwzj+sLq2w3L
	Z0iS0OXW4oNjCpY+SymsdcQoIZXOdlNdE3xcY/qapneHxQ+CW6hlPbpSOT9/it4Ua/77lLuqKqR
	qvWKipmGxYJZV/b5cbAoBfn+Mj1wKCWfqMqJYWgaf07mE2o7nv0iM7EdMFToz1mZ9qOoQgSyEsl
	FyWRIqg9jkChpG8SqzBSNxaROZSBYAhhvEtz+r7Anx+BOZ8YtG+yrKFkG/9CuhdfULChO17t2l9
	NNae8PhM1AEM4GagHeSxpiKP1QtdnShjm0P9ST8y7hITyA4agj6e/1bhUixqOd++0D7YB3GEu+q
	Ol1KUYi2GKYWbYLRpGPvYCGn8KYazRvmDUf1ZcJ7e1Ihu3qyz4FEUK56yhMjvEvcakFEuv4CowK
	X1AxVz11cptlCuM5XoUvlManyY8cGLe3v5825ch7NgXiHVmKjyqjxFAmYM6rgasr/dCxUPs7UD0
	Ua6U2jZhFE=
X-Received: by 2002:a05:7022:ea25:b0:12d:b43e:435d with SMTP id a92af1059eb24-12dfd532036mr2967176c88.5.1777845220347;
        Sun, 03 May 2026 14:53:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df828849dsm11350184c88.5.2026.05.03.14.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 14:53:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d9beb8ff-0ffe-42ff-8249-e12f1a4c2e2c@roeck-us.net>
Date: Sun, 3 May 2026 14:53:37 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: lenovo_se10_wdt: Add support for SE10 Gen 2
 platform
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20260428124954.1193450-1-mpearson-lenovo@squebb.ca>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260428124954.1193450-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 05:49, Mark Pearson wrote:
> The Lenovo SE10 Gen 2 platform uses a watchdog chip from the same family.
> Watchdog functionality is the same, so update the driver with the new chip
> ID.
> 
> Add the Gen 2 MTM's to enable support on the platform.
> 
> Tested on SE10 G2.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

... but you might want to have a look at the AI review.
It appears that the driver has some issues.

https://sashiko.dev/#/patchset/20260428124954.1193450-1-mpearson-lenovo%40squebb.ca

Patches welcome ...

Thanks,
Guenter

> ---
>   drivers/watchdog/lenovo_se10_wdt.c | 66 +++++++++++++++++++++++++++++-
>   1 file changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/lenovo_se10_wdt.c b/drivers/watchdog/lenovo_se10_wdt.c
> index cd0500e5080b..99ff01af4124 100644
> --- a/drivers/watchdog/lenovo_se10_wdt.c
> +++ b/drivers/watchdog/lenovo_se10_wdt.c
> @@ -178,7 +178,7 @@ static int se10_wdt_probe(struct platform_device *pdev)
>   		return -EBUSY;
>   
>   	chip_id = get_chipID();
> -	if (chip_id != 0x5632) {
> +	if (chip_id != 0x5632 && chip_id != 0x5652) {
>   		release_region(CFG_PORT, CFG_SIZE);
>   		return -ENODEV;
>   	}
> @@ -280,6 +280,70 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
>   		},
>   		.callback = se10_create_platform_device,
>   	},
> +	{
> +		.ident = "LENOVO-SE10-G2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "13LJ"),
> +		},
> +		.callback = se10_create_platform_device,
> +	},
> +	{
> +		.ident = "LENOVO-SE10-G2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "13LK"),
> +		},
> +		.callback = se10_create_platform_device,
> +	},
> +	{
> +		.ident = "LENOVO-SE10-G2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "13S1"),
> +		},
> +		.callback = se10_create_platform_device,
> +	},
> +	{
> +		.ident = "LENOVO-SE10-G2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "13S2"),
> +		},
> +		.callback = se10_create_platform_device,
> +	},
> +	{
> +		.ident = "LENOVO-SE10-G2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "13S3"),
> +		},
> +		.callback = se10_create_platform_device,
> +	},
> +	{
> +		.ident = "LENOVO-SE10-G2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "13S4"),
> +		},
> +		.callback = se10_create_platform_device,
> +	},
> +	{
> +		.ident = "LENOVO-SE10-G2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "13S5"),
> +		},
> +		.callback = se10_create_platform_device,
> +	},
> +	{
> +		.ident = "LENOVO-SE10-G2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "13S6"),
> +		},
> +		.callback = se10_create_platform_device,
> +	},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(dmi, se10_dmi_table);

