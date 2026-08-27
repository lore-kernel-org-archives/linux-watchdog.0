Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AEC3C8708
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839170; cv=none; b=hXUVtcnBKZ8L2SpbV8zwjmTAIjrogbrhvh6QJgt2BgBBEeRoisA7SCc6O5H5n9X+jX4LJlsLxxvp3G0mhLdVCdD8iTsyXV/mRY770L4+hf9CoVHewLGN3PGDL3sK12reDhwAXH0SfmRX6R4K7HACSw4pfZZK1AXopz8ickYYzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839170; c=relaxed/simple;
	bh=4BApbd7xRD274am4qHzSTtPAUlhQ4Wf3kdL+o+NAvEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nclx6sAvK3+A1paPOjrkXQDvIxJlGgI0QFMCsaBuU/wAHpaxl/mShDiO9FsfjzOE/5YERgr6z9V2kKRhbfe6khMMHFFZEMvoTcSPvNMQR/jTLrQRK5xaeYfsXMFH4oRPfrP+5M8lvd7ASKrvUOXJZFJ0ggaWKv5ymL+NFjEQRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siw2lhYn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siw2lhYn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381b831d535so3692535a91.0
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787839169; x=1788443969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B5StRPqIQTEZjnwEJl7/p40cn9Gtnc5osnnCjWoXWNI=;
        b=siw2lhYnmzU1LcPxrKChEiGPBfGlLQ1r/QNN2wK17Dp0IeSO1pVOAOZZ9zOUFtS0WR
         Kiy1dJj6eTaCZaEz3LWWDihP9PdQ2iUkgObF8atWGbCd6ZIcfD4IXgwqyojQTB5Fh3j2
         AMmeCm9pYqF7LA7umk3q7y+kObIMnF5wTxys4Bxxfg/vZ//vUc2AzdUNxKKpl6rW5I4+
         xCm1y7XRnAxhqQgaNisBYDADL7lFNQzkPYVK8msN4EzFaGdcUlk1hGE8/wxsyUrnUNd8
         Lmy4VLgG33cJfXJBNdNcWUaVZzZKXNZIZ2547OfRCb2iRaK351LFc/g1s4YH5CKLMO07
         WL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787839169; x=1788443969;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B5StRPqIQTEZjnwEJl7/p40cn9Gtnc5osnnCjWoXWNI=;
        b=RJbI15EH7FGIemi0Ul3VJVkzBt9uVdYcrwe9QjwuoMzvKQIgnygWiU2V2+3fLZeQ4Z
         rSbwQ6WQkPjP5+obbJjLy7loqkzFEAtz5wQiMkw2jheciNE22IM/oQXCT7TxGgg5he6K
         Twdb3c9PGulXleQXPuPwxfUPL+FmpELy9EUlRjTaFdQWfqgkGZCwjWW+wLB2TEEz6re1
         zgYYGT9XuyEoGxzKxlrQVk60A/Q40ZHfTLF1te8tI0HQVg20OyoLdNNono3lKP35s8Rn
         AZhwd7mu3kp6uEXcPhNvMOrS2TEGrJOPMEBw5cSiNJ5tQmsUsav6+jCKw7w3HbjQIVAx
         54Dg==
X-Forwarded-Encrypted: i=1; AHgh+RrToz+s+BL2lsjOZUwtNp2zGldLo0n1mxW9/SC//I074TUDE/srSBpjOBd9AXQ5iRP2/hdWDASdJ7dGdoOe4A==@vger.kernel.org
X-Gm-Message-State: AFuF++lUdMTKOTgY2V5n+s5dsIIkLySn52E0MPb4WeJlEr3+4VRtiJbx
	StMa99t9K0dY33K2NqsQFPG3EfgkRdh6bxxOVxlaN8c12gv6Lro1mRnI
X-Gm-Gg: AR+sD11mlPXteK4IH8/4iGXpZ5gc80jRCEdVgl+vTa+OkqV1yuACtsKSYS2r/xL84eB
	N4QjGKsvjaUw/n4MNYUQSaoAb2UFHSFs4F5xBm1bPuhjJXPHlHXfd88mO8x7dCDIFCk2dyRGGPf
	DBKfcApIRKZlZ3mhaqsf9aNQBYCEpZXrh6yUWinwLG3o6Eu4T/i2RewabuWmvOUuz+FnRWw+q15
	k4tyn5giybYSSYJkPR0Ko94hK67yvD+wCbX5Vw65VZthEHMm+uEIreiAhlUszGowoDKd1tnkAES
	Z2psCwemUJKzMdQlbQbj+VX7VYz/Cmhc1IxbdPwAqvaG0MfsarZSYoScEk5TqwzXeg73OIW1ddO
	ljFYhaYO7LfFX3M7Bc34Jx02pqQwU1HejWDa2AEIC8Vg9b6WB/JUpIvVCniXdQH0f45tX5T2M9+
	hAxdhGEX0MXR4IxlrGSBIj+I9v7K6jbUgj/a6GnW3hHHaihVVH8Sd8GsVBFLJhR8ZfWXwyKi+7Y
	A==
X-Received: by 2002:a17:90b:1fd0:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-3966d3ed042mr33079618a91.6.1787839168843;
        Thu, 27 Aug 2026 06:59:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd55a4sm2972734a91.7.2026.08.27.06.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:59:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 27 Aug 2026 06:59:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: xingyu.wu@starfivetech.com, ziv.xu@starfivetech.com,
	wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: starfive: fix runtime PM usage counter leak
 in pm_start
Message-ID: <6cefb263-7f9c-4be5-aff2-6e1a66bdd4b5@roeck-us.net>
References: <6a8b157b.8e75e0cb.2cc15f.4aae@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a8b157b.8e75e0cb.2cc15f.4aae@mx.google.com>

On Sun, Aug 23, 2026 at 09:14:59PM +0530, Manush Prajwal wrote:
> starfive_wdt_pm_start() calls pm_runtime_get_sync() and returns its
> error code directly on failure. Per Documentation/power/runtime_pm.rst,
> pm_runtime_get_sync() does not drop the usage counter on error, so the
> caller is expected to release the reference itself. The early return
> here skips that, leaking a runtime PM usage count on wdd->parent on
> every failed resume, which prevents the device from being suspended
> correctly afterwards.
> 
> Fix it by calling pm_runtime_put_noidle() before returning, mirroring
> the same balance the counterpart starfive_wdt_pm_stop() already
> maintains with pm_runtime_put_sync().
> 
> v1 only balanced the pm_runtime_get_sync() failure path. As Guenter
> Roeck and the Sashiko AI review both pointed out, the same leak
> remains if the subsequent starfive_wdt_start() call fails: the
> runtime PM reference acquired by pm_runtime_get_sync() would still be
> held while returning an error, again leaving the device unable to
> suspend. Drop the reference on that failure path too.
> 
> Signed-off-by: manushprajwal <manushprajwal555@gmail.com>

checkpatch says:

WARNING: From:/Signed-off-by: email name mismatch: 'From: Manush Prajwal <manushprajwal555@gmail.com>' != 'Signed-off-by: manushprajwal <manushprajwal555@gmail.com>'

... which means that I can not apply this patch. Please fix and resend.

Thanks,
Guenter
