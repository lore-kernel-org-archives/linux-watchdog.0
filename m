Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905542;
	b=H6ZJhBDIZzgVKbuByw86w2kQ9dmbfsVU2f0cdnDr7YkrjZuIXcTFdfRZsB6ROFGv8ExM
	 3MEufzQvq3oUD7wvRGSRbSi2gd9J1p5lJFOiZ45eAQ2YHJMxzaRotLUOp60rbM+pU+gw9
	 nC6abCOWgQ0OLoQM7mj67lUbsIsbPda82T3F6bOjMRke048ynhR6xRzkNVTi9YIni0eNC
	 l1ViFOKKh1cMj9iOC4oY2XSr3NYYqqTZ7y7XIbdv6DSA/EKYHqCP6FfSqgVv8Vei42tSC
	 WM22aM1UNn86WM0ceKMtxXbAgOX2P9XxC+8xSZQA/n/PGCRQuz4v7NnR7a6x73r8ERg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905542;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=yC/X45mxOSd5NMIcOD6plKPnzuKaFBwMNQGlbS4zpO8=;
	b=RG2PhA+2RbnEq6j64Jdfhvy243ZpmarJrTvzEkewtC8KDLAtgl4Yz47d0ZYj3Nvlmi+5
	 6PcUbt47UmcYE8um/kVmFoMU0my+xyqRzXIOp1WcwivZWbXSJD7FVJQGCiy21ptSwWHSg
	 dRxK/BEwotE6m/G+yTcpxCxeo/BD7zXaaSfzj3fAi+04xuY5o9fRIVhnELQTARORquuxz
	 PEJehGMVW2IRr2LDOtl1FhVxCvzwy+NrsQymBjhpVsRK+pGv1DLKClQTwop3PbQSgLdD2
	 w0MkLU183wZI0GCeZHuEt7sp0F7mlRjelnTGXsXufYEBMdoew0vAr6FK9CyHT8bd1Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=JHSxpp01;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE2606A328
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 19:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45FE2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=JHSxpp01
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id P1lrxy2D3yb4YP2mGxLVrS; Thu, 05 Nov 2026 19:05:36 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P2mFx1RTuPdvCP2mFxXOrk; Thu, 05 Nov 2026 19:05:35 +0000
X-Authority-Analysis: v=2.4 cv=ZYIdNtVA c=1 sm=1 tr=0 ts=6aecd37f
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=Fy7aeiTQQSgHsYxaS7kA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22
 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=yC/X45mxOSd5NMIcOD6plKPnzuKaFBwMNQGlbS4zpO8=; b=JHSxpp01VZjl
	Q/FKMExnwtCKZrlrVX55lwONHq0vOOpdtxEvCrV8Sshry/uPwBC5+bwZ//pb0JUrOV3BIsnhj7QG/
	+4OE5yMcZw6SfJ3eP4INNX5a7t4OYFJgCwS0YTcewmOIdXpKsHbmQ1AXSKDCempVSBNTQkJTbmczp
	dt5EPToFY0MCIS0age97rZx/+0gJLVf4WWlGIXuGgwk3GtPn3galF5w4R39JkHuWbih5KvSnZb0xX
	zdmcZjtFfyY4DogoOAP80pC3lCv0wdPqbsPlf3NMdZTQ0jVs1UnC5Pnx+erJ4nG6y16rwImSeo7CR
	/lFssP58dmxMmYGNSHyLwg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52492 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP2mF-00000003PM4-11Ms;
	Fri, 06 Nov 2026 00:35:35 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v2 4/8] watchdog: starfive-wdt: Fix runtime PM usage count leaks in probe and remove
Date: Thu,  5 Nov 2026 11:05:25 -0800
Message-ID: <20261105190530.2371854-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261105190530.2371854-1-linux@roeck-us.net>
References: <20261105190530.2371854-1-linux@roeck-us.net>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xP2mF-00000003PM4-11Ms
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:52492
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 20
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAYor5AovI85bMYWZictdVbXdq9qbfRSL1QB8SNDfQ1Fl5aLSxjtKXOpCiutXrDwR1jMuZoT0NUYjjMHdbpB9njarW8x1Zt/bcZiFwOcCXTihnyrr5Ob
 s6EF2nXN0ZViLWtqbkdlCUCh/f/yGjws50d8bDhTQQEr0bm/NaABFmJ7Z2X59x+lPzg1KMtfU6wSnQeqOAxNkLJmpW3h9zS/kWQqc4KoqLJl3IGLqG3TKNW6

When runtime PM is enabled, starfive_wdt_probe() acquires a runtime PM
reference via pm_runtime_resume_and_get(). On subsequent probe failures,
err_exit manually disables clocks via starfive_wdt_disable_clock() and
calls pm_runtime_disable(), without dropping the acquired runtime PM
reference (and leaving the hardware timer running if early_enable was
enabled and watchdog_register_device() failed).

Similarly, when early_enable is set (or the watchdog was left running
on close), the active runtime PM reference is retained after probe, but
starfive_wdt_remove() never releases it before calling
pm_runtime_disable().

Release the runtime PM reference with pm_runtime_put_sync() on probe
error paths (stopping the watchdog first if running) and in
starfive_wdt_remove() when watchdog_hw_running() is still set.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add Reviewed-by: tag

 drivers/watchdog/starfive-wdt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index c5f044c9d03c..859232fa55a3 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -517,8 +517,14 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 
 err_unregister_wdt:
 	watchdog_unregister_device(&wdt->wdd);
+	goto err_disable_pm;
 err_exit:
-	starfive_wdt_disable_clock(wdt);
+	if (watchdog_hw_running(&wdt->wdd))
+		starfive_wdt_stop(wdt);
+	if (pm_runtime_enabled(&pdev->dev))
+		pm_runtime_put_sync(&pdev->dev);
+	else
+		starfive_wdt_disable_clock(wdt);
 err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
 
@@ -531,8 +537,11 @@ static void starfive_wdt_remove(struct platform_device *pdev)
 
 	watchdog_unregister_device(&wdt->wdd);
 
-	if (watchdog_hw_running(&wdt->wdd))
+	if (watchdog_hw_running(&wdt->wdd)) {
 		starfive_wdt_stop(wdt);
+		if (pm_runtime_enabled(&pdev->dev))
+			pm_runtime_put_sync(&pdev->dev);
+	}
 
 	if (pm_runtime_enabled(&pdev->dev))
 		pm_runtime_disable(&pdev->dev);
-- 
2.45.2

