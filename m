Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A439475;
	Fri, 10 Apr 2026 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781107; cv=none; b=o1ClkByOx6Y3iAodWmRNCMsaX5rFfXh6qw/96nw+OpxGsM2xTNK7wOe7sppKMDSNj2U4z5TicNSEztro27aPg+XJwxwGR30iilF34tqywF1WAOFFYFZBW5fq7ZHiSfgAGA4+y/i/vS8HvjEoQeCkvKki8HrAQ+hodbwQlcn32To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781107; c=relaxed/simple;
	bh=nsMOD0l+cpVlUFsTsP37+7HhClYqt9d7DhgNOT57EKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3KQosbQ0qjQYd6eMsVtkmC+QcRlWZIWx54kzRjHkoYV89Go0Tn/Y3ao2Dk91M8OlDFukjKD++AXm+UUpNZs6lSm+bwMQdisb5t8n+MqMVCWkAyxDOKOiXbZcUAAkUdU021zKUwrqEI5agAV8oJDF/9YU4iTRiT2vauv2V/oxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mabDgb/H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mabDgb/H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1zftIdX5l6y+9hrN2wzhZP9TRyUmnOK22yO1ySxmJis=; b=mabDgb/HlXu3Fbp0j692HDggiT
	gqXpX96vgEbTAuX0+P6cPBnr3vRAI8bSXM4s1GMZCg5nl5KrLHi3r+sS6Afm1EAy1E3PDKMhB/va6
	DG9KJqFkYdjuW5eRhLVP6s3wboYX/jLTNSKj27aEjhPF6vhKBoKvdvkXYQ9dzRHZhcQsgyrDOdoU0
	V62Ge/WxQZncfXREQ07NuTKooVYepFVNQfRUeH4KNGgWx/Y2Rc5D4N7TIhXPZZdzbW1GbQeODfcjD
	Xf/H4dmF9Jh5Ca42NQvlMP8ff/Ff+sQvR8UBepZK/J8TukyfdjG05sLxoG6+hCVKXMOVbWkaYzIR9
	Y+xb3ytA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAzmh-0000000BN4F-498u;
	Fri, 10 Apr 2026 00:31:44 +0000
Message-ID: <9e3403a0-4ec2-4fbe-a50f-53f939c1d841@infradead.org>
Date: Thu, 9 Apr 2026 17:31:42 -0700
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
 Guenter Roeck <linux@roeck-us.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260409175301.22902-1-nueralspacetech@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260409175301.22902-1-nueralspacetech@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/26 10:53 AM, Sunny Patel wrote:
> Revisited old doc of watchdog and did some cleanup.
> Also added support for new api in doc.
> 
> Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
> ---
>  Documentation/watchdog/watchdog-api.rst | 49 +++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
> index 78e228c272cf..446f961852ec 100644
> --- a/Documentation/watchdog/watchdog-api.rst
> +++ b/Documentation/watchdog/watchdog-api.rst
> @@ -2,7 +2,7 @@
>  The Linux Watchdog driver API
>  =============================
>  
> -Last reviewed: 10/05/2007
> +Last reviewed: 04/08/2026
>  
>  
>  
> @@ -106,11 +106,10 @@ the requested one due to limitation of the hardware::
>  This example might actually print "The timeout was set to 60 seconds"
>  if the device has a granularity of minutes for its timeout.
>  
> -Starting with the Linux 2.4.18 kernel, it is possible to query the
> -current timeout using the GETTIMEOUT ioctl::
> +It is also possible to get the current timeout with the GETTIMEOUT ioctl::
>  

These 3 printf() deletions of /was/ are included in my 5-patch series:
https://lore.kernel.org/linux-watchdog/20260228010402.2389343-1-rdunlap@infradead.org/


>      ioctl(fd, WDIOC_GETTIMEOUT, &timeout);
> -    printf("The timeout was is %d seconds\n", timeout);
> +    printf("The timeout is %d seconds\n", timeout);
>  
>  Pretimeouts
>  ===========
> @@ -133,7 +132,7 @@ seconds.  Setting a pretimeout to zero disables it.
>  There is also a get function for getting the pretimeout::
>  
>      ioctl(fd, WDIOC_GETPRETIMEOUT, &timeout);
> -    printf("The pretimeout was is %d seconds\n", timeout);
> +    printf("The pretimeout is %d seconds\n", timeout);
>  
>  Not all watchdog drivers will support a pretimeout.
>  
> @@ -145,7 +144,7 @@ before the system will reboot. The WDIOC_GETTIMELEFT is the ioctl
>  that returns the number of seconds before reboot::
>  
>      ioctl(fd, WDIOC_GETTIMELEFT, &timeleft);
> -    printf("The timeout was is %d seconds\n", timeleft);
> +    printf("The timeout is %d seconds\n", timeleft);
>  
>  Environmental monitoring
>  ========================
> @@ -227,12 +226,33 @@ The watchdog saw a keepalive ping since it was last queried.
>  	WDIOF_SETTIMEOUT	Can set/get the timeout
>  	================	=======================
>  
> -The watchdog can do pretimeouts.
> +The watchdog supports  timeout set/get via the WDIOC_SETTIMEOUT and
> +WDIOC_GETTIMEOUT ioctls.
>  
>  	================	================================
>  	WDIOF_PRETIMEOUT	Pretimeout (in seconds), get/set
>  	================	================================
>  
> +The watchdog supports a pretimeout, a warning interrupt that fires before
> +the actual reboot tiemout. USE WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT

                              Use

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

Documentation/watchdog/watchdog-api.rst:250: ERROR: Malformed table.
Text in column margin in table line 2.

================        ================================
WDIOF_ALARMONLY     Not a reboot watchdog
================        ================================

Please test your patches.

> +
> +The watchdog will not reboot the system when it expires. Instead it
> +triggers a management or other external alarm. Userspace should not
> +rely on a system reboot occurring.
>  
>  For those drivers that return any bits set in the option field, the
>  GETSTATUS and GETBOOTSTATUS ioctls can be used to ask for the current
> @@ -268,4 +288,17 @@ The following options are available:
>  	WDIOS_TEMPPANIC		Kernel panic on temperature trip
>  	=================	================================
>  
> -[FIXME -- better explanations]
> +``WDIOS_DISABLECARD`` stops the watchdog timer. The driver will cease
> +pinging the hardware watchdog, allowing a controlled shutdown without
> +a forced reboot. This is equivalent to the watchdog being disarmed.
> +
> +``WDIOS_ENABLECARD`` starts the watchdog timer. if the watchdog was
> +previously stopped via ``WDIOS_DISABLECARD``,this will re-enable it. The

                                               , this

> +hardware watchdog will begin counting down from the configured timeout.
> +
> +``WDIOS_TEMPPANIC`` enables temperature-based kernel panic. When set,
> +the driver will call ``panic()`` (or ``kernel_power_off()`` on some
> +drivers) if the hardware temperature sensor exceeds its threshold,
> +rather than only setting the ``WDIOF_OVERHEAT`` status bit. Support
> +for this option  is driver-specific, not all watchdog drivers implement

                       driver-specific; not all

> +temperature monitoring.
> \ No newline at end of file

warning: ^^^^^^^^^^^^^^^^

-- 
~Randy

