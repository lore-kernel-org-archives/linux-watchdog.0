Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905537;
	b=a7bXqt0NowpZJSUFoHHT2iP2ClvhN5lUw4/BEBY5WWhXusNhmZQZrIrV6gpVivNZVNLP
	 FesK9855iT62iLJ8wd9zu84ctOPndK7T65nL8TiZdC3QhuDJ9Sco3YVQj0s+vn9HLt3Pi
	 o+8rBVFwwNv7YJwETrRiWIXw7DM2qqYDhjTlx1F2Aoa6xVRzq//tna9P6yuJ16sNyW7cj
	 KB90UMEuRn9mxk5xPfmPKO00XBtxPTk3dzLt+ZReyd8LQDxBl+BsBqBGgApQzpxnGX500
	 qNDdpcoMa2SEAqp/tpmeDk1G7Y8EXKlqT7mVPfdzeNYP5HtN2ZNjnL6aH8uN4hs8r4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905537;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=Pp6gapWgFBS3uvliHNv/4u8TGn77hS8w7wdiMD/8+6A=;
	b=rZMr4sIjKp8Rs+lz7r7BIWicxDDDcZ83a8V6w0vfoH4s8YSVrncjIpsQFjGY/rCVPMCS
	 OYfi/8GSkPNZDSpChoRs3LwkXb82pPjovBExgMWR4+gz1Qr/7HoUDkoXos7YJoI2NcA3J
	 UUNMkcPf5uktz+sDhNkRWBb1+7lfRtWUhRLfRo8myUkLCjsoGe2TUhcP7jXXwRoGSbwhr
	 sKH0Y9WhH27sb8A70v6R9TTdxjRWM6RP6KO3rQ3FwmwBsBOT99U+J2V7typEcrXPvVXg/
	 D2wh5ICDxSjblLTNxAbqVEeGL0HAk/h5NSSSC7Ov3eoZx1RywQ5j4NDF1PjUbCo21tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=XksgcoeV;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC92606A326
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 19:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DC92606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=XksgcoeV
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id Ow8Rxc7TYVK9UP2mGxRWOM; Thu, 05 Nov 2026 19:05:36 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P2mExkvK4gk6fP2mFxBYwU; Thu, 05 Nov 2026 19:05:35 +0000
X-Authority-Analysis: v=2.4 cv=KM9aDEFo c=1 sm=1 tr=0 ts=6aecd380
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_jlGtV7tAAAA:8
 a=3PXyhcpJQwbvkuCwS84A:9 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Pp6gapWgFBS3uvliHNv/4u8TGn77hS8w7wdiMD/8+6A=; b=XksgcoeVwz0q
	EHZXtiGR9ggDMAY1d7kPRPFAvZo/YcW/rK0E2EAuwsQdEh+b+ai8CDuQR1lK3YRT49ZpD4Be162Qg
	/xUKOKOME1q6XDhXYf7XIZcY487Gg1wFLl2o8qfsXU7moTJkyHZjXLfi39iymMNAXMYBOWVXRMPdw
	jWCAoAK/jkJoZJ4Zdto7/v7pUoCTJiaqgL3Xq15O+B7r6SGe8CblCzV91eLB9ku49H+TREiUt8Y2S
	vX+IEAFdmD3BjNnaVcNDcjRqqdm04y+pj6+iHpRUfW+SlZQ+LFu/6uULOwEx9pVlLFpOv+8KtVhka
	4LquhNQM4ZO6YA2VWoK1BQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52490 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP2mE-00000003PKE-27xN;
	Fri, 06 Nov 2026 00:35:34 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v2 3/8] watchdog: starfive-wdt: Avoid unclocked register access in remove and PM paths
Date: Thu,  5 Nov 2026 11:05:24 -0800
Message-ID: <20261105190530.2371854-4-linux@roeck-us.net>
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
X-Exim-ID: 1xP2mE-00000003PKE-27xN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:52490
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 16
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOq33aw+hF3AnF/uHhjUwwIxnmXTrca3/PT8Zdmjk7mq+Ygrp4O4zKfPT43z6F52vfYly6ZK9VH1TNEfhFJdgPOW581AbgYS9+dJaNWWzCNYwZcU4jbr
 3Eg09Up34Dy3brrVQuZVHuYgL44RR3uRi8vm4SAoo329bHrVYqv24D3MidxlXAuq3/amB7jZXjgVRChS9M1vu1Hml0qaF4cTMLauilZr+03RbBm/scQyss3L

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
- In starfive_wdt_pm_stop(), check pm_runtime_enabled() and ignore
  non-zero idle return codes from pm_runtime_put_sync() so watchdog_stop()
  does not falsely treat a stopped watchdog as still running.
- Remove the redundant starfive_wdt_shutdown() callback. Because
  starfive_wdt_probe() already sets watchdog_stop_on_reboot(),
  watchdog_reboot_notifier() stops a running watchdog on reboot, halt, or
  power-off (while respecting the watchdog.stop_on_reboot parameter)
  before device_shutdown() runs; calling starfive_wdt_pm_stop() again in
  .shutdown causes unclocked MMIO when suspended and an unbalanced
  pm_runtime_put_sync() when inactive or already stopped.
- In starfive_wdt_suspend() and starfive_wdt_resume(), only save/stop and
  restore/restart the hardware watchdog when watchdog_hw_running() is set
  (in which case an active runtime PM reference ensures clocks are enabled
  before suspend and re-enabled by pm_runtime_force_resume()).

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Remove the redundant starfive_wdt_shutdown() callback instead
    of guarding it with !pm_runtime_suspended(), avoiding unbalanced
    pm_runtime_put_sync() calls when runtime suspend is forbidden or after
    watchdog_reboot_notifier() already stopped the watchdog, avoiding
    unclocked MMIO during hibernation shutdown, and respecting the
    watchdog.stop_on_reboot module parameter.

 drivers/watchdog/starfive-wdt.c | 38 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 4724fccbfe63..c5f044c9d03c 100644
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
@@ -536,22 +541,17 @@ static void starfive_wdt_remove(struct platform_device *pdev)
 		starfive_wdt_disable_clock(wdt);
 }
 
-static void starfive_wdt_shutdown(struct platform_device *pdev)
-{
-	struct starfive_wdt *wdt = platform_get_drvdata(pdev);
-
-	starfive_wdt_pm_stop(&wdt->wdd);
-}
-
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
@@ -565,13 +565,14 @@ static int starfive_wdt_resume(struct device *dev)
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
@@ -607,7 +608,6 @@ MODULE_DEVICE_TABLE(of, starfive_wdt_match);
 static struct platform_driver starfive_wdt_driver = {
 	.probe = starfive_wdt_probe,
 	.remove = starfive_wdt_remove,
-	.shutdown = starfive_wdt_shutdown,
 	.driver = {
 		.name = "starfive-wdt",
 		.pm = pm_ptr(&starfive_wdt_pm_ops),
-- 
2.45.2

