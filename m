Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810704;
	b=jnky2PVfsmgF+mc1qVJbJ96NdNuH8lz+HSpWzs3D/CoHwIdNnZvTr+AV/ZRnEg2wLVBd
	 q7pczOlR+lHlYRqwZAzah19tEWSm+eF88VWk9jVcyoK2seUWVHydTOHSjN4IbdeQImrY/
	 z5mZxg1+GBh6Kd9hGULdQZGlPYQG65DJnsiPNcJo7Un4W1/4KXf/nKDQqcPouUHkJDNq/
	 QrEFhrMnNL91/tr5OxP/hORmR/hpv2g5wL2+8SR+qVYG2jhXlTBkC3Wd5xF2oiny1uZ9i
	 +yH0WyTYrE2rYh+7f4NzPygzvo+ADc7g4RdvatFNM0yHtKBcphaEB18mquIB88/b+YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810704;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=+i1Yey3smt8TUdrh/ON06MrYbR+AF9wHtLHNG+MPoI4=;
	b=cK1nQP2fhvGSUuXkHw1k1RCfa7FGBEZWbIsadUXJLid8UTYFDuVfjC+or7kpFQcnMNQK
	 QHgxhvQDiJFS6ndi+KboBTDioHqrLrqGMDotQ95Q+LqtJqcmQniJ/40rx9HEfSi5uIaPn
	 AqKrSFirR3q8R+S1xPYwuOF9a5Jz+VnS1mKwEyptkqYW2lMxDYT9KcEea31rRwRML4YxR
	 3lRTU5wCLFpP89NqKlJGOWvFfKkXljZRmcUaYGTN0RcGdK28qypq/9n4TwVj6f2KU7QCh
	 lXYZOLsl84zv/U5kjAQZaPLKAvxN4Sa/8QpUzW5DU5Ez5m9TepcPtwJUfggu0295fTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=snjskALz;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44201606A328
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 16:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44201606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=snjskALz
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id OdvbxWX3f4vCDOe6hxWUAN; Wed, 04 Nov 2026 16:45:03 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Oe6gxSPDdNBINOe6gxuuHL; Wed, 04 Nov 2026 16:45:02 +0000
X-Authority-Analysis: v=2.4 cv=fvzcZE4f c=1 sm=1 tr=0 ts=6aeb610f
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_jlGtV7tAAAA:8
 a=DaO7CXVDyyh4gy_mf_4A:9 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=+i1Yey3smt8TUdrh/ON06MrYbR+AF9wHtLHNG+MPoI4=; b=snjskALzbaWv
	7SsqzPawWU7fbMax6Me+Fq1Pc9dYLStXkhsR4bblVeSgcg9wItKZ2ZDmHdK1Zl1fZtCJVhKZOAslX
	gQ5/wa0DFIR8qWcB3Gn+kjJ0V+0iUxJU7GE+z9ZLYEfpIk8si4b8INNhizOD+5GdPSlT0WSUT2kBT
	LhMe7DP/IZbWOmfPpC/4x4TR2rhh69+gLuJU06LzTAcv3bGMkMTWEST6wrJLMJqA9rMcLvXO2+bLx
	YqJBb4kVS4bJVXQmSOlBxDvv5APQZh5G551Q/rVFLuOnQUUPCI/SjTx2H0Jeyfl9FUuAMYsUQD/nx
	0DyHa7EiBEhGGGDsG/W+aA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47518 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOe6f-00000002cHU-41Dv;
	Wed, 04 Nov 2026 22:15:02 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH 5/5] watchdog: starfive-wdt: Drop runtime PM reference before registering watchdog
Date: Wed,  4 Nov 2026 08:44:45 -0800
Message-ID: <20261104164445.3209560-6-linux@roeck-us.net>
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
X-Exim-ID: 1xOe6f-00000002cHU-41Dv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:47518
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 44
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNaMZVgZUjgsODWR1NW4KRxRWq0gV0aWtyo/uuaWhh9YdpX+7/uHMcoXD5gjypb4T7ZfeM6HrdtrDG++oanGtZFNUgBztYuA7MABePlBLTIbfkeyZCN+
 Fh6r701YIK8tW9KVuSWaFPP5a5oDoAYerseawqF1AhVPPgvZW4kZsUFrWK5eCnvB0+anbzpod/nlhYXHy6gMHrU/HO0Qrcrv8lIqL6itlW6u3qqji1iK3B4J

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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/starfive-wdt.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 817f84cc2807..d3eb29c45e6a 100644
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

