Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FF55C33F
	for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083728; cv=none; b=ASWb5JRAAUBj4g6GVlk8jj8BvEQckNEgp6IkV4fewamlubWo9124/gFPB9kJ7MvrEtgbqpi/nOzqyjM/ciOWJN2yv8j2cq96dtHo7lgLN2vZKIjtifNdt8627a/JwjgUvHEHhlrGDrfFX6eYOpKu47e5ncz5fgjFCHxJv0OftHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083728; c=relaxed/simple;
	bh=b3ykcdzu5139p8lLJR0aJjrtvtqRBGOs4S9A4CZdy80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRQ1pf0htUOrp3b44ga3/zAPMgxWcY4fWXgWZ9FjaY76SdvEC9U1ci/u9/7Tni6kbnYHuNlYAaoL9k5MkKcDcXWh6nhG6FNH8X6eWSCnD/+o+Vj2PxwrWTQWdfGVJDy45thFUjPMZ1uWzccuE/WrO1Q0zeefmKmXRdQC+6yOYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxq+FRxQ; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxq+FRxQ"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8692a8568e9so3546681b3a.3
        for <linux-watchdog@vger.kernel.org>; Tue, 22 Sep 2026 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790083725; x=1790688525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6eUa3MEmKBKqWKJ7eHJvPbt6Q+Vwkf3VRBTTs/7k78=;
        b=lxq+FRxQVS15moXqWve64Z/vTsn+U+UMWsGUGQOZBIxeWtyg+uhCVQEHUQezCrlNzM
         tkkzt32uqw26bvfWblQ2tElEZ4+K9pQAIF9cIcqNCBvVRfGCmGBYKT2ovt8pE5kr60W5
         Vh4Z+3ybb1qoiIk3pqTI+rBuWJEhbd2Uvt7sMtW3UqZwUhPj8DchDEQT1EVOZrtmDTK0
         dAH8eBZfrAqSauy4XdpeGoN7ofHbDDuYNeWZg+8KD5GRgNnbKbu96IFGNrchuern5YCe
         ih6uxZgfqHd0ezDc9OUal8M9M5B57PluwftMxzHyhiACc8LAol7u8i93G6CrbM5ZMk2c
         1Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083725; x=1790688525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6eUa3MEmKBKqWKJ7eHJvPbt6Q+Vwkf3VRBTTs/7k78=;
        b=QDCU9ZZTHiCPbJTZF5cMb4t9kKvFSrWMjM0cPwU30ecm9nnx1GWICEPNrbUePbH4eL
         W2+UKWl3iC/kjz0uZcVPuMnZdPiBTE5/ZxkLMpPd1CLVEOspBODbUgKYwOlVayfwVWbU
         qWyE8yJ6Yl2b9Z8/zPAVxU5npibUWOI9cyiXaP5fUx5Q5Esr+VZbW8HQC7eTa6JwHsdZ
         HekPXNv3rmqhDrS7+yACcyH+nXHxhmhgnPxP17yHzN4uqViuRMDg7fjcwopCiWFsZebV
         7QbuhCKjKmZ4NFeDFfrvj1NzMj8We5p6Xyan3Ec69H/jML/4wOQBkHGiMmrfPIWU8y7o
         g3NQ==
X-Forwarded-Encrypted: i=1; AKwUvBzC0X3M2JCa2nSb2SbfMvWf5f0JL/5jrbQ2e3JZH0pzB+N30938zCa6VFY4Vh2PCQ4D3XSXEenqum79oT8wdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lnUnLeFAnF8Y8WelzqY7cWYND0uDPN4TKLdkDkLjjGmO02XFNn
	sZnhJYTw4ApYn9vm3q/WA2yGKRywdf9Ag69U8g3gJGFzB7+8v0N8CuC2
X-Gm-Gg: AYBFou1kidCfr8aQrYmF9G44WBHRu28tNOl14lTdP7mFQAwFbcD4RV8lzpGQWPwVoNJ
	hIWEmPFDBCCW2xJVcpZAcV2vMa+zoDCIdR2oeEvT87CSMuKYqHRiGhjYCTsXWbJpoUKnQLvzcpf
	ZYOAcyubOsAt2obrFdjIQ3pcRYc/9/7vKBhzdO38KmAkuUsnLsYNOZ1Gq1wSUFkRqnLpmWbB7o0
	jjItMT4E8egDDPECSBkcIwuz4TXZ9i4prndI/KAB7G+UqCIdGefrFiNhFwuE+5W5/jBHKV8jQhZ
	+6N6uBZ5vhHhKZhWn/qSNlgPncl1MEw3p3pAxF3/eaHRW5IFhyYYs5r/C65wPnIfdUX2sGkQ1Wu
	EfugIWxcbjnoR/rZpBlBvOW1FhDPWuq4qgCMSPFMLV4tZO77ZuoA/3o3HjDu8fKj4fb8rPtEEvl
	I9ij9vBl9izYL0rhcslQDOwcolEebn9NmLq5Ces8mmznumwm8JpIGTP9HCclDcAQ9elveOZTEdL
	X4EHiYIr0KI
X-Received: by 2002:a05:6a00:a115:b0:879:ffd9:1286 with SMTP id d2e1a72fcca58-87c81ebbbacmr1272041b3a.8.1790083724286;
        Tue, 22 Sep 2026 06:28:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c32fa89absm852763b3a.46.2026.09.22.06.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:28:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 22 Sep 2026 06:28:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?utf-8?B?5p6X5r+s5ZOy?= <m18667909625@163.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: use kstrtouint to parse
 softlockup_panic=
Message-ID: <e5bc7dc4-3faa-491f-9c8d-62afe0be0bbd@roeck-us.net>
References: <20260921064143.81420-1-m18667909625@163.com>
 <7b91e8cb-d068-484c-9a9f-2c19cb37f5ba@roeck-us.net>
 <20260922060000.10086.1-m18667909625@163.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922060000.10086.1-m18667909625@163.com>

On Tue, Sep 22, 2026 at 01:50:40PM +0800, 林濬哲 wrote:
> 
> simple_strtoul() is deprecated. Replace it with kstrtouint(). A bad
> value now leaves the variable unchanged and produces a warning,
> instead of being silently clamped.
> 
> __setup() handlers return whether they handled the option; there is
> no way to propagate parse errors, so the handler simply returns 1.
> 
> v2: warn on a bad value and return 1 instead of returning the parse
>     error, which __setup() handlers cannot do (Guenter Roeck).
> 
> Signed-off-by: Lin Junzhe <m18667909625@163.com>
> Assisted-by: AI coding assistant (disclosed per kernel AI guidelines)
> ---
>  kernel/watchdog.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index e5134ad7b663..7f8c904554a9 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -17,6 +17,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdesc.h>
>  #include <linux/kernel_stat.h>
> +#include <linux/kstrtox.h>
>  #include <linux/kvm_para.h>
>  #include <linux/math64.h>
>  #include <linux/mm.h>
> @@ -422,7 +423,11 @@ static unsigned long soft_lockup_nmi_warn;
>  
>  static int __init softlockup_panic_setup(char *str)
>  {
> -	softlockup_panic = simple_strtoul(str, NULL, 0);
> +	int ret;
> +
> +	ret = kstrtouint(str, 0, &softlockup_panic);
> +	if (ret)
> +		pr_warn("softlockup_panic: bad option string '%s'\n", str);

Hardly any other __setup function warns here, and I do not see the point
adding it here.

Guenter

>  	return 1;
>  }
>  __setup("softlockup_panic=", softlockup_panic_setup);
> -- 
> 2.54.0.windows.1
> 
> 
