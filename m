Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4D59C998
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988890; cv=none; b=MvrAjcmQZg3jj3OyQbHFgIwDPJ9BY2DyHPDj42+UeGxmyyFU94QchZ3m36T8Vf3Xcp19FwxQ42hheQN+HyT2nhJkTtMBMALq1FsJAB0lFrDgs1D30in+x9+LrOJ//2UZklsNKsjNS8ycm9p3aYJ9puUpnMoyp/5G1HfOjeZ1b+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988890; c=relaxed/simple;
	bh=ceVz0o9tcGe9MDsynd1j31znF+EjiAmRfe+cPrmhdBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6Fv7l917syL2mRPNrz1JwJHN3ffaQpr4FS8EX7lScbP19MxrV4Qp+EjcJuX9JF3As/K2tqOjv3QK1pDlTG5ooeyQ/VzMN9J/ayzxXKyJXGQL1TnLCmqZqpJ8+ndoNMcMpHtcSX3z28MQ807s2Isfw9Bn4khg7NErW0OBtwwjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF3PisIq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF3PisIq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6d28aa26cso41555585ad.2
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988888; x=1789593688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3NLjqteAOb4BfJa4KMZU3dUwkT0UPcgIQHkE8qwI7Gc=;
        b=DF3PisIqRZ6arvqqSHFB+ChEJo3kM74H0XsO/x5oeqBE1CLO+WcMykD2H/M7vhoBx/
         JKW0yTVae8S8EjbTumEZY+PQFU2j0p/nGEEptIDei4neI6f4aWbi1l4LSdRp2GyRKvUk
         az5juxStAY3bRmm6hKqvssF3nhWzS/Me6aFXZ3HuDoSPgNbFjIv54aaVm/sIomdqEr93
         wXvCrB1GgqMo4DZorzKesv8VA2j7d2tVhp9cGt/i9LI5mWK2OnToY1ZyVojmpfdVFrDw
         tkYFxSZmuB23WYuoj6Z+12OFMfAWy2Lm3FjFXPlCLvcAbpojhCnww1k+7vFVWTBzZ7D4
         xRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988888; x=1789593688;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3NLjqteAOb4BfJa4KMZU3dUwkT0UPcgIQHkE8qwI7Gc=;
        b=saSXB/jveeQ9EhrcxKq+VN9AXHOXAQ9r3VxTZc0nioPo9YsZJT9gzgCojJvrpCR05m
         IiwS7lI1/8ScFf4n2X3uPwYJivsaJIKRlFH2llyBQ+/lJphvaoaA4PvfW1NtZ2TFVzj7
         1NRcDVx4Sun04Rt6fN/mPEiLAaoiKHZKHHDXL9E+mp0oLCLz+Gg2pZglR1/iEgQpkFqa
         Mq7R/1Q/vOe76uyMlZcqwRd9llUxzqJ/BNU7A/YZo9irAbgCH+2qEyBbsXIaucx1sXrV
         Yl4w/aRNeJrlNm+1ijuF3JZe2SwNA/Y56hHnQkA4gq/qnLlhwq8T48mD43Kwpyd6mU8d
         wVWg==
X-Forwarded-Encrypted: i=1; AKwUvBySfP9Rol/hjrZ39cFFX3oORAkQRJgPxbW1Zv5gH1Qe79mbYb78SOmplDoEDjGQQNx9YVuQV1YUzCJJ9G0KtQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lPQeuNyaqQklS70cI+QLsp3fof5K8csfIcRSpLLSltLK14V+yk
	YN/4ueFa1yERMGb/9PMxwqea3e64CRjWol0Sc9An8r3ttNf44kkHI2JZ
X-Gm-Gg: AYBFou0yVbdbmvo+pynwqzEj3b3w6rA7aWdHqlmE1ehV7LY2zRGpZr1RKzI3COJA1L5
	Qtit6yvyO5hSgpkH15SrG5/gwbWdt7SUGxQK4SWsEjara5qbcMP3g+mRRfkkn2f0WpOVPbkMkCs
	B63Ovt9bNG/V6a8rRF9LSBrhxNQ2oDDE9OrD9XQ1vAAc/fBo5ELWK0sRLvV5un98WrF4oc1Lgm+
	5A4tTJ8sZ2HprRQBILSKTJbyJQfrdJegBH6N0t9BC/24xZxaPYULrW9xWCjpDhN7i+VX/Nhsb3q
	kBqpr1EX/m3DwxCWQeSJWS9Y+ThVawwmWEyJI6Ft0+n7L1CNnZSX6t3f85X/THUsR/H7dOtDMEG
	WITf4NSKchRb0D3iFUcBX+V9RLYtztgXd00HmdwvCcglNR/pB5tWJVlFjZ7+csTNSA8vQYDiKd5
	dGad5fu8GBZxTudMcp3t5iHL28VyqBvYcuHC2+kOJp8GcvXzuJHKPjSZqSv3Lkf8j1/Mne8++Zs
	uLmshKmKDsj
X-Received: by 2002:a17:903:4b4b:b0:2db:2376:6e8a with SMTP id d9443c01a7336-2db2376762bmr460512055ad.9.1788988888276;
        Wed, 09 Sep 2026 14:21:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1483d6absm79424625ad.1.2026.09.09.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:21:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 14:21:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] watchdog: msc313e: Propagate error code in
 resume()
Message-ID: <5b12bba9-79b8-469a-8a4f-829b55236e0d@roeck-us.net>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-9-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828161348.13212-9-tzungbi@kernel.org>

On Sat, Aug 29, 2026 at 12:13:47AM +0800, Tzung-Bi Shih wrote:
> If msc313e_wdt_start() fails during system resume, the error is
> currently ignored.  Consequently, the watchdog isn't running without the
> user's knowledge.
> 
> Propagate the error code, print a message, and explicitly clear both the
> WDOG_HW_RUNNING and WDOG_ACTIVE flags if start fails.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> v2:
> - New to the series.
> ---
>  drivers/watchdog/msc313e_wdt.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
> index 4a5cce2a16b1..6af865750ad0 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -191,11 +191,19 @@ static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
>  static int __maybe_unused msc313e_wdt_resume(struct device *dev)
>  {
>  	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
> +	int ret = 0;
>  
> -	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev))
> -		msc313e_wdt_start(&priv->wdev);
> +	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev)) {
> +		ret = msc313e_wdt_start(&priv->wdev);
> +		if (ret) {
> +			dev_err(dev, "Failed to restart watchdog (err=%d)\n", ret);
>  
> -	return 0;
> +			clear_bit(WDOG_HW_RUNNING, &priv->wdev.status);
> +			clear_bit(WDOG_ACTIVE, &priv->wdev.status);

I think Sashiko has a point here. Please leave those bits alone and
just return the error.

Thanks,
Guenter

> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  static SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend, msc313e_wdt_resume);
