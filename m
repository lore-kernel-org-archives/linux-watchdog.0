Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905548;
	b=LMaz4iRsKrkUxhoOQlPgRdesRyM+IAFQs5S8hzs03NyiYgcMLdwUOrpvKZXNx0rEs9uE
	 wRnCAUHp7ZKeS2FRL9W3nSIqhFSqhg1vobaX/uixl81Q01ZyLM+MogA+G0p51KlLWQjcj
	 VwGbwnJHRLmykeigNt9lnkr29VaMgcvS9z2dL0iVQV4jxLHNzrhuoYj2DgsQTFBI9AZk0
	 ddecNkypWV41hzNj6yhdBXVwnjM/06rddduVgLgMtqQPf9JmUEUHZU+eXGEWJjzAsI4/P
	 MhgCrJ8UuIjYqGzj10GB33RrN8jvut5e/NTBYJ8nEcHaWKhNUqfgJEqy17JBet8gZYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905548;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=sJEFDKRaSiur8ynaKiZkJGi/Rd0axqKf8B7Z4C6Tq3o=;
	b=TbTpw3drjjtLyRSV1sQVQcFVSKduLuYaQ9vuQ7Bn9hU/s0TRjwJspeJOJBUj4KMs76SG
	 Fuk+PUXpKuSN5d/It6fRgcjUPupSJxcfJnOzuWU4V18IXdWqEgIO51YOaw5jpvKctsPW5
	 nyVa6YrXVqnW+uiO3Iw6MElhBCZdwOQfs6uURZTCnOLL94Gfs23N7CZX26AUFKdyyuuVA
	 p00Gv+O+FIOXmnlEJiyyOx0CkHC0fksHwL68dRyqYtPq+Z+uLYZUcaVvxTRTAt858t7Jz
	 rIziASa/GUY6oh37QLXR+PX8LFlgN9J1EHhTEsqS/pZ3u4RZdkqbMb9hMALGuoV2H1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=V48kf2qx;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB4606A326
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 19:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38AB4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=V48kf2qx
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id Oywfxp0yGOOJnP2mQxd2q3; Thu, 05 Nov 2026 19:05:47 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P2mQxhLmfBdeUP2mQxoL4O; Thu, 05 Nov 2026 19:05:46 +0000
X-Authority-Analysis: v=2.4 cv=AaexH2XG c=1 sm=1 tr=0 ts=6aecd38a
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=DaO7CXVDyyh4gy_mf_4A:9 a=KQ6X2bKhxX7Fj2iT9C4S:22
 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=sJEFDKRaSiur8ynaKiZkJGi/Rd0axqKf8B7Z4C6Tq3o=; b=V48kf2qxO8w1
	tC+SK19h0OT2j3bFIL8YVHhm7mf6wCOH8EqsQhuJyVLZagyRRvsITAgr3GUFQpBbU42vJjl52CnY3
	10jRuM/fAPbrj/NAJwxeIVprNDjCwXX74z5VbZ3YmEeQo9e/aLUZMxG9lz1kdSZ5tTVc17qUoBq1X
	mmNICYUSWFVkQrAR+x9QUaaJDwmf5Co4vE81TUqOYOwFd6ss0G1DXtx5gC/j6paMcg7LrH7XwAbi9
	ZNcB5syyAdM79oSnRTnmmRFmUtMwkQTRej8fN6c1YfIJ1DwqBFd9ywVkUcboQf+Tsrlr+BTPvVJzS
	1FHAd4DGdEUPZHzyp/ja2A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40714 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP2mP-00000003PTo-3w6A;
	Fri, 06 Nov 2026 00:35:46 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v2 5/8] watchdog: starfive-wdt: Drop runtime PM reference before registering watchdog
Date: Thu,  5 Nov 2026 11:05:26 -0800
Message-ID: <20261105190530.2371854-6-linux@roeck-us.net>
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
X-Exim-ID: 1xP2mP-00000003PTo-3w6A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:40714
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 24
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDOkcY2a6c5W8p2p/iGjBBEHgAXfbb3Ajm+frC+Ui1GMkPPNQmiNbjTKC9VBcV2nsnlPrMGeVJh4xFq2Xq4GDjOIEApXRXcBocznT4kjx8brepr1r8HQ
 9zaf+TOFX8NnT8E50e/meOfoFxY6yddvR9nvryk/ccSosEScJJMAYwyLx/76LDZgyAudJrt4kBTc/Tk98mjXofsCbmUM7yoeS7rUysOvI/zlAFXn3AWaov3s

In starfive_wdt_probe(), watchdog_register_device() is called before the
probe-time runtime PM reference is released via pm_runtime_put_sync(), and
any non-zero return value from pm_runtime_put_sync() is treated as a fatal
probe error.

If userspace (such as udev or a watchdog daemon) opens /dev/watchdog
immediately after watchdog_register_device() exposes the character device,
starfive_wdt_pm_start() increments the runtime PM usage count. The
subsequent pm_runtime_put_sync() in probe then decrements the usage count
to 1 and returns -EAGAIN (it may also return 1, -EBUSY, or -EPERM in
non-error idle conditions), causing starfive_wdt_probe() to unregister the
working watchdog device and fail probe.

When early_enable is not set, no hardware registers are accessed after
starfive_wdt_stop(). Release the probe-time runtime PM reference right
after starfive_wdt_stop() and before watchdog_register_device(), without
treating pm_runtime_put_sync() idle return codes as probe errors.

Fixes: 8bc22a2f1bf0 ("watchdog: starfive: Check pm_runtime_enabled() before decrementing usage counter")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add Reviewed-by: tag

 drivers/watchdog/starfive-wdt.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 859232fa55a3..4142e1502038 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -499,28 +499,25 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	} else {
 		starfive_wdt_stop(wdt);
+		if (pm_runtime_enabled(&pdev->dev))
+			pm_runtime_put_sync(&pdev->dev);
 	}
 
 	ret = watchdog_register_device(&wdt->wdd);
-	if (ret)
-		goto err_exit;
-
-	if (!early_enable) {
-		if (pm_runtime_enabled(&pdev->dev)) {
-			ret = pm_runtime_put_sync(&pdev->dev);
-			if (ret)
-				goto err_unregister_wdt;
+	if (ret) {
+		if (watchdog_hw_running(&wdt->wdd)) {
+			starfive_wdt_stop(wdt);
+			if (pm_runtime_enabled(&pdev->dev))
+				pm_runtime_put_sync(&pdev->dev);
 		}
+		if (!pm_runtime_enabled(&pdev->dev))
+			starfive_wdt_disable_clock(wdt);
+		goto err_disable_pm;
 	}
 
 	return 0;
 
-err_unregister_wdt:
-	watchdog_unregister_device(&wdt->wdd);
-	goto err_disable_pm;
 err_exit:
-	if (watchdog_hw_running(&wdt->wdd))
-		starfive_wdt_stop(wdt);
 	if (pm_runtime_enabled(&pdev->dev))
 		pm_runtime_put_sync(&pdev->dev);
 	else
-- 
2.45.2

