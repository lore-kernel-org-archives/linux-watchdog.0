Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051882BE03C
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608780; cv=none; b=c5lC6ZJgqTE+j9+zbh8++TE5OqMfhxDyDI5hcskL6EZqxXycHlSvbCtoZr3CNKONfOSDNc+sRpphlS/wC496j5S/gtmrWVoGaFEoZ+xRnw/iHOjVZh7Jukly+68XCW3u5l6lq5IV9vYrlHhU6Vbx7QaZRHTtky967bgJ1Bnltv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608780; c=relaxed/simple;
	bh=ftiUfxQVNR1SjBvKCGg4ct3ufcSYLlYjKZkQtXz9PQo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mTuGeMfwekGdGpXEh75C675tGTRGa+U00bSlbDruWx54qUCKAK9voKcw9ItUx0aVc+18juJuCdBBNPuPrIgP+T+l/+EUOaHUra1n7wWDK2I8Bxy+bUVVL7TPUj+ABHTVGUQ31oiTFtRJsrmqilLhFr/NbVC+Rab7X7duSvk3lxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ade37e9ab23711f19a56ed5b684f684d-20260917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ca86f634-809c-40f2-ac83-e99cbfdcbda9,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:62849897387738c61e17f4a9dcc2217e,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:
	2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ade37e9ab23711f19a56ed5b684f684d-20260917
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 753047897; Thu, 17 Sep 2026 09:32:43 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	support.opensource@diasemi.com,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: da9063: fix suspend/resume handling of HW_RUNNING watchdog
Date: Thu, 17 Sep 2026 09:32:12 +0800
Message-Id: <20260917013212.2591505-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

da9063_wdt_suspend() and da9063_wdt_resume() only check watchdog_active(),
when the watchdog is left running by the driver sets
WDOG_HW_RUNNING in da9063_wdt_probe() but userspace never opens the
device, so WDOG_ACTIVE remains cleared, the wdt_disable() will not be
executed in da9063_wdt_suspend. In this case, the suspend callback is
a no-op and the watchdog keeps counting during system suspend,
leading to an unexpected system reset.
Check WDOG_HW_RUNNING and wdt->wdd，can fix this issue.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/watchdog/da9063_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 92e1b78ff481..3703110e82fc 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -271,7 +271,7 @@ static int da9063_wdt_suspend(struct device *dev)
 	if (!da9063->use_sw_pm)
 		return 0;
 
-	if (watchdog_active(wdd))
+	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
 		return da9063_wdt_stop(wdd);
 
 	return 0;
@@ -285,7 +285,7 @@ static int da9063_wdt_resume(struct device *dev)
 	if (!da9063->use_sw_pm)
 		return 0;
 
-	if (watchdog_active(wdd))
+	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
 		return da9063_wdt_start(wdd);
 
 	return 0;
-- 
2.25.1

