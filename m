Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890352;
	b=NxkUvObrwn6dmWxHy9C6m314114B83ry8kday20V9d4JjevX8aZhWgT3vL2TJt3xlo/i
	 6uVFNfndyTXa86HgeFC54TUZ4Z82w3on81hyB4/YLrFglTDU1MY1Og8lzQXrZmw12Yz28
	 cGd5kEqcovKneiWIpvWEi0hyVzvy2Wx3fRfgOFA40Hdu4QwcnG0Isvjyvl3wTgC72UWN0
	 B64QBaPbeVyJ3fP47EMmFDu9xzQhGMUxPjNmGazkckL2PaEy9VarV/QweAwjVXpWJXNoq
	 7D4E8Hz5X/Fk7eIYRHmD1ajRQjB7AIcBHFl43b6UZ4fpb7siZqSIBwhom7fnyab5Vgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890352;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=5/JfEDPujbEw2M1lWRc58Mv/QZQzJGit/BukOm4pw94=;
	b=U+gWIlIcbYYnUQ8kV3lDxV8buqdb3HdHnaHWlJSKHfSI7gIpXVWzDOrYAw270ljWG4V0
	 UnrprVwdHjjwaNUSQY+gURPNq7JWhjZiY7jHayK6C74703rNpAZQRelvWuebPMWjMkD9K
	 P6M46uI0EJVZiAMUNbTx1Ht31V4bjBjeuNAWIWCoxt41cwaLxhIeneMH4URT2tJOEWFnc
	 Lq0tNpvBUUegrkMphBsuskoSjte20vWqq0hmKaPqQOLqp3LGtV70DoOKRLS7pIuNwixNy
	 qpeb3+Ir2N/a/9wnkdNZrEewXn07eGmlM0+eYYHGdu1rjqRGUx2iPYSs/C535rG0Wqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=xHVrQ71y;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552D606A31B
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 14:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4552D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=xHVrQ71y
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id Oj1Yxu9LWyb4YOypLxInpZ; Thu, 05 Nov 2026 14:52:31 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id OypJxo6BSpr6MOypKxZoQ1; Thu, 05 Nov 2026 14:52:30 +0000
X-Authority-Analysis: v=2.4 cv=Ec3IQOmC c=1 sm=1 tr=0 ts=6aec982f
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8
 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=3lCh_UBG98VLpMggqdgA:9 a=CjuIK1q_8ugA:10
 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5/JfEDPujbEw2M1lWRc58Mv/QZQzJGit/BukOm4pw94=; b=xHVrQ71yxEEErEjvzO/goFpVjc
	Q8HKrFBLHimVLEH6/RRtspOZ7YFPvPV9sSokwWFs19OcyMjB2sTa6JobCEnyDF0/A8IfUEN+5X3Nm
	unbKphs/aSOCdAcWY/SKTUD9/TFkIZlt26gT5Dv4Sz/4O5Uj+GMondXzlSWGoWtPIcM7R0RWGxSWX
	DMuuHT/0BGYz0vrBBIP4VVDe9XZwDx9ysdBnO8VIsW7jYAj15FLo7Ste8sfEB5noVUBl4OEY39IxZ
	OIvKO/a39nLyRdf/n3L7zTlSL22nknLqRHMFEOrsCkI3c/pFls2MkOjgyLClf9nWmuz/ly3OBwSOm
	tZHk53FQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44792 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOypJ-00000001MoB-2oy8;
	Thu, 05 Nov 2026 20:22:29 +0530
Date: Thu, 5 Nov 2026 06:52:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH 1/5] watchdog: starfive-wdt: Drop runtime PM reference if
 starting watchdog fails
Message-ID: <0a5970d0-7b39-476c-8238-7c05ae6b6435@roeck-us.net>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-2-linux@roeck-us.net>
 <auyIwPSEVBdme68d@google.com>
 <0168a321-10ac-4f67-a279-1523a00e0972@roeck-us.net>
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
In-Reply-To: <0168a321-10ac-4f67-a279-1523a00e0972@roeck-us.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xOypJ-00000001MoB-2oy8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:44792
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 9
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNaIG3cBaWM7hxYtq1re4+1/oN5QbuitD+c7PGGy/DD4BnQb15hkIHIzyW7lhhbyf3ng/7zyQHWitLRuhlcC4WiO5igbT9NPqqP4qLO+ozY9NK1LFS3a
 kwAWl2dDltMBILSKwO1NgIUc79CmuiJCr9wMH8R81fFmmVNJ5PlR2vmzsNdEsrQJ3xCQUaVFpWNvt8UelYBuDIrUGhFI8DLb6+YOCJuWiqbzt0Kha0I3C5ZA

On Thu, Nov 05, 2026 at 06:49:26AM -0800, Guenter Roeck wrote:
> On Thu, Nov 05, 2026 at 01:46:40PM +0000, Tzung-Bi Shih wrote:
> > On Wed, Nov 04, 2026 at 08:44:41AM -0800, Guenter Roeck wrote:
> > > Commit 8f0ca55016a7 ("watchdog: starfive-wdt: Fix runtime PM leak in
> > > starfive_wdt_pm_start()") switched starfive_wdt_pm_start() to
> > > pm_runtime_resume_and_get() so the runtime PM usage counter is not
> > > leaked when resuming the device fails. However, if starfive_wdt_start()
> > > subsequently fails (for example, on a timeout in starfive_wdt_int_clr()),
> > > starfive_wdt_pm_start() returns the error without releasing the runtime
> > > PM reference acquired by pm_runtime_resume_and_get(). Because the
> > > watchdog core does not invoke the stop callback when start fails, the
> > > usage counter remains permanently elevated.
> > > 
> > > Drop the runtime PM reference with pm_runtime_put_sync() if
> > > starfive_wdt_start() fails.
> > > 
> > > Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> > > Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > Cc: Ziv Xu <ziv.xu@starfivetech.com>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > With a nit,
> > 
> > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > 
> > > @@ -372,12 +372,17 @@ static void starfive_wdt_stop(struct starfive_wdt *wdt)
> > >  static int starfive_wdt_pm_start(struct watchdog_device *wdd)
> > >  {
> > >  	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> > > -	int ret = pm_runtime_resume_and_get(wdd->parent);
> > > +	int ret;
> > >  
> > > +	ret = pm_runtime_resume_and_get(wdd->parent);
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > -	return starfive_wdt_start(wdt);
> > > +	ret = starfive_wdt_start(wdt);
> > > +	if (ret)
> > > +		pm_runtime_put_sync(wdd->parent);
> > > +
> > > +	return ret;
> > 
> > Or just `return 0;`.
> > 
> 
> Good idea. I'll change that.

Ah, no, we still want to return the error. Difference is that
pm_runtime_put_sync() is only called if there was an error,
but the error must still be returned to the caller.

Thanks,
Guenter
