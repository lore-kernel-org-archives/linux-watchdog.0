Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483956;
	b=pakxEJHNVJN7pHyODBfV1wNbdBe2hpErsIvRXBpXlMspnDCEWpjpKElUQ1qovG1KVi/w
	 0NR7duCh3mMqwTf5vMaxstlzYELz7jh2ELHe6PH19vww7xerKJkVr/sGmUwcE8twDHtKT
	 jZ6iUhPxuZESwBQ6K2fnlMjJ5kxGTy9Og3hDVFr7KkY4EnHLbFHWd1JIsyW3vEaz7aGgl
	 UGXI7FK6h2BS1BamqXQiOQPHEexVnNE9lMXUHKKq0nh2HcvHr87hXLWGvkrlZlM0cxaDd
	 V4goyGcv958ZCn8/HfKwUjjBcLvtQsgWp1Mq4bkwCZ10Uk+34kyeED6HTnotsxqw73A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483956;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=SGFRyGcF1lLJTeMBDpTngHwnsqEYU5Sojp9lG0KjoAI=;
	b=CgWNXJ80l6CJ6oYyEr+AVcB3k2zB80b75v6ScDy/LHTOjVT7maroJM29CmOAZ4FUxVoc
	 JZkqa5c3xXhhzGcJehyllrBUr9DRIe/BJQjtkfTGiQKuAZzBqNaju9yldBeHFu6uudCsI
	 AnE2r7W5evJ7smnPDaipHVRxEl8BPm46rJymts8gpvKCtHgEjSknqehOLrslufD3pp69g
	 pm1sOYDublaf3D674XSQugazXBw41alrfHfAMFAMiX3OGkSJwe8LR6Q4Z+6P8+p8DA5k/
	 qU35PrphPkziQ3lzgXPB1b4y1vDZzdU+ZWFvSjhTmT3Y/3vjpluXI8RFGy0HgXjHxog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VoNlmHRK;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8F606A323
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 08:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D8F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VoNlmHRK
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CE461C5CD5F;
	Tue, 20 Oct 2026 08:13:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 66CF160393;
	Tue, 20 Oct 2026 08:12:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF58410328D1B;
	Tue, 20 Oct 2026 10:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792483952; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SGFRyGcF1lLJTeMBDpTngHwnsqEYU5Sojp9lG0KjoAI=;
	b=VoNlmHRKmJKfCySanE3bzWnC+LkWNVIIDHASdfFs2qC2Bol+5asS6P46Tit9jW///nVwGM
	PM7jyRtgAi1+wa/DjFWi+qLyFjsryqRHB6fVsxa3jI6NPnmg6QK+Qe4PqstC010SoI6Gli
	TbitwF/6AMMuqWSmnq2MDno49BiV1EYAE14HHy/wYkQ6LDOhsks09qqVC2erYOhCCAewM5
	z1YB7v+jKqmJd+aZuTRdPN1C+rQGsTmNd1I4IOvhHXFyahzohKdbnXOA2TvA0u1M5puT2j
	JZ6G3XkNzH4v6b0wiuiu68Fnu7T2xIoJqW9bJDMK5/Ie18vJ5qJ3DEgjAIio/w==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 20 Oct 2026 10:11:55 +0200
Subject: [PATCH v5 2/5] watchdog: w83627hf_wdt: Convert to platform driver
 model
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-w83627hf_wdt-improvements-v5-2-90b226684fc7@bootlin.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483947; l=6885;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=z08oih7fS+IQVbil9H1CUbv8cffrduc0eTHrV5YTZVU=;
 b=3YUeH9N+1qQ71Qt2ivS+718ysoRAx0WLnbMzz9VPONZ7ktOzUtoneZ47xhdIDnG9naJjjZPPp
 uO0jQZuU4D2DQ4gPUCeyAgfrdJLYZ6hsoPg+hxLSPHMi0kRakN8/vjB
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

This driver is not yet converted to the driver model.
Convert it and add missing error messages in probe.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 165 ++++++++++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 59 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index fa1808a4c6c8..96ea278e45c4 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -30,6 +30,7 @@
 #include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/ioport.h>
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
@@ -326,10 +332,6 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
  *	Kernel Interfaces
  */
 
-static struct watchdog_info wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-};
-
 static const struct watchdog_ops wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = wdt_start,
@@ -338,14 +340,6 @@ static const struct watchdog_ops wdt_ops = {
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
@@ -462,6 +456,58 @@ static int wdt_find(int addr)
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
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
+	snprintf(data->info.identity, sizeof(data->info.identity), "%s Watchdog",
+		 id->name);
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
+		return dev_err_probe(dev, ret, "failed to register watchdog\n");
+
+	dev_info(dev, "initialized. timeout=%d sec (nowayout=%d)\n",
+		 wdd->timeout, nowayout);
+
+	return 0;
+}
+
 /*
  * On some systems, the NCT6791D comes with a companion chip and the
  * watchdog function is in this companion chip. We must use a different
@@ -488,36 +534,48 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
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
+	{}
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
@@ -531,35 +589,24 @@ static int __init wdt_init(void)
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
2.56.0

