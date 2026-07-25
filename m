Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186B3CAA4F
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975422; cv=none; b=FupCxAfkCGmGYzwc2Unf7vJlGK7awe2VLffF64GcIEpD2QmvkZ4xEjiTRtWBeNXKnzeU0y1F+jwKefhXHWulsruxhAZFD7pVca1rF8t7sovXLmEuJrx/Xj4kaGw3jQ/xHzNZDWO+bNw7lkMasMkJpxlT5BNSLT9GGiTqamYwu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975422; c=relaxed/simple;
	bh=nonqBUUO6BuiZRnFsU6dBuonG96InzXyRH0c0CqEAZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkQR4sackSSPbV2wFciHMGa8C1rZp1he/T0wVgL+xbg4AKJXgMa6YpRfSqeK0GFuo4Q7ztvN4xwOnqZ57J2wJT6bGBI6QxyLg/kekq0VwTIa28/+JTA74/iVmanJlet+J6t/mGrocsNOx61WUUsywVK6uZPtxxTXjXrdjIqrp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ROGNtukB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ROGNtukB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 730EF1A1221;
	Sat, 25 Jul 2026 10:30:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48A2560398;
	Sat, 25 Jul 2026 10:30:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3948311C13104;
	Sat, 25 Jul 2026 12:30:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784975411; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UkBM/H8e7hXCrGpwGsU/lIUXx8VlxUjZx17ypg7Op/4=;
	b=ROGNtukBgjGOhoAd98g0s72fvg+NcJ3dXYb4/JPWrMTAmKRcL84k9z9oIUf9udCcPSElM7
	+8xzEdXEpSNnIZ/r4wKZ0SrO+jOzBhpdlF2/vXVYCGmejAoRjaAsW9UundLqETF0n77srR
	9ROCZTzsi9j3C2c4u11Te+coYCi2fpfhBGIbFir4M/0MwiBNiZRBh4j8strjos5oSf+uBk
	6j12zXRDfeQguAZkAI55/MJZGS0UVXRRf7JRhsaYHCctCowEeRASt4Y/6387ILeNiKBSUa
	JPQ9jNbeF+B7xW75gJt3TybQ9rnzZowhUVDW75Asolkn7Ozjv+cVb4RcLBi1Aw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sat, 25 Jul 2026 12:29:36 +0200
Subject: [PATCH 9/9] watchdog: w83627hf_wdt: Use dev_* logging instead of
 pr_*
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-w83627hf_wdt-improvements-v1-9-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784975401; l=2273;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=nonqBUUO6BuiZRnFsU6dBuonG96InzXyRH0c0CqEAZ4=;
 b=sMBj93tBSI6JruUYDrD/Sw89muE750GBV0RogN+Orkr/mEtaGCjOvFovjoZFgqYp2bg1RvhHI
 P8yDTz1XSBvC03iCf6I/T5abfZI3NUr5Sa7TuDKBHafocwLDSzYzMVy
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The pr_* logging functions do not identify which device generated a
message. Use dev_* logging functions instead.
Since the device name is printed with this family of function, remove
the duplicate name in the initialization message.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index cf1a3fb3a6fd..83c5d8b52b13 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -471,12 +471,13 @@ static int wdt_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	const struct wdt_pdata *pdata = pdev->dev.platform_data;
 	enum chips chip = id->driver_data;
+	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct w83627hf_data *data;
 	struct resource *res;
 	int ret;
 
-	pr_info("WDT driver for %s Super I/O chip initialising\n", id->name);
+	dev_info(dev, "WDT driver initialising\n");
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res) {
@@ -533,11 +534,11 @@ static int wdt_probe(struct platform_device *pdev)
 
 	if (data->early_timer_val) {
 		if (early_disable) {
-			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
+			dev_warn(dev, "Stopping previously enabled watchdog until userland kicks in\n");
 			ret = wdt_stop(wdd);
 		} else {
-			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
-				wdd->timeout);
+			dev_info(dev, "Watchdog already running. Resetting timeout to %d sec\n",
+				 wdd->timeout);
 			ret = wdt_start(wdd);
 			set_bit(WDOG_HW_RUNNING, &wdd->status);
 		}
@@ -550,13 +551,12 @@ static int wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
-	pr_info("initialized. timeout=%d sec (nowayout=%d)\n", wdd->timeout,
-		nowayout);
+	dev_info(dev, "initialized. timeout=%d sec (nowayout=%d)\n",
+		 wdd->timeout, nowayout);
 
 	return 0;
 fail:
-	pr_err("failed to initialize watchdog (err=%d)\n", ret);
-	return ret;
+	return dev_err_probe(dev, ret, "failed to initialize watchdog\n");
 }
 
 /*

-- 
2.55.0

