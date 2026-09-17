Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075D315D53
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604921; cv=none; b=SMDs34mKWxdD4MzyKxhMXjpGCfYgaDfLJNq3ZFqiEcMJ0XOrYlI1Dkz8azGwovVJuTOmjq8mgkNqM3KYFPmsOs7LlY0amo0QlKPySKIVTqRVwhSGbZhKPzbT2HSvLC8fjFqWeq8WQAFLvpHmDDc60JuaGHyp6hlNcO2V4jM/cwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604921; c=relaxed/simple;
	bh=3pMdVJHKYz5J9ib8uBjE7OWKJkAOczbrxH0zKsT+P38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzypSFn9hz19MP8AS3Yzy71ui3EAUIZ21mULNuXVJtj0wyofE/4FFPYbpjIr7blG2ZaI1CNgcoJtzq9AXzGKHTFIkiPwHLEnG5LvFci3ztFMcz9+cR1RO1lj42/eJ6TtNUDPs5KX8tu/ygtGMbp4+pADfLrM1CFoUXhK9kTXNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0aqRPDF; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0aqRPDF"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso2464775ad.3
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789604920; x=1790209720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=70Ad2tuJAd7+0temZQeAvFdIzO9M6V246nOBkiiOttI=;
        b=T0aqRPDFHM73phRyWmpWm/qSTyQE7xli5yvabxvhtxNi+rSyNvi9BUUGZrnb0hzwyR
         fe+VOZGt21bRh1j4W/Ux9Epr/lnr/0N1geY/hmzMOx1pFVekC/CvjT75TcV3KI2iXjaQ
         WfeELZEf0IqhkEjTbeOAZfhsYj9frzpxNDnb6AgLlJLRjxL8+EOkGbBML975z7BrRnN4
         PfWeGT9TPTJMjkc8Voqq96T7w0fRa34K0+fNLVcKad8UA7RTD+HsLIl9t0AbROxujxyS
         +VXqK0BeMF3J2DBlzlNtFpQeDakqkk7HXZHOZqTdT/t92y6NaC+u/n8p0VbPo02yLwZY
         Xlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789604920; x=1790209720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70Ad2tuJAd7+0temZQeAvFdIzO9M6V246nOBkiiOttI=;
        b=marsrxuPj00fKiBv2EW+O/JOUuqWA9MiwrOJMMEVAPL3vDr934ZdoqIOc215pN1jjJ
         oWeP06Wr7q7nFg3ICJHw0+M5En4IoUgW4esSkGNWfP18P3SfPwEIq7QZDvqhQinx6laG
         QualV3NKSNRHUQMA4QyjE1ijJCOJ4gk1Ym1yidKMj/BEAcysWfmLcAda5vL99VVU88sW
         3guxIVHethCcLFz8acq4HmrKosIm1ql04sG0FjByJz3q4WbCoFuAWZIk8KGMEdYw3wgj
         +xs+mQD6kZw67IyH5f/ufdoMv3dpyVutdbMqLNEX1kyJMsO4NCSERYDYPkrKtbYDuRfu
         llkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsSaOd40snxVwTglY6OxpISTJQ+8MhRGtaBVZIlfu7pHM9SPv6WRVivm5aDAt4v2Kcg8lJHq5byyqzx5hHpQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k2AqahMjkeUcIwkuwBlFTQeyWiNTrWacdwd6z6/gx214uMDsGM
	OpMB/3Bj1aJwSXiDjrDvE8QCWpOlbfa9COp4FfSIgQt929MIN3TC7UXaYGLrTQ==
X-Gm-Gg: AYBFou0Uta/Ftv61jKTOg568LTH4Tl0d0QgJND1pxDmeuLePtt99pfry2P23/v2bmUU
	t5T4mLFOz4mTl5vsBdI/8M82hlXQIxVK3NIB29B1Dth5Gm1CG4o6QLcYDJesY4LfwirHozzkW8R
	Oe3yk7XirnkdlUPvDXEKkYo9B65ny2tY8PxVMAjdLs3fanpRDkYAm6xodFNwAXx6Qg1GHi3Eui+
	88ZZU1EC1HFs2qVYdUdAHV22sM4ro39CyLO7jJng/Abchyd+9d8BZCEH6pwR0W63mg2NCKMq4pv
	qc+rQ+Q740USBURJMYL1KXJljrliewWPnfgh2NgXh3fpbqRwgHEayc28KpIwPwZZukgcRzUpIQB
	eqYZhFT1YVmnKFhuCQLLOb2V4Wh2ld3Fr4l2VXbiIygMgfpAfWqHATv9buh6E7WFKc9sMc3ixYE
	vmFP30ZZQg1HC5kYBNKdoMUKDSgcRvTIlLD6bLB+C/VmOi3Zb6ILgmDeJ2GKGwPpNaALPc6EEAO
	YoENGZZ2wiS
X-Received: by 2002:a17:90b:390e:b0:39e:8d5:fcee with SMTP id 98e67ed59e1d1-39e1e4d750emr11947446a91.17.1789604919683;
        Wed, 16 Sep 2026 17:28:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e360a6c8asm1946241a91.13.2026.09.16.17.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:28:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:28:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Baruch Siach <baruch@tkos.co.il>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] watchdog: rzv2h: Avoid division by zero
Message-ID: <7915afcc-4740-4315-a53f-36becef281d5@roeck-us.net>
References: <20260913064851.8239-1-tzungbi@kernel.org>
 <20260913064851.8239-4-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913064851.8239-4-tzungbi@kernel.org>

On Sun, Sep 13, 2026 at 02:48:51PM +0800, Tzung-Bi Shih wrote:
> clk_get_rate() could return 0.  Avoid a division by zero panic.
> 
> Fixes: f6febd0a30b6 ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,
Guenter
