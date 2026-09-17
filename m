Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276CE149DF1
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605207; cv=none; b=flqURrGw2vi17sIodcT600qx+KkRSUxSRWRrJJfPxBy+lgOzVHXmDhl/oFKr7C70U6pJaIhQFGwgsWqm+vneMjgWb11DECuoqG+fCf1+cEPrODJNNQQtU7zdJA74l0Oxzkh1z8NO/4Smnz0rkKRKgN4a+XY6hTbgOcTxlcDoW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605207; c=relaxed/simple;
	bh=ou8GpvZojR4odQ5MJrVTWssTKUfmqDNosaoFrPI923s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA2XbUe4ZD5/6Dz9lkb06382nnBz6+5Abr6ckQCPuCI+iftj35/jhNtvHnvnpn9oHpFf8QHTvvm1FAs16EinmHQFCTGnpe14cCM/OpcneBX7B6xxTJySEbn0owhyQoINliyHj0C75ZX6j3Aoko69P23KDw5r7+GM6G3Tey7r+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8eGMXVn; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8eGMXVn"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so2680395ad.1
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789605205; x=1790210005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=whsYeuyLZfnon2OzMG0dFNPkrEuHuXDZOSc3/3S4UiQ=;
        b=H8eGMXVnxnZ2DHjY58HBuFH62K9SUff/sHmh5ciVr763TJ6lYxFL9eO+0ZdWszub4D
         lyyD4Ji4HKXtkrQfHQT7mE1McQCO90/FIzGW7LTQJZ9ItT8YXcSrMQXDGUtay5q68/cN
         TMDaXb3hq50FRYDg4ufss3UyN5SIdCGYiX2z975u2kq86qrpM92nmC2bvZ+AuHhxo0dB
         JH8I+FJRRQCykM2Rq7ZoW78cnnVO8TqbmAlhPttExXzWLN6vdq1/wtp32DEED4N6nq4q
         zBBAKPJp2osDRpCZLZA2cnwUNZuZWGYa8pTUGuBZmzk8uw9XnvEx4IJ+cXAt4q/IM5/z
         ePXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605205; x=1790210005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=whsYeuyLZfnon2OzMG0dFNPkrEuHuXDZOSc3/3S4UiQ=;
        b=fN/eC/Ez10VsvyiQJnsaaJMsrCNTobRQOrdqiuDw7ZWe75V/jKY4GrJlE6xFcPqFAp
         xjIh8tfVTkvRjQoH5qriyQRRNivhRHYM+euYKc4Ve0mviQBQFF5iDiJY/qfyTL4R0k5q
         VH/D9twmHnwN8qw+GQzMwSz7M6G0YYfnZPgzrNprCpnjRbekSo45JUJbn6kmKShvzOHe
         lI7UL85opfgJHi3QIpgc0T3VvT0BuqzNQJ6QDVRrbObZMge1MkILuAXysAkTcmgjDZTq
         Uf5yjeaPtSG0XKDA2/fHow77RJTGmWZJjoidSvNLDNxWZ6pt951p5O4JJJzfKanpbz68
         6uaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZtdQ7dYb1/UY9r20A7zxyVaw9z/eK/k/wzSTM5vYOYMgfFoVe4YI8iDWZq378HCXe1so8sUywkMqNTelBxw==@vger.kernel.org
X-Gm-Message-State: AFuF++ldbq8OO0QjjGimF8+CUQl59Be++DkF7AtKHUo/0MshXkNgJ0ho
	+ms1p64o9VboFMGhljpaIIfzXITObPCCKrsB3He976DbG91Xh8HDdHOgXEIHqTIN
X-Gm-Gg: AYBFou33IafsBdaap0af6V4ivvczCAwcxe/o0QSzVfbY6cZPFuLCuqXKe1pLf3AY1G3
	PLreXoU+LewW8Q7a4rdE5Tbgt1dniLLHmWZuj0OugSgRyOTiz5wiZo3hZ2rEC8GaAl7kAb//uap
	E4tPJWS7nnZSucpLDP3wvHzQ7C6dKtbffOxx1btHBGC8Cy/uY6ic9igWrE8uxxZxQBnvvHZFBXx
	QkKiVfKvUPrDf0eIkSVFEmaE2fvvz3l04DFanN3KJYRz1sfkuNbc1fL4T7tj4hO7mTNR8jSz0JK
	rH0U97+qg97wghLe6PkYxnDqlOnhFVCHSfaG/Rs6nciSjEP+mSgThNOgfhUm+LHBCCwwvEcO/Mv
	QnA59ACgl2y+oSIMDLvCFDrRQz+i8r/w2YTxylWbGW6bhV0ekAPuU2UGQM/RDZPBRUfjsBedK8L
	Boh++Ls44fITikqjzAXB04GQRuL0g7mfgAXkO7GNiG6Ev6PXKi43Qe0jopU/mptE6iKbcDzCPdO
	sllgxpbOd8h
X-Received: by 2002:a17:90b:5866:b0:39d:f97c:bb2f with SMTP id 98e67ed59e1d1-39e1e25a32fmr10575599a91.3.1789605205316;
        Wed, 16 Sep 2026 17:33:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b8e1asm1725461a91.12.2026.09.16.17.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:33:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:33:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Li Jun <lijun01@kylinos.cn>
Cc: support.opensource@diasemi.com, wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: da9062: fix suspend/resume handling of
 HW_RUNNING watchdog
Message-ID: <2880652a-78aa-4e35-860d-07d5f04fb4cc@roeck-us.net>
References: <20260914062353.582205-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914062353.582205-1-lijun01@kylinos.cn>

On Mon, Sep 14, 2026 at 02:23:53PM +0800, Li Jun wrote:
> da9062_wdt_suspend() and da9062_wdt_resume() only check watchdog_active(),
> when the watchdog is left running by the driver sets
> WDOG_HW_RUNNING in da9062_wdt_probe() but userspace never opens the
> device, so WDOG_ACTIVE remains cleared, the wdt_disable() will not be
> executed in da9062_wdt_suspend. In this case, the suspend callback is
> a no-op and the watchdog keeps counting during system suspend,
> leading to an unexpected system reset.
> Check WDOG_HW_RUNNING and wdt->wdd，can fix this issue.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Applied.

Thanks,
Guenter
