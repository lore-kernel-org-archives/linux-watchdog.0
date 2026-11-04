Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810692;
	b=36oqP3ingoeS3FVjz+lU+051HJo4uts5T6yvvb0nbpLHASYPUST3spF6iGLX4F4Tv3wV
	 yLGgNflfLLJeiYGntXHJbTPYFC/oKMrLuiQdrcuUo6ZgnleyEOMWbAsywNgv80C0G3aye
	 O5YmJ8Uqyzyga02j9opNWLDjMDlMxBqemda58KbdNeLPoyQHYUEodygSDYTVSY8Ob6i8M
	 qw6ij0//tY0fcHFsRNL7k1QAE0XJe/ZVnHkyQzydtgWu8CnB0536aTCgbbgStFkZWeFJt
	 yuejblM8t80u53pXywqRY4wpxfn5xXvk+SIeyGap6z7j6DslyzRdjtSSupU1woPWl9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810692;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=/MIAENARYjiu2YZytHVH8gdaagTqD28o4CT4qMRsE7o=;
	b=Zaqw74Twurq6EieWI+VouCGQK4RNszWvN+nf3LUbVSGC8GK5wJb+jxo5SQwROEy3kNAC
	 NaQ7HmcEOwx6H3wXtrC752Pgk3TqbGp9EF+Cj2eiX1DRgLfsxPdMJ4gJFMg14yB3LguHa
	 /nlnwpcQgzUJaWd5RwEVw6Hi2Fu/SBdA0FaIVtJdL0t8cwTez6idDfzyl6WGFAgP+lIZS
	 c6W/a0/m6MVlPJHGINAPLFZXAqzp43lmy8UH0IEBFmkQ3BxQMH3AffWDet98H3F7St5V+
	 y9029mzSPrqgIRFp1cGfB2L4IZwbzKRRPQ4Uli3mNd3yxuQC+kb7IlXnHbjzfJGENZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=IdOS1sYp;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA475606A31B
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 16:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA475606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=IdOS1sYp
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id Oab0xXTtyVK9UOe6VxFw3Q; Wed, 04 Nov 2026 16:44:51 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Oe6UxSOoFNBINOe6Vxutvm; Wed, 04 Nov 2026 16:44:51 +0000
X-Authority-Analysis: v=2.4 cv=fvzcZE4f c=1 sm=1 tr=0 ts=6aeb6103
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_jlGtV7tAAAA:8
 a=vkQkGw-c68Zx8GrWE4cA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=/MIAENARYjiu2YZytHVH8gdaagTqD28o4CT4qMRsE7o=; b=IdOS1sYp67l+
	Nt0j/fKNO9mNWch9ghJ2BxiwJbAZAZoTDe0p1matwYaVRZoJZ9RhjgAxJes2AKHC/EGVg6f0EQRmo
	/W1hd8MLE+999ZKYD5BWlZo1BGiNrzMFvBetZe+9qcp3udguFNjVO6Msk5y30PexISi8KDNOYWIey
	5j8deFrdAKR++rNQZaFYeF8ba7GC9dPTID6BUcN0TwUOJHNuPFefLJTVurVy0zlORvuogqrnwTdIe
	EKxbuLV4K0HPAAD2fl9hj/vNgTpdim5YaXplzn/IaEQMjptXz6MTVG1slOXG5nwgi01agyVMvFCkO
	OXpI96pnOeibTybCTzJOlg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41182 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOe6U-00000002c3w-1X5s;
	Wed, 04 Nov 2026 22:14:50 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH 3/5] watchdog: starfive-wdt: Avoid unclocked register access in remove and PM paths
Date: Wed,  4 Nov 2026 08:44:43 -0800
Message-ID: <20261104164445.3209560-4-linux@roeck-us.net>
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
X-Exim-ID: 1xOe6U-00000002c3w-1X5s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:41182
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 38
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE7KC7f/UQNjyWMSugTIKJ5UUxDcBpW8g0Kt6kS0VrGL+yrfyrsyyPg/WQJ3B78E7r+psrMovMtXaW9qN1Q3GHVUxeMpZkZBFp3K9LhZt1eW92Zqv+kG
 1GH2osYcMkQx+zEIJpufDgMenGexUnLhsMoi81bX4uDiswXN9FZ0yZiedPyxGoIEzfIO0tER49jc4041U3LX4HvlwRmqv+9sDa5rlLDXzRFNcxJQAfiDWeg3

When runtime PM is enabled and the watchdog is inactive, the device enters
runtime suspend and starfive_wdt_runtime_suspend() disables core_clk and
apb_clk.

However, starfive_wdt_remove(), starfive_wdt_shutdown(),
starfive_wdt_suspend(), and starfive_wdt_resume() unconditionally read and
write watchdog MMIO registers without checking whether the watchdog is
running or clocks are enabled, causing a bus fault when the device is
runtime-suspended:

- In starfive_wdt_remove(), starfive_wdt_stop() is called before
  watchdog_unregister_device() while clocks may be gated off. Unregister
  the watchdog device first (which stops an active watchdog via
  watchdog_stop_on_unregister while its runtime PM reference keeps clocks
  enabled), and only call starfive_wdt_stop() if watchdog_hw_running() is
  still set.
- In starfive_wdt_pm_stop(), ignore non-zero idle return codes from
  pm_runtime_put_sync() so watchdog_stop() does not falsely treat a
  stopped watchdog as still running.
- In starfive_wdt_shutdown(), skip starfive_wdt_pm_stop() if the device is
  already runtime-suspended.
- In starfive_wdt_suspend() and starfive_wdt_resume(), only save/stop and
  restore/restart the hardware watchdog when watchdog_hw_running() is set
  (in which case an active runtime PM reference ensures clocks are enabled
  before suspend and re-enabled by pm_runtime_force_resume()).

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/starfive-wdt.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 4724fccbfe63..18301f5d1144 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -390,7 +390,10 @@ static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
 	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
 
 	starfive_wdt_stop(wdt);
-	return pm_runtime_put_sync(wdd->parent);
+	if (pm_runtime_enabled(wdd->parent))
+		pm_runtime_put_sync(wdd->parent);
+
+	return 0;
 }
 
 static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
@@ -526,9 +529,11 @@ static void starfive_wdt_remove(struct platform_device *pdev)
 {
 	struct starfive_wdt *wdt = platform_get_drvdata(pdev);
 
-	starfive_wdt_stop(wdt);
 	watchdog_unregister_device(&wdt->wdd);
 
+	if (watchdog_hw_running(&wdt->wdd))
+		starfive_wdt_stop(wdt);
+
 	if (pm_runtime_enabled(&pdev->dev))
 		pm_runtime_disable(&pdev->dev);
 	else
@@ -540,18 +545,21 @@ static void starfive_wdt_shutdown(struct platform_device *pdev)
 {
 	struct starfive_wdt *wdt = platform_get_drvdata(pdev);
 
-	starfive_wdt_pm_stop(&wdt->wdd);
+	if (!pm_runtime_suspended(&pdev->dev))
+		starfive_wdt_pm_stop(&wdt->wdd);
 }
 
 static int starfive_wdt_suspend(struct device *dev)
 {
 	struct starfive_wdt *wdt = dev_get_drvdata(dev);
 
-	/* Save watchdog state, and turn it off. */
-	wdt->reload = starfive_wdt_get_count(wdt);
+	if (watchdog_hw_running(&wdt->wdd)) {
+		/* Save watchdog state, and turn it off. */
+		wdt->reload = starfive_wdt_get_count(wdt);
 
-	/* Note that WTCNT doesn't need to be saved. */
-	starfive_wdt_stop(wdt);
+		/* Note that WTCNT doesn't need to be saved. */
+		starfive_wdt_stop(wdt);
+	}
 
 	return pm_runtime_force_suspend(dev);
 }
@@ -565,13 +573,14 @@ static int starfive_wdt_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	starfive_wdt_unlock(wdt);
-	/* Restore watchdog state. */
-	starfive_wdt_set_reload_count(wdt, wdt->reload);
-	starfive_wdt_lock(wdt);
+	if (watchdog_hw_running(&wdt->wdd)) {
+		starfive_wdt_unlock(wdt);
+		/* Restore watchdog state. */
+		starfive_wdt_set_reload_count(wdt, wdt->reload);
+		starfive_wdt_lock(wdt);
 
-	if (watchdog_active(&wdt->wdd))
 		return starfive_wdt_start(wdt);
+	}
 
 	return 0;
 }
-- 
2.45.2

