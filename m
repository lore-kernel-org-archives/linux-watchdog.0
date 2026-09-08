Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D2345CDA
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864586; cv=none; b=UN5SCEm7kZUSkCc/G/Q8j6x67XmwuQE3bvNDRtiWfCbczCHhHsIgnJ4Zo12l38uSMX2qLl8XpfHDhHHmS6eayfXiWZF2QsG0xPXVofkcOCSybLvN+zr7coPzTA8ciO494NOGHhGhHYf3Bv4XSDW6vZMXMZCkYdQ1YqQSXCTsj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864586; c=relaxed/simple;
	bh=95MFNV55uVXLS0pz+2yyZ+xEYQiH14O78IXTeSQxJGQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=C8q884oGMOvlfjBKPFy0WXtZNiCYyJFs/osJuJ5BCl8vXZ/wo4FhLvmaMl5e1cGxf2/hmKgq8jRTc1MLiozKQV7gkOlbpGsFhmkhc/OUvM8OuloO04jAUTAmANY1PYW2eqTXDr6PGKTj/3ZKxmvubseCyChcJiz2nFOOFKcNHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f9dc4802ab7211f19a56ed5b684f684d-20260908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ba48e428-c000-4261-9284-f4a788127b6a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:665170020d881700b3fce97fd975e8fc,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f9dc4802ab7211f19a56ed5b684f684d-20260908
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1224120366; Tue, 08 Sep 2026 18:49:33 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: sp805: Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
Date: Tue,  8 Sep 2026 18:49:05 +0800
Message-Id: <20260908104905.3388262-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.
This also drops the __maybe_unused annotations on the suspend/resume
callbacks, since pm_sleep_ptr() inside the new macro already handles
the case where CONFIG_PM_SLEEP is disabled.

Additionally, wrap the &sp805_wdt_dev_pm_ops assignment with
pm_sleep_ptr() so the entire dev_pm_ops structure is dropped when
CONFIG_PM_SLEEP is disabled, instead of leaving it as a dead struct
with NULL callbacks.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/watchdog/sp805_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index c2125f204a13..7b01011a5bc8 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -321,7 +321,7 @@ static void sp805_wdt_remove(struct amba_device *adev)
 	watchdog_set_drvdata(&wdt->wdd, NULL);
 }
 
-static int __maybe_unused sp805_wdt_suspend(struct device *dev)
+static int sp805_wdt_suspend(struct device *dev)
 {
 	struct sp805_wdt *wdt = dev_get_drvdata(dev);
 
@@ -331,7 +331,7 @@ static int __maybe_unused sp805_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused sp805_wdt_resume(struct device *dev)
+static int sp805_wdt_resume(struct device *dev)
 {
 	struct sp805_wdt *wdt = dev_get_drvdata(dev);
 
@@ -341,7 +341,7 @@ static int __maybe_unused sp805_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend,
 		sp805_wdt_resume);
 
 static const struct amba_id sp805_wdt_ids[] = {
@@ -361,7 +361,7 @@ MODULE_DEVICE_TABLE(amba, sp805_wdt_ids);
 static struct amba_driver sp805_wdt_driver = {
 	.drv = {
 		.name	= MODULE_NAME,
-		.pm	= &sp805_wdt_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&sp805_wdt_dev_pm_ops),
 	},
 	.id_table	= sp805_wdt_ids,
 	.probe		= sp805_wdt_probe,
-- 
2.25.1

