Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5844A206E
	for <linux-watchdog@vger.kernel.org>; Mon, 21 Sep 2026 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999505; cv=none; b=VWvJSf24h+YQZySLp675vrczn7Y0S4Jc4YoGDx6o9sZxU/L+TOZHXzUs55KiJW8gF4JRfda1HDdy3slh40XZ622V0oju4z4GHFfd1qIljs8wpIm7Okdyxn4iNW4iN0LhadJQbPD8Rd+AVKDup9D763rqQE6Aw0wXgpT0NiWliB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999505; c=relaxed/simple;
	bh=2vJx7TXxxT0fRGwPZFAMsd+M7lzCJ1o7ZpGwKRgPhJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz1bojZb6F0gvpC9CO91jQ9atzyGf4LuROkLVsHSXDEis6Kw01hqjDbNCd/yI9kt4ZwjI2sRQQW4tXiWinhpX1vbsDWg1mCx0ttGMZHpusWxKYChfOpNpW9uH1OBmgIv6a5dsabBDf567yGGrjqBBEXBYoxFaijR0k8QGTY7vIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoJtZLwg; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoJtZLwg"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so2273697a91.0
        for <linux-watchdog@vger.kernel.org>; Mon, 21 Sep 2026 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789999503; x=1790604303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FVndDmsTO0EsvVcjBdIJcO67VaQ5MrgsL7GRVTGdqJY=;
        b=LoJtZLwg2/FuZ7AhOl8b6SB6LU6WDXBJ1Cga+/14h1/PqvD33S19mpct6v+vb4v4T4
         wnY0K538QIvxK1PSWEuTALdRpC764hzQ4u7tMlA8+Q62zqxRfBILlGhn0XOK/Rwx1ZyE
         TFGvRvr4dGkXDrrKv36fr1nLGHLo9TL9nm09I/IxNpfuMIn9ho/fGIvjm39Eh54B6LKK
         nsh+kzlixGF0vxzohsfdgaOaCBEKpsyWSRCUE9ccsDCjRfHHyWVbBcsFYeQkavANlRmR
         QYCDAzJ4EYCy1xN8b5SbZbvm1TSJADU9f8UATx4n3ZSSML9QnuQb/3jKLM0VStlKCEyp
         I72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999503; x=1790604303;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FVndDmsTO0EsvVcjBdIJcO67VaQ5MrgsL7GRVTGdqJY=;
        b=CC6qTjquGDDTI3DZMk6WdG0MNYZhDmqbx2cegxjMbHZ0QP2NQl4kw7Qvt76Z8OOkmx
         e1rBuR+hoguLQnqz6EFJNN+hQkMrACGOp2tYmo63JtddtU6h44dQHnbInTbIfGmtsL0P
         GJtku5qtUptcCEQrN3C0Okjcx8vnkgeSpOLZH/B9AHv5sDYmQirUWC04kjI5DiTGu3u9
         6jUWmMUSIjk3Ysh/PVpNTvdh4GtBpBTR43KPZnzEW91uWETs7ibMuq8H9JDZk4A5uljq
         FhkbJ+Hzu1p5MphVr1Op5IMbfyVNs/FLAJm8kvdwYs6sBzXF5JDPLsFis78kg2sjZ5a2
         OPtg==
X-Forwarded-Encrypted: i=1; AKwUvBw7/gSYG4keDWQoe5fwQyjoGwX5J0gyadJwFnlMkBiElvGmTkYmcfr/pLLbEHANyeqDh7qiB+2LObtc96QZGg==@vger.kernel.org
X-Gm-Message-State: AFuF++nA91ON/kX5dRHW4s3jS0tlWcIiRi3JBIB6usbjkILLX2bh9KQU
	8RjnyvyDt3cY5AxEs6AA3qgsAGA1oWYyjHzSO58DRE3j6Xu158BjKs4G
X-Gm-Gg: AYBFou2AJcPEMTPqyLTF1cfH+MA75+sUeZBlpHf5FXi+EXVWEZ6/LqPbcYRLWX19lj5
	77PMn6mvde47VzeYoqGNJ8kDZ1cI1C0DcvX+6oq7ra8qTcZmRfHM2cV9AaP2zl5g58seWyLJELP
	dY5fbJxyoktZWkWAtf3S06paRS9DWbvNMh/+Q4tXg1UrKslXZmsLuSIF+s1wt9E56VLcKAwt55r
	ROKZ86wIb4KYVuLCE/oKEZRBby2mc5YWhDUd9KxZsxDsI+KjyFpjjRAIU8KWjFZKb9LsaSvrkeC
	CjkrYA7XJt7yUp7OzZ70zdOZYRVhhwq4sTrfqS/GHC0aVRQIs235y3WTvI6Yb0heiL+MQYFBvaN
	MNA+cc+IfF2keVmugr0hRvWh3MMbnxQoTuCXQ63Y6dBtYOf1oGpP16Er3DStGb6z4nZ14SdPfe1
	N6L0318n3yD/t+lJ4yF0GagBHNOFxhVCf+m2G1Jq0YYKu0B77wmJGv4lAC3DT4Agdqiilp8QVd+
	4x4hbrNo289
X-Received: by 2002:a17:90b:3b4b:b0:39d:f66e:1720 with SMTP id 98e67ed59e1d1-39e54eaf13cmr19405297a91.13.1789999503258;
        Mon, 21 Sep 2026 07:05:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a063a4185fsm273006a91.3.2026.09.21.07.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:05:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 21 Sep 2026 07:05:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: sashiko-reviews@lists.linux.dev
Cc: Muhammad Bilal <meatuni001@gmail.com>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: cpwd: serialize device access against
 cpwd_remove()
Message-ID: <52bfac35-5dd2-4b19-bc8c-c766c9a93119@roeck-us.net>
References: <20260919192301.272194-1-meatuni001@gmail.com>
 <20260919193320.0BB191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919193320.0BB191F000FF@smtp.kernel.org>

On Sat, Sep 19, 2026 at 07:33:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] watchdog: cpwd: AB-BA deadlock between misc_mtx and cpwd_mutex
> --
> 
> commit b2d69e49e806eb6cb2c3610179ff17ccacb7cf1b
> Author: Muhammad Bilal <meatuni001@gmail.com>
> 
> watchdog: cpwd: serialize device access against cpwd_remove()
> 
> This commit adds synchronization using cpwd_mutex across device operations 
> and teardown. It guards cpwd_remove, cpwd_open, cpwd_ioctl, and cpwd_write 
> to prevent race conditions that could lead to use-after-free or NULL pointer 
> dereferences.
> 

I am not going to apply this patch.

If you want to do anything serious with this driver and you have the hardware
to test the code, please convert it to use the watchdog subsystem. Otherwise
please leave it alone.

Thanks,
Guenter
