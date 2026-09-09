Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F0476697
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986923; cv=none; b=oITcx54Zk5XzJuOzoM9gRnQIcEjz69caxsEs3nmbOF3pD3R7g/2Pjzm6qXcSB+TMeS6g8I/WyBPfdVSwlgnmkxcjcF+BL585Ddp6L6+b9eHCxhHAPhxFHr8iTu/EHwEOTiB+Co/Kj+DPJrnewgA9zu5t5A7UJtnwqDA0wS58G9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986923; c=relaxed/simple;
	bh=07LNECGhqbxuDE3/ezerltiEZk0Jw6+qcbidkyFvKW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2KaKww30roT89/EPz9qD+YxJaeM4RfrShwZfNEbre2RRYD6kCAcEMVhRdg5NjMiiPplYiA1unZYnEVZ49y3bxc8IQsVKhU/qV8d4q1j6uC8moNBpmnWShunZYNbIhcerx+QUGZYHly1vObfYmMcHDmn22/s4SIAtlDWa+P+cK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlkcEGHV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlkcEGHV"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so5325095ad.1
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986917; x=1789591717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SpjhIh9U8HeFCCBcijCvGjgHO/5RlcEHB0ZHWnx8FeQ=;
        b=jlkcEGHVB/caDrCDSdXyi0NtNLuwsCF3DMKOcmHHWjcRkbYDBudShlUJ5UnO/BCH7r
         U/G1woajW5L1pM5bA5NyBt7d1lhwCT0RWOAU0n3EGAH0B2g9FU68i3wb4KuDUrxL47Xb
         ty7rNECZAdstUK/Dn06xkWBSXAEsBzws3TAGcYjkoOzIpy4S7yro8wXFMga9zu7Fr5Te
         1iA3gWSSXjmVf9YOOzZ9Mvhzjlpqu7D3KjH096CfaFNYscT+quDYZELXdIp+/FgdLPVL
         mwhD/dHjzU4cKd7OdZygLS9ytkkUE/88HLGvCMgW3z9KKZ8WWMUp+FGOnXeWkdSdBVd1
         Aztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986917; x=1789591717;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SpjhIh9U8HeFCCBcijCvGjgHO/5RlcEHB0ZHWnx8FeQ=;
        b=e3vLD9KGWXD3/m7Yt4CqWKvrS6Z107d/jLMY8PRJ8H+s1+yGMNJsWc+n3ADEX/8mgt
         7KpydVRU5s8QKPkPVUGiaEvjEV/9Jy4nTyN5ZAROBMbH8v1FwHSeoIpf+yXDETJNqYQm
         ozIS3wW/KQFnbH0aJc4RNZqLZAJIuaayskxhhYvynir+kvDmXQ2OxsGXh65f/hqKP+U9
         DjKYp1muLkyNEY/ESNrS9YpOzFO9rqEayOqrE8TsXv66Ejh5o4E5o0hb4Zzf5aGZ4ueQ
         iQ1ETyPASao80WV8UQeNJ/Rb4D1VOf04ZaO6viE3d4pexrzNyy6oFsngI2lK/vYzzymK
         yLYw==
X-Forwarded-Encrypted: i=1; AKwUvByPx2yaK3JJvz6PnhNIjMj922uqhyhI8hHIIu7YmKVsTQNt7SeUFY7GzFzlKYLhhxm8juRLwn0+ttIRi4Rcyg==@vger.kernel.org
X-Gm-Message-State: AFuF++lFB2dtjiSDkSl64H8sXZo//NHDuwnJqCktCKIzSefplein1zJC
	jJybfxDRAUzx4A0NF6bLhcIzApl7FZTNy6KCPL3Hcl7dGQyQWP6srwZr
X-Gm-Gg: AYBFou1Tvoqs9VXYJf4LX6krG2sAqWgeq2/UJAliYJjPg2YmAXMbymKBU4t/D2TCoBs
	pCou+zUnRi2G9yf0p/CxVHzdUm8Bf9McWC9ZKgIqfX93aFhoDLbEJkrNGjwWTKCwy24m5CcdUsN
	NncM59Qe11k4Ui18BvEapGuG22djdRguHD4Pc5l0imeDW/lINQ0xW1/7CV96YtkjUulJW4CDpsu
	qrSUay3N1+fRxk/jN4wNggkqfAShfCuKIwMSuOg0Zw2mDNv2ENMPEpGFo6pAjf2Lk1CtFR1pLBx
	bfboaQFjnki/d4yJUEiN+qSie9lUKwLJ5VM/OJOlN7ky6EGxpLtMNRUCcpb3LLmWcYGLB9bLcHN
	cqM0l8zxNymqQihsibVgisEK0yFEao/5cvnP3pnE0oUz0QshFpAC3xL/B1Psc2rsOGvIhWYJGz4
	z6/E5crXdK89ycOCkS4bLhD/9u3nz86kUnnPCsJwzwKFslYsgyh8YZqomaj8HoAUv6zL3cwtavg
	rJZ7LIrC/uX
X-Received: by 2002:a17:90b:1850:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-39d70b4a963mr4682260a91.12.1788986912527;
        Wed, 09 Sep 2026 13:48:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d76997228sm1306299a91.0.2026.09.09.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:48:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 13:48:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Li Jun <lijun01@kylinos.cn>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: sp805: Replace SIMPLE_DEV_PM_OPS with
 DEFINE_SIMPLE_DEV_PM_OPS
Message-ID: <ff690e3b-a4ec-4787-a3e4-ccfa72a46672@roeck-us.net>
References: <20260908104905.3388262-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908104905.3388262-1-lijun01@kylinos.cn>

On Tue, Sep 08, 2026 at 06:49:05PM +0800, Li Jun wrote:
> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.
> This also drops the __maybe_unused annotations on the suspend/resume
> callbacks, since pm_sleep_ptr() inside the new macro already handles
> the case where CONFIG_PM_SLEEP is disabled.
> 
> Additionally, wrap the &sp805_wdt_dev_pm_ops assignment with
> pm_sleep_ptr() so the entire dev_pm_ops structure is dropped when
> CONFIG_PM_SLEEP is disabled, instead of leaving it as a dead struct
> with NULL callbacks.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Applied.

Thanks,
Guenter
