Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890170;
	b=sMCWRFeCTAGx5OH9rBpOWixlK/tHfKg2wdk99zjf9r2VyBKHHO1VtJ0jnpUWAvETnDlF
	 uAWITZVUrnr8V4biVOSOVQW+wDd5CyBP755tf7jGpd6/bqZ2eKl5VflO2lFCU2OmQlF6Q
	 62ru2T7X/xjlL5qrue6+owto3mjpkmGswOyDg6X1pgNdqpKsKzyoJpdZr9vl5qa8rwUZD
	 HLVU99VijVdn0Ba+rsUUOiiCOjBI3lVGy5mvZeyvO+/IM9GhJs4bhlSDHLz8j3fXOYwfo
	 aKYRuezRh7Mn1a6/J/6p7ZRCssHiS5mdcRigSsk7AKsZKDQJ1z6t6MExYOBUZieOZgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890170;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=LlvTYu7hiauCOklgiz4ovh1x+LTttUvooZWLjOFh8dI=;
	b=4u8IZgVYd//THm4YOWB5FFoGXxp6xQxNvZ+bfr0fi6LBD4rhHuZYNFEiN77R2dRVatJG
	 gONHTug1+7ua7uYgwmc+c2f7hmdicXDjMm4fuf3BSS1QciEdI6VdFvockcfhgi+jnH6bb
	 gRokdMCbWXlu+zBmbY68hj/1kfvQ4ZWY5OdLT6rHOfDv3naGuGOyC+Q5z3YxjS9HIa71a
	 tDuJaqTowPAHuYJm4f7fdqy7hZ71E7U+lYsDpjJbm0aGu4nTs6oEj1IBWIhm9LNlywG9a
	 us53fRLeQzXEUStxjq5NgW/be4rOLBxWaGwuJG9aVFaI0ZPcC7zkF3XmNlAoDOpcHiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=H1K0SPqq;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB93606A334
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 14:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FB93606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=H1K0SPqq
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id Oj1YxZplaVK9UOymOxOm3u; Thu, 05 Nov 2026 14:49:28 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id OymNxByvbuJrPOymNxjgXK; Thu, 05 Nov 2026 14:49:27 +0000
X-Authority-Analysis: v=2.4 cv=WLZ/XmsR c=1 sm=1 tr=0 ts=6aec9778
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8
 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=Nksg_fBlfFGtrz3jQusA:9 a=CjuIK1q_8ugA:10
 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LlvTYu7hiauCOklgiz4ovh1x+LTttUvooZWLjOFh8dI=; b=H1K0SPqqlCQvy+YXJU2NdTcvL9
	qidZOSRzwgGN2A7DfT6BWTpf4ZIBcyNF97ZP+1ny3EDGQrF0BthMSaQnS01nG00v8L+eowiLLgkW1
	vNlZKd2eksHG47/HQwr3cxQehzDi497HzHHsyZ72clUvNSScU2LVEhtnfZbCjGCxbqjYLl+vwYOcs
	NX9LAz3gSHP6GICz3hISG/Ehcr2fuK/6gxkaOCAt7nFoUhh9dE6+BrNtUtytmiEHnKhyDkhJNBmfh
	do6NcRfWxWZgt4N+e8fQVyDf8++rpJFbW/Emsv4BxR6lZfBR6MOCZYBqb4cLB8OA/64SDnrN/s0x4
	WZ7lIpVg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56772 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOymM-00000001KOr-3gr9;
	Thu, 05 Nov 2026 20:19:26 +0530
Date: Thu, 5 Nov 2026 06:49:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH 1/5] watchdog: starfive-wdt: Drop runtime PM reference if
 starting watchdog fails
Message-ID: <0168a321-10ac-4f67-a279-1523a00e0972@roeck-us.net>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-2-linux@roeck-us.net>
 <auyIwPSEVBdme68d@google.com>
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
In-Reply-To: <auyIwPSEVBdme68d@google.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xOymM-00000001KOr-3gr9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:56772
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPDNkMdHnSFNjVV9XrHr8v3cmrFFwaJBgYrtw8stw9flGcGk4dr9Qdz4fh1c0I2rUbg5NzBENohK0hJ0YENKyiBAfmldE5LTPOz21FvwwkeUSW+CelZA
 zGsYZSBlctzSG1gjviw/X/yZXxRnivBKbN1YxQMXu7uerQRHZ9CK/ZLO5Pn8Zo67r1HgquYwaVXieIF+nyk6jm6gbuQVAx81Y66NcGdWr2+9cSzt7Ab0cKqh

On Thu, Nov 05, 2026 at 01:46:40PM +0000, Tzung-Bi Shih wrote:
> On Wed, Nov 04, 2026 at 08:44:41AM -0800, Guenter Roeck wrote:
> > Commit 8f0ca55016a7 ("watchdog: starfive-wdt: Fix runtime PM leak in
> > starfive_wdt_pm_start()") switched starfive_wdt_pm_start() to
> > pm_runtime_resume_and_get() so the runtime PM usage counter is not
> > leaked when resuming the device fails. However, if starfive_wdt_start()
> > subsequently fails (for example, on a timeout in starfive_wdt_int_clr()),
> > starfive_wdt_pm_start() returns the error without releasing the runtime
> > PM reference acquired by pm_runtime_resume_and_get(). Because the
> > watchdog core does not invoke the stop callback when start fails, the
> > usage counter remains permanently elevated.
> > 
> > Drop the runtime PM reference with pm_runtime_put_sync() if
> > starfive_wdt_start() fails.
> > 
> > Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> > Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> > Cc: Ziv Xu <ziv.xu@starfivetech.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> With a nit,
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> > @@ -372,12 +372,17 @@ static void starfive_wdt_stop(struct starfive_wdt *wdt)
> >  static int starfive_wdt_pm_start(struct watchdog_device *wdd)
> >  {
> >  	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> > -	int ret = pm_runtime_resume_and_get(wdd->parent);
> > +	int ret;
> >  
> > +	ret = pm_runtime_resume_and_get(wdd->parent);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	return starfive_wdt_start(wdt);
> > +	ret = starfive_wdt_start(wdt);
> > +	if (ret)
> > +		pm_runtime_put_sync(wdd->parent);
> > +
> > +	return ret;
> 
> Or just `return 0;`.
> 

Good idea. I'll change that.

Thanks,
Guenter
