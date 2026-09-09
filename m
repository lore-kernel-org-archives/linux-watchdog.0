Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5F58E2AC
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986492; cv=none; b=myxKsPJQelLGSs6sQs60R2xzuGtyPhcCw2XJHr5Y4KD0I1cGhpAHwy3PVM6abBk1iveY32Nm6gWM0xgD1v2STXbgTjFTZQTv8gpnyRDLFIJz0iFTn+dSa1575f0lqgZULxX+6+vwao+Pf5sP7WmA5q2R3J4FoU0ZahwnTsfc08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986492; c=relaxed/simple;
	bh=sDIoieN0iiytdNiLJCwbreTls1+0GbCuzDpG9+Rip/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCwLEBTGsGinTpGj+PcNz7ocSyJ2FzM3TLLOoIQtd5nQgoTlxwy2Kgr66hxCXd2PzgUcYpQOQmbMyTYGkS+7I/nXBa/MJ5cxAZ+LQRERPybayNXlzb0ML0PgMoZ62Ilr4k0rduyTPHB7QLLCr6j+sY9CXDu2uWpEffXp6hyKIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skELug6w; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skELug6w"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38759bcd877so6830496a91.2
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986485; x=1789591285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s9pgzxm6q+J9KubmJoPUAw855UBtesp3SKhgXYDELGo=;
        b=skELug6w41L+oSFvpyZnoIQHgET49o1Ep9RvSTBYLb+TbO1Ef57amjV4PwPD2uXWKS
         61V9PR+8cX8Vjvi8aY9kls8zJ8u0IzSUgJ4tPlBY0fZBQzrjFaut4Ib5Y4ABfhrjwEqt
         HJxc2G8oFJLkuguUS/2bO9cszkPjpOWoIQ9GO0pbI5rCwC32Epy58+QWqed8PXSBjs4z
         k9iwDKMXjy4JRx7gKdXvuRiwl/JAwC0SAxNROURF+23Rv9k7v4n+W4qPhVLh3+Lpzz1D
         q81rC5ew7OlDT8p4boP/2FmkxdZ8dZMJF5jCE0jy5COF4sUFS4Dk2Wsl1tfb++4XvdA1
         vdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986485; x=1789591285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9pgzxm6q+J9KubmJoPUAw855UBtesp3SKhgXYDELGo=;
        b=cQqeZG7resyT4VdsRGPjhK1rsaWp3+wwRr9N3q1P6MBRczJCmHQVxPz6mFmnFFcALh
         vDNnptfaEDK2RjIyzVpvqp3GVgUznFgyMz/S4+kUWCDsTtm4JmrU5y7hRRdCIshEEDa5
         ZM0KOuMrO1qiamfB5r/yDnnaZDfRMd5z8E5iyzwKVkmf9dSTwl0oQJ1hvnjpvZ4/aLDa
         R5cO/bD521PwVBEmyKjc3wTdQyeaExL9NjhYcktYoVQuw7LwejyttkjCb0J9yPORw+Yc
         ZWrGCcv1f1oxc+0ebbjMuP+QJzoIPvvjJ18siCDZEGEC7Upq2/+c1JkztiqFT1E9Myf8
         2sIA==
X-Forwarded-Encrypted: i=1; AKwUvBz5vs0DkUiBPuQU5PFw86r2eiT7ulty9mvwNvydIKiGOgKsHGprulf7Kl4ZSNqzQrx3dSyhBBH/zrhrnD6vfg==@vger.kernel.org
X-Gm-Message-State: AFuF++l6+D+mtt+GojaK9FQ8zzHxtcCK01eC7VVacBmKlugpseRIwGQ1
	JuD3AUeX7Tm134MKyTM/dMdyDivMbkr+JutF9EZJlVMUcxI3IAKF/2XsSskBNg==
X-Gm-Gg: AYBFou06fqEDqO9eO8hpoYmSxmjD21fU4T+L2EU5vUEYlsmLX7hGoeN578R/TATrtiV
	tNcYL14zMYQpA1xSlr3QQ7KxTSmwcK4Y8cwrrPBEiCVJC34/U7eP5IfqzAux5v19XT+GHYwa8pU
	fxkiOvAAdleyacMvUyAbUYPTssRuYZF+3vOomU8inYnS6xllDQI+k+jepAjtOVlj+FhBqusQx6w
	oagiO2Q1euhvmJkgs9CqcAHcidOFBcX6V3wePB7Rz00tGCk6xAUt+nuRJqe9R5zyuBMx5q6mekF
	02Iz1xEbRitzpkvxYYytSJmAHEJC2Y4r6Z/3Ph5zTzSvgwjXbYy9XabkpI1AmR/YiKaNDjTgHP0
	ClBHodAg/umtiV7rsXBS27JcyJvJFFOmWKiygamR66HdYTUsBw8r/pWTNf/hVsqXrp+EC4jwcpu
	5HiGtRrDme56J1po8xR3us/HnkG9wHr2C7yAT8cHgRwAIG5mTzq3tMgIypLDlvKmTSIsWKqUC64
	LTvVzg1GBMuYYDWUEDH5wY=
X-Received: by 2002:a17:90b:1c0a:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-39b2623abfemr53747331a91.21.1788986484746;
        Wed, 09 Sep 2026 13:41:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d771149a1sm1215130a91.8.2026.09.09.13.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:41:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 13:41:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Arcari <darcari@redhat.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Curtis Klein <curtis.klein@hpe.com>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: fix hrtimer start when pretimeout is zero
Message-ID: <a95e695b-0ad3-4c49-8e9a-19d890a3d368@roeck-us.net>
References: <20260903182029.936030-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903182029.936030-1-darcari@redhat.com>

On Thu, Sep 03, 2026 at 02:20:29PM -0400, David Arcari wrote:
> Per the watchdog API, a pretimeout value of 0 disables the feature.
> However, watchdog_hrtimer_pretimeout_start() fails to verify if the
> pretimeout is non-zero before arming the timer.
> 
> This omission inadvertently starts the software pretimeout timer,
> which could result in the pretimeout handler executing incorrectly
> when the watchdog timeout is reached.
> 
> Fix this by adding a check for wdd->pretimeout before calling
> hrtimer_start(), ensuring the disabled state is respected.
> 
> Fixes: 7b7d2fdc8c3e ("watchdog: Add hrtimer-based pretimeout feature")
> Signed-off-by: David Arcari <darcari@redhat.com>

Applied.

Thanks,
Guenter
