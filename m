Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4B31F9A0
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986521; cv=none; b=onbDJA/WP7XWVv0lO5BTDJEuqHJYzaxVPX4GbWiQhA7FUXkzQVHZNLIRInd2v6fAPPxvz4RFG0vJ5TtxGJYs9glFg1/AlSillnllATd2cYV4HwcdNDbTQ7uUPKXGyJZ8ZkDIMqzCi8CwdXRc8jk2HYXKFSLH920EfaTNjOJvJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986521; c=relaxed/simple;
	bh=7gYcfnNtAhe4lnRIsm+c0Bt9B1ZgRgZTPX6Ou1RlEJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie5wcGELefPU6MhUMuYVYrmVMs/sjAy/m/JWgFEKXZBLfrmE3Lm+QY4ypLFUoc6mVDWKUPDA89HYCFXl+7gw+9lIG0FtT4Dk8ymJ7moOMEj7W1703tRTwgQjdauD3fmWg12INlMsYXg0AfIak9pbCniuw401WaWlXAi0HEnvvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkgPUsp/; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkgPUsp/"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8c9c4cd8so3470267c88.0
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986519; x=1778591319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6eoolunM8+Qnu8GKjHPLpBUZh/8jvI3CyH2eEbHLBQ=;
        b=DkgPUsp/2fcTgeZ4ir2VQ0CaxFGtQzKwo2hlDaaYpQUYJzdXPxZ1d4RG9jpKt+aCbA
         zgc/sDaOacURsKLDLYAwX1yJ7Kc09gy5EHBgdUEkKH7urf/H8dE2fUSTqf8JlYMFNXkw
         EEDfrcX241rZvyvdkO5tZTypztf75nw6MvgzUv25TWgoRWISzxM7mDH+RD7jjfHLNHzZ
         +lEoDu0gooOTVQ6ubxJzutRlNPpJwrBeOE28lxHP+X+IStHZbyPRg8cARQtKtR+c6OvQ
         BUkKI5o5LeWSnbLu+vOBksSXcAeRGrLOE8ECg54FqW4jT+jxORVl8nbLbhM60VtGAsbx
         2KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986519; x=1778591319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L6eoolunM8+Qnu8GKjHPLpBUZh/8jvI3CyH2eEbHLBQ=;
        b=Ve+hGpZ2xA0SPlOYGBafL5TMkyBMEEusPTvRPqSfNRVNDQbDUlRpLm7xhxv31XtKwn
         StrC1vLsvP1hg1rFqBMh0ApnVNwHpT7+OJ9AFV++Q04UvCDm/Fijwgvkp9DEHNxsBMiM
         hRf1R4Y4BjUs3YJktq5ypAHNIfLtwE4SpuQtWfc1FIz0tCg/WmWdgUaLMuRTjd4gtsvL
         B7MT9y/Dl0fJly7NmhejYfIw+3nc+2xRcfeK02j4umSE7SH2mxzOH/3Ts9mf9ZC7m48o
         6cTq8N3vTYGVRSbGS+XyEAk8yzC+RUnV7dDKIQYPGFifjol54vCSi6vQDNGEIZrJtAl7
         9tCg==
X-Forwarded-Encrypted: i=1; AFNElJ98MqLzVf9PrtGPWDm7yeqaqm/qamRWxrGHBjBc6rfOhwBg9lmr3Q7Qi5ahPIhcWbmv+//WucKT1nuovxXIXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdj5MDyK6UcVMbbMRjQBN1+xWNBQ7HIJSGWQbI2X4edXRkVwy
	uoq0AaDzAmlepC5uRgTjJkJFLeO6ag6EroyblZQjATuPg0qCW56EecAY
X-Gm-Gg: AeBDievb4nrK1s3whyA0sP74nk62J98b2b0zJ8VP7gSetenZf3Y8/Kh1OmIkygcq/Ia
	owXdqzbnb1/miDlQ/axffg2rwGG6MPNj2+gmLdCH4SVpOJPm0GXwlYORfK+oFMFGKSXk14OSOzs
	fO/0zO6/EDjgZd9Cp8r299IEYgInYZRgosZ+W1gkr2ShoQCJoz5ZU0DPTxuaa5aC3ojzTxGWz31
	f0ybk/vB5V1Dn7Uyr6+HW3qCg+HSMIziMjDwmsJFH/Viuii77hDVxipBlvreUb0ygFl6Y1OMrAv
	WyHaOE5IZSE44YyLEloWpCLjsRkOguWT3gzoQ3cexNSQQYKpRNQ0FG7/CF+KJDDShEx1bNwkXmg
	kBe2GSzw+VxNH1H9DZM+0Ce/6roaPOm8TEa3ubG/x/SlicRnR6dm4R7zj85RUv97YZcif9TGCkU
	ghgGpnwSt73neU2nG+mQ9S2mq3kcpgz+UlBLPSa4gGqC7hukNHckS1sDNkuw==
X-Received: by 2002:a05:701b:2507:b0:12d:de3e:86b2 with SMTP id a92af1059eb24-130a9ffb6e3mr925456c88.21.1777986519483;
        Tue, 05 May 2026 06:08:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84252c0sm23229783c88.10.2026.05.05.06.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:08:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:08:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philipp Hahn <p.hahn@avm.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Hahn <phahn-oss@avm.de>, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] watchdog: Change suffix .txt to .rst in references
Message-ID: <955dcb87-5a78-47c4-99ad-23e77d7f599a@roeck-us.net>
References: <cover.1777972790.git.phahn-oss@avm.de>
 <bb1aa3129d5e52bc4c8e1ec3340b88f80f726fef.1777972790.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb1aa3129d5e52bc4c8e1ec3340b88f80f726fef.1777972790.git.phahn-oss@avm.de>

On Tue, May 05, 2026 at 11:26:12AM +0200, Philipp Hahn wrote:
> From: Philipp Hahn <phahn-oss@avm.de>
> 
> Fix link to documentation, which has already been converted to reST.
> Also remove apostrophes which are no longer needed.
> 
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Applied to my watchdog-next branch.

Thanks,
Guenter
