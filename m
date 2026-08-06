Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A442122D
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052518; cv=none; b=cLtsbL6vdiiJWFpkwvbuuCkeO2ymwvh/EFPLqq6BqpCtiojmtsS3Zg6AAXHUk5CbkZIbYYVaiWs8iTz01r4kctzqpCvUwB9sf2qu5yTi8e/UPpGFaTkRdsNVZWtNWUx2kqJ4hoqd60zglKW+woZRWDM28DBLIfnM1wdNisV23VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052518; c=relaxed/simple;
	bh=u4mYCUb7A6vXwqZPeaZnsDxDp6uqmLsrUiKWTgkQhH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qxd6w54Ok7D8s8lx5oM86XPo00COKfqfXsQPnuiK2qsKVUSMZsLPdC/3lv/IKLIRjsKXu0w72n3KhgaUaV9tvFNig0cF1Xm/YW3mwKEwb+OO6gHFHjny+KqjcvOKXRYT2AU3h8D1NKxC3GdHGT9l1O1hdrHUzABijMEjut2vNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCy8Ea8J; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCy8Ea8J"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso2408749a12.3
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052516; x=1786657316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8zBZKPK23TfXcgyMB9pk4gFPHhEbEq+i3z/pYrHxDl0=;
        b=kCy8Ea8JdElBBmnkyvsbv3vtqZ341JwHRWsWv4ojBfKKwBqKjLZd0sp3giv4TUuYvl
         HcryPAan2FzxtoRM9hoHLaIiR4LI2cTIeMhbo4XbXUnYAumO/+80gMuSQ0Ve3KY7iTFy
         vTId0eJzpCbcSxAk2rAaX+ykz9lXWl1gfrYTswPUWPPppLNyf5CadjOo9geYbGMRmC4t
         CKYg1+/k3pgn891t5daKXyZiNWeQuaCvF1KaAzBRNxRdLLXJGSDn0BxHTaC6T4HG3AM9
         fjVS/p+O/R4BXpHnpBbeM1DNwi0E4OWG+wiMXenxEwj+Y/Z95SzrJRZSM7Pz/HKSw1jP
         itQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052516; x=1786657316;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zBZKPK23TfXcgyMB9pk4gFPHhEbEq+i3z/pYrHxDl0=;
        b=pn8Kj63Lf3bliqPVg5LH1aU+kk9ZUMVG++6JYDc1OcAjv0Wds7tenJsWkwbuZUnmjj
         pA/k0kXSSuEydQbhnWUGvK0KIMElAUMNPWzvjkouvGBfTxeZ1fk7icWenfhI/RjBOLoQ
         MnY9EeWXeF2bqe7ixD96GWB2RSc5SHMAhgqYo6Du1sNTpJUi+G6ZnPKia7uQedhhEqF6
         PFgb9oqrCzO6U7seO5jS0ri64uZHYwZBkgX7h/8HV6ppluk6nw4lr2OpYfqSLzeTr+NA
         YS+9x4rEIRdJINFYhSrpfSTVTABOJml6+3yccsY1ayzPBqA87vcVvlFSqZpvPrbFG1lT
         xhZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/TXZUhLNHa1zHYimkNrWV2RSO/8FugEcEKaZZ0DijdBve+duwZg2/Bw4Y2szWJJmaALwAa0ipX4INasWufg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14RdARXsEyeuHjJGDcMeFdl5GV3dnT671S8ZTZOc/ZOd8pLBB
	jXTgrDmV/w4d9QtflqLLP+G8uO07eUw6mKm8IDsESV0itf66DnTJLSTq
X-Gm-Gg: AR+sD13upgiWbe9boVKtYMoZ/DIkMzr8VemtkpiXR8Z4QEldrkqVFOooPxEOjXappxX
	pyL1wQC3eakkOAtKWFo4xGpOAzz16lyyI0dLkp/blQ5OeczCDCGuxpF8sLvfqcHzVuxn0HWDVeW
	2dEIoxTwbY+Q7FcPmQ+DgGpKMQepvOybRsEuecCFI4zL5gTyJf0jLa12rkAAa7iGN4Y8rAbNNHY
	0K+b95xsvdKHq84gefub0fev8NA9u5D4M2GF0Vhd/zor3hciSG6x4SQMAleXoPUIJYyW7I5EDOI
	/1SH7EV24B0i4iBulwY5JQS83kY8mBjZonF8w88q963bMr4rsFodUGsuc5wLLLqgZq1FMAQM+sw
	mDA3OuLuFfNK/UqIUGN+sobwjCzqCWURzrEd0No3Wgn+YHdB5tAooFwUyPaG+llYtXFtooVbJpW
	xHy4tgkn5WMI5wK+91XkgTHVb4TXI4GiAL3xl6HY7Xfbb0JkWz/EE3KjQ37sP6Kz1mg8tlDpoeI
	g==
X-Received: by 2002:a05:6a21:1bc1:b0:3c1:c6e:9360 with SMTP id adf61e73a8af0-3cb85f4a60bmr21408761637.32.1786052516422;
        Thu, 06 Aug 2026 14:41:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bca44c9fsm324948eec.17.2026.08.06.14.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:41:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:41:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mayank Rungta <mrungta@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: pretimeout: Convert dump pretimeout
 governor to tristate
Message-ID: <bba685f6-5497-46bf-b4b0-b35829f74edd@roeck-us.net>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
 <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>

On Thu, Jul 30, 2026 at 03:00:22PM -0700, Mayank Rungta wrote:
> From: Mayank Rungta <mrungta@google.com>
> 
> Commit 645ad41da8b2 ("watchdog: pretimeout: Add "dump" pretimeout
> governor") added the "dump" watchdog pretimeout governor, but restricted
> it to built-in code because trigger_all_cpu_backtrace() was not exported
> to loadable modules.
> 
> Now that CPU backtrace APIs are supported for loadable kernel modules
> via cpumask_backtrace(), convert WATCHDOG_PRETIMEOUT_GOV_DUMP to
> tristate. This allows kernels to deliver the pretimeout governor as a
> loadable kernel module.
> 
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

As mentioned in the other patch, I can not apply the series without Ack
from a maintainer. In case someone else wants to pick it up instead:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9f013d774897..922741dd837c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -99,8 +99,8 @@ config WATCHDOG_PRETIMEOUT_GOV_SEL
>  if WATCHDOG_PRETIMEOUT_GOV
>  
>  config WATCHDOG_PRETIMEOUT_GOV_DUMP
> -	bool "Dump watchdog pretimeout governor"
> -	depends on WATCHDOG_CORE=y
> +	tristate "Dump watchdog pretimeout governor"
> +	depends on WATCHDOG_CORE
>  	default WATCHDOG_CORE
>  	help
>  	  Dump watchdog pretimeout governor, all cpu backtrace is
