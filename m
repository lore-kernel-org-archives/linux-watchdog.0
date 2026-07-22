Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC97259CB9;
	Wed, 22 Jul 2026 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712029; cv=none; b=o845P9a7W6hx2MFZfmY71wBNqTv5Lf9BPq8NmmVUM2m0/KhUPBHuGPRsHAW7uIRh3Z4OA5C+RiE3jbH6Gt/NXCV1qZ3zkRkAynCVsYZA99aYh0ap+2Yc8hK27l71G6K8MSENdBNlntDebQV4JOsDB+FcxjsF71lLf+CWUJpmjsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712029; c=relaxed/simple;
	bh=ht9iv4F8vt/8LFifyFb3oJaUX17SWnDYE/8BVJfkUvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOeaM41st/vmVx6ACjtXQy10FSyBlWLUbf4hzjWaXksSaf6d0CkD8YpLpxlGnTyfDyuFgGF58Hu56D7mTaytSUNeZ9aYDW5/ftWGm1s+u7gFZqPTW/8J1asAnwGSTXaBj0zWASMTGr1+LdYBdHhlEu96nikxzzGWh5pr/K+dWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jg8CsMPI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jg8CsMPI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9F2024E40EC1;
	Wed, 22 Jul 2026 09:20:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D04460388;
	Wed, 22 Jul 2026 09:20:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 116EA11BD1850;
	Wed, 22 Jul 2026 11:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784712024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Oh/yNPDezdV0HMgSY5ouqiscRtqRQg3+qt8ontK4cK4=;
	b=jg8CsMPIN+1wrWNwqDxeAhM2ZQolv6JwzKWIOshRCM7YtLTWJFpKsh/G+z9DClpNhWbiIv
	I3DrzQiYum+NihlmMxEtzaiXCJild3PklhwhuONXfCCeLvoxtwz4mCdxlhSe3H8EGZxZqz
	2qLK5JCKsEz1emnk+/TPydmdVV//Unsh9w0a/cw0aQ2pHxfucu8drWPBWnl9FvqTL35JlI
	XfoT57nLiq1XFlUTGG2laCZJWKVKhQWjdz6Mimq+0hrJesPnmA63Cgw/ty7qBzFfLrsmoh
	1at+B8CDYkiIbKMd1bmFtbf1wlggbqOGtDEHgmaZQKnwhxISajdLBz2nLadhKQ==
Date: Wed, 22 Jul 2026 11:20:22 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] watchdog: sama5d4: Remove redundant dev_err()
Message-ID: <20260722092022e8d308ad@mail.local>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-9-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722084218.79073-9-panchuang@vivo.com>
X-Last-TLS-Session-Version: TLSv1.3

On 22/07/2026 16:42:16+0800, Pan Chuang wrote:
> Since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
> devm_request_irq() automatically logs detailed error messages on
> failure. Remove the now-redundant driver-specific dev_err() call.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/watchdog/sama5d4_wdt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 704b786cc2ec..ecdd9aeab79c 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -291,10 +291,8 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  		ret = devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
>  				       IRQF_SHARED | IRQF_IRQPOLL |
>  				       IRQF_NO_SUSPEND, pdev->name, pdev);
> -		if (ret) {
> -			dev_err(dev, "cannot register interrupt handler\n");
> +		if (ret)
>  			return ret;
> -		}
>  	}
>  
>  	watchdog_init_timeout(wdd, wdt_timeout, dev);
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
