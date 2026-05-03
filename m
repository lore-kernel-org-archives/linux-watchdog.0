Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A43A63E6
	for <linux-watchdog@vger.kernel.org>; Sun,  3 May 2026 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777842244; cv=none; b=AFVpib43Sff1L8r5+w1Ycyb37ntCnJDM7+uraNb4QlxC6uQojg7WR3rLcLpLObAQxVsXS+mnfMHq3PBNGA51i58d86fUySJwU2CyF4E/Zv78zuKdJOYQ6Nq+7Yng2gPGFlqyNlCA12XCZ+nAdTPS2QSvE8CQiWroYeQK8rAL9fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777842244; c=relaxed/simple;
	bh=O5vaqctSh9GzLWxBkBx/+od5fmtbCmAczok2yn2HIsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifqbpn9CLzYlDOHbuRC6w59Nt1WCPRhB5XzOx/II7yYVlrXuFHBIDLE++XPwH/YqCeUQ9DZF2zeE2+uzqJV6FvW55F7teLiUn6Vq08nsvWJOL66yoRGF/wsc/8ddcDjibw46GSSmhvFTJjc6N78WgybwlhwvVZQ75KRrgiHSeg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOuVytnC; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOuVytnC"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c8ccc7755so4951346c88.0
        for <linux-watchdog@vger.kernel.org>; Sun, 03 May 2026 14:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777842242; x=1778447042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dl4XbChRRX2SzAfJdIqD9LXDTYpJPDAGOZzCS282mUk=;
        b=lOuVytnCb4wC9y5i7KIdgH2EX0j8BJyrJQ7bWzJcYYJYQ+/0A+XXO739hxMKwJG/KE
         j0S3hlBGiUfnalfIVe4owoDkSY5ZmoJZs15U9uHU2tDAQFI6K6ZyNjKCmKw6NUXJUPAX
         jvEpGkUTNLhJHleKTJY94cHFd6fzTMovGmo93B05ze/HRmsIwPu67dkU28uOBTS4Uyi4
         Gvq95VNFo9QleduFtwINoxT47QHB4RW3RrMU24KrB/q2bbIQ8IZEUH9wrCAXne2N111w
         3/Nvnp6gU/cv3GIO8stQIIUF4TeROu4uHE0HrpRlgKl+WBjBZdwkHfBdpIcrNT8k5GCN
         KJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777842242; x=1778447042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dl4XbChRRX2SzAfJdIqD9LXDTYpJPDAGOZzCS282mUk=;
        b=F4ZSMLUzL8dPbeaMp4QupddfQ8rwHhldG6j5Dz002ma12tQZPYx7ZNnQcgc+bC9pZH
         7nUP8uMHzQOTb1/+g2f3912YBz5rkG4pxz5kRYPp6mtY3m+hFVDpjhQZDyAUA1UulVaR
         gFXwC3JSPruV/tojV3VgmkH/51qB5yQ/U0/w251ss6lZc4jOnN/sYhdIzOEtmJPsD522
         PfeMnzFfOGpuHKkpSBNIKqFdsMBCkOtaSZh6dZ2mnNdqLYZ0thAxPEGeL3qkZwHu6AwZ
         AjOToyLDNmXO5JSnQ3EWMOzYcJ1T7+p7kjIUer2EuQF1InJ3nXV5HzIBRy1yqRnx25K0
         xZaA==
X-Gm-Message-State: AOJu0YwdDMx99iM0HS2eSfmUnnj0uBC5Jr+Jdd4PP2W3XYXH9n3WTjlU
	qGUoahxHLGCySsStuF8QqYCnTd3EmWo4XiIRZH4j0T5IO30gJOsXNarb
X-Gm-Gg: AeBDietUJLFDASUzXSZ5eNE9CyFG7hEnEQPNd2IUAMpG6al1PfSPBXElpF1SNe8SV7m
	lrxh7biJYLReJVccPlell+Irku0ykQ6DvcajF2dQO5g+Rc8fHlD/zHKu9iTV9XgPUI5IBzyYjJ/
	9rMGZbHAFbK/nCLM6aU0qPioHZefBxucHp8V+5syiZBsYnk5MngSChAZwzXwZEQFpj7/IHHtYVc
	qupmMf53J1o71fEbJLACVsUVCcJt2z42HIw6maA0gBs+VpCNFKVWz7VqJQRcucerayc6Xh46s94
	QZzNH7R81me8lBVxAgE9h4pK9DIN5QkH+cKFXrYpVX2ABUrl7Ja9gKn5yw20VaeWiqO4cm2lXmW
	eHZOAxPgVMWHGcl3eHQari52CHZy8Q2fvOQa/GCdR9M2KK7ZpqBU6JCBH4u2/dExKgJgUDH9SAU
	v91PzJjrm3xnQBxXNiv8XBsQoBimolojjyq4G3WkY+Mak4VTj0KqUx1HonWw==
X-Received: by 2002:a05:7022:6187:b0:12d:b2e9:b20f with SMTP id a92af1059eb24-12dfd821474mr2830188c88.21.1777842241500;
        Sun, 03 May 2026 14:04:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm11486445c88.1.2026.05.03.14.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 14:04:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 3 May 2026 14:03:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
	alexandre.belloni@bootlin.com, andrei.simion@microchip.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH 2/2] watchdog: at91sam9_wdt.h: Document WDDIS bit
 position per SoC family
Message-ID: <a5f60dc5-0aa7-4324-821a-e0c74b965f8b@roeck-us.net>
References: <20260302113310.133989-1-balakrishnan.s@microchip.com>
 <20260302113310.133989-3-balakrishnan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302113310.133989-3-balakrishnan.s@microchip.com>

On Mon, Mar 02, 2026 at 05:03:10PM +0530, Balakrishnan Sambath wrote:
> AT91_WDT_WDDIS (bit 15) applies to SAMA5/AT91SAM9261 and
> AT91_SAM9X60_WDDIS (bit 12) to SAM9X60/SAMA7G5/SAM9X75. Update
> comments to reflect this and add SAMA7G5 and SAM9X75 datasheet
> references to the file header.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/at91sam9_wdt.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/at91sam9_wdt.h b/drivers/watchdog/at91sam9_wdt.h
> index 298d545df1a1..2020694f8f6f 100644
> --- a/drivers/watchdog/at91sam9_wdt.h
> +++ b/drivers/watchdog/at91sam9_wdt.h
> @@ -3,40 +3,42 @@
>   * drivers/watchdog/at91sam9_wdt.h
>   *
>   * Copyright (C) 2007 Andrew Victor
>   * Copyright (C) 2007 Atmel Corporation.
>   * Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries
>   *
>   * Watchdog Timer (WDT) - System peripherals regsters.
>   * Based on AT91SAM9261 datasheet revision D.
>   * Based on SAM9X60 datasheet.
> + * Based on SAMA7G5 datasheet.
> + * Based on SAM9X75 datasheet.
>   *
>   */
>  
>  #ifndef AT91_WDT_H
>  #define AT91_WDT_H
>  
>  #include <linux/bits.h>
>  
>  #define AT91_WDT_CR		0x00			/* Watchdog Control Register */
>  #define  AT91_WDT_WDRSTT	BIT(0)			/* Restart */
>  #define  AT91_WDT_KEY		(0xa5UL << 24)		/* KEY Password */
>  
>  #define AT91_WDT_MR		0x04			/* Watchdog Mode Register */
>  #define  AT91_WDT_WDV		(0xfffUL << 0)		/* Counter Value */
>  #define  AT91_WDT_SET_WDV(x)	((x) & AT91_WDT_WDV)
>  #define  AT91_SAM9X60_PERIODRST	BIT(4)		/* Period Reset */
>  #define  AT91_SAM9X60_RPTHRST	BIT(5)		/* Minimum Restart Period */
>  #define  AT91_WDT_WDFIEN	BIT(12)		/* Fault Interrupt Enable */
> -#define  AT91_SAM9X60_WDDIS	BIT(12)		/* Watchdog Disable */
> +#define  AT91_SAM9X60_WDDIS	BIT(12)		/* Watchdog Disable (SAM9X60, SAMA7G5, SAM9X75) */
>  #define  AT91_WDT_WDRSTEN	BIT(13)		/* Reset Processor */
>  #define  AT91_WDT_WDRPROC	BIT(14)		/* Timer Restart */
> -#define  AT91_WDT_WDDIS		BIT(15)		/* Watchdog Disable */
> +#define  AT91_WDT_WDDIS		BIT(15)		/* Watchdog Disable (SAMA5, AT91SAM9261) */
>  #define  AT91_WDT_WDD		(0xfffUL << 16)		/* Delta Value */
>  #define  AT91_WDT_SET_WDD(x)	(((x) << 16) & AT91_WDT_WDD)
>  #define  AT91_WDT_WDDBGHLT	BIT(28)		/* Debug Halt */
>  #define  AT91_WDT_WDIDLEHLT	BIT(29)		/* Idle Halt */
>  
>  #define AT91_WDT_SR		0x08		/* Watchdog Status Register */
>  #define  AT91_WDT_WDUNF		BIT(0)		/* Watchdog Underflow */
>  #define  AT91_WDT_WDERR		BIT(1)		/* Watchdog Error */
>  
