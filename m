Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DE5616B8
	for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092959; cv=none; b=QFN4wZ43+QUatg3i2HYG9hEsMzr9oJYAQHSAEu56NkFk66HtZHB9qewV68Ep/EBUw78RIEJb6lYBqGcbTfh8SLErB8CTYPDQvREQBl7suPE7DARA6wj1JopqVvKQDPssCp2jIVzzliFG3c5cPhPqbs7V08Fb2JuiZyqo5Mt9tlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092959; c=relaxed/simple;
	bh=5Nc0E6uhwpOLhJ5EtHZx20sCq0FgvYX46L8SSfikNeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0HohCypR9jkwYrTIKqWp7pEnJ403h1atl8+9xI7ZhBIm+lJ5AFeCdBcnoaA44nor2UgU63FYWN/hHIaTjUhortCiBBvivAGiKUjtLPVHsZxjySMUpx5v5Wn8HwvITyJiFKIDn6uzwifxecb7+TwU5iSZirtXK42PqWowmJFOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAWVTpG6; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAWVTpG6"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so55431a91.3
        for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092957; x=1790697757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8E+kKwSqex3XXbBNJuLlbTD55wWaphcALCZWnc93Tss=;
        b=kAWVTpG61PfZEqBghapa4FkH+n0/je7fAbyKOffmykoRIVutLO3HoKdrV/aM5TzBD0
         ZcJoi3xSUUnIH2l6ehWzMwzIjpQ+LM/AOnRDp84l6tvEtRIkJWxYEOn5qBZWm6WRWVdN
         UI8vSOEFDetuQZFR3frcxzLzsZmeKMx/M+IpJxPJIVuK9pxBTTI4fDu6g2H4rEIUqUBK
         HeFPcpj/acQ4GPzOcFSNLLCwF2VvcVxjFxQ8TitM9N5QOuKLucytqnXYq9LrxK+IDpDm
         Z/SW0tX66S+udVCrzB/n5JRj7R7qZ8YPlTiYekUNMItUsomwPWdKawBTCrqoghcxNQNp
         wf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092957; x=1790697757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8E+kKwSqex3XXbBNJuLlbTD55wWaphcALCZWnc93Tss=;
        b=SPQgf8G0Ez5QVk5yUT8UK4549LxOuntzBrMYY+EORRAMkJf4CiTq5AnP3BEnBkP3Mw
         tepwi5qvO+hXvp/hCQUfXRzUxjX72SSWGw2dA6t5PBPPnOHacdokBERiDgzl+K8plrFH
         chT1+EOL7ygCYxitqYWNIbH3LC1HKxfaF0vfAqAG5P1z6WaABxDvBPEx66IO2aZStGMa
         NqqK7llaJTCTfpm1KTTOQi9YsDEkMpbp+L2kdiheKzyUBT+2NaAsia10zM/k/FY4aaLu
         prmsjwOv9qQx5RQH9VxHsVjhjmhUYSkWABxmgGFhmf7BMj1EcsjQOGNmtO0vbyp/5vYV
         Ps+A==
X-Forwarded-Encrypted: i=1; AKwUvBwXak/jpmYM6cuQnahs+7tX+f7BCUThW3Rpuh67g3j+Xc1hAKy+1uQj1BhsvrW2gdt8hL4F0KTTGpXnlhedLw==@vger.kernel.org
X-Gm-Message-State: AFuF++lYcQqaMqxOu26/MyRWmsBSJf7qR+XT8eu+L1SPYjtpWNHM2fi8
	jnYxL2M6Mczz2uc9OkuwpTMjA0hmJ5km8/xX/c8F6JP4nVhQjGuJ7+s6
X-Gm-Gg: AYBFou32k+uHep2WtDl8amTqUTHn8NYPLkxiDIV5ZimsuFd4BLW2Bs/yeXb8YohhGRd
	/b+4QlwqvpqjBF6RImx7fMXP1fCRXX6V9VsIR/JOPRq4YGGcuPrWUNor8+hCTZ1Ob1Gr3yuCE0Z
	JK6fYe4WSwQWMDoYUKbKqm0DBST+6se9Cn7kmjM90FOweUpe7G7zVwhk96q6VmPDBI3VardjMOP
	tcKZSRh2nCayM++DJZep6JX3ByX+FXy/65VhfMfIjQ4toiTYso8e7WUhHPIWj2AWhV1f1m+MiET
	ibDyyVn+vKt3GAsvh4XV1IkAWosJNrYpx13JUWwY/r/8zmmogeGEm5uFAJhw2tOBso5hsY23t5u
	Y9Hn8Xqr8KUSWqkj0lrJlBYZ54iSQBFM8t800a2zPVYVoFjYD+DwoJMWMpKc7A70LCm2TLp1uJV
	/1BgJLutC+msUiYEOhmEFyD/U+XIDjWFNdckyPunifiklMw1o4tTnhYCujYguo9taA0PRnSP700
	2UKaFo+BTMg
X-Received: by 2002:a17:90b:5826:b0:39e:6c68:c777 with SMTP id 98e67ed59e1d1-3a073234153mr1714050a91.45.1790092956933;
        Tue, 22 Sep 2026 09:02:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07db882a5sm109505a91.1.2026.09.22.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:02:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 22 Sep 2026 09:02:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?utf-8?B?5p6X5r+s5ZOy?= <m18667909625@163.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: use kstrtouint to parse
 softlockup_panic=
Message-ID: <f2d5714b-6277-436b-9be7-f5cff30c7b76@roeck-us.net>
References: <20260921064143.81420-1-m18667909625@163.com>
 <7b91e8cb-d068-484c-9a9f-2c19cb37f5ba@roeck-us.net>
 <e5bc7dc4-3faa-491f-9c8d-62afe0be0bbd@roeck-us.net>
 <20260922153000.10086.2-m18667909625@163.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922153000.10086.2-m18667909625@163.com>

On Tue, Sep 22, 2026 at 10:49:52PM +0800, 林濬哲 wrote:
> 
> simple_strtoul() is deprecated. Use kstrtouint() instead; on a parse
> error the variable is now left unchanged instead of being silently
> clamped.
> 
> __setup() handlers return whether they handled the option and cannot
> propagate parse errors, so the handler simply returns 1.
> 
> v3: do not warn on parse errors (Guenter Roeck).
> 
> Signed-off-by: Lin Junzhe <m18667909625@163.com>
> Assisted-by: AI coding assistant (per kernel AI guidelines)
> ---
>  kernel/watchdog.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 420f08140713..69cd5ebb4929 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -423,10 +423,11 @@ static unsigned long soft_lockup_nmi_warn;
>  
>  static int __init softlockup_panic_setup(char *str)
>  {
> -	int ret;
> +	unsigned int val;
>  
> -	ret = kstrtouint(str, 0, &softlockup_panic);
> -	return ret ? ret : 1;
> +	if (!kstrtouint(str, 0, &val))
> +		softlockup_panic = val;
> +	return 1;

This is not v3, it is a patch applied on top of a previous version,
and it unnecessarily introduces a temporary variable.

Guenter
