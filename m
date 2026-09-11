Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74D3B05BC
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097943; cv=none; b=D7Ec9fpaU2jkYG8Prjp1IrBotwk3f5ALNhLWwxlExgBTl+TLvVolNTr9Sp1btF/c8QS4733z4gD2jZZ3qxSJo6U+37outh/3S5P7TDJ0GfibVJ7XmQx2DdpX1lIjoRgr8YXmbPMdbsVFnfTKiu4+ITgwI8mORjrV96ji83m/N6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097943; c=relaxed/simple;
	bh=2vtNj8ArxcpkG2TN9lSymlNN/EkOkEcMjbt4H1+mjbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lopRJEwEQc3g13gV3udqonE6rgRIkuLXr2i3GqMgHPYcwSP533mTxJtzcWxrkDZQ+GdxZXCPx3s80Qbvr0Ytpfq21sh62V8sGAmX3npUKHCYwx6Zmkm0m2baS6bwCTPqsL4t0I8vBLo73UnH25GWouCtUCLN7ejGqZvzApof2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqmCgVV1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqmCgVV1"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso424195a12.3
        for <linux-watchdog@vger.kernel.org>; Thu, 10 Sep 2026 20:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789097941; x=1789702741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9Hp7chvUah6rX4chN2ppCqhTl3fuiFFZhHPXtC3gr3g=;
        b=iqmCgVV15FCpoWI7PGV85dAcB8cvXGhhd11QTSxayxb56aiOhIzIRAKpCELRwGcZre
         p+mMNqsusKfVHLCKIghA/n8nV3xhhTXR0HrIrogF1OB9+j7xbTki8b5EEXjr/0L3p+kS
         CiWcoHEsd3jCKKggpF+lqndmJKOKJrk2jCAmCMapatlVsp9otIK+k6YKRGCAjgYF3Sr2
         7sSxHuqcLl/q9drjnPT66KqjlMkxVkHZlrxV/pBSxh6jnz4SJl1E1+ZG7ZW8aMCseF3U
         bcKLWdzWJEvc38hoRlbYJA2No5lXm8Z7Z4RSvoCZriYiBRv5BuTDMWnv00uK34jj054c
         zYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789097941; x=1789702741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Hp7chvUah6rX4chN2ppCqhTl3fuiFFZhHPXtC3gr3g=;
        b=ei2/vgwjBtZmyLeTsEAAwUoLzFVpnEA9LbHaJmkOlYMYRNNg5M/i8DEP++a9OajwrZ
         gMqRrD0Me3apoMjirkq2at62X8bt9yj+nBt2xVRV8pUu5PaYmtOtPxIA1/S+U5zjvxDH
         kPokaQyTYGoc/1qLdvmswlXcpeSGrk/ZLcPKS6uSIHrH3uQ9SaeDP2MeUdnyy5H2jsqs
         bjEKxLS4t8nEQ5gkE5tijCVywjp+5b6xREMhvfVkJgVSNv3Px6yeYiGpdbqPWsSfJ1Qn
         e1lBO0yEkv4l0ppnfzR/olbHxHVSmk6XHJsie4149KQ55vU/4PDQkdGgG8QQdBEMvm5+
         Xw6w==
X-Forwarded-Encrypted: i=1; AKwUvBzQzJOFHoRgGKb8agdXikUSB1eCDQa8ZZqtrNALbocsz41yScMnhJ0kL87fuCHLtBVAdDqXkK5UnQN9XIMLsQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ma4iXo2O6QjXT0IYGfzexMXZzgStyaxM1AUInkoNFFm/xTOMvn
	5E7tubixdvQRXBjMJNhimpe4Hj6SfSXzR3qPp/NicWAvfzHxVJKnd7tlFf60/c9p
X-Gm-Gg: AYBFou1MqIYWNF3PWhl7mLH4W/GMT0Ry3+zAAb0c6PSqaEpAhjnC6Xc9RZLG0sBfBqd
	fyJizf6ZutPkrPwawQ3IG2GmzhWTncDbdSYFOkDna2vKCyEX3vTgnfp9yVNtlKlDg2TTJTgM+4K
	GG5YWWCro6MuZM7FOFUZyD0m3QxZK6hG7hRcBspJLhvRVemGnv0CPy/WBWi9O6qHNRuFgg+IVao
	UFHdayBiULuXZC+/MqvWozT8PefE/3T47MfAdmAueQV6m7riMwvA8K/WbNiECrcQXcXuCGm5t1t
	HsdHVNeqnFDILPGGCVg6QemQ5ZAsvxEJ0bQ6RN/DoGNrNfLaCqp1zc54YvlC0XHKgAaikarEQgx
	3qx6rTN8yxifom9rhMLYFQgalDAAc3hiZbJr4eKKsW8sKbhqsr87a2txb9x165r5WVKgu5hr0JZ
	5oKvRWPtexj0QJdt3t9YrSt9L+YAWekBW+iMrxVw9vQxfeJoeJ2WfJjh/0ezI3bqwGsEBRN6lwf
	n7gHwHvsaE0
X-Received: by 2002:a05:6a21:3397:b0:3bf:b84c:2984 with SMTP id adf61e73a8af0-3daed206213mr4429110637.11.1789097941023;
        Thu, 10 Sep 2026 20:39:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c65a8120sm475663a12.30.2026.09.10.20.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:39:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 10 Sep 2026 20:38:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Li Jun <lijun01@kylinos.cn>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: PM: use DEFINE_SIMPLE_DEV_PM_OPS and
 pm_sleep_ptr for dev_pm_ops
Message-ID: <6fa63e8c-c901-43b2-9a52-940a5ae50f1d@roeck-us.net>
References: <20260910124730.1127847-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910124730.1127847-1-lijun01@kylinos.cn>

On Thu, Sep 10, 2026 at 08:47:30PM +0800, Li Jun wrote:
> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.
> This also drops the __maybe_unused annotations on the suspend/resume
> callbacks, since pm_sleep_ptr() inside the new macro already handles
> the case where CONFIG_PM_SLEEP is disabled. Wrap the dev_pm_ops
> assignment with pm_sleep_ptr() so the entire dev_pm_ops structure
> is dropped when CONFIG_PM_SLEEP is disabled, instead of leaving
> it as a dead struct with NULL callbacks.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Applied.

Thanks,
Guenter
