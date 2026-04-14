Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADB2F28FF
	for <linux-watchdog@vger.kernel.org>; Tue, 14 Apr 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187122; cv=none; b=boX2e6rwoM/uP/IRgtz3FjU9UPdNDdNykfnzE9s6xqsSFjBo/NzRWr45+OA92gB+EHSwYGKTYoggBc9XgYz/TCbO7oUmL4qVdoAJ2fDD+L5IGGg7NZG6jA7/3GsIsWxrJyIfib9B1fVPxIf8DripmMvu2jciUWHFmgpOvNkHN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187122; c=relaxed/simple;
	bh=l4VJLiaQnUGWNqq56MRrwD1M5+5RpBujlHwL6ugThNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZuLMtxOASAkYaXuyBT7T9+WZBIc41Ey1P7epbxNGkhrnKpvYFODeb2Usfmew0Jwu9R0jep3B0p9Xc5UoNgY+vVDwvUm4Obes0e3E7Qg4wcdTN9/fLFQSfDUwr8W9Gal9rHtAqk+pOnGHuJbSDes/ZQYFJNO4HCpxMMVLsCMpQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT5WHA1J; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT5WHA1J"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c742723c863so3728749a12.0
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Apr 2026 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776187120; x=1776791920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I/Y4I1bHWOZ95823lOSalVrpRocLk3v1BB0vX52vmQQ=;
        b=XT5WHA1JMGiIMS8+B5BZ4twQw7EoYetV4D8TPwKj0IcAUSx4Nt/0TeTxqovHKtQd3G
         1CmEuGRMZUSH/yi5VpL8wOgZ0frITS8+UWP6p0zjwBnBFl7uUhwFCRiAK8Rb/LfvMpGk
         +O5rbAzExs4LOgAgW4nlhCFiV6rvTKZcgMXYpWIkm2uKtuYgU9Or1OztLSbKUWQX9oS4
         a+PH3xeoEh1Rdjq2bnWHZK8OiTIJZnCWmA+65Lo1VWnvpt0Zivnyi3B447TJEnppPPFq
         HgR2UpuRb93dnhpLpjmmTKKpVv+0A4IXLaLH3eNH6D0le0FFWOX5LRhn889T2Y0a9b6Y
         rxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776187120; x=1776791920;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/Y4I1bHWOZ95823lOSalVrpRocLk3v1BB0vX52vmQQ=;
        b=kJEzm0nDZ+yfQFqUKscEJUGEHHYcWvseCorYc26BW8IAXuKylZqa6tn5kzKumePxOW
         7FEjLd1PZCqucO+ZEDR30b3A3NJLQEjP28qK5xZCDsMOXTotRDG8+MDlYF7ofmKVIeXI
         cya1/R4TyK1Hh6RREQVA6xX6iMaGpd9/Dcoto+tiFSoEn2a6PORTsyQlH1QRTsubXmLN
         ZISzIXCaEAjOYBhobmFG9F4ABwMW31sHrlKtW5mYOi6sVnchpU2fpzeSp41cAvAPAXFi
         UMucHe7fSM6QW5UI8cps7fONwiJbMAxFLefc6Xbp31/RasxcMlVns2tRcBZa6T33OAIu
         lv2w==
X-Gm-Message-State: AOJu0Yxod5TM4MyVMfU143q9bzUr5kjQnzNtX1zSf8xwQ/oNnJt57ory
	h9jI6bcyd4/KPIOC4JcRIzncMORGruXCO0FtpYZbYHXxVLNvdEvNmPM6
X-Gm-Gg: AeBDieuvyv+DiFAHINbCpv0e7/L5X8IEvSS42PJsUPrldE1zrkRMdP8h8zB7s9J3Jle
	Ne+28uNeiwsTlgf8ozRBLCt41/TfQu47OXX3RhlCpAHHYXBrPPhzpwZKEh+ZrrFpokq+8NHrBQG
	vba1A4QGHmzdTOfMVaAaM6L8q9plTuT3Qpr+RPu3g1J7VYdmahwk+avtgfEEurskC/lLw71R6Vx
	Atbq294jnL7GrAtb6Jbo3dcTQ39/DCmUkOi4IePtW5aDLQ3uILp6my4aeyEl9EdFldbY9d8axIK
	iwPmyhW3pLz+wcWivWDw7L/8keWQRdaN/pGwbFXqJLsyPHSdMIIiUOtJBjYzpWTbj0omxcBu4te
	f4fLCqYjGo6LlXsaFdJGOYuty88YscDD3fD4Rbvr/eZeqI5uM6zPHgQ8yIEshnsCeWr+p5LSm7y
	gFqvlSBnoywTEkSCpBlOtsIJew5kNIVsk5CcpGEowATgKs3ymWKbJ12EH5YnkUzwfVcufc+3RYW
	MrGmYX3dC8=
X-Received: by 2002:a05:6a20:3d09:b0:398:a060:a967 with SMTP id adf61e73a8af0-39fe3c79306mr20055750637.11.1776187119353;
        Tue, 14 Apr 2026 10:18:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c794d8f3984sm1878336a12.12.2026.04.14.10.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:18:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <04d3ab9e-8754-4a62-8b49-a865bfe5aa64@roeck-us.net>
Date: Tue, 14 Apr 2026 10:18:37 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Documentation: Refactored watchdog old doc
To: Sunny Patel <nueralspacetech@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 corbet@lwn.net, wim@linux-watchdog.org, rdunlap@infradead.org
References: <20260413041215.10362-1-nueralspacetech@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260413041215.10362-1-nueralspacetech@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/12/26 21:11, Sunny Patel wrote:
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

Reviewed-by: Guenter Roeck <linux@ropeck-us.net>

> ---
> 
> Changes in v5:
>    - Fixed WDIOC_GETTIMELEFT printf statement to correctly reference
>      "timeleft" instead of "timeout".
>    
> Changes in v4:
>    - Fixed WDIOS_DISABLECARD description: corrected inverted logic —
>      the ioctl disables the hardware timer entirely rather than
>      stopping pings. Clarified that userspace, not the kernel driver,
>      is primarily responsible for pinging under normal operation.
> 
>   Documentation/watchdog/watchdog-api.rst | 65 +++++++++++++++++++++----
>   1 file changed, 55 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
> index 78e228c272cf..736436a68f65 100644
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
> +    printf("The timeleft is %d seconds\n", timeleft);
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

