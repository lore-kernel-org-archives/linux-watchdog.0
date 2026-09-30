Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BF3546CC;
	Wed, 30 Sep 2026 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769213; cv=none; b=dqqQntfe0WHuC+J2XNTk137nwu3ySObIBFfzt6rstMFnXvFKFHKY21RK1V3W0dhvPNzLlItyAHBJmU/Xj0RmtlRHzEDLlP81pxMwKDkYrn+iyMzENX7E6KbcKCeJnTtKS41QlydYIupuMoOx0hyBemqhjPraXktWxJq1pTd4kLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769213; c=relaxed/simple;
	bh=iTB6a+dJ0oZpMgHysKpzHZObemNLKuXXnjGBOgsP9OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/tM+qjgFT/hMl4Gdu6ZN9tpPLB+pXHb+jnnMveesBDEY9jc/vP1e5BZsq79wChm8ykJ+Sxgiip5a6lXPF8FQuI5XaZfhPVSl8RpVevKxLWSBOZvBXQjKlwpw2+hYoK0ylUr3OmjomDFNCTq1arVgiWt7x/c1KYl349qCrqm9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G44yalhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G44yalhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58211F00893;
	Wed, 30 Sep 2026 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769209;
	bh=nXC41ysyyS+PrcqM+upU5jwSRAm3wcckWpd6j18u/Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G44yalhKFKJZQeVHWEP5Tm4329JuZy/W/Qr7jGA8FM4CnkRQDN9yzWx6P218zaqDU
	 HjQsc8BV9cZ94G7kydQETPPawLKxbzVW8MOrlIZ+5AeZxdKBum6pAbwjUDFpq8TGmA
	 Cxis/rzF9pQ8ZHme8ILV0ls9TRuR//AkB7ewxrMPNhwlqOjOYHrrp/acXegJszZ7ZV
	 8J1KEJ9r368ySv2DufGOz8+0Mr47/Sdo6Gkr6xHCE1IsyHfNiRDsYkFGlkYF61lMJf
	 9/3Btjj8GMOS5bY4Ku01oMpTQ3rU3cTqpjRQHAm/004yWrGoP1bd6BDSA5zZLRufz/
	 lvMUvupW8hrUg==
Date: Wed, 30 Sep 2026 19:53:26 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] watchdog: core: Add missing locks
Message-ID: <arz4NgR9yewNFvDY@tzungbi-laptop>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-3-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929134635.2567137-3-linux@roeck-us.net>

On Tue, Sep 29, 2026 at 06:46:29AM -0700, Guenter Roeck wrote:
> Add missing locks to watchdog_open(), watchdog_cdev_unregister(), and
> watchdog_set_last_hw_keepalive(). Also protect old_wd_data with its own
> lock to prevent its modification while in use, acquiring wd_data->lock
> before releasing old_wd_data_lock in watchdog_open() to avoid a TOCTOU
> race, and keeping misc_deregister() outside old_wd_data_lock to avoid
> lock ordering inversion with misc_mtx.
> 
> Fixes: b4ffb1909843 ("watchdog: Separate and maintain variables based on variable lifetime")
> Assisted-by: LLM
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
