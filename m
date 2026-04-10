Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69985314D18
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775782438; cv=none; b=dCZqtqAcZQTt2zMjhHOa23+AvXGN5fLjNDWCfZFNCTYwKg6SIamlIBEUsG1knn2SSu0WO0cHnf8cQWC11ZHvTz8ayCA+8t1ZimlPyul4SaRDDxj+yTDW3QS+7jlHf6veVTjjny2Fq8i8JuVaBsriWNZD16JWHQ92r6Jcv2YyDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775782438; c=relaxed/simple;
	bh=OTmZ+oGMVvjRnvXG6OGGFurCLhilKvD8WsmlC0/3ZRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgUc4Y5qfkX6Grrff26rXMmLej3CK5Vw3FMkGviaYqtyF5Rv+19YO+Uo28it/oJJtZHcBTJkcNeiw1tZ5HD5jg5Ja1AEOUmEUy8b++hCjamo6g/NaKmN1r33ag5XBH8W2VpHNgKnwnC71FhZi2gTJW+PndnDJ+88ctOMuAEOZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYlRta/W; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYlRta/W"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad9f316d68so7260645ad.2
        for <linux-watchdog@vger.kernel.org>; Thu, 09 Apr 2026 17:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775782435; x=1776387235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zlPpzT2EYibWjmLAuoWUFVaCZoy5o7mnT06yLl6p+LU=;
        b=BYlRta/Wz+IZgqSmPPlWSm8dMjQS3mdzTZihgoHSPPrn0YM133hqfhQ+r0gtJQJytK
         DkIIADga1kYHqEtpHkYlq7P5VK24rUsUZBjVbdhHpsxQHUhd8+ScnescvuBkoaB5NOLE
         ogR4Q2XxHB29NPVJn2/OgTb3VrNTnwB5R6/BTMcITYrUDh6bo7txvwq+4+Q1mIs29cZ1
         zhrhs/heYduEU1MmYKwubHrd9gCTT+juXyi0U+sU7GmLIaPJSCjuikEbXu4y9iUDGInU
         j0ccpvYMODlhDAg6xYfqu6jiHuHqPpT7ucV4mfoz6c+HDRNj9Edx4hoYI2XtpiAP9KBS
         k12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775782435; x=1776387235;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlPpzT2EYibWjmLAuoWUFVaCZoy5o7mnT06yLl6p+LU=;
        b=AkAFwkkDdkgIkiCZUiKLJ0ZzzgTF9i+sLSY/JXbjj7j29kIYqOnE1JK+aFc22/+GNg
         58amYlO7VZzzI+ipkquGN06fCIoSd93gfpsTdxUDZ2qvH3cpf1e6IMUz5d+zZjXPpgF0
         0/wT/FcqA1xDN5QKaPgUkdAW+y2YDqsriuGnDDz55g5Uxcu/FI+4Xr9A4UCwXpQJPUsw
         kDFIT/aniJde9JLZWDgFwAB25NzdmjqOvuh+fofXeKscHDpdrSfv3TD0flkPnUAPPoW8
         yn++VIUZdRvsLl/VrvAKiqMfgxKmZycGzoBpsJ8d5TayU1+XOObkHGCCsUHJpAmN2drj
         Bv2w==
X-Forwarded-Encrypted: i=1; AJvYcCUpB6Lj614H4C11OxA8nqiseYY1PdFvAGPuKgtzVFsXyAqQinaImkYZ5dZ+7ULkSxDFMSdr8JQXk3yzL+BX3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rwSMlacjHWxlICkgLXXi1+rHO95UIzrhYeGXo3h9tc8i4GYY
	brIJNPGYlN2MoDogbyRF0kWzMs4/APlvMt3FLXEa8QgGAKc7+mU5pRri
X-Gm-Gg: AeBDieu8sVcbJ8nMKMNvM5poSMIQ4mBV7JFVJHXHLukP5jepqWqCfNe0NYLh5J4pRNW
	+zAFB0ExIgwqlmIwwXC7U1sIrGcLy9WkbvCOp/X71KpL91gYjT9GmS7KMU2XC0QdfIWGRBGYPjH
	1Ou3HnRifE2OlaWht1uVINg935al0f6+Fp8Zo+na35T+WGwmWA20raRNUzVql01eCrcRrLEI7Un
	Kfh3dd7XBGghM6NB4wyysD/bRCV/rTF61Z6RwwkUbhDlIxKf8NJXkEfDujzIFi7IyaAlEUFCz3G
	C15zJ6bnAusNy7qXyP4AN1F2sMvfEUkiiFaXDjC3cWpB+PlqTm2oBN7x5c/XLecTv/SxJx8+ko2
	W2YjBotTuxFSM9xdHRiftVJvhf2Xdm/3zep6SZDgAQRKsqDDy0ZpI4gsgko/ONq8rYQsznL5P9m
	rnaBImSpxrdAOFqeDSibMvSTXTqBp+GW+BBbDBvP6U3A9xvVw2Qfyml+FtDKLd/xEABBIsmmW+
X-Received: by 2002:a17:903:1211:b0:2b2:4b4e:e4d8 with SMTP id d9443c01a7336-2b2d591b8aemr9022925ad.4.1775782434748;
        Thu, 09 Apr 2026 17:53:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dabe98sm8061865ad.6.2026.04.09.17.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 17:53:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <132f7e64-4fc6-4274-a04e-e53f0b957665@roeck-us.net>
Date: Thu, 9 Apr 2026 17:53:52 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Refactored watchdog old doc
To: Sunny Patel <nueralspacetech@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260409175301.22902-1-nueralspacetech@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260409175301.22902-1-nueralspacetech@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/26 10:53, Sunny Patel wrote:
> Revisited old doc of watchdog and did some cleanup.
> Also added support for new api in doc.
> 
> Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
> ---
>   Documentation/watchdog/watchdog-api.rst | 49 +++++++++++++++++++++----
>   1 file changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
> index 78e228c272cf..446f961852ec 100644
> --- a/Documentation/watchdog/watchdog-api.rst
> +++ b/Documentation/watchdog/watchdog-api.rst
> @@ -2,7 +2,7 @@
>   The Linux Watchdog driver API
>   =============================
>   
> -Last reviewed: 10/05/2007
> +Last reviewed: 04/08/2026
>   
>   
>   
> @@ -106,11 +106,10 @@ the requested one due to limitation of the hardware::
>   This example might actually print "The timeout was set to 60 seconds"
>   if the device has a granularity of minutes for its timeout.
>   
> -Starting with the Linux 2.4.18 kernel, it is possible to query the
> -current timeout using the GETTIMEOUT ioctl::
> +It is also possible to get the current timeout with the GETTIMEOUT ioctl::
>   
>       ioctl(fd, WDIOC_GETTIMEOUT, &timeout);
> -    printf("The timeout was is %d seconds\n", timeout);
> +    printf("The timeout is %d seconds\n", timeout);
>   
>   Pretimeouts
>   ===========
> @@ -133,7 +132,7 @@ seconds.  Setting a pretimeout to zero disables it.
>   There is also a get function for getting the pretimeout::
>   
>       ioctl(fd, WDIOC_GETPRETIMEOUT, &timeout);
> -    printf("The pretimeout was is %d seconds\n", timeout);
> +    printf("The pretimeout is %d seconds\n", timeout);
>   
>   Not all watchdog drivers will support a pretimeout.
>   
> @@ -145,7 +144,7 @@ before the system will reboot. The WDIOC_GETTIMELEFT is the ioctl
>   that returns the number of seconds before reboot::
>   
>       ioctl(fd, WDIOC_GETTIMELEFT, &timeleft);
> -    printf("The timeout was is %d seconds\n", timeleft);
> +    printf("The timeout is %d seconds\n", timeleft);
>   
>   Environmental monitoring
>   ========================
> @@ -227,12 +226,33 @@ The watchdog saw a keepalive ping since it was last queried.
>   	WDIOF_SETTIMEOUT	Can set/get the timeout
>   	================	=======================
>   
> -The watchdog can do pretimeouts.
> +The watchdog supports  timeout set/get via the WDIOC_SETTIMEOUT and
> +WDIOC_GETTIMEOUT ioctls.
>   
>   	================	================================
>   	WDIOF_PRETIMEOUT	Pretimeout (in seconds), get/set
>   	================	================================
>   
> +The watchdog supports a pretimeout, a warning interrupt that fires before
> +the actual reboot tiemout. USE WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT
> +to set/get the pretimeout.
> +
> +	================	================================
> +	WDIOF_MAGICCLOSE	Supports magic close char
> +	================	================================
> +
> +The driver supports the Magic Close feature, The watchdog is only disabled
> +if the characted 'V' is written to /dev/watchdog before the file descriptor
> +is closed. Without this, closing the device disables the watchdog
> +unconditionally.
> +
> +	================	================================
> +	WDIOF_ALARMONLY	    Not a reboot watchdog
> +	================	================================
> +
> +The watchdog will not reboot the system when it expires. Instead it
> +triggers a management or other external alarm. Userspace should not
> +rely on a system reboot occurring.
>   
>   For those drivers that return any bits set in the option field, the
>   GETSTATUS and GETBOOTSTATUS ioctls can be used to ask for the current
> @@ -268,4 +288,17 @@ The following options are available:
>   	WDIOS_TEMPPANIC		Kernel panic on temperature trip
>   	=================	================================
>   
> -[FIXME -- better explanations]
> +``WDIOS_DISABLECARD`` stops the watchdog timer. The driver will cease
> +pinging the hardware watchdog, allowing a controlled shutdown without
> +a forced reboot. This is equivalent to the watchdog being disarmed.
> +
> +``WDIOS_ENABLECARD`` starts the watchdog timer. if the watchdog was
> +previously stopped via ``WDIOS_DISABLECARD``,this will re-enable it. The
> +hardware watchdog will begin counting down from the configured timeout.
> +
> +``WDIOS_TEMPPANIC`` enables temperature-based kernel panic. When set,
> +the driver will call ``panic()`` (or ``kernel_power_off()`` on some
> +drivers) if the hardware temperature sensor exceeds its threshold,
> +rather than only setting the ``WDIOF_OVERHEAT`` status bit. Support
> +for this option  is driver-specific, not all watchdog drivers implement
> +temperature monitoring.
> \ No newline at end of file

FWIW, I think if we update the document, all functionality not supported
by the watchdog core (specifically but not necessarily limited to
WDIOS_TEMPPANIC) should be declared/marked deprecated.

Guenter

