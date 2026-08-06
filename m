Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE31E5B68
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051949; cv=none; b=Rm64BPZL9sCGAIHvEybzZ89SFvee2JWT0V9QD6sVF7867jlesc6dUFuaa96C+CE9IHV7hbSXf3p82E8hUrMhOTa1JYABBI8519p3p+G+kdfj7RvdIeDvPll5N/LjUwePUD0UVEi42ByK1K6bgirgDLeKe2ZmZcU51bnbAWKci2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051949; c=relaxed/simple;
	bh=YnwxsCul3+jkThFLF+9y5J+N84ltifMob70I4GtiKEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMOLPjCHBRvtK9MmINhXSvezIB+OVkz+hzjZuhYHKS96Eone5oxOFETgbKgvct4uUx36HuDIpG6O7YvqwlmXgCUmdRzQEmzuwCL95/YedEaAz0BtkVNVLfct0lDRfkyTudAgsjMFY2qUxSOFnkQsDEsTspBLYZSN2ZI03IxlapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqyJ0TVM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqyJ0TVM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d049069377so29335695ad.0
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051948; x=1786656748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6vf8m71Thf7y7jGfiPJQl4yxKA5uMf4oLhl2ZsCsSRA=;
        b=KqyJ0TVMowEdUdHD9xb4zWG558el3MUypB9BHpWatby3aFAIIWvd+Ybv9fR07SMUai
         wDOxeMggS4bjcdATyR6CIcdAUlkoq3YajdEP+g22hvOfHPmNj+8hVYZXQtkLCaXo5VqN
         u47Dv4SdsnViO9oRO/19hlXSdiS6K6FKh10/PFGVKGmmDIwHRxtrtVvgMnuYb9rNiexZ
         +GKscQWf99eBvD1DNA/9+3vhJySEjQjIIc0bnpd1+GF5KMzp9lk2W8v7Kn5edLvyYfMR
         Wmxo/FEFr1PgIUlnhL38pk8ZJHdPD6i63I/MGJ+yUTBskkwcXwobGQ4CcU7Jfs3mzQNo
         4+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051948; x=1786656748;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vf8m71Thf7y7jGfiPJQl4yxKA5uMf4oLhl2ZsCsSRA=;
        b=ATYH7/oPEi+6VUWIEIpFSm/3tce6Xk/NAG85FS3iPTPhgccwbpA4oFjC0sx0bnO9J7
         wzuSGIbGjOgUmdAgORtQOvtlP8faihRkbhsLFENVM4fzn4bw5ZKtEXfkvbXBx0aatxjc
         WN8GVzkM38OJG/iO5E+OQF1dUZofcLdiUuvjN41wl3kuU39e5kgf+rp+5K7iVFpSznKZ
         HfCLoMqFj0VqY8250Ofjt1VEI7c21Uw56AGFuQ1FWJVdIA+y3hdI8fBoukv5pCeiITjq
         UOrl6A1d1su9AnQJL+OvL6AuZTvg/h4kVNisPY0Kmabk9BGefRTHwCyZUYbC/6/oqSE6
         tq9g==
X-Forwarded-Encrypted: i=1; AHgh+RpLBfk+JQfmmS5kx/5THPJpjUeD8f/x+8ZpYHM5uDCyEhFzHu3o9+UbJP9Abj/qhw0+5KiQt9t+Dxxc17fjQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxotNa1s5oxH2XVsg8h3xy44nB3vdB4SBagiUZlYZqBRZ6WTNLr
	tmK6pnuNropuPl9oG8QKOclKFJktJDHoS0pPRXbcVqgfZZoneuw0dleJ
X-Gm-Gg: AR+sD10BCPJLcI9J/s/gsw8X0wOA0S9AgMQ6Orv0aiF0PJSTDlsFeuQmOXSdXuvilpA
	wjs/Vv6CjUpzc+NuC4T7DIliD2TAHtu9PQ1ee92qHs/yFluSdp6UUUIL2vnwQabqyOCPCdIg4qt
	IR1u9Qy6sijWvKwpcYNxZ0FUXC7OPv2igkIs0JfhngYm/gUmYQmTgTUfInlQ1FA614I+npBVyH0
	jn6bGMSfW5UV7G26btYnp6S+5UYKeITUN1rMy3mAUUsMEWtADwESl3aru4UGyGChztiM9ARrUp/
	S/nEK8sHwGhPawthagrW8/WNkA7IK88s5Pse9I0y3M5WIUa1rAdHkiOjapF/MPpr1ApLWZXhyJu
	a6fcKx0xPjLEbh6gCHiCd4j2HYzJFsniRPFuXIXunFe0U88pTBISUuC/go1m6s4ukPFqFMFORbx
	NgVoTNtMr8Tc7hcl220YFc+kGKH1YpmhnDVUwwY5yM8sgmEVpGYNCm4Mex7j+OPNZieAVTtRLMa
	UViJdCfUu8z4C/QZE9bp/1p
X-Received: by 2002:a17:903:8c5:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2d106e99159mr54741385ad.22.1786051948008;
        Thu, 06 Aug 2026 14:32:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4e957esm235465ad.75.2026.08.06.14.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:32:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:32:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: wdrtas: Fix kernel-doc parameter name for
 wdrtas_reboot()
Message-ID: <cb17b508-71fe-4c74-bdc2-58d622b7eef5@roeck-us.net>
References: <20260730060617.7-1-bbnpreetsingh@gmail.com>
 <20260730060617.7-2-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730060617.7-2-bbnpreetsingh@gmail.com>

On Thu, Jul 30, 2026 at 06:06:16AM +0000, Babanpreet Singh wrote:
> scripts/kernel-doc -none reports:
> 
>   Warning: drivers/watchdog/wdrtas.c:460 function parameter 'this' not
>   described in 'wdrtas_reboot'
>   Warning: drivers/watchdog/wdrtas.c:460 Excess function parameter 'nb'
>   description in 'wdrtas_reboot'
> 
> wdrtas_reboot() names its notifier block argument 'this', but the
> kernel-doc comment documents a parameter named 'nb'.
> 
> Update the kernel-doc comment to document the 'this' parameter.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

This is a 20+ years old driver which doesn't use the watchdog subsystem.
I am not going to apply any patches to it unless the author shows that
it is a real problem observed on real hardware, and then I am likely
going to ask for a conversion to the watchdog subsystem unlesss it is
a critical aproblem and not just something AI came up with as a possible
issue.

Guenter

> ---
>  drivers/watchdog/wdrtas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
> index d4fe0bc822116..6c25171de224e 100644
> --- a/drivers/watchdog/wdrtas.c
> +++ b/drivers/watchdog/wdrtas.c
> @@ -448,7 +448,7 @@ static int wdrtas_temp_close(struct inode *inode, struct file *file)
>  
>  /**
>   * wdrtas_reboot - reboot notifier function
> - * @nb: notifier block structure
> + * @this: notifier block structure
>   * @code: reboot code
>   * @ptr: unused
>   *
