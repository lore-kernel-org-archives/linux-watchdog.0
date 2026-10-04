Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565C742123C;
	Sun,  4 Oct 2026 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116000; cv=none; b=p4cNEN+y04r6eDz55ZQhVCagpBLh0y6qp9grkCDdMVakw2TWJV0LSOD3nuFKS3xWUqPNxFcDWdsJYJ5bwc0KJ2Ry7DgUuDHYj70vy84NNwtoCZBNJ0OihNQ/1PvMRXnj+dOpBiMq7qZH0UUdjJl2TAzeMdjBJuMUobj48XbFr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116000; c=relaxed/simple;
	bh=fbU4jq9iJcxM1dXDAVAnk9wW5AEqObsTWZ2ZQg3wpdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hp2axuEdwrvI1igtV5YTj2niuTXZbS9zRuAhzzeCOshr5lildpTTwiV3OtMI077iQYcRNb+askrow8+mbsjDLH0gzlP+B34B6yU0GBJ0uPPTo4C3oDLLQSI4arR4Wnoy7zrER6LdqDhkVZBr6rBUJ+GpMSaIBEKnDKGShCurukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kJclNlm6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kJclNlm6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D38C84E41158;
	Sun,  4 Oct 2026 12:13:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8564604FE;
	Sun,  4 Oct 2026 12:13:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B303410328199;
	Sun,  4 Oct 2026 14:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791115996; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=A/bC68BaDNPxCcgSOhh3ZZYpItyy0U4U2lom7bdSCZc=;
	b=kJclNlm65LlgkUxc6OoElbRl3fYw/SarWV7fmwTdCuSgRlR027IGRBDf+KAXEjd2HjI9Hz
	ZitUSZZvFDKD2wtUy+Zp3Gh+410pP/M45s75MZaC4xk2zMkBUQ/q6eawopJaa+JDH5UEUS
	rOtpYba7vjrrj5GxFO9cjrrP8jJ0s43UsX2v/oXIRQKyudppPrs5sWMznqLJGLjynYIKuU
	PVGjhEOaZUSNfbZGVKMqCYZkqP6X4biDOc38GFjs6QFp1KIIN/U2t9dGfdSx9/GgzyBxtI
	mo46kcX9GK9fsf7pr4MBASrHBRYMYFQkAJmvHFIJutyTl759IA5GtyQmr+uR9w==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sun, 04 Oct 2026 14:12:50 +0200
Subject: [PATCH v3 2/6] watchdog: w83627hf_wdt: Convert to platform driver
 model
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-w83627hf_wdt-improvements-v3-2-8e27b518595e@bootlin.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791115992; l=6789;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=fbU4jq9iJcxM1dXDAVAnk9wW5AEqObsTWZ2ZQg3wpdk=;
 b=s8495vAQR8SrSENR4Z4pdkb74ahbFPhmlqLoW5PmUhewhqxhkTU6EB7PwkUVXwcZ0swosy2vy
 cMj3YYsSJJbD8E2+of+D4bukv6Yfvy30PC+noA4l92ZRebmbkdZF0en
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Convert the driver to the Linux driver model with a platform driver /
device.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 165 ++++++++++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 59 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 1529a4e16820..57f5c000f276 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -29,6 +29,7 @@
 
 #include <linux/bits.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
@@ -129,6 +130,11 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define WDT_CTRL_RISING_EDGE_KBD_RESET	BIT(2)
 #define WDT_CTRL_MINUTE_MODE		BIT(3)
 
+struct w83627hf_data {
+	struct watchdog_device wdd;
+	struct watchdog_info info;
+};
+
 static void superio_outb(int reg, int val)
 {
 	outb(reg, WDT_EFER);
@@ -328,10 +334,6 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
  *	Kernel Interfaces
  */
 
-static struct watchdog_info wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-};
-
 static const struct watchdog_ops wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = wdt_start,
@@ -340,14 +342,6 @@ static const struct watchdog_ops wdt_ops = {
 	.get_timeleft = wdt_get_time,
 };
 
-static struct watchdog_device wdt_dev = {
-	.info = &wdt_info,
-	.ops = &wdt_ops,
-	.timeout = WATCHDOG_TIMEOUT,
-	.min_timeout = 1,
-	.max_timeout = 255,
-};
-
 /*
  *	The WDT needs to learn about soft shutdowns in order to
  *	turn the timebomb registers off.
@@ -464,6 +458,58 @@ static int wdt_find(int addr)
 	return ret;
 }
 
+static int wdt_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct device *dev = &pdev->dev;
+	struct watchdog_device *wdd;
+	struct w83627hf_data *data;
+	enum chips chip;
+	int ret;
+
+	dev_info(dev, "WDT driver initialising\n");
+
+	if (!id)
+		return dev_err_probe(dev, -EINVAL, "failed to get chip id\n");
+
+	chip = id->driver_data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
+	snprintf(data->info.identity, sizeof(data->info.identity),
+		 "%s Watchdog", id->name);
+
+	wdd = &data->wdd;
+
+	wdd->parent = dev;
+	wdd->info = &data->info;
+	wdd->ops = &wdt_ops;
+	wdd->timeout = WATCHDOG_TIMEOUT;
+	wdd->min_timeout = 1;
+	wdd->max_timeout = 255;
+
+	watchdog_set_drvdata(wdd, data);
+	watchdog_init_timeout(wdd, timeout, NULL);
+	watchdog_set_nowayout(wdd, nowayout);
+	watchdog_stop_on_reboot(wdd);
+
+	ret = w83627hf_init(wdd, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize watchdog\n");
+
+	ret = devm_watchdog_register_device(dev, wdd);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "initialized. timeout=%d sec (nowayout=%d)\n",
+		 wdd->timeout, nowayout);
+
+	return ret;
+}
+
 /*
  * On some systems, the NCT6791D comes with a companion chip and the
  * watchdog function is in this companion chip. We must use a different
@@ -490,36 +536,48 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
 	{}
 };
 
+static const struct platform_device_id wdt_ids[] = {
+	{ .name = "W83627HF", .driver_data = w83627hf },
+	{ .name = "W83627S", .driver_data = w83627s },
+	{ .name = "W83697HF", .driver_data = w83697hf },
+	{ .name = "W83697UG", .driver_data = w83697ug },
+	{ .name = "W83637HF", .driver_data = w83637hf },
+	{ .name = "W83627THF", .driver_data = w83627thf },
+	{ .name = "W83687THF", .driver_data = w83687thf },
+	{ .name = "W83627EHF", .driver_data = w83627ehf },
+	{ .name = "W83627DHG", .driver_data = w83627dhg },
+	{ .name = "W83627UHG", .driver_data = w83627uhg },
+	{ .name = "W83667HG", .driver_data = w83667hg },
+	{ .name = "W83667DHG-P", .driver_data = w83627dhg_p },
+	{ .name = "W83667HG-B", .driver_data = w83667hg_b },
+	{ .name = "NCT6775", .driver_data = nct6775 },
+	{ .name = "NCT6776", .driver_data = nct6776 },
+	{ .name = "NCT6779", .driver_data = nct6779 },
+	{ .name = "NCT6791", .driver_data = nct6791 },
+	{ .name = "NCT6792", .driver_data = nct6792 },
+	{ .name = "NCT6793", .driver_data = nct6793 },
+	{ .name = "NCT6795", .driver_data = nct6795 },
+	{ .name = "NCT6796", .driver_data = nct6796 },
+	{ .name = "NCT6102", .driver_data = nct6102 },
+	{ .name = "NCT6116", .driver_data = nct6116 },
+	{ .name = "NCT6126", .driver_data = nct6126 },
+	{},
+};
+
+static struct platform_driver wdt_driver = {
+	.probe          = wdt_probe,
+	.id_table       = wdt_ids,
+	.driver         = {
+		.name   = KBUILD_MODNAME,
+	},
+};
+
+static struct platform_device *wdt_pdev;
+
 static int __init wdt_init(void)
 {
 	int ret;
 	int chip;
-	static const char * const chip_name[] = {
-		"W83627HF",
-		"W83627S",
-		"W83697HF",
-		"W83697UG",
-		"W83637HF",
-		"W83627THF",
-		"W83687THF",
-		"W83627EHF",
-		"W83627DHG",
-		"W83627UHG",
-		"W83667HG",
-		"W83667DHG-P",
-		"W83667HG-B",
-		"NCT6775",
-		"NCT6776",
-		"NCT6779",
-		"NCT6791",
-		"NCT6792",
-		"NCT6793",
-		"NCT6795",
-		"NCT6796",
-		"NCT6102",
-		"NCT6116",
-		"NCT6126"
-	};
 
 	/* Apply system-specific quirks */
 	dmi_check_system(wdt_dmi_table);
@@ -533,35 +591,24 @@ static int __init wdt_init(void)
 			return chip;
 	}
 
-	pr_info("WDT driver for %s Super I/O chip initialising\n",
-		chip_name[chip]);
-
-	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
-		 chip_name[chip]);
-
-	watchdog_init_timeout(&wdt_dev, timeout, NULL);
-	watchdog_set_nowayout(&wdt_dev, nowayout);
-	watchdog_stop_on_reboot(&wdt_dev);
-
-	ret = w83627hf_init(&wdt_dev, chip);
-	if (ret) {
-		pr_err("failed to initialize watchdog (err=%d)\n", ret);
-		return ret;
-	}
-
-	ret = watchdog_register_device(&wdt_dev);
+	ret = platform_driver_register(&wdt_driver);
 	if (ret)
 		return ret;
 
-	pr_info("initialized. timeout=%d sec (nowayout=%d)\n",
-		wdt_dev.timeout, nowayout);
+	wdt_pdev = platform_device_register_data(NULL, wdt_ids[chip].name,
+						 PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(wdt_pdev)) {
+		platform_driver_unregister(&wdt_driver);
+		return PTR_ERR(wdt_pdev);
+	}
 
-	return ret;
+	return 0;
 }
 
 static void __exit wdt_exit(void)
 {
-	watchdog_unregister_device(&wdt_dev);
+	platform_device_unregister(wdt_pdev);
+	platform_driver_unregister(&wdt_driver);
 }
 
 module_init(wdt_init);

-- 
2.55.0

