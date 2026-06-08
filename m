Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0C3E6DDB
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947587; cv=none; b=DhuqlVN+KRhrmdykYxV1KKIERgrJVzr3x2S4MxunFdzXsDxO5CzHkyfXhM/A1GhGWZzGUw8ssUNFcRA+nUix0Ur/PHaU00o6TELJYpy79HhOtH3XoZDrseJFOwOEEUJbzxA8F6LP4SDLsaiVSsX0iDX5G9TgeyQxnVm8qbcptBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947587; c=relaxed/simple;
	bh=3j8dNNSJeoF7jcZhQTeeTh2t4eVcLuzkLRDOwhU9gG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqNjcu3cG0/ZCxMcm2Oj5fFDmPd+xMaS+IS5fRO7HF+CSdnpTloICJhu2i6j75NHPTIFDEKKlbkmEFuoJFTfc+T077ks5VFOL/xMDn+JZwG4GFKW2yK6AWRyXHzWuLHknlnKLIoLiyZSIdbUJcRUINKPSpJZ3XigolRGo1SE2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHKioarK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHKioarK"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-842338c18e0so3308514b3a.1
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780947585; x=1781552385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmQl7nKoLuGAiX+6QzzNqkp9oEPlCQzeoRFYAPNXRs0=;
        b=lHKioarKsBDj4AtEUiNKMkHQxUgcpA4xkJgv/HUYiUhkxth8K4cJ9swPYRzRC5MqCh
         eM2/rg81Mq1N+QaQoeG26Vj75ZsHcihM8zyqNL7UmHyo3p7gtxpt7UywW4wgD84DLFz2
         HvD55pfFUd6ZxaRSRXlvr09UM5CxH4HHRmMG6lxEptnqKpzuToCS4VBnxYbFA1EVx1mY
         4X6gGsq25hzZDw46+KUnYtbwE40zbYbS85fQVnJzabdmQHXsWlJoHl9rsSitICpyvmfV
         YByNY8BTm603TpyRLvbkrWlV0s58sjHHyagN0b4YdaBmnssf2h9JDbp4RkTCJBj7bn7e
         0A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947585; x=1781552385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hmQl7nKoLuGAiX+6QzzNqkp9oEPlCQzeoRFYAPNXRs0=;
        b=haGA9flhQFP9rpkgxpJS83F8kbgRz6MnQ3Vzq1Pj9tKJQQLMIMfDkLjtw4Zhf+11K1
         0CbqdH5leIlDlAxUCEhrHuvCeI+40ku3CS5q0M2p9EvHkAAGG+SilunktbTU8de2gs4f
         1HnHmvG29ICgoHJvCcQ7qP/WDYEHalHsuIe30EzWYgopWKgSwOF2kSPyxVzEcB3TQ4zO
         SyPV19/dYf/c4LfXDoJxUubgASH6sGNfviHNbPvSqyLk4I24bmXvLqh2ifi+3i6iX9HW
         ycefnVYFxw+ekguJk1/xCahfhANpu1/uylAY62/Nl6AtewlCchQw1e3TkZBIdrYJrhK2
         VJew==
X-Forwarded-Encrypted: i=1; AFNElJ/VQbbSE58ToaJUR8rMcLwSCFhcmsHSi4nuI6+G5SavXrPGD2eW0RI/YNatMe5LCvEOnwPn716IlC5X3pwLsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHysTR95m8I5CF6k3D+Zn3qVuQnDuCkNg9T3I1g5E67gsM4bq
	dhJXpTHI146+Khv6nU1r/OmNHYsxPa9ym6keOpUuedlxgdcQ7Xccx8mRaXM25eHZ
X-Gm-Gg: Acq92OErz8O24jYeqo5uAiN9suXf6DwyOzbz4QiKwpYlq6+MztLvzxWASILn9mgLOvw
	QLtYaeCYI0IIOiND9uZHj0SpRfwJkS/6S3yNJwQf4LMR9ApUvbTSP0GNpLJjue1iURb6XJhy+lS
	eQf+dt08CmpsUT//rZiH2xEMSfsTyQ6l91ubgOTXqXBVDF1CP6pIvZbvhkitOtCYBcjYz3x6Jj0
	ri1nRkLwDFR/F3Ig1UzkxUP0g+HP+dPKjApwHv1nz1F7KkLvJIFEZp017xUAQvUWqlKptktvCJd
	f3S/k5wpSfdslBCrwe83Flg1+uS0TP5MMKn+M1UWBGkji0Pvp+IErBEP6jMERByre9levFw6b3d
	3M/7/yNCdRYMIEGdkPlUhxZAAOUCuhTZQSqrdNcSaU3w5ca0E/LwiLxutp7D5Rnk02dOz7bi7BY
	wwk+pzv7BKdit8KNpnrygAa0XefFhnZ8zuEn1homw+tPD0oJI=
X-Received: by 2002:a05:6a00:1302:b0:82c:9897:70e6 with SMTP id d2e1a72fcca58-842b0f9c4abmr17330232b3a.34.1780947584928;
        Mon, 08 Jun 2026 12:39:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428222263dsm21158772b3a.2.2026.06.08.12.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:39:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Jun 2026 12:39:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: William Theesfeld <william@theesfeld.net>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] watchdog: starfive: balance PM refcount when
 start operation fails
Message-ID: <271cd3d3-eed4-4ed1-bbe4-ffa65434182f@roeck-us.net>
References: <cover.1780664848.git.william@theesfeld.net>
 <cover.1780666366.git.william@theesfeld.net>
 <3a2ba59a0ed3e5ee121a49e04c5bed0c452af238.1780666366.git.william@theesfeld.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a2ba59a0ed3e5ee121a49e04c5bed0c452af238.1780666366.git.william@theesfeld.net>

On Fri, Jun 05, 2026 at 01:19:37PM -0400, William Theesfeld wrote:
> After pm_runtime_resume_and_get() succeeds in starfive_wdt_pm_start(),
> the runtime PM usage counter is incremented.  If starfive_wdt_start()
> subsequently fails, the function returns the error without releasing
> that reference, leaking the usage counter.
> 
> Call pm_runtime_put_sync() on the start failure path so the counter
> is balanced.
> 
> This also folds in the v1 conversion of pm_runtime_get_sync() to
> pm_runtime_resume_and_get(), which was the original purpose of this
> patch; both fixes together close the refcount-leak window in this
> function as flagged by the maintainer on the v1 thread.

That description doesn't really match the code. The purpose of this patch
is to fix a refcount leak in the upstream code, not to fix the refcount
leak introduced by the first version of this patch. That the first version
of the patch introduced a new refcount leak is irrelevant (and actually
confusing).

Guenter

> 
> Signed-off-by: William Theesfeld <william@theesfeld.net>
> ---
>  drivers/watchdog/starfive-wdt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index af55adc4a..ed8c5711a 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -371,12 +371,16 @@ static void starfive_wdt_stop(struct starfive_wdt *wdt)
>  static int starfive_wdt_pm_start(struct watchdog_device *wdd)
>  {
>  	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> -	int ret = pm_runtime_get_sync(wdd->parent);
> +	int ret = pm_runtime_resume_and_get(wdd->parent);
>  
>  	if (ret < 0)
>  		return ret;
>  
> -	return starfive_wdt_start(wdt);
> +	ret = starfive_wdt_start(wdt);
> +	if (ret)
> +		pm_runtime_put_sync(wdd->parent);
> +
> +	return ret;
>  }
>  
>  static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
