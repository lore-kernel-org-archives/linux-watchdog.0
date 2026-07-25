Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95E30AD1A
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784989713; cv=none; b=dLAJ07QQ2Kcfidcc3t2GWbaH/NOLX1cJRWvVCe9qhDILOHUOSUtpWVJwOeftlAVrCGWEGo4S9UinJKwz4mj5ACbJC3xbKS1R9rYUW6c4GBmbeMX5zQxRjEl47DSCvpsu9Xr3Lf7j/AiXs6DB4KW1o6Phwlm3ZA3WeTERztGNU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784989713; c=relaxed/simple;
	bh=pQGOuGM8nQdQXgwGqgXaprbqUTN0rVKbqokO+RZcsxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdGIGldhvRyhTnb59o4RR/JCbyR9zHgUzkSfBsPsGTK7+Cw3DsR02GtUG3Nzb4MH1ytjnioZXdp1DRYd/i6Lbf6Zt9g3jbWSzIrZpJ9nV22C9ykBfmMosdKWc3k+6g7wUyI0XvmdnbU4kwOn+EnL54n8CE7p9/Wcu019M8R7Dcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdxwUiBp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdxwUiBp"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38101f85591so2199046a91.1
        for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784989711; x=1785594511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FC1a1AYlU+R/P7tPLNI82w2LrP2mji2zuzNnbAHHivE=;
        b=fdxwUiBpuen7v+lhJKDuxzCAimjVdmmfpEPUoFg7f9cmnJshReKxL7UGD58Z7D0cAx
         j2BNwFPMh1Sd5DRBECdGtUlrNQY5/E3dtge/U8Ybzx+LVvC8Fr7NRuuL2X2yVuqgwJVX
         eO7IECA0rrizRufkz9HI2b/RD8gO3ucWNdopPog2LUR5P1vAtYXyr39/Ucz2ZMsMlSf9
         GXHqByikLKSl17XOJpyzbb0QBvO4PVMoUz1U50jD6nL2nAnUgM3cClACP3t0HhVMjNMh
         cv6AU35+ANm8ddlQtR1Xq5jg658z/KuQkj4fVOk2IjMVOGZkxd/hB517CeEEdoHGAT++
         5rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784989711; x=1785594511;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FC1a1AYlU+R/P7tPLNI82w2LrP2mji2zuzNnbAHHivE=;
        b=VD+Nv01dzS+ICuUksYWiz5pfX4jieRUMAzlp8kLiFkqBS8xc8BhaYAXuQ6To1YpXKt
         bC/yaX2nBymgHPpzzt5B8EM9oIqlwN8fNE8nKtlQYdY3QyXLM/A65Bxi00pftxZiBZMa
         oHZA79EHz1XdNO6cBT4jm1ss2ZvTmDj2oA6RAs2N9OD8hywzuWXXahML9gk6MO6NcofT
         IkLJuObS0pkmxkGY2dbTBP9z/Pj6hUf3Yedh5AvCeCI+wwp5YgUV+tgouCDFw0YZobzd
         DVKKWhXBCbGFtEbSuT47TJFgmgGW7Nkh1jIV1xwmbkMy4ICOfg45vsBZP3zobqSRxjRS
         OS1g==
X-Gm-Message-State: AOJu0YyN5/g/akXPqfzcuQS6iL79D5VzTBjhb5UrFzARbFmjhyp3GN8V
	kvvD7MkN4YCskGDsQSqIAggP2SCzXvN/Vc+MaYYsRZzns/ytVIRpQcw2
X-Gm-Gg: AR+sD10Tb6Y4gPP57XD/0YB7DxQ4ztRFhmQUIyRKISx+8mSdAUxvfiugYz3xd/DQAvl
	0TqzYoFYgRAymuifmaBHeQgrTFSbhY4v3gDlMcwo+ZhuXCclJQkZqE4RApTU6JjODuCIv8xCEtm
	BUNmlf5mDT+AiAZZ6nA4avWGyIjCuk6CfQYEpNzX+ZLb50mw3R7vCGKY8c2Oo9jutEZn3C2FMJ5
	fLsHTXRnv4O58zC9LMFLht4+aM75c0Je+nIY0O/AcgQkoCIgUvHwbDYhmlsj0tvSyOTORsG8niX
	BiqiMPT2p/bdhdWP1on1yXwEzUAEJEH+bF7JV6AcbCHuour2n6frrCJDuTyY21QZwyK7cTyfAxm
	GLHbpAyMhq4VW5DeAImfXTEm0U4BxwRrt3TleKDnAqPQhcwvRj/DgOhyDYZdqk9vOdKLPt4Op+j
	GM011tfwI2wLvR7DcW8MON5mVWiQwgxJ5V4v2WoC4sJVH214Sv7IQ=
X-Received: by 2002:a17:90b:380e:b0:37f:e5b1:ec4b with SMTP id 98e67ed59e1d1-38f1eaaa3e2mr5180240a91.5.1784989710855;
        Sat, 25 Jul 2026 07:28:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130cc5ebsm47367345c88.12.2026.07.25.07.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 07:28:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a367bd8d-17af-43a6-8e5e-1aad24b1015a@roeck-us.net>
Date: Sat, 25 Jul 2026 07:28:29 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] watchdog: w83627hf_wdt: Report all initialization
 failures in probe
To: Paul Louvel <paul.louvel@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
 <20260725-w83627hf_wdt-improvements-v1-8-4e9a1b4e8297@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-8-4e9a1b4e8297@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 03:29, Paul Louvel wrote:
> The driver currently logs an error only if the chip initialization
> fails. Extend the error reporting to all failure paths in probe to
> improve diagnostics.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>   drivers/watchdog/w83627hf_wdt.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index 90d41f21aa5e..cf1a3fb3a6fd 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -479,12 +479,16 @@ static int wdt_probe(struct platform_device *pdev)
>   	pr_info("WDT driver for %s Super I/O chip initialising\n", id->name);
>   
>   	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (!res)
> -		return -ENXIO;
> +	if (!res) {
> +		ret = -ENXIO;
> +		goto fail;

No way. Use "return dev_err_probe(...);" instead.> +	}
>   
>   	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto fail;
> +	}

Not for this one, as Sashiko points out.

Guenter

