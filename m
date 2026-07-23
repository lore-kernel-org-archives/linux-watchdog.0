Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650C33B6F4
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783530; cv=none; b=I0HsJberYJT4okUKeN85gCPjNxpOPsZWWLB6S3AKgHYUCkNPqn+ShR4HKhLem7P1ix9WHp5C2tpuVr96mVx4aRN0f2J7nO5OFp7BQXd76EMlEzw7xJXzthKHjE3bT5ky6cT8VD36CeYmBbM16NEJ3l8zmQjNlwoQEnXqnzy+H70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783530; c=relaxed/simple;
	bh=sp0zenaSjYTYAWF8OidErfXvK/gC54aeemvpF2sv40I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6LZPh0krALxrxB/Nhi9kCKbjTrzkmofGl5YuUzSFPZDBQrFatpyXizBieUJMB25haKsCKwKLjI1vMwlWu4B5M/5V0Zh9QTs1tpHN/YTA18Vp2+K9bV2ly9k0HYcOvc+g/qNqC1VthxFbAxHj1mXlrdo8TvGs3pIjG2GIE0UXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAKb1Pl1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAKb1Pl1"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb662575d3so142718a12.0
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 22:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783528; x=1785388328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQl72L56ANhTo8erID3s8JKmjpf7jGxP9P7gDHBEwV4=;
        b=pAKb1Pl1NOjRNQyca3ecEjT/ZTHbe9QLdmq5tvvx3ZOJGP8+X/31pcB0SGH+h9fvM1
         L8RUMqf9zXzBErmF4u3/zuFkO92uEoOSuHztd8BSQGhqpj+SjtfVkcg+3/1Pc7Hz17ri
         yXqAuwX2p1pXcBdC6Jc4mkmiio36VsJeCaENjoXkRrdM5KosA9qXUNHhEyDCVnKPCMyN
         1T67CGXbtN6X8Ju4ZWmpPLLdqutixhZ8MMwUwZoeKzDfma4vvp7yjvJzopJLMt3utimF
         jlX4eRYvNgF279Jad545WX4b6eA+QDJ42ufJPR2LU2i+hSB7Z6TAxeVP1rziuLBMLJY1
         8xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783528; x=1785388328;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lQl72L56ANhTo8erID3s8JKmjpf7jGxP9P7gDHBEwV4=;
        b=lT/8vvVaDlurbXiexmgZMlyZtElo6n0emqmxjkxl9yUrVpM3iZLfbWOfN7iSLqDTmY
         +NfgRMl2j1nbXeddBmo+kRlDgawsSZkzMm4HvAvxlPwYCXKHOggoQCR4/HFQHl3tLSN1
         H27J7lNYLSQ07oq4rRgkedBqCzhGRuQ9jtWYpPJMoHtu75C5RiQNAULNTuWO/iujdTZq
         aff7LUxcIwgBVGXfFeRjaFW+Bh91dTq3lhFfYNzpRnombdYuzYHxTzce+RVbbSEHAvjX
         wpdlZ93rwlqJRWSoI701CwYdoNm6bdwVVZkUjKCsR6P3zf+pJKkF4+sr+4Z8IsggHtIU
         2K7Q==
X-Gm-Message-State: AOJu0Yzcwgh56DAbIy+bC4vyAcUViR1GAC0gA0R2POw2/ewv9pTukgdq
	0F1dmPSNG3YGDVt9CPcZann86FgS1UBoWAHQwp++0ZFdbiTOP8yELAjr
X-Gm-Gg: AR+sD10dJnnXoFSP1RJ48l9wnpTeoGxnkQk/kH8UY0bQV21E+Qju9NZ/cw9DUSLkXNB
	cR8VMnSJQu96GzBJgdePNBQk2csYK6BXHGTwa1a3cYLU6Ox4jF1ynJ+7SRh3jntDbTF912mZjOR
	HLATTjkT8QbxbvoFvD7pdWbzLQEW+a5/1NXxD8vJ5/f/SbNlqHIWS3+jh0WX1nU3BBuOWKXBu3c
	4BOeDCwKp9iqHafkUBHBDUbOnVzXT29+XU6xKAkDNh8n7iPADuqHiA3Z1NFAfAC7TRKvwP9J/nz
	D+pDbwsYxoV54GSF24erNbKVjRI2IwJ7pmLyVtpTt24rB97R3GkCGjo6HkA+86WHpI8YAodBuH+
	PqyT57TBVHtI7Yu9zTKncdyDGp4KqgQ8ZPjZVc9mCNET8Wt8vc+SUMbxvzVWNCt47uSQAnPwu6J
	ub04HQJCY6UIAT2WLyIeX5/6WnNQCsRhUMbR+xWsno92k+8sFlsek=
X-Received: by 2002:a05:6a20:4313:b0:3c0:9c19:b271 with SMTP id adf61e73a8af0-3c44b2616efmr1825370637.63.1784783527954;
        Wed, 22 Jul 2026 22:12:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1b6a45sm14908156eec.28.2026.07.22.22.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 22:12:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a3660418-97af-4085-ba2d-8488eed1fd23@roeck-us.net>
Date: Wed, 22 Jul 2026 22:12:06 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: atcwdt200: fix return value when watchdog is
 enabled
To: kr494167@gmail.com, wim@linux-watchdog.org, cl634@andestech.com
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723022634.8642-1-kr494167@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260723022634.8642-1-kr494167@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 19:26, kr494167@gmail.com wrote:
> From: Surendra Singh Chouhan <kr494167@gmail.com>
> 
> atcwdt_get_int_timer_type() returned TMR_UNKNOWN (enum value 3) when
> CTRL_WDT_EN was set in the control register.
> 
> Because atcwdt_probe() checks "ret = atcwdt_get_int_timer_type(drv_data);
> if (ret) return ret;", returning TMR_UNKNOWN caused probe() to return 3
> instead of a valid negative error code.
> 
> Fix this by returning -EBUSY via dev_err_probe() when the watchdog is
> already enabled and update the kernel-doc description accordingly.
> 
> Fixes: e4e0848ad046 ("watchdog: atcwdt200: Add driver for Andes ATCWDT200")
> Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
> ---]

Change log goes here. Do you really expect me to look up the patch history
to figure out what changed from v1 ?

Sure, this one was recent enough that I happen to remember, but
I seriously fail to understand why people can't be bothered to
add a couple of lines here to explain the changes they made.

Guenter

>   drivers/watchdog/atcwdt200_wdt.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/atcwdt200_wdt.c b/drivers/watchdog/atcwdt200_wdt.c
> index 8e3b18aea368..7e757c217b0b 100644
> --- a/drivers/watchdog/atcwdt200_wdt.c
> +++ b/drivers/watchdog/atcwdt200_wdt.c
> @@ -260,9 +260,9 @@ static void atcwdt_get_timeout_params(struct atcwdt_drv *drv_data,
>    * register to determine the interrupt timer type supported by the hardware.
>    *
>    * Note: This function must only be called when the ATCWDT200 watchdog is
> - * disabled. If the watchdog is enabled, this function returns TMR_UNKNOWN.
> + * disabled. If the watchdog is enabled, this function returns -EBUSY.
>    *
> - * Returns: The interrupt timer type supported by the hardware.
> + * Returns: 0 on success or negative error code on failure.
>    */
>   static int atcwdt_get_int_timer_type(struct atcwdt_drv *drv_data)
>   {
> @@ -274,7 +274,8 @@ static int atcwdt_get_int_timer_type(struct atcwdt_drv *drv_data)
>   	regmap_read(drv_data->regmap, REG_CTRL, &val);
>   	if (val & CTRL_WDT_EN) {
>   		spin_unlock(&drv_data->lock);
> -		return TMR_UNKNOWN;
> +		return dev_err_probe(dev, -EBUSY,
> +				     "Watchdog is enabled, cannot detect timer type\n");
>   	}
>   
>   	/*

