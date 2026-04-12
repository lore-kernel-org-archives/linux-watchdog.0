Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04A2417DE
	for <linux-watchdog@vger.kernel.org>; Sun, 12 Apr 2026 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775997371; cv=none; b=nRfuAMcw8TYlURmp0F399wsdS//u8EJSjstbTYYR+twGx7lA5v07uhD1z/xiUTtXjgH/FjUr3Z0XlX7JmPVDc9dugJ3onSLIvaT90MlBAJcGSvxx4F0JR+RGqrX9ApUeFqX0sd111549Pld1pdwRa7ryiLODepGeD0DK/jFSWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775997371; c=relaxed/simple;
	bh=S1Y5htxt/0iv0cewsbMrJKvX3E+/At29ZpfYuZqkCvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUOP1VgdCQN5W2o0Z7/D8C0zJ8wO03KtKmh8ydV9K0GE2N5EyvkiXATpxpTxurHGrWF+uH3qfdfhBkrlF/ilcvvcDyDSMwXyzUI++G4YNr0tlEK3LmpBXapBqNpbqxS9a8tcwClG16mLrg7wNqdinZdYbFfJ4wqvVw3XEULYxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKBc8e6B; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKBc8e6B"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c1fcce8f8so5434368c88.1
        for <linux-watchdog@vger.kernel.org>; Sun, 12 Apr 2026 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775997366; x=1776602166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kGJkiCw01j6G/ngx3xY9x4SzB4E2Ahy8XukeWE39Qpw=;
        b=GKBc8e6B7lbE9Ftr8QOXBdxfnexb/Ogdia9RQsnx/NdA3rjA39pOfgJ54oBGiZq0DG
         eCdTSHoD7iSzw8LMlVfmjOGszEbr7yhZQ1+dinTRXNnl6syIjWGqjw30i9iR0r5mcBqB
         9zcCfL9TrCdV6+rXwtZYKtkB3KryiyuR2z9RimgwbPOldLSZxgmhBKjk3MoaTNljUj0+
         1cH0e1zdXdV+Z7RmmKyKUzZehgcLJxXj+Xa1uWctQ4roe2eJs5dn6sP5SMuCSQg3CAv+
         cGXNutOaoFyqejlftXEOozOupV33S2Y0KeIGWUPBCG5L+TzRN4oI/uMgJkhhKblfur6j
         lZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775997366; x=1776602166;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGJkiCw01j6G/ngx3xY9x4SzB4E2Ahy8XukeWE39Qpw=;
        b=Wvx1NfnTCiPg2eItzo59H3h8qk7FPffaiDurE/phjUn3V3d8LeIPg/P6UVKYV9DVW4
         4ek9lqEO2tfIu7ejmrGR0wDdLTS6MObfGmZKWIMGR/Bng6t6mBzZyMZ3Ghlq+b7LE/M2
         /95HYrmEsjPJOJY+5oTDaI1x2g+CXA+i6ZLaT6or+Tx7zdsACUSMWddgKkUW3AgAKGYD
         3+j3SjMYiJ0bkBrAYyy060gX60Fbz3I31DM+AsavV2HcNpoEsIfe6CTC0Rz33N3U0noo
         CNqFkKCiyOuwejGI63ABaPpD7M6TLwTuWm2oIPwTtWvR7xNnJrGQNE0FPtz6z3nluNJN
         SKSQ==
X-Gm-Message-State: AOJu0YwUrGSSP+6SpVK08HNxxT/6/Z0Vv49nktCWWffICEXZkzIY5TPF
	CAH8b9HMw4WqULLq9f1Fm/3TH63z9EGsmGswEg8kENAdMGGzHLAHvb5J
X-Gm-Gg: AeBDiesoTIQve28cAD6H6Xumi1ByrEhlTK7DtAMRfd0thz73POdCYGBE9SNT3W+/FIP
	3Y1G9wcv6WbX4Ddna4u4yH6uxqo2V8gPIWXKI8/nca1WRUWle+pjQBvEF/irhaBkeNldznCrYeV
	F+/h33vMKjzYTrYLrEksFYLeFDzw/f+askcKaU6ZfydaDAWYkt/TFH9XfXzPXvbKhuRGS5bQrd8
	dOlS/htofZ7pT06JglXggaFP/gRwqD4ASakPkZ+IY0kKibTbUfCeQHJTrniIWjfvXeKrsrfwW9J
	i3/b8OWp6XbDTuxAbe9BaMRUte6ZGipFc+YVPFynwNxo9EV0k5gw3WGJyfnHfUJFBOB0QaNQIuz
	KaMRjMWjUoOMSKRzWlQniR88mAe+t43iNWSDffNRQgC47eCPu9IRE6DRgd5Otf5SiT4rDpfTNUB
	r38ELxSfrm3c0CmpNt1+nGNmSHSt8PacvvD/2m+fj5yaQprw9/i9JZJzjMHYD1tIqEqoxFU2eh
X-Received: by 2002:a05:7300:730f:b0:2c5:b23e:48ac with SMTP id 5a478bee46e88-2d5873adf4bmr5607864eec.2.1775997365983;
        Sun, 12 Apr 2026 05:36:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562ac344csm12315148eec.25.2026.04.12.05.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 05:36:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <34480190-af4c-4d19-966d-45a446732517@roeck-us.net>
Date: Sun, 12 Apr 2026 05:36:03 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Documentation: Refactored watchdog old doc
To: Sunny Patel <nueralspacetech@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 corbet@lwn.net, wim@linux-watchdog.org, rdunlap@infradead.org
References: <20260412095338.52271-1-nueralspacetech@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260412095338.52271-1-nueralspacetech@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/12/26 02:53, Sunny Patel wrote:
> Mark WDIOC_GETTEMP and WDIOS_TEMPPANIC as deprecated since
> neither is implemented by the watchdog core and both are only
> present in a small number of legacy drivers.
> 
> Add documentation for previously undocumented status bits
> WDIOF_MAGICCLOSE and WDIOF_ALARMONLY in the options field.
> 
> Add documentation for WDIOF_PRETIMEOUT and WDIOF_SETTIMEOUT
> status bits describing their respective ioctls.
> 
> Fix the following issues in existing documentation:
>    - Remove version-specific reference to Linux 2.4.18 from
>      the GETTIMEOUT ioctl description
>    - Fix duplicate "was is" in printf format strings
>    - Replace [FIXME] placeholder with proper descriptions for
>      WDIOS_DISABLECARD, WDIOS_ENABLECARD and WDIOS_TEMPPANIC
> 
> Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
> ---
> 
> Changes in v4:
>    - Fixed WDIOS_DISABLECARD description: corrected inverted logic —
>      the ioctl disables the hardware timer entirely rather than
>      stopping pings. Clarified that userspace, not the kernel driver,
>      is primarily responsible for pinging under normal operation.
> 
> Apologies for the broken mail threading on v2 and v3 as well.
> 
>   Documentation/watchdog/watchdog-api.rst | 65 +++++++++++++++++++++----
>   1 file changed, 55 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
> index 78e228c272cf..43ca6b2bbeff 100644
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
> @@ -42,7 +42,7 @@ activates as soon as /dev/watchdog is opened and will reboot unless
>   the watchdog is pinged within a certain time, this time is called the
>   timeout or margin.  The simplest way to ping the watchdog is to write
>   some data to the device.  So a very simple watchdog daemon would look
> -like this source file:  see samples/watchdog/watchdog-simple.c
> +like this source file: see samples/watchdog/watchdog-simple.c
>   
>   A more advanced driver could for example check that a HTTP server is
>   still responding before doing the write call to ping the watchdog.
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
> @@ -145,12 +144,12 @@ before the system will reboot. The WDIOC_GETTIMELEFT is the ioctl
>   that returns the number of seconds before reboot::
>   
>       ioctl(fd, WDIOC_GETTIMELEFT, &timeleft);
> -    printf("The timeout was is %d seconds\n", timeleft);
> +    printf("The timeout is %d seconds\n", timeleft);

Sashiko:

This isn't a bug, but should this printf example use "time left" instead of
"timeout" since it is printing the result of the WDIOC_GETTIMELEFT ioctl?

It has a point. Please change.

Thanks,
Guenter

>   
>   Environmental monitoring
>   ========================
>   
> -All watchdog drivers are required return more information about the system,
> +All watchdog drivers are required to return more information about the system,
>   some do temperature, fan and power level monitoring, some can tell you
>   the reason for the last reboot of the system.  The GETSUPPORT ioctl is
>   available to ask what the device can do::
> @@ -227,12 +226,33 @@ The watchdog saw a keepalive ping since it was last queried.
>   	WDIOF_SETTIMEOUT	Can set/get the timeout
>   	================	=======================
>   
> -The watchdog can do pretimeouts.
> +The watchdog supports timeout set/get via the WDIOC_SETTIMEOUT and
> +WDIOC_GETTIMEOUT ioctls.
>   
>   	================	================================
>   	WDIOF_PRETIMEOUT	Pretimeout (in seconds), get/set
>   	================	================================
>   
> +The watchdog supports a pretimeout, a warning interrupt that fires before
> +the actual reboot timeout. Use WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT
> +to set/get the pretimeout.
> +
> +	================	================================
> +	WDIOF_MAGICCLOSE	Supports magic close char
> +	================	================================
> +
> +The driver supports the Magic Close feature. The watchdog is only disabled
> +if the character 'V' is written to /dev/watchdog before the file descriptor
> +is closed. Without writing 'V' before closing, the watchdog remains active
> +and will trigger a reboot after the timeout expires.
> +
> +	================	================================
> +	WDIOF_ALARMONLY		Not a reboot watchdog
> +	================	================================
> +
> +The watchdog will not reboot the system when it expires. Instead it
> +triggers a management or other external alarm. Userspace should not
> +rely on a system reboot occurring.
>   
>   For those drivers that return any bits set in the option field, the
>   GETSTATUS and GETBOOTSTATUS ioctls can be used to ask for the current
> @@ -254,6 +274,11 @@ returned value is the temperature in degrees Fahrenheit::
>       int temperature;
>       ioctl(fd, WDIOC_GETTEMP, &temperature);
>   
> +.. note::
> +	``WDIOC_GETTEMP`` is not implemented by the watchdog core and is
> +	considered deprecated. It is only supported by a small number of
> +	legacy drivers. New drivers should not implement it.
> +
>   Finally the SETOPTIONS ioctl can be used to control some aspects of
>   the cards operation::
>   
> @@ -268,4 +293,24 @@ The following options are available:
>   	WDIOS_TEMPPANIC		Kernel panic on temperature trip
>   	=================	================================
>   
> -[FIXME -- better explanations]
> +``WDIOS_DISABLECARD`` disables the hardware watchdog timer entirely,
> +allowing a controlled system shutdown without triggering a reboot.
> +Userspace is responsible for pinging the watchdog under normal
> +operation; this ioctl stops the underlying hardware timer so that
> +the absence of pings no longer causes a system reset.
> +
> +``WDIOS_ENABLECARD`` starts the watchdog timer. If the watchdog was
> +previously stopped via ``WDIOS_DISABLECARD``, this will re-enable it. The
> +hardware watchdog will begin counting down from the configured timeout.
> +
> +``WDIOS_TEMPPANIC`` enables temperature-based kernel panic. When set,
> +the driver will call ``panic()`` (or ``kernel_power_off()`` on some
> +drivers) if the hardware temperature sensor exceeds its threshold,
> +rather than only setting the ``WDIOF_OVERHEAT`` status bit. Support
> +for this option is driver-specific; not all watchdog drivers implement
> +temperature monitoring.
> +
> +.. note::
> +	``WDIOS_TEMPPANIC`` is not implemented by the watchdog core and is
> +	considered deprecated. It is only present in a small number of
> +	legacy drivers. New drivers should not implement it.

