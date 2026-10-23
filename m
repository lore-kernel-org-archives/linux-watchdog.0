Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724734;
	b=R9ja9lwadkF6+1zWuLXf6ZXZObXohDCkJBrW5wfAZxgudwGZBHdQlKXfatAiTdYesUVm
	 tQ8s1ujsjZG7WF03U9X/Js3LRqwiasrCm8afjNtc43y4GYnqH2dTmaoVKWMrJqQGl24oK
	 7r6uCKhi7fwCT3A1F1RoTsoTk0h5udfjb+PfMviWB05MdEQwkUOdA4GOkiVQP66N+AfWn
	 4c3SPpxirMvCX9HPQchhSXZyIQCT7Fm42ZRodrlbAbrAAjYgsSXWq1tKl6fzw5zmquJrd
	 14YsJAFBbDAtBCosWdAzMFBVCQCLURVApTqw283Nv6ASBdIkxIu3Vs6TVjaqN4VYwWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724734;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pOreW26xuh7Frj+IoBIipKrJswLecNXgZZXTEGzCs9o=;
	b=ni2ABysF7lTzhgjQ6l68HpzQGOA5/FsdHWX2SqDC/yGpGfF+g4B5ejCpyKDHKsPNQcM/
	 +sqgy+wx3doD6muKWaQ42mTz1BMV+nQH2EZCzVIJE+Sw7/ygSKrz3LqrelntfkjJybEBr
	 SYACo3pQRNBmc3eCl8krkDHxgqrAPMr3+G72VFBrl+vNF02DNhHXwZpaLJ0VJWMRfpBZ2
	 Ks1cK2YC/K2z/SIlyywSOV2Ux5VhxzZYUgqi47qIS/Hxp2j+ug63JOK1toYTdI1A+BDtC
	 JCTpwjP7YAsRS0kHaNLRGBgqn9KVa7crWV1CnN/7Q6Y2cYMAPZHMC4CpMJesOajR6bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hy17Lrhm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E399606A31A;
	Fri, 23 Oct 2026 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hy17Lrhm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401001F01825;
	Fri, 23 Oct 2026 03:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792724733;
	bh=pOreW26xuh7Frj+IoBIipKrJswLecNXgZZXTEGzCs9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hy17Lrhm2SLixrRMqzphoc7prdI6CmqyW4yavsvC/8MbMd2NaCyCiIbx8antLdHvh
	 GLvNuWWuBIKJsTfObU5Ul1f/ZqSKOJWnPlLSfOhqPGp0KLXiN5oW9TduPS4pPRaHBH
	 hCKIwVur07n2tCSITq6CcDTG7GtGUnfu5AbaE/AkDDAMm7bOlwSn3TjB061fK8YE7s
	 61CF39795eUQ7PXG6U6g+94oNhB2CX91nedvwJph7zQwPxrxG6W2o5cq2tHaUwPlqX
	 jSerSvoVTIlNcc1fVP5bpliBaW8G0ZR03EY0bQJGoGPNL/POu7U8Ae9xOivahEfQHr
	 tocUo+qCFWAUw==
Date: Fri, 23 Oct 2026 03:05:30 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org, iav@iav.lv, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog: dw_wdt: use
 devm_reset_control_get_optional_shared_deasserted
Message-ID: <atrO-ntRyvUMrKNE@google.com>
References: <y>
 <20261022134354.534642-1-a.shimko.dev@gmail.com>
 <20261022134354.534642-2-a.shimko.dev@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022134354.534642-2-a.shimko.dev@gmail.com>

On Thu, Oct 22, 2026 at 04:43:49PM +0300, Artem Shimko wrote:
> Replace devm_reset_control_get_optional_shared() with
> devm_reset_control_get_optional_shared_deasserted() to let the
> device-managed API handle reset line deassertion and assertion
> automatically.
> 
> The driver currently manages the reset control manually: it calls
> reset_control_deassert() during probe and reset_control_assert() in
> error paths and remove. This is error-prone and requires explicit
> cleanup in multiple places.
> 
> Switching to the _deasserted variant deasserts the reset line on
> acquisition and asserts it again when the device is removed, which
> allows removing the out_assert_rst label along with the related
> assertions in the probe error paths and in dw_wdt_drv_remove().
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

With a minor concern shown below,

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 39031445d754..2cffe337b4ea 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -588,9 +588,9 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>  	if (IS_ERR(dw_wdt->pclk))
>  		return PTR_ERR(dw_wdt->pclk);
>  
> -	dw_wdt->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> +	dw_wdt->rst = devm_reset_control_get_optional_shared_deasserted(dev, NULL);
>  	if (IS_ERR(dw_wdt->rst))
> -		return PTR_ERR(dw_wdt->rst);
> +		return dev_err_probe(dev, PTR_ERR(dw_wdt->rst), "failed to acquire reset\n");

The driver has been "quiet" in probe().  After the change, it starts to be
less quiet.
