Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB8489FAA
	for <linux-watchdog@vger.kernel.org>; Thu, 10 Sep 2026 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044484; cv=none; b=o+6dmYoUNbqV9D2SNPcddRiKIHOlDC2j5o3UQQ5npOVc432JxRjhHbCI/e2Qtk23P592LkUEwJt3G103mscESMhmiMmSo9NbedrMN/XPmI//36L5I8PhA/CM0FdZUeaXlVRMcEWcNfSE4YqIc/71j7k4fjKeE+aVRIuIjSXbNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044484; c=relaxed/simple;
	bh=3uLe8gVB+srjFDJF+kHeWIZxpZtXcwmTjKwroSAiu04=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=N7mOfmeFpmMCIv9t5o5f1MNDyGU2eF1/Mhf7AwTyRKslgX35XvLha9MueIayPKa4rQ9XKsfF7afN4MZ004Ml0rCdfbMXQbECo4vgvMOJ28aix/oLmO+0qmx4SJmARaBooB7XzFxAi9Xg88EKrYOOj6jays+IG/xZTn6ecisJzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d5a22444ad1511f19a56ed5b684f684d-20260910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5a86a90e-2b12-446b-8a4f-380a374d504b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:786be6241c42f67a395d5c306c19ac90,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d5a22444ad1511f19a56ed5b684f684d-20260910
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 352904517; Thu, 10 Sep 2026 20:47:51 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: PM: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr for dev_pm_ops
Date: Thu, 10 Sep 2026 20:47:30 +0800
Message-Id: <20260910124730.1127847-1-lijun01@kylinos.cn>
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
the case where CONFIG_PM_SLEEP is disabled. Wrap the dev_pm_ops
assignment with pm_sleep_ptr() so the entire dev_pm_ops structure
is dropped when CONFIG_PM_SLEEP is disabled, instead of leaving
it as a dead struct with NULL callbacks.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/watchdog/cadence_wdt.c      | 8 ++++----
 drivers/watchdog/da9062_wdt.c       | 8 ++++----
 drivers/watchdog/keembay_wdt.c      | 8 ++++----
 drivers/watchdog/msc313e_wdt.c      | 8 ++++----
 drivers/watchdog/of_xilinx_wdt.c    | 8 ++++----
 drivers/watchdog/pm8916_wdt.c       | 8 ++++----
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 8 ++++----
 7 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index ad46b33ce5f2..ba2efccef467 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -359,7 +359,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
  * @dev: handle to the device structure.
  * Return: 0 always.
  */
-static int __maybe_unused cdns_wdt_suspend(struct device *dev)
+static int cdns_wdt_suspend(struct device *dev)
 {
 	struct cdns_wdt *wdt = dev_get_drvdata(dev);
 
@@ -377,7 +377,7 @@ static int __maybe_unused cdns_wdt_suspend(struct device *dev)
  * @dev: handle to the device structure.
  * Return: 0 on success, errno otherwise.
  */
-static int __maybe_unused cdns_wdt_resume(struct device *dev)
+static int cdns_wdt_resume(struct device *dev)
 {
 	int ret;
 	struct cdns_wdt *wdt = dev_get_drvdata(dev);
@@ -394,7 +394,7 @@ static int __maybe_unused cdns_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cdns_wdt_pm_ops, cdns_wdt_suspend, cdns_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cdns_wdt_pm_ops, cdns_wdt_suspend, cdns_wdt_resume);
 
 static const struct of_device_id cdns_wdt_of_match[] = {
 	{ .compatible = "cdns,wdt-r1p2", },
@@ -408,7 +408,7 @@ static struct platform_driver cdns_wdt_driver = {
 	.driver		= {
 		.name	= "cdns-wdt",
 		.of_match_table = cdns_wdt_of_match,
-		.pm	= &cdns_wdt_pm_ops,
+		.pm	= pm_sleep_ptr(&cdns_wdt_pm_ops),
 	},
 };
 
diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 426962547df1..2b6946478527 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -248,7 +248,7 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &wdt->wdtdev);
 }
 
-static int __maybe_unused da9062_wdt_suspend(struct device *dev)
+static int da9062_wdt_suspend(struct device *dev)
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
@@ -262,7 +262,7 @@ static int __maybe_unused da9062_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused da9062_wdt_resume(struct device *dev)
+static int da9062_wdt_resume(struct device *dev)
 {
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
@@ -276,14 +276,14 @@ static int __maybe_unused da9062_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops,
+static DEFINE_SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops,
 			 da9062_wdt_suspend, da9062_wdt_resume);
 
 static struct platform_driver da9062_wdt_driver = {
 	.probe = da9062_wdt_probe,
 	.driver = {
 		.name = "da9062-watchdog",
-		.pm = &da9062_wdt_pm_ops,
+		.pm = pm_sleep_ptr(&da9062_wdt_pm_ops),
 		.of_match_table = da9062_compatible_id_table,
 	},
 };
diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wdt.c
index 7c8e53921e40..20b9eb6a2727 100644
--- a/drivers/watchdog/keembay_wdt.c
+++ b/drivers/watchdog/keembay_wdt.c
@@ -250,7 +250,7 @@ static int keembay_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused keembay_wdt_suspend(struct device *dev)
+static int keembay_wdt_suspend(struct device *dev)
 {
 	struct keembay_wdt *wdt = dev_get_drvdata(dev);
 
@@ -260,7 +260,7 @@ static int __maybe_unused keembay_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused keembay_wdt_resume(struct device *dev)
+static int keembay_wdt_resume(struct device *dev)
 {
 	struct keembay_wdt *wdt = dev_get_drvdata(dev);
 
@@ -270,7 +270,7 @@ static int __maybe_unused keembay_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(keembay_wdt_pm_ops, keembay_wdt_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(keembay_wdt_pm_ops, keembay_wdt_suspend,
 			 keembay_wdt_resume);
 
 static const struct of_device_id keembay_wdt_match[] = {
@@ -284,7 +284,7 @@ static struct platform_driver keembay_wdt_driver = {
 	.driver	= {
 		.name		= "keembay_wdt",
 		.of_match_table	= keembay_wdt_match,
-		.pm		= &keembay_wdt_pm_ops,
+		.pm		= pm_sleep_ptr(&keembay_wdt_pm_ops),
 	},
 };
 
diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index f69d66971c41..e283fc7c60c3 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -133,7 +133,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &priv->wdev);
 }
 
-static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
+static int msc313e_wdt_suspend(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
 
@@ -143,7 +143,7 @@ static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused msc313e_wdt_resume(struct device *dev)
+static int msc313e_wdt_resume(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
 
@@ -153,13 +153,13 @@ static int __maybe_unused msc313e_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend, msc313e_wdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend, msc313e_wdt_resume);
 
 static struct platform_driver msc313e_wdt_driver = {
 	.driver = {
 		.name = "msc313e-wdt",
 		.of_match_table = msc313e_wdt_of_match,
-		.pm = &msc313e_wdt_pm_ops,
+		.pm = pm_sleep_ptr(&msc313e_wdt_pm_ops),
 	},
 	.probe = msc313e_wdt_probe,
 };
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 352853e6fe71..d6b1adfe31d1 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -251,7 +251,7 @@ static int xwdt_probe(struct platform_device *pdev)
  * @dev: handle to the device structure.
  * Return: 0 always.
  */
-static int __maybe_unused xwdt_suspend(struct device *dev)
+static int xwdt_suspend(struct device *dev)
 {
 	struct xwdt_device *xdev = dev_get_drvdata(dev);
 
@@ -267,7 +267,7 @@ static int __maybe_unused xwdt_suspend(struct device *dev)
  * @dev: handle to the device structure.
  * Return: 0 on success, errno otherwise.
  */
-static int __maybe_unused xwdt_resume(struct device *dev)
+static int xwdt_resume(struct device *dev)
 {
 	struct xwdt_device *xdev = dev_get_drvdata(dev);
 	int ret = 0;
@@ -278,7 +278,7 @@ static int __maybe_unused xwdt_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(xwdt_pm_ops, xwdt_suspend, xwdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(xwdt_pm_ops, xwdt_suspend, xwdt_resume);
 
 /* Match table for of_platform binding */
 static const struct of_device_id xwdt_of_match[] = {
@@ -293,7 +293,7 @@ static struct platform_driver xwdt_driver = {
 	.driver = {
 		.name  = WATCHDOG_NAME,
 		.of_match_table = xwdt_of_match,
-		.pm = &xwdt_pm_ops,
+		.pm = pm_sleep_ptr(&xwdt_pm_ops),
 	},
 };
 
diff --git a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
index 007ed139ab96..a7ae57fb2453 100644
--- a/drivers/watchdog/pm8916_wdt.c
+++ b/drivers/watchdog/pm8916_wdt.c
@@ -233,7 +233,7 @@ static int pm8916_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &wdt->wdev);
 }
 
-static int __maybe_unused pm8916_wdt_suspend(struct device *dev)
+static int pm8916_wdt_suspend(struct device *dev)
 {
 	struct pm8916_wdt *wdt = dev_get_drvdata(dev);
 
@@ -243,7 +243,7 @@ static int __maybe_unused pm8916_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused pm8916_wdt_resume(struct device *dev)
+static int pm8916_wdt_resume(struct device *dev)
 {
 	struct pm8916_wdt *wdt = dev_get_drvdata(dev);
 
@@ -253,7 +253,7 @@ static int __maybe_unused pm8916_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(pm8916_wdt_pm_ops, pm8916_wdt_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(pm8916_wdt_pm_ops, pm8916_wdt_suspend,
 			 pm8916_wdt_resume);
 
 static const struct of_device_id pm8916_wdt_id_table[] = {
@@ -267,7 +267,7 @@ static struct platform_driver pm8916_wdt_driver = {
 	.driver = {
 		.name = "pm8916-wdt",
 		.of_match_table = pm8916_wdt_id_table,
-		.pm = &pm8916_wdt_pm_ops,
+		.pm = pm_sleep_ptr(&pm8916_wdt_pm_ops),
 	},
 };
 module_platform_driver(pm8916_wdt_driver);
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 060447101f48..958e68746f8e 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -114,7 +114,7 @@ static void stmp3xxx_wdt_remove(struct platform_device *pdev)
 	unregister_reboot_notifier(&wdt_notifier);
 }
 
-static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
+static int stmp3xxx_wdt_suspend(struct device *dev)
 {
 	struct watchdog_device *wdd = &stmp3xxx_wdd;
 
@@ -124,7 +124,7 @@ static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
+static int stmp3xxx_wdt_resume(struct device *dev)
 {
 	struct watchdog_device *wdd = &stmp3xxx_wdd;
 
@@ -134,13 +134,13 @@ static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
+static DEFINE_SIMPLE_DEV_PM_OPS(stmp3xxx_wdt_pm_ops,
 			 stmp3xxx_wdt_suspend, stmp3xxx_wdt_resume);
 
 static struct platform_driver stmp3xxx_wdt_driver = {
 	.driver = {
 		.name = "stmp3xxx_rtc_wdt",
-		.pm = &stmp3xxx_wdt_pm_ops,
+		.pm = pm_sleep_ptr(&stmp3xxx_wdt_pm_ops),
 	},
 	.probe = stmp3xxx_wdt_probe,
 	.remove = stmp3xxx_wdt_remove,
-- 
2.25.1

