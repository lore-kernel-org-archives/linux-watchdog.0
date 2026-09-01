Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2A32C8B
	for <linux-watchdog@vger.kernel.org>; Tue,  1 Sep 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303753; cv=none; b=nNIYMO9eMbKFSx9pYRKBRjYdshj5lYcFVEPpaH9FS9+CMCx1MrsZvBp/n2RCErk1dk4O5nr2kPlmnoT3ki1dhztjqqjKVc0uqraEHzLk/Y7f9gwSpQ+2b0s37uSJP85BCg6uiH6Rx4mWCYaVS3q64mnBiCeQ98fDibkFCyhSNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303753; c=relaxed/simple;
	bh=+gQNNbFnTumXT0iR+hM/RV71lEvWRVZyc2oX0tZOSvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZjKBJk+AyGBAnVd5g/NogCKDEI3zH0fcJGMa4lnmW6TUq2ISDOkN0gWfW7ZOWN46ZMyGVXo/GjXPHN0CbYpCNX3XnZVJ7PpsC0yv2GtvbHzH5XeUVktIrjGf/m3/MiHJV/eYlOaDHKMSdQABa0vae80dgIZ8ytvvz9pQy2G2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7ftEzpO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7ftEzpO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398a5aad413so365710a91.3
        for <linux-watchdog@vger.kernel.org>; Tue, 01 Sep 2026 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788303751; x=1788908551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5lRubRw4r4a1yQYYdGqmoQ15QOh3yiGEv0tXtGD7fyY=;
        b=J7ftEzpOPG1HgpevbZNLDEqyoCOUWbIxUnBT+8jlgepqe19I3HTfPFb/ibyekrzvbR
         Vbx96CCkKBMjXtSy6/bDzYLjtge4pkTp1JDZoLnhpnfJ+Awcso8q39dZUzjDBAQAo/fq
         3eu8KrfHy0xNgMROd9cpjJsVL2lX+IfcqSOlqjElkJoUZup9BETgT+zwpadCuvcGFB3x
         OcH4GJU8idrUyB4thB2AUt9lGU4PK3ZIZTKCF0vdoL9AbfcotJatayN6ONCfTyMkKvfA
         PMcfA6hF9kdzmowsCD1rGskQSxtQFIKdd37oQbPaCMRrSlWBRsPiDqpiOC4K8D+6V1Ud
         604Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303751; x=1788908551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5lRubRw4r4a1yQYYdGqmoQ15QOh3yiGEv0tXtGD7fyY=;
        b=lrH9ovSzelUPWRmyS8TCUYvHYk46oTh8o+a3SWQHtADdoOmEFGcukuJGWiW5h7ZpVd
         yqd/wJ8Bv8mmz4Wa+8E5KAtUhkrHKieHqEbX8/3jMqHyAokLKFdAJTafx12rLp6QAy57
         nCHFloFkt4X4FSmE7l9bnEDUaDQAJR1k06nSLNcrBVXm6dtE9PNOXuBYJErFRKIi5gx+
         dy0rXgrX+qCXmRWcYDsl+c3gNr/8wJJu1i4nFpBzeh1wgMm68OttTTMqdhpXVTS7NoYz
         DqpVfsoUs2N+bxNyCwv5h8/x1KC21t3g2+phdCgHw7EPpjRqFJUf8BEfxWY/BYWvFKYI
         5XZg==
X-Forwarded-Encrypted: i=1; AKwUvBytXge66SvoXeJClaYrHJbxGLKeSnYiuTHZpMqgYEwbDq37gyUioiCrECUMmIoLlAMD87QbTJEokXr+S/6rkg==@vger.kernel.org
X-Gm-Message-State: AFuF++l2kIEquOTJ/eF+uyD8CBADiUSiF6+OCXETu5urshvRtuYhjGI4
	seseb7eaydApK9MqXWfDrFFuQeeDZ05gYh0zXrOc3kioKn/f4WHs5AywEyidxg==
X-Gm-Gg: AYBFou2CiC06y0Y0jjOWqtQgSfymkynYLUeHyvFFhu4/6NFqrmf0YuHWv8HKwHGuK51
	eXONOIjJ2NkfJ9yVjSL1o4TAvET4HE0FMKyvxepKjBrghvS7lRyyqHiSH/5mNfQE1c2ElGgUntp
	DRoh32S+9e54DMMq8TfATHSApeTm076/pVtnDn/SDXqFSMCL0GH9WwZNzPy2Y9wkNgdpRPvCLen
	NS88Q4u3ND/147yJkIE3fFqUKh91ivg/zsd66gppx9dAuG0zgGbfXxCv/dWkA+Z90812Sw3j8tF
	4Ii5XjOcLvPby8Mge3RPkmH0h1Zd8WVtvEm4NkRquZpmbzuZMTcaZln6yW9pYgeYkR3GUHouZZV
	Lv9GXUBI3gUGm7JrXInvGiBJT4LDHThWjPv/4u09OFfRg4R4e7R7mruBgnOZEBtEUIfTsgQQy/k
	ANBz0vTxvBvyXRRCVcDXFxMhYV5pWrA704FJU+o7qbXcmQ5/pZagOj635jsDKVYsTL8pRNleIkE
	/YitQuS9Sle
X-Received: by 2002:a17:90b:384f:b0:398:9bd1:3210 with SMTP id 98e67ed59e1d1-39aee0e6a17mr422028a91.17.1788303751072;
        Tue, 01 Sep 2026 16:02:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7bd00sm1050895eec.14.2026.09.01.16.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 16:02:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 1 Sep 2026 16:02:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Charles Haithcock <chaithco@redhat.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: Differentiate scenarios when watchdog is closed
Message-ID: <1c15e728-cafc-43c3-87d8-981a2682d441@roeck-us.net>
References: <20260901214251.760184-1-chaithco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901214251.760184-1-chaithco@redhat.com>

On Tue, Sep 01, 2026 at 03:42:49PM -0600, Charles Haithcock wrote:
> Presently, when a watchdog device is closed, we print "watchdog did not
> stop" in a few different scenarios;
> 
> 1. When nowayout is set
> 2. When the watchdog is able to close, has received the magic character
>    to stop, but fails to close in device-specific code paths
> 3. When userspace deliberately closes it without stopping it
> 
> For 1, we explicitly print we can not close because of nowayout. Nothing
> differentiates the other two however.
> 
> This change adds a print to indicate the watchdog was closed while still
> running.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Charles Haithcock <chaithco@redhat.com>

Applied, but please version your patches in the future.

Thanks,
Guenter

> ---
> 
> v1. Introduce change and modify logic to differentiate
> v2. Simplify but still differentiate
> 
>  drivers/watchdog/watchdog_dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index d7895009a2..937bdd4c92 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -305,6 +305,10 @@ static int watchdog_stop(struct watchdog_device *wdd)
>  	if (wdd->ops->stop) {
>  		clear_bit(WDOG_HW_RUNNING, &wdd->status);
>  		err = wdd->ops->stop(wdd);
> +		if (err < 0) {
> +			pr_err("watchdog%d: Failed to stop watchdog: %pe\n", wdd->id,
> +				ERR_PTR(err));
> +		}
>  		trace_watchdog_stop(wdd, err);
>  	} else {
>  		set_bit(WDOG_HW_RUNNING, &wdd->status);
