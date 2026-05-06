Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3123F1641
	for <linux-watchdog@vger.kernel.org>; Wed,  6 May 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074091; cv=none; b=OTtanVvqlSlI7MlXj4WK7cGFIb04gTlf7zxTsWyvK2VnjAtuB25QK5D6HwhMJVpNp1j2eEwx6bC3PtT56pbpO9+BOdbzpvxnNWfyW1t/wa1/fplOF2EWbvSGaEfp3I6YvlsLgVpY3GJEmBOg3BDd8LxbqbETsV1NHIm4TOHiqIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074091; c=relaxed/simple;
	bh=1YW1t4xBkQhP9j4ZJX7CPHZAQiCKQvy1TD609Z+biLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsusG3hxYs/smUIkxAjWSWdFjWzMwG21iIjiP764ZvulunyzC6Z7rF+Hqxz1SxOxcqLwAwrSeyLCqPGTm2UujHkunBe0t4aYBbKcb7iIOMk8UkYfQr26egbqI+dUqvQgVWFydlNs1SFPKyyyfmQYniCu2zfTpq1dxOg4lf/XRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPVlwLV/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPVlwLV/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-364d72f2986so4674381a91.3
        for <linux-watchdog@vger.kernel.org>; Wed, 06 May 2026 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074090; x=1778678890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uS1a9bcJxdnsN4Cgf1syG4AWcpUPrEuuLJmo6Jj7Dw=;
        b=kPVlwLV/Rb6P0rCO4NlhuDo74LCjqQ3JJFdzVa7Mfw64KvD9iZyKz/d9ifMYrLgt3w
         hSImknI6kMxF3TLosKMtKTUeiOGR3dyxnoBgKwAnW2bHFH6B/tuaXbeVbI+Gw/37gcl+
         giPrAcJn7++IkvYuT05WnUa/EKBshOnPgS762fztwZI2rBHAYCveMK9LmDItLtdH/AUA
         hW9YRKNzZQ7PwrwwlKbG6uZtzPBpZRFVuNAxXIOKyr8d+AS6ZwXiPLddE0kLJlaIvcwK
         QqSdhHaJcOBH9QwSIp4PM5IavB37nVyW8TttX70hhhU3rm5rNAAZoBBUz6vOt8rJyzSO
         PQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074090; x=1778678890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3uS1a9bcJxdnsN4Cgf1syG4AWcpUPrEuuLJmo6Jj7Dw=;
        b=GgbkoYBffojCZQNrgzyKOgXnZZaXDPPlKrXHgdFOJKqBpPfp+uX6MceKxu2yoghIEO
         zBTgPPkDbpQb0xp7XZhHqKGBet5TQboBCc/79MK62QKLS8PRxof3rexOunRtu2aQMzbw
         fi+PM3HR/qnmXpG//WsGzu750LDhgxBRd9eRcLlA5nEaUl7U4m6cWotyFuDhxVG4J9qj
         lNVJxro3n/++sh+7UW1raNBbd0O+UC31DS3A7J+g0+ElNX/QqXw6DBu5tFvCE2ZrBq0c
         yXJHHCfVS081eJQBIyCxtqHy1DxKpIkeEg5ic7u2FsBizRVwAg+HEf80ZNvOdhPQvmmU
         aM3A==
X-Forwarded-Encrypted: i=1; AFNElJ8EPUEn/r+u3T4Al/vC9AtBr5FpvgXtI5KWHzeAFCE+Fna4UQVV+q9E7Etq/XSu5crBsfvoSJwaYh7vnDYAKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyun0mcv0B5Mnzw02jJx6TCOBaZY+/PAaJOUxrjXhbxQoQDHfyN
	tkcABmPEZsU5BQXDN80Y4YdXd7eVPLOpCYpdWwJ5NzRWM2PalzCciuXp
X-Gm-Gg: AeBDieumufdgKeCIbqR1N+Ms3jhf82tM1JDMpR6Epd8MLFr3EqFwvZT3Z+I0Dk1XN8U
	8Mxuce5rlV81sVHBfJatqahQxpaDSClggFFOy0CLtM4wgVipNRT+SYcCu8D8Q21wJ3MgRCbcVSG
	kS4B1sXbt74rcS/L7aOK7R5OOpSxcJmgUlqtSZ8D8HAMp2Lr0qZJSozgodqgimHEihRE291WAvt
	ARp7Rb93YnltomA7V/MNffzSkgdEVdtecdKI9Rn4Ce1i8MG1zQ7IG6gis4g7VqeFWHY7QfSzzor
	I4Tv9EvFXKn0Ha4Lyo/YCoD/HElHlZdXAiJnHo63X42UKXehB/+YhyoP0vRSCvq4zTgYTnl1eV7
	JqSHjEUbEmhBWQUVLSyMc3p7gvr/5vadTlAkV5eoo1CmsK2+RrovJz1afp/cK85ou6nII5WXPiD
	4XIDwzP1niWDChwHbGcNpjo0n+acKl+IK6ixx/a1PCkDMMAYY=
X-Received: by 2002:a17:90b:264e:b0:365:a968:99ce with SMTP id 98e67ed59e1d1-365ac79e52dmr3411738a91.24.1778074089592;
        Wed, 06 May 2026 06:28:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4f75f25sm2593699a91.10.2026.05.06.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:28:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 6 May 2026 06:28:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	brgl@kernel.org
Subject: Re: [PATCH v3] watchdog: convert the Kconfig dependency on OF_GPIO
 to OF
Message-ID: <1226bbb6-0b89-4a0a-895d-99d4b39d31d3@roeck-us.net>
References: <20260506081600.4921-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506081600.4921-1-bartosz.golaszewski@oss.qualcomm.com>

On Wed, May 06, 2026 at 10:16:00AM +0200, Bartosz Golaszewski wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it
> controls also provide stubs so there's really no reason to select it
> explicitly. We could simply remove the dependency but in order to avoid
> a new symbol popping up for everyone in make config - just convert it to
> requiring CONFIG_OF.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Applied to my watchdog-next branch after resolving conflicts.
Dependencis are now
	depends on GPIOLIB && (ACPI || OF)

Thanks,
Guenter

> ---
> Changes in v3:
> - Send the watchdog patch separately so that it can be picked up for v7.2
> - Link to v2: https://patch.msgid.link/20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com
> 
> Changes in v2:
> - Make gpio-watchdog depend on OF && GPIOLIB
> - Drop picked up patches
> - Link to v1: https://patch.msgid.link/20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com
> 
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5..ab1d5d6df5f3 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -250,7 +250,7 @@ config DA9062_WATCHDOG
>  
>  config GPIO_WATCHDOG
>  	tristate "Watchdog device controlled through GPIO-line"
> -	depends on OF_GPIO
> +	depends on OF && GPIOLIB
>  	select WATCHDOG_CORE
>  	help
>  	  If you say yes here you get support for watchdog device
