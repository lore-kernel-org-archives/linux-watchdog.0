Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5C3B0AF1
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276860; cv=none; b=mBcXKxVzFbesen9n2j6LSJvjYw1B0lU1bHP7DhdCK0GNioKsm5j9yK+fCERI58GWcyoE8zfQB/rJOXXefbkQyMFbURAdRkZ3U0nGMdVPgCDKwUTOauBo0jREsI1hG96jrX2So/7bBv7iOFxS770W0QZDM5k2zFegNS/fNv250Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276860; c=relaxed/simple;
	bh=2HYTb0v46JJReVzWRZ8ta4mLH4Pcnp13cEeRyFBwIVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMdjjgs/z7n6b5kV/Xm/C5jxbH10TbsRecA8WtUxizBHi9WbKhPt5Tj1yPUiFhUFapHDkXASLIh3PDDGkdSzMtiSitWZVx4VmrViMVa+Bh4sRQqyEAIc5FaOOhK9YovgykD8PrcUqWOGP9vN/7kJMqWN7XVjhjMNilJQ+ucnR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj8jpwBH; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj8jpwBH"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba895adfeaso261423eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774276857; x=1774881657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RF/ASTXorC1Yfhc6nVN80YYeNSMrW6Qe7YXBp1CjIco=;
        b=Kj8jpwBHfbzyqIVFU7LZlM4E/7iQHS6yCox/Pw0tkx7/6W/JtiisKQ7rp9dlAJQZI/
         DNdBGnDd0SdvSvcGBkP0zyxNU1O2rTw8v+tmR6394DIGhKyBnKVcfij654fNEcNY2p6f
         Cy5ApipOFMFfIjSgXTv87r7dDwW2eMeNKA7oHLhWirW4x/FA7+82YxkP9NmbclX7s/0n
         xAh3vaS1ZQMYTAgN0zAuY5Ws6+KLaKNB93ysqfC+bIEHSQ6RWh30vGW7J02t+63ke13f
         WqprdQK4u/1Bj+aHKSQTrkoPHQP8BG5FEFSO1rIYdGYYGocbvHUg+8IfDI0VZI0PwjQp
         rsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774276857; x=1774881657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF/ASTXorC1Yfhc6nVN80YYeNSMrW6Qe7YXBp1CjIco=;
        b=W6CNn5FddebGicJzo39qtE7Pa5Dso9PzRnhB9ywuDUGcS8CEdjAQvWrnWgu2B5nXU8
         lj1qGUP5Xpx8bl5ny6KrS29ulGFRMrWPqRfRoYAED7Pt9533lPdlMu7aUaewPL0GIo0c
         ZjpwCDjjHDNVdc7uOzWPxGDjuvkhxw0zzX6n+I807MXlfHg4Fw4hVuUo74zhtZlO6y4D
         333WWhFCaUlF2Zr7BubUgih1ZcrG0CxuI/VZRCvngGI0pG6Z1IVCriFPA7n3tJPPOcnw
         +QQ1EUsJGraweLgPuLurLUyinCDuUlMgGqJ8UfyqXBAjA9zWPkDS47vAeFHqqcwjUP7A
         VsSQ==
X-Gm-Message-State: AOJu0YyBTTj0Fvc9PxZA5H9x20+1TZww1KPPsj2GpTAjtnszk7nXEZHh
	m9oiZNRBWoNfDaGMx2PvemxdfwxW3+InkOLzhqsMqZeUacycGOiI++ME
X-Gm-Gg: ATEYQzywHf1SXjqIZzcP8teSA8h6sMb6gKTXl9+8QB7+eqkZzZ4qRrLPOgLmpQ7CzKB
	bar71Gc3FN3enk9DrD5okiyxe4ltaj1Ya8CYsOlrAa8QhPbYM+v5vdEP8Mm7+yKi6AXb4CUfUB4
	+K09cNP5Ljl/3rX1g1YwvAVct7fAH+9Qk95pvJyM5l8J2uunLqCQi4ttfS8TlI5Bga4moYiEGv/
	jMcGmp8lYny46D04Wkmn1UPEF8yDFJJpT5PW8KoqUwG1HuWfg4bYo4dPWBEhgWBMEWW1zHDqzRG
	iacaI7G3TGj47ojgwTCLSiY2hvi6EjB6kV1xqh+EXkYzBT6HR2FbhexUwtbxB4zRww+LJVgKpdC
	vp/ONQVJjx/UEpiW2//2fllGj/BZTJkZdLvfYEfoOjQ9W0x8TeluHSJRj9su422pg9RbkSgoFsf
	IsDJqqHkUVQ+h4+91vDEnMY//VN8g1oguJKsnNcEk7qEOv9967TWB0TrQUOI/atp0hG3lUl8//
X-Received: by 2002:a05:7301:6794:b0:2be:723:a9b0 with SMTP id 5a478bee46e88-2c1095a5b8cmr6038980eec.5.1774276857139;
        Mon, 23 Mar 2026 07:40:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14caf3sm16899917eec.5.2026.03.23.07.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:40:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5f723be8-1a9b-471f-9921-bcb498578e43@roeck-us.net>
Date: Mon, 23 Mar 2026 07:40:55 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/1] watchdog: menz069_wdt: drop unneeded
 MODULE_ALIAS
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
 jth@kernel.org, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
References: <20260323112413.21923-1-dev-josejavier.rodriguez@duagon.com>
 <20260323112413.21923-2-dev-josejavier.rodriguez@duagon.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260323112413.21923-2-dev-josejavier.rodriguez@duagon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 04:24, Jose Javier Rodriguez Barbarin wrote:
> Since commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
> the MODULE_ALIAS() is redundant as the module alias is now
> automatically generated from the MODULE_DEVICE_TABLE().
> 
> Remove the explicit alias.
> 
> No functional change intended.
> 
> Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
> Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/menz69_wdt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
> index 6e5e4e5c0b56..3fe23451135d 100644
> --- a/drivers/watchdog/menz69_wdt.c
> +++ b/drivers/watchdog/menz69_wdt.c
> @@ -163,5 +163,4 @@ module_mcb_driver(men_z069_driver);
>   MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
>   MODULE_DESCRIPTION("Watchdog driver for the MEN z069 IP-Core");
>   MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("mcb:16z069");
>   MODULE_IMPORT_NS("MCB");

