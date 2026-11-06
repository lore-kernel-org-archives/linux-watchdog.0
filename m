Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974957;
	b=FGixZLKFui5CaDOuN3p5GcQUnt1HjyCL6bmElEEeZyrS1xxstNnHMJ20G1bwsZm/waIw
	 X9oM0ccw2q7v2rOwEUtqgxvjOQKna6iLqZ6z2ZNAMnaSOZjm6EuDHaqOvaXJ+87+ZiWcg
	 u1Qgln33LilFE0upFT5uicoQSRfasjHRM7fYCCZonunIKMvAZqF9ScJmZiQnEPw73VNbk
	 N8yD+MfHoYgYuQX5KmAGE8LOjJKdp1GTOCBUJq+VvE9ia/vF19xcw0AbkYc2Nle4HoeiU
	 kvIW+8iSRMSoDzSgViyh7Zk8ond38xc+MBsGKIL52hp04Kppg8n7/GsUy4v9DVO336g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vNRZ7AwoqH0bpC1KCCRMM7tpLpbZSFBFd3MWm1jJtZ4=;
	b=UOnEi8+3nGJb+tTb/0I+ijfya1WIPchfliucyMETSVC1S1xokXHS5HB+e7Zl1On9LdH9
	 PX/hniGMDscjbj6Ejqps0wRr37MDXDkKa1I07NKlHBwz+96B+N85w8dfoLC2slwZ2GqiR
	 ysXcFWISQT1aAv2vbKLjSht6RHFM1hQEftmjCPuKlgDc0GIt5qMtHG7btbveQds551YYD
	 w6YGJxuPItHGV6dnAoSa+sy/5oB2ok89k7LWg24DXFZFsBZSJ6er/vcdv14gDBuCgeBUD
	 3fBuIzohFq0biCLgyKxhz4metf56RLhOqcN+8phsOprelgRrWS5R6NJQHeE6wcv6yTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NCf8uO0/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505D606A335
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCf8uO0/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493DA1F008A1;
	Fri,  6 Nov 2026 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974957;
	bh=vNRZ7AwoqH0bpC1KCCRMM7tpLpbZSFBFd3MWm1jJtZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NCf8uO0/oLMMFLvpAqTjFf6F40D+YcLhX6zma+2uztRe5z5JTBGG60OOw1XxzqCDu
	 03W0L38LSpfTnb62TmNppjKCk7pUGZx+WBkLZyeGPoBAJ+YSYKPTfUkQH/nRJadYoB
	 SfdwzDx2daljjxjiU3IL+Mpq3+tFh0sdNGuDO1UUW+nB6am0A7sLDhII83exc+At/+
	 u0wqWPWXAu1IgFq5kT8iAlpUm+holPv+M/zA0HYa3Apemd63Yq6U6rLBdKHQRF6oxp
	 cY0vT8zek79lVi5iCwu8VJ3g7lhDDG3ADq8s5ag2FcAnEGdvfO7p84n52Y8Vb81fJS
	 bwfejvIlanU7w==
Date: Fri, 6 Nov 2026 14:22:34 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH 5/5] watchdog: starfive-wdt: Drop runtime PM reference
 before registering watchdog
Message-ID: <au3iqjLv6tatuwyr@google.com>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-6-linux@roeck-us.net>
 <auydfozcvsC4yjR-@google.com>
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
In-Reply-To: <auydfozcvsC4yjR-@google.com>

On Thu, Nov 05, 2026 at 03:15:10PM +0000, Tzung-Bi Shih wrote:
> On Wed, Nov 04, 2026 at 08:44:45AM -0800, Guenter Roeck wrote:
> > @@ -499,28 +499,25 @@ static int starfive_wdt_probe(struct platform_device *pdev)
> >  		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> >  	} else {
> >  		starfive_wdt_stop(wdt);
> > +		if (pm_runtime_enabled(&pdev->dev))
> > +			pm_runtime_put_sync(&pdev->dev);
> >  	}
> >  
> >  	ret = watchdog_register_device(&wdt->wdd);
> > -	if (ret)
> > -		goto err_exit;
> > -
> > -	if (!early_enable) {
> > -		if (pm_runtime_enabled(&pdev->dev)) {
> > -			ret = pm_runtime_put_sync(&pdev->dev);
> > -			if (ret)
> > -				goto err_unregister_wdt;
> > +	if (ret) {
> > +		if (watchdog_hw_running(&wdt->wdd)) {
> > +			starfive_wdt_stop(wdt);
> > +			if (pm_runtime_enabled(&pdev->dev))
> > +				pm_runtime_put_sync(&pdev->dev);
> >  		}
> > +		if (!pm_runtime_enabled(&pdev->dev))
> > +			starfive_wdt_disable_clock(wdt);
> > +		goto err_disable_pm;
> >  	}
> >  
> >  	return 0;
> >  
> > -err_unregister_wdt:
> > -	watchdog_unregister_device(&wdt->wdd);
> > -	goto err_disable_pm;
> >  err_exit:
> > -	if (watchdog_hw_running(&wdt->wdd))
> > -		starfive_wdt_stop(wdt);
> >  	if (pm_runtime_enabled(&pdev->dev))
> >  		pm_runtime_put_sync(&pdev->dev);
> >  	else
> 
> Would this improve readability?
> 
> 	ret = watchdog_register_device(&wdt->wdd);
> 	if (ret) {
> 		if (early_enable) {
> 			starfive_wdt_stop(wdt);
> 			goto err_exit;
> 		} else {
> 			if (!pm_runtime_enabled(&pdev->dev))
> 				starfive_wdt_disable_clock(wdt);
> 		}
> 		goto err_disable_pm;
> 	}

Ah... I should have written:

		if (early_enable) {
			...
			goto err_exit;
		} else {
			...
			goto err_disable_pm;
		}

or

		if (early_enable) {
			...
			goto err_exit;
		}

		...
		goto err_disable_pm;
