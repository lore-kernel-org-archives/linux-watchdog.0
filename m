Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810696;
	b=EqQvGc+sluEbjblX4+EsGobgYC37624RwAsas/MTnMSsxoZmcXaU3F5yMOcB9E1F0w9L
	 HM+G69NxH2k03Bb1AjXJ2Ii/Uoo4WJf1Alt9wwZCTqJxlltoGhZANEhBMBwt4AR8dlGmV
	 65FjoKhencPoe+5Ju+cKdEA0RycRuJwxdajhAmGJ3PdIKgEW6rRZfyeh5cJ7Sg0W3K7l/
	 eYr+kv7g/pi5HbD+x503gFPpuTdcnxX5EN6n1zn/wNv0IIbJYVumMafL/8D8qOEAGzfiY
	 iH/RaA+pLw5b56r3W55NGU88g5kNaOhELZXKAu/LgCCKwLJleKNbSo2bz/Adar+r9QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810696;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=jDYYNXrtKDGM8bqOzOBaEIFoNggK+jfZofVYQWBAQ3Y=;
	b=qfA59h8ojyD9yfMJyocPY5QvE7VWH1kexO2NDyLJXUrY/3VuqUY3b5Lnm9fioNyXrjJP
	 FZMGbYiBM0z4QPL0J+AsqOOCdLWE/3GPhgj7PNSCqWPLLwx1vu7caKdds3ST683auxIV/
	 rHMAQH34/BCKAs+HRQuSIfSqF3BKT1mQFMiFVlTW6Dx/fMZC05Z/syDs/Ca9A2hQwgjne
	 wmhcJz2LF7yidurh2Wg+LFt0fC3sS9lIFTJm76wP7JNZ/8qGgGIa2bvNsiqVjY6OlXwn0
	 evu3u0xDYYY+pKtSS/94aKJ0QtHb1wa3IshDaxicoFPplvBs/97AM360xu5s7zrNC/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=fLCE4mIY;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB1606A31B
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 16:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87EB1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=fLCE4mIY
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id OIFix0qDSAR1iOe6UxuHQ5; Wed, 04 Nov 2026 16:44:50 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Oe6TxSOmSNBINOe6UxutuJ; Wed, 04 Nov 2026 16:44:50 +0000
X-Authority-Analysis: v=2.4 cv=fvzcZE4f c=1 sm=1 tr=0 ts=6aeb6102
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_jlGtV7tAAAA:8
 a=CJDYlvsNdJ4W8PfXJ5AA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=jDYYNXrtKDGM8bqOzOBaEIFoNggK+jfZofVYQWBAQ3Y=; b=fLCE4mIYAjhn
	XbMmEEU0ETqqpPzsdF5rxnGpfNuMnR8TBi7vR0freXsr4tlM36iCc1ooHing90lq5Cx3Jbck1kVVr
	LnExJTmq+/JumE/syywI1PUCEhtotI/8AhtohZVEBmXGDX1XAo+M5R6RWrn/M+i9cnT5FbHgH/Fwj
	LiFRediqf5+PxwuqaHhq7cfwxekexRcRt0MnP+i3ijudpbUf3raMA0YgxW/4OFhkSDwFsuMCI5BJY
	q4Vh6CWe0bjm/Es9kFRzzDF7gHvEQJFzqj247lcGRjljR1AFPXPV3reRD3UYLkM5/u3bcZNNnorsQ
	/E/nOtkjDvjGGdIDNEWlww==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41170 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOe6T-00000002c22-2IrR;
	Wed, 04 Nov 2026 22:14:49 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH 2/5] watchdog: starfive-wdt: Balance pm_runtime_enable() on probe error paths
Date: Wed,  4 Nov 2026 08:44:42 -0800
Message-ID: <20261104164445.3209560-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261104164445.3209560-1-linux@roeck-us.net>
References: <20261104164445.3209560-1-linux@roeck-us.net>
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
X-Exim-ID: 1xOe6T-00000002c22-2IrR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:41170
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 35
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI/6+Q1x4NMqV/F+KnUAfgyYej5bpwboHUyQKGtSsCeN58M1V0xdZEcutCcB+mJgAHI1g3kP++Fh2bUdHsxQIuWXUari44TG6DoyD7j/goCrjjZSI82F
 pC8Jl2B+K9smUi5X/WTzemkmnU3WLPMwyKgUdIOPsGrmM+YjtW/sF5YPgHnhEOOpeGS9sAw943j1wU9qB3se5Elg7/zj7V3sAs5k18R4topQ8S4NRVDGeOIh

In starfive_wdt_probe(), pm_runtime_enable() is called before attempting
to resume the device via pm_runtime_resume_and_get() or enable its clocks
via starfive_wdt_enable_clock(). If either call fails, probe returns
directly without calling pm_runtime_disable(), leaving the runtime PM
disable_depth counter unbalanced (and triggering "Unbalanced
pm_runtime_enable!" warnings on deferred probe retries).

Add an err_disable_pm error label and jump to it so pm_runtime_disable()
is called on these error paths.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/starfive-wdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index ab6920b8d7d8..4724fccbfe63 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -454,12 +454,12 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	if (pm_runtime_enabled(&pdev->dev)) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
-			return ret;
+			goto err_disable_pm;
 	} else {
 		/* runtime PM is disabled but clocks need to be enabled */
 		ret = starfive_wdt_enable_clock(wdt);
 		if (ret)
-			return ret;
+			goto err_disable_pm;
 	}
 
 	ret = starfive_wdt_reset_init(&pdev->dev);
@@ -516,6 +516,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	watchdog_unregister_device(&wdt->wdd);
 err_exit:
 	starfive_wdt_disable_clock(wdt);
+err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
 
 	return ret;
-- 
2.45.2

