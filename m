Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3133BE144
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559482; cv=none; b=h+Js8dGGG8ueOJVBUWsfbAYthBIJiwIAIwYvALvOGqbcEfcEuyUjJMsVrx7Kh+Kdf+9mQfX3OtlezFQulxjiVNfIsvi6pUPkOWQxD1ZAv62an3/B0h1uIsUJhKkIJ1K8rXeBjqdU9gkDQJvk1j/4XavfUxZhKw/usa6JuZPwVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559482; c=relaxed/simple;
	bh=ofC8nsZtMAjtWZq7JsW9Woxvhtpsc/5etfnOqSlsAX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/wKdBhO7aD6nAgwM8yUZP5MdcUL4IGyh3ah7nOR62G1BP1ItiGmQA1YcUhOI9JxNoqMJsbPSHSFqQUAOq1ZKzuDEH0vxgwh2l9T7r2HA+Ydv0EHeSuG0yT8UYNJVC9c+HpvolUVF4SsO1g5TAhMQ+kRa8+XnqxizAVNxD0euTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=st69cswQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="st69cswQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caf228a910so80067645ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784559480; x=1785164280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2Im12ZLLd9bcOvQfTP/toQA7Db0tJk/hh7uBO5HAZ8Y=;
        b=st69cswQb+ZOYW0JtdZmgd+ia8XQWRtq0RIWiFGNey+FlfSKedBgi81nF3Gb1hgUsg
         oYa0bVEumcMBlSRqubf2J0aCFdw0JpxOjNdLMA+tq7z4+mdZENXzBct8g5WaIWu+FAPi
         D1PzoMs2jsqu1XLF8DFRGUF0oXkGLZJRX4OgeIozTMUEaHhJUZhi/LskXoVPGp9L684c
         pHpW6gxr9hi6DLicC3b1TgYPGiBU/waXkz4w7aFBUqFp6MdP9vYT6ShlmTB1Y656dup0
         BBNyUT//OleleO2ZSF+Ldn/lPgauM0EFFOO2TCXURz0HiiRz3Br778yrrpCu5c9kcOJD
         cStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559480; x=1785164280;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Im12ZLLd9bcOvQfTP/toQA7Db0tJk/hh7uBO5HAZ8Y=;
        b=np79c+TEhHeQayiwr5DgMmach00ab4gqvph65z+J72klwM9JWnOGobo0hkun2w9+I7
         pIqIrzVpYqOck/mpLtslJiPHOWuAeb6F/42SitbathpEmMqxZfSA/+OeyKPfAm0QnTzK
         pSY4uxkQSKHF8izfhrI3JCZ8KXPA6f8zHCmCPoUJT/RVf3nax+OVqVfAJyTFYnXaz0QV
         4MDKqR4x1ouFUbbqcrmPjZjJFBFlE3v7q9TZQM7JcWjK2BIlmO4+9drdLDqUhzhrXX4D
         2FatHxj/iCH5Va89eYLXns+bjsdtgwoRAhF030YqQ3tmRgQyTGuJr2Rkn2qAUkqsoQUn
         NIGA==
X-Forwarded-Encrypted: i=1; AHgh+RqLWp/nla1nJw7btGy7/c2x5iSZ3C65+L7hIVg/n5rgAa1rHmgVwEphpkvGox1BNOKfLY6nJMZYK5PbqYWE1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/x3exjj+WgoMFkeAkAPUwsm/S1Lq2df7ClWTcI+TGLj5fnmX
	poAzSZaC8JXyfcdlDhNumT1hnIYUu+TTYos+YhlG9KlFCO3YJHKm6sdE
X-Gm-Gg: AR+sD138ESZaiVYZx9fezP+KM+p62Kksi2UmSQPt0tY6JZRKowsfviN+L2k4AJ+jvWR
	mdIIkjFvFeuyMzJFDMQEYd3Enoiq5yw3gye0kuNM9sgSXl6tccyV5QwxiDwa//Sr1A6HcozMOST
	TLdwM4XCVWlBT7uGzYZr8FWNhdXOFejUlOUW4B5gEsaToVVuare9A2Ab4HV1NA3z6fJPkwO5KyE
	mZpDox/wKbVBD8UckdeqjZbircj42Kv5AvX36T4dbvHoZ5eNlS9Pt8lC5kJVe3lc4vNKymFjRiV
	AuYBMfmEYbLEf+hPwV6V0phscwD9uNfD58ig5eYx/rFoxw5MD+XJE3JarmRQzyb5Asu1tyBNT9s
	/f0oKwC7pWFvmCouLijLncnXbAcy/BQL/naJgEEZShsJ/lGBep03oTsYn6fqAzqGaAG/xfgTd9w
	Do0DeLdf0anDGeFzE=
X-Received: by 2002:a17:902:ce87:b0:2cc:f4d4:299f with SMTP id d9443c01a7336-2cf34962042mr157078285ad.27.1784559480464;
        Mon, 20 Jul 2026 07:58:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bb62sm36002789eec.2.2026.07.20.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:57:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 07:57:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 2/2] watchdog: rzv2h: Drop WDTRCR_RSTIRQS macro
Message-ID: <cf85d5b6-7d9d-46a6-9ec5-ab0a17c9515f@roeck-us.net>
References: <20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715133922.2129340-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715133922.2129340-3-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Wed, Jul 15, 2026 at 02:39:22PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> WDTRCR_RSTIRQS macro is unused so drop it.

Nit: This is a define, not a macro.

Thanks,
Guenter

> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - No changes.
> ---
>  drivers/watchdog/rzv2h_wdt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index 0f951219caf8..3c8739902ec4 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c
> @@ -40,8 +40,6 @@
>  #define WDTCR_RPSS_25		0x00
>  #define WDTCR_RPSS_100		0x3000
>  
> -#define WDTRCR_RSTIRQS		BIT(7)
> -
>  #define WDTDCR_WDTSTOPCTRL	BIT(0)
>  
>  #define WDT_DEFAULT_TIMEOUT	60U
