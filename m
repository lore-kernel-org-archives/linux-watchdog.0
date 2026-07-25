Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2062F1FE3
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975412; cv=none; b=V9b0JcFAWPIrho9yu7Z8P98QONRr2tyPDehHiZCkYfp2BGPOK5aGcUVsmA5OtmaLr9Hkn709uxrlnMVfRZTwS42YeeCEVsAwCEoxPuU/9JnRQZHLjpnIla67hOcbf0e0DIRkRdjIVgLFJ40aWA6+wBW4Tb+limkHqEC/Qn+1Vts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975412; c=relaxed/simple;
	bh=NYMS6rzlXBJ6I4sa6/BxUJezzsBrtEmBn5wY6HXmXtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Un4AZ7vUhyEHy1E7VPoOIIRR8Zs4J+PPFPO3nRCk4Griv1ePXMbXytJ/tFvIRgbBIL+ibceGabpZN83H/XVPygE/mvtjtSRhOwyj0PUt9Ps/uIn5/ykw37ZUKXjuwlMNJeX1D+uH0spLtg11n+IX+/6TGP29DuwhAhJ0yrxk2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KM+tbvs0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KM+tbvs0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 08AAD1A121D;
	Sat, 25 Jul 2026 10:30:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D24CB60398;
	Sat, 25 Jul 2026 10:30:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B334711C13102;
	Sat, 25 Jul 2026 12:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784975406; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QH1QNAVQ801U1Z/sCO38fcE2HzCFVq7IpMVOAYHQino=;
	b=KM+tbvs06YuKpV1KKxyMshQpK35uqSSrRa029Cl+pGRoDxGFYu3ifAFRYx7P2uDdhSnuwF
	IMBjzEZsL3klYmWzP9bQtYn/RP2mTdGDihFq9ujMSi+m0N+22FANjG2SOnfRVAbiZcbEOA
	i4HMbPTsBzhLpaV4Y2Cd0RQndYGiD8sfIZXhWzQq8yEe2Cu28hIUK7/m6OTfqdOZCjBKHf
	2+n6qWi9lHwGMjop2rBu9Te6VRXI1MYOJlNibXriSNZGOl8vWj7x/Z+J8UTfuC6ic3JzYU
	MCLRAcw3EKiv/4txYdOGr5ws5sHbiCYZTt9Fwwbzv6Mhdbnah842cTjx/bDLKg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sat, 25 Jul 2026 12:29:30 +0200
Subject: [PATCH 3/9] watchdog: w83627hf_wdt: Use private driver data
 structure
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-w83627hf_wdt-improvements-v1-3-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784975401; l=3274;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=NYMS6rzlXBJ6I4sa6/BxUJezzsBrtEmBn5wY6HXmXtY=;
 b=93hSkwP20VWkbGAtI26tpvJFIZCFwUkXxKYuYQ3wD94DBgnqc4DmLtBEPYSD9uOJjdQLvKhXR
 HjjcssWDTRjA9KKWh85lCxLZM2Mnu3qjDJmxOtoggWKpUSjv8Jh8yw8
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Allocating a per-device data structure is a common practice in the Linux
driver model. Add one that will be used to store chip-specific register
offsets, and configuration.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 49 ++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 993e65ce4447..72e167f37885 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -132,6 +132,11 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 
 struct wdt_pdata {};
 
+struct w83627hf_data {
+	struct watchdog_device wdd;
+	struct watchdog_info info;
+};
+
 static void superio_outb(int reg, int val)
 {
 	outb(reg, WDT_EFER);
@@ -331,10 +336,6 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
  *	Kernel Interfaces
  */
 
-static struct watchdog_info wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-};
-
 static const struct watchdog_ops wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = wdt_start,
@@ -343,14 +344,6 @@ static const struct watchdog_ops wdt_ops = {
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
@@ -471,28 +464,44 @@ static int wdt_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	enum chips chip = id->driver_data;
+	struct watchdog_device *wdd;
+	struct w83627hf_data *data;
 	int ret;
 
 	pr_info("WDT driver for %s Super I/O chip initialising\n", id->name);
 
-	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
-		 id->name);
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
+	wdd->info = &data->info;
+	wdd->ops = &wdt_ops;
+	wdd->timeout = WATCHDOG_TIMEOUT;
+	wdd->min_timeout = 1;
+	wdd->max_timeout = 255;
 
-	watchdog_init_timeout(&wdt_dev, timeout, NULL);
-	watchdog_set_nowayout(&wdt_dev, nowayout);
-	watchdog_stop_on_reboot(&wdt_dev);
+	watchdog_set_drvdata(wdd, data);
+	watchdog_init_timeout(wdd, timeout, NULL);
+	watchdog_set_nowayout(wdd, nowayout);
+	watchdog_stop_on_reboot(wdd);
 
-	ret = w83627hf_init(&wdt_dev, chip);
+	ret = w83627hf_init(wdd, chip);
 	if (ret) {
 		pr_err("failed to initialize watchdog (err=%d)\n", ret);
 		return ret;
 	}
 
-	ret = devm_watchdog_register_device(&pdev->dev, &wdt_dev);
+	ret = devm_watchdog_register_device(&pdev->dev, wdd);
 	if (ret)
 		return ret;
 
-	pr_info("initialized. timeout=%d sec (nowayout=%d)\n", wdt_dev.timeout,
+	pr_info("initialized. timeout=%d sec (nowayout=%d)\n", wdd->timeout,
 		nowayout);
 
 	return ret;

-- 
2.55.0

