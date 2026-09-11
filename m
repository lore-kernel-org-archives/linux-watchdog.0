Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD6286425
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095958; cv=none; b=jeul79iKOnfOzJLyfxnxPHahCZrOtoCNrKYLQaW1aLZ+gZCvfUYWtPuUohFXJDAJpd50foge8kcmUJ5aLmLkm8bK9TV430swevHYh8t9SGylIeKVLHtdtNvWHnDKC2bJOXr14bopGrafK4CxBSsvkWBJRJGflrJPbsa8nwR5oPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095958; c=relaxed/simple;
	bh=k7QI4j+TKOJu8ZyxI8aH/yAzqXNN1lNcgndEphlQpRw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iRg2L60oVoXISJU8BiLyabLHFiMVZ/poZkJXTeKcEfSDTCJWY5PeWmtVxlsG3Ge2vZ0/N5lP2yce/a3eqra2t7GApnJLr0DSOD20nH4xrdGytvE5s+c0mRmZt/7HnTnRifRpZXRKlKstCt4bY0yHXj/hpXCH+rEEqEBKuspU81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ae8e01b6ad8d11f19a56ed5b684f684d-20260911
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0914911d-7e62-42a3-bc51-239aebe95f72,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:a8a5c4a8dbfa5d2f681b3f9344efac2a,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:2,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ae8e01b6ad8d11f19a56ed5b684f684d-20260911
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 931265426; Fri, 11 Sep 2026 11:05:45 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: sp805_wdt: fix suspend/resume handling of HW_RUNNING watchdog
Date: Fri, 11 Sep 2026 11:05:31 +0800
Message-Id: <20260911030531.837140-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sp805_wdt_suspend() and sp805_wdt_resume() only check watchdog_active(),
when the watchdog is left running by the driver sets
WDOG_HW_RUNNING in sp805_wdt_probe() but userspace never opens the
device, so WDOG_ACTIVE remains cleared, the wdt_disable() will not be
executed in sp805_wdt_suspend. In this case, the suspend callback is
a no-op and the watchdog keeps counting during system suspend,
leading to an unexpected system reset.
Check WDOG_HW_RUNNING and wdt->wdd，can fix this issue.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/watchdog/sp805_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index c2125f204a13..2ddb754f3b4a 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -325,7 +325,8 @@ static int __maybe_unused sp805_wdt_suspend(struct device *dev)
 {
 	struct sp805_wdt *wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&wdt->wdd))
+	if (watchdog_active(&wdt->wdd) ||
+	    watchdog_hw_running(&wdt->wdd))
 		return wdt_disable(&wdt->wdd);
 
 	return 0;
@@ -335,7 +336,8 @@ static int __maybe_unused sp805_wdt_resume(struct device *dev)
 {
 	struct sp805_wdt *wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&wdt->wdd))
+	if (watchdog_active(&wdt->wdd) ||
+	    watchdog_hw_running(&wdt->wdd))
 		return wdt_enable(&wdt->wdd);
 
 	return 0;
-- 
2.25.1

