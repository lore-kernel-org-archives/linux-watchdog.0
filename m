Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9717A2E8
	for <linux-watchdog@vger.kernel.org>; Sat, 28 Feb 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772243653; cv=none; b=YJ6OmLi+QEjQ9tmOZM03sYgeOS5Kvqq1CwO+tskaO+queis0H8aUaRiKBJmm5H2zaUKgGfeh28PXmypLgIvLeIMukc03FHEsddSTyXryS1KCZi7niat3iOnXO4mvXE9cG2dzm8C2FQnk7aU5fn7drhNsf4IrVBkfXfSPVcezhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772243653; c=relaxed/simple;
	bh=+nVea+1LEhc7u1RV0hreJFi+NiRMUkXwmpuRGxuDlD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohCJDQtD3c882FPvKcSR18xHJtUCJJVLPTSJ064zr83N+JKdVH062S2yb75PE2O7EU+Zt3W2NPK9NqXEwN2DGXVBFH3YxM4Io7+ultz3gSpiegWwaeER5Ex4jLaeqvKJYxFMu6kbtdqMclmwklYlny0V4a4f4BCrMQE0gx8BCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZAwnWUb; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZAwnWUb"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bded9bf7a7so914319eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 27 Feb 2026 17:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772243651; x=1772848451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxQavnKskrdCHrZOEdg/KgmOqoLnQplqpgSz9FhP/tE=;
        b=JZAwnWUbJkZecHj2JUwxuXKnd74bOc7ZTCuWpqEDb5lq1SXSeabsBY6Uqa7fFFHNAi
         0r2eaelqc5zRqDu3eQf2U3o3/Z0Rr76TV7wwMiXe/eL/ioclBQkWiU5MRmr99N43c5tH
         eaTspbqR1eX9/G2kdqVQ2wnBP8tlsEkIbP/RVqgTpvItVzzrgxDZtvsdgqGO7nG9/bWX
         vuftLB/ZQ+GxRMU/DUaLrem4nYh84NMbId7JS0wIDCNlh2B8Kd9JFBKiywFdqaneLPYC
         xomRhAM1HwJ/RLUJ4HHLwcolfrYd5hJ8mK3VK16/AavinBUMcbeNTB0+CHhuUIY69W3p
         fzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772243651; x=1772848451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TxQavnKskrdCHrZOEdg/KgmOqoLnQplqpgSz9FhP/tE=;
        b=gFnGPMvA9YpYGkyJimyivk7sKQ2wmr8gbmAMkPOWbBhS2+Tb5eRgS76aHIgloZ25aa
         2gbb29v7Fo66stYlG6VtSq0tWsHyilBf8z2C71+3EGSHBEfor/moh6uMMcIwAbF3qTUC
         hIW4Pfp7mnyXPl00eBncjegRD8YtH7NSbcmiBKDnVAuvDjT6YBLAfMakRv2nH+DdVUyQ
         wSTmJasQ2OSrSg60zvvqoTwWqP9x3sGY3zormC3yheJLf6nlwz/zovMyGmDwAMJjTYAP
         IPiDiI5S8MS6qjZZ0IpJXgh+F+sLcZwgDFouNKUbIPng9wq712oyMVKh1pIrGJjtJH7v
         qUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiyERULxhOMlkqKfB+AvnUYfpB4qqjIjTQoidgpwBNbwIjcwUSezbP/6gL5LjPMrVVwT0njOmpPYv/ifBK9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUDHadkxBgJBuA+6znojobnkSRIkorgx8CjaXSef8kCtl6TRg
	GhpnS0/lEnjWhNsaSDTNWh+0vwswEI6bublDGkvvfzOrTIHqkSGr7tGpLHISX0cd
X-Gm-Gg: ATEYQzyIwqhb9DPwW2wnpmVbkE+ADxBSGkOt17Mj8CUdnrOwMA8mGG6Q0zYfe7+3qCZ
	KEoRBodLA0Z6L+5R57dJIqzzAhVfoBz63nirDTjSHmH9BknNjsjc9IKnourNTL1qhyiHzGenZMa
	ywStrH1YkaCPC1IoMrZdXeAw8dCSElj3QRtam6pK1hBNHMElXRWokck3rwdXRz8NaKlyGiQPnON
	pQcsVxSR0WBrYDYKwfNyQeEs37nt3g0OAXCuzWWKJ3uqHA9Y6HfRnGyeIJ3rYdkR3LZu8GIENlN
	G+vROcNNWFXjRY6iXxUdl9F2XHGjDiQHxCywfzSSFKEYiOmPZOdm5FOu/SsNaOQBOhA2iXyWq3L
	h4KjO1IFZDCDBFJMR8RIB8qPFsc+6pazTaf19AjmIAbndUU1dqugfGK0TRZco7NhN0zjHax3KFJ
	hxbCKlV3mWvFBbnf7C8Zz0ykM0mhXwuQ83GLYK
X-Received: by 2002:a05:7300:ec17:b0:2b4:7e6b:9c00 with SMTP id 5a478bee46e88-2bde1efba9dmr1980138eec.23.1772243651044;
        Fri, 27 Feb 2026 17:54:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1e02f95sm4977756eec.13.2026.02.27.17.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 17:54:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 27 Feb 2026 17:54:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/5] docs: watchdog-parameters: add missing watchdog_core
 parameters
Message-ID: <35acf767-986c-44f7-b167-ae9aec2449de@roeck-us.net>
References: <20260228010402.2389343-1-rdunlap@infradead.org>
 <20260228010402.2389343-6-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228010402.2389343-6-rdunlap@infradead.org>

On Fri, Feb 27, 2026 at 05:04:02PM -0800, Randy Dunlap wrote:
> Add missing watchdog_core parameters (handle_boot_enabled and
> stop_on_reboot).
> Add default values for handle_boot_enabled and open_timeout.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> 
>  Documentation/watchdog/watchdog-parameters.rst |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> --- linux-next-20260227.orig/Documentation/watchdog/watchdog-parameters.rst
> +++ linux-next-20260227/Documentation/watchdog/watchdog-parameters.rst
> @@ -14,13 +14,22 @@ modules.
>  -------------------------------------------------
>  
>  watchdog core:
> +    handle_boot_enabled:
> +	Watchdog core auto-updates boot-enabled watchdogs before userspace
> +	takes over. Default is set by the kconfig option
> +	CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED.
> +
>      open_timeout:
>  	Maximum time, in seconds, for which the watchdog framework will take
>  	care of pinging a running hardware watchdog until userspace opens the
>  	corresponding /dev/watchdogN device. A value of 0 means an infinite
>  	timeout. Setting this to a non-zero value can be useful to ensure that
>  	either userspace comes up properly, or the board gets reset and allows
> -	fallback logic in the bootloader to try something else.
> +	fallback logic in the bootloader to try something else. Default is set
> +	by the kconfig option CONFIG_WATCHDOG_OPEN_TIMEOUT.
> +
> +    stop_on_reboot:
> +	Stops watchdogs on reboot (0 = keep watching, 1 = stop).
>  
>  -------------------------------------------------
>  
