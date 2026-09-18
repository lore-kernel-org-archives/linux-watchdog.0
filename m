Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3265502D66
	for <linux-watchdog@vger.kernel.org>; Fri, 18 Sep 2026 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744201; cv=none; b=Ltui5sBdOcqXzW1pNi+611h4H5yrVNl/+uhWFYMGCsXdhf3j21m9OnMBJxAilzIe4hQV1JRku7aldWHFDi/6PUdxIXgjwdTokYjb3pqN6KD0u/CQyS1hWhXZX01gv7xf0IW1y1N+cbHqzoZUo0fXCnUnpAEzefUSP3DLug0yPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744201; c=relaxed/simple;
	bh=JFUJQ1OOdOIpOZp57fGeA256fhBeVxdWE2A4por1yyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOb1q58eA/3sLyuzzhLoN5dVry5be5hR9btg3wtHfcOk0HVbtTFnPgB8QnNIdEoN0iB3bmvFKpuZiLn5cW5p+67JyMV7x7x4yoh6uCu+h/0BEoMElHcZjcpZbYIk5Zn07zJTLGSwu/sMKqVIl+lrk2x/SeebqNwfzE5Uhb1SXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4nW85ny; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4nW85ny"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so729124a91.3
        for <linux-watchdog@vger.kernel.org>; Fri, 18 Sep 2026 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789744198; x=1790348998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFd8wA4LfqBgsfkS3OH9kAmDVG2UukU1h2QuyRYCBG8=;
        b=j4nW85ny2XjgaXglI4ncMgHw2ijaEcbz4QS+rLEeZMQvfPiL1+VK+AjNVDb0dGDsOD
         iD6DoD/0MqyhYZulyZaibjCRweQ2ALrdzbuRq0xVaX7oeoU5lFSabCjNm/XSnU3niEWd
         7aY0oexO3yjefRHhb+LSZE+alAptGDsMI7VESzmwjLV1SRW7k9CGzgTT5nRqQnrKBtoH
         /lhKJFLGgXOa5GQfsZixAm7X1X6wDomxcDmhj9t6Pg0ep+hPCNZPqB4H9EdLQbH5q92N
         KYg4otk/Jh34Z2PwHfhlIpKGFVSHrSvvMpZ16MNiP03UwZ22AcaBXfLK8nvodPfUaBFx
         3SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789744198; x=1790348998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFd8wA4LfqBgsfkS3OH9kAmDVG2UukU1h2QuyRYCBG8=;
        b=uZw77GSBDHK7oS4iAHbziqLFwAgBWkh8VQynthRtnhPC2TXKa3gsP2M52PKI30yApl
         VGwoL16TBJjaQid9jeDYSQMD1v7CgwZZHOQdfqWQD0Q4EMIzLVkwdhrv7RWPYJ6PCGVo
         uYGaCn4CSAHpOkzcAIB0jVa7z2p4n+8wC6nZVatAWaV8k0i3BGOoi7hLqcyaQI0uuAtO
         EC8nQT2/wXvCi+3vx6DhUzgEBE6FlPbbvwpy0tCFVHEsNE5MwCm3APqEBOcWZQIZFuTr
         oviUOKjHl8iHsHAqy5tnFmw6ZKZFDtn1EKLi8UYJA5wwoEX72L0oUzk+PdOkJjZliXCk
         OaeA==
X-Forwarded-Encrypted: i=1; AKwUvBzd0YO/znokJ8zjU5yOp2mNQqxqW3WvW7q/mvWqI+20f50pW6mks4l7SVaqAPC62xAPBUH1SFQEtoinmlVZ9g==@vger.kernel.org
X-Gm-Message-State: AFuF++l6RekkxjHsVLPHMIPvLhZS1IDkQrpIwS3LZwd3jHhtCJVNMvcC
	Ztl6eGuch8YrftoNh22dDSYvA1PWDcRpmPYQKpQrOw2tSAxNHu9eE9WvJWQAeEPZ
X-Gm-Gg: AYBFou177cVDmMLXwvUqRyLxYf8MvQlXmCbAettwRLPceCIAtyB6sbu1m+zzZlrR/lK
	d34yDN/Bu6u3+2MzArmqxCH8UGZuTMIlJiiDdUJ5sXVHT3cZwmpJXOLTZDMsKr/tmqlNxATN23K
	2DLXx4KDkF65VBYvilOcltafVKC7Y/5mYyUv14SbsCS9MsNFZEcIN7JCiJ9bhaPReSSg3nOeqrS
	ywBG/FXNKGS0VzPNI8FdL6Upd11VSP8hSqltcuwXe2CIj+1bMZ8PbyCv8hhlJf7/GiwrV3PGfUc
	owQGFHnBfgWdLVDI6EX/hWoQpWjfybbQyLGwAWj8jzwdQeSBVi1X3ltXJ86yy3ykiWHEWX3biqK
	FE7YiGRY5EUua0o5p9EPPu5Zo4Tu+K92BTkq+1C70HsdsORAHHMSXGBz2OC9TFaos+iI3cli1mc
	Co5gBzXOjpRTA/2ymFnbSFyaMHABxlW1Des++uf6vyIAeWtxyN4S2+FD0fayENJV+Itlty8ITJq
	d/WqVJMTqKG
X-Received: by 2002:a17:90b:5804:b0:39e:6a7e:ee1a with SMTP id 98e67ed59e1d1-39e6a7eef7fmr385710a91.38.1789744197602;
        Fri, 18 Sep 2026 08:09:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a50c9fasm3994015a91.8.2026.09.18.08.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:09:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 18 Sep 2026 08:09:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Li Jun <lijun01@kylinos.cn>
Cc: support.opensource@diasemi.com, wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: da9063: fix suspend/resume handling of
 HW_RUNNING watchdog
Message-ID: <45c796d2-bc78-4915-8266-f3db49e525e8@roeck-us.net>
References: <20260917013710.2754679-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917013710.2754679-1-lijun01@kylinos.cn>

On Thu, Sep 17, 2026 at 09:37:10AM +0800, Li Jun wrote:
> da9063_wdt_suspend() and da9063_wdt_resume() only check watchdog_active(),
> when the watchdog is left running by the driver sets
> WDOG_HW_RUNNING in da9063_wdt_probe() but userspace never opens the
> device, so WDOG_ACTIVE remains cleared, the wdt_disable() will not be
> executed in da9063_wdt_suspend. In this case, the suspend callback is
> a no-op and the watchdog keeps counting during system suspend,
> leading to an unexpected system reset.
> Check WDOG_HW_RUNNING and wdd，can fix this issue.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Applied.

Thanks,
Guenter
