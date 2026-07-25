Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA03C9893;
	Sat, 25 Jul 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975413; cv=none; b=si9E2nJ4yQkii+KYjbJBM92fR8EASUL3gMX5IjvJBe4VxK24aOmp9SckmrrXAdlgqq1smLJMHPDLP9ZEkhgzj6qNgN8s3HVgJiSvcg6HggwiWAQK4e3wJDWmO+oZ/poxCPxhEuUoKfHQEipEGEXGM3yJVlVe2e1BRlEDeW+H5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975413; c=relaxed/simple;
	bh=6Ss7utLAm8NuXgFCZJHFFq0LJv+q+UPSgtvyMoh+t3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAHYbkqB2zf67tPTCi1mmw7h9R8RPDlsL5xBvvLEmdj+nOwBPbafTQic+bxhPn7YMryQvBLrmMBerLyZjbLjnrGTAGurGfwzbbvNv6ZuFSJIibMpWgTiuHDRD6TQ3+bUW0HXejMvJ+MvrHDd2WhCC5+ppt+fS4r+/cpg4qZSMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TZuJJPKu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TZuJJPKu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 328754E40F4E;
	Sat, 25 Jul 2026 10:30:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0806360398;
	Sat, 25 Jul 2026 10:30:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90F5E11C13101;
	Sat, 25 Jul 2026 12:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784975405; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Br/FmK8ZaOJJ4rp/fDxPspVN+v03eMr6eGNUaxthq+o=;
	b=TZuJJPKuL/hijnm8bf9zt7fj7WfD1hpjoI1T0ff7JrZsOZAxID8TisaY3NGT6jTMLph17q
	RaKSM8nx+Tgn+iuPFAsemZHkbFRC3SxSaZk5wxnxKIxrpVzPvm2l6Z3wdqf+EmTK8a9O/r
	iWLl683EjFtwB6ZeExQVHgec9BbQuLM7pwnbz5YmQt6YWEZQ4+kQo/K+1fri/u2cJM73pl
	C35O6vLSV5kMY4ew4Z5awa5iZPlCaOZ408dRBeldk1DMzxgjcyaNPKtJdmwh+Rv1lDqyNJ
	1C+U/KqMS6vmlqoKj6ix4N+dv5BBz8/zkxTyjqEkIfBMhBN+Lpr7vANl2wxMPQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sat, 25 Jul 2026 12:29:29 +0200
Subject: [PATCH 2/9] watchdog: w83627hf_wdt: Convert to platform driver
 model
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-w83627hf_wdt-improvements-v1-2-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784975401; l=5513;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=6Ss7utLAm8NuXgFCZJHFFq0LJv+q+UPSgtvyMoh+t3k=;
 b=D9wAzpWe620KzqsfiUHyFVFBYkKXLpqAZynngAt6p+jjnaVtzSJwVjkLyTWNss3xK3ignZbra
 NJUPL2ZWdvNBa9uta9+xAx+/bKjdrs9iLUlpSgZzDIi4JY0jZM3PQJ0
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Convert the driver to the Linux driver model with a platform driver /
device.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 131 ++++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 47 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 1529a4e16820..993e65ce4447 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -29,6 +29,7 @@
 
 #include <linux/bits.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
@@ -129,6 +130,8 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define WDT_CTRL_RISING_EDGE_KBD_RESET	BIT(2)
 #define WDT_CTRL_MINUTE_MODE		BIT(3)
 
+struct wdt_pdata {};
+
 static void superio_outb(int reg, int val)
 {
 	outb(reg, WDT_EFER);
@@ -464,6 +467,37 @@ static int wdt_find(int addr)
 	return ret;
 }
 
+static int wdt_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	enum chips chip = id->driver_data;
+	int ret;
+
+	pr_info("WDT driver for %s Super I/O chip initialising\n", id->name);
+
+	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
+		 id->name);
+
+	watchdog_init_timeout(&wdt_dev, timeout, NULL);
+	watchdog_set_nowayout(&wdt_dev, nowayout);
+	watchdog_stop_on_reboot(&wdt_dev);
+
+	ret = w83627hf_init(&wdt_dev, chip);
+	if (ret) {
+		pr_err("failed to initialize watchdog (err=%d)\n", ret);
+		return ret;
+	}
+
+	ret = devm_watchdog_register_device(&pdev->dev, &wdt_dev);
+	if (ret)
+		return ret;
+
+	pr_info("initialized. timeout=%d sec (nowayout=%d)\n", wdt_dev.timeout,
+		nowayout);
+
+	return ret;
+}
+
 /*
  * On some systems, the NCT6791D comes with a companion chip and the
  * watchdog function is in this companion chip. We must use a different
@@ -490,36 +524,49 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
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
+	struct wdt_pdata pdata;
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
@@ -533,35 +580,25 @@ static int __init wdt_init(void)
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
+						 PLATFORM_DEVID_NONE, &pdata,
+						 sizeof(pdata));
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

