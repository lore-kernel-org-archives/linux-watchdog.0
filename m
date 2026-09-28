Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D74A4ABBB0
	for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594643; cv=none; b=OOPOw9Em+mTHG6psAfHg9Z3rTnAey6fzv3tQUj87RmPCAfocdbUCZlxTsQEHEPkmoptDIdTvDNNCtqNMEUtbG7MctI+11o86Qm7U38DA6GpnCx74Qt1/O4Y2/NvAaMGOG9urybDieidhl3Dzlat5Xje4FWrvkDrg6gRyaVRwd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594643; c=relaxed/simple;
	bh=EtTzFxA5QJRtmdY0BycnIWHAtaHV6S5zMcVADPu96ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGVOmz8c4vWTjBvAyvpblLMQinvAORh72DhHQoDQ6pI34TIB/EmSR3GFayKHT9GrUuh3JKlrXEnr/QIG7wstafUi+KTJdu4QZK9LgjYya3LIRANZmwb9q1n89QprG0+cPKjqGqw0CRtN0qH4cgZMRgzO98CxEC739EfIXFZwuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRRAinO3; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRRAinO3"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso4524763eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 04:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790594641; x=1791199441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i386EA0b0Na+wN/uj0pCmxx8C5abhthHYG3OLw1qm+s=;
        b=oRRAinO3I4JUizyq6fI0/AuKHDi+6rdFgKAhxVM2TSctP2iQ+DRK7a3NB19s4Wopq5
         LhD1r//Yzqzk4Hh04ViobtfqeG50szqW+zt9r0v6SdJpKrXNN+yu48CHR28sLEUxtnPg
         BFlYn+WxmIvhF66SHMHiKSsUpmaezD9ShkGStHpsZ4qTcC/4w0PfL2Vg1u9en/7mbXVR
         aS5K8J6AIXuYoDXTpEXiTvcXs5yfFjEzBrq3wdWGCn9/3zv6aMBvIMVd37DeYx4SLwrM
         j08jnBkhrtWyyDwCLB6WCTLsjvFPeV8K4oTjmu/FEmQBpNsO1mdmI9YqZ3whKpnqD7X6
         OL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790594641; x=1791199441;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i386EA0b0Na+wN/uj0pCmxx8C5abhthHYG3OLw1qm+s=;
        b=hG3eIPcDs1DbItfKpvzCvA4HeaFCSRC19dnhirciipgYhlNV28TQnZwPVUbIktHxC8
         qAlc7u3X8Jqh4n8xb2DbJ2EbV0uqxt8mwJFedhGJG39VlZQHhu4o0QSZS7+uywaQWKfJ
         3eTratC2OgunBaIwsPBZOtsxtQGCSMRu++VRqhKi1/+BHkwJGgavWVwrS8Q6fhnMB/sr
         n0vc1pDcxczwW3UbVKvi7BhjrFe6UVrkuBk49A48tqwQWD4sI3vQds1pYDwwhpNyafGv
         IhIan6G7xNYMkfI+ciHC4pcBfKV6sSzXW3d4dMb7ynrKsFIyJAKhNnd07pDbuRP0sagt
         UmfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwC3l3GvpsuRBTA61xmbX/doyBzM5wbfpPrA/J8+0ctW9u7qzNuww2kQWNdFYFXCiFWMvcuWfm57IHFjq8RRQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kDMtfhLHzA/OOo01F+LodDS6UXNLsM4vEfIl/JZZlPpmllbUSH
	QUfmNDhTvE9oDXXMvXex5n9XBUtg5emPCGhnJSoXAQHqcabqOGEAosa8
X-Gm-Gg: AYBFou2SQBjpFVN8WLgTy5x6LvF2+O6JDVnU1YxiXzXcjqV9R/UPMnImK/tAmOXkvyz
	OBGurWRUe2wwf/MLdS5h9XUgP9hMOng+ACjjPW3HMt/o41IJ9a1aosE+ODkVFxTnuNp6GgVCv9O
	o+xPHby6/JFWz/C3mX0SUnwLxPOxRbY/zFAQpRxLLv+neUd96MqgDKbHuOCFYcoqKskQY3SvS06
	i7gXendJPd9GBMczqcH8X9XH0+8S+dNpVOEOnjjMIehGJInhBDj+dGofUCbqdbBU3O4fczM0du2
	c0EQ5/ZwO3UlR4lPIQqPZHq0LFPa2YGyuELwVqHiU2w7AmA1hsqMo+iTlzPAkotAky5zvd3BqNn
	REJcgMlW6stodO9KnAZHuI1PJldZNBO/mg3Uyr44DUfT2C2cqhS1z2mFLzZoOAsXP5DsdIzwR3g
	DsmcYBalutyNQ/h5eF7Vz//HyDr/uUASaQfkF6J0RlhgnzLT9V0m7gwUx0e5h5glwFxaCCoKNNP
	dgUMLRa6faW
X-Received: by 2002:a05:7300:ec0a:b0:342:d7a0:2f40 with SMTP id 5a478bee46e88-342d7a0334dmr10596463eec.7.1790594641113;
        Mon, 28 Sep 2026 04:24:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341f2b18cbfsm26321026eec.30.2026.09.28.04.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:24:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 28 Sep 2026 04:23:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the hwmon-next and watchdog-next
 branches
Message-ID: <d40a607c-af12-4e56-89e9-de2544b07143@roeck-us.net>
References: <20260928105944.2186541-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928105944.2186541-1-matthias.goergens@gmail.com>

On Mon, Sep 28, 2026 at 06:59:44PM +0800, Matthias Goergens wrote:
> The T: entries for HARDWARE MONITORING and WATCHDOG DEVICE DRIVERS name
> groeck/linux-staging without a branch.  The repository's HEAD points to
> branch master, which mainline already contains.  linux-next merges two
> branches of this repository (Next/Trees): hwmon-next for HARDWARE
> MONITORING and watchdog-next for WATCHDOG DEVICE DRIVERS.  Name each in
> its entry.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> This is part of a cleanup of all T: entries whose repository HEAD is
> not where development happens: one patch per repository, sent in small
> batches.  The plan is at [1], and why it goes out in batches at [2].
> 
> [1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
> [2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/
> 
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 140eafcbbd78..6dd05753c41b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11483,7 +11483,7 @@ M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  W:	http://hwmon.wiki.kernel.org/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
>  F:	Documentation/ABI/testing/sysfs-class-hwmon
>  F:	Documentation/devicetree/bindings/hwmon/
>  F:	Documentation/hwmon/
> @@ -29359,7 +29359,7 @@ M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-watchdog@vger.kernel.org
>  S:	Maintained
>  W:	http://www.linux-watchdog.org/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-next

If you want to be that explicit, shouldn't that also include the fixes branches
for both subsystems ?

$ grep -e watchdog -e hwmon  Next/Trees
watchdog-fixes	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git#watchdog
hwmon-fixes	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git#hwmon
hwmon-staging	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git#hwmon-next
watchdog	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git#watchdog-next

Thanks,
Guenter

>  F:	Documentation/devicetree/bindings/watchdog/
>  F:	Documentation/watchdog/
>  F:	drivers/watchdog/
> 
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> -- 
> 2.55.0
> 
