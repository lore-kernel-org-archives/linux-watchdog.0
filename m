Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C63E274C
	for <linux-watchdog@vger.kernel.org>; Sun, 26 Jul 2026 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091522; cv=none; b=oixHT2HB85kZdABWxqvIqVWrRUZxrCwZjRMbbKfCAZ5BjmRBDidQFEOWfrzSG0AyhzZqoo58VXC+jCxmERTeyAmhRNNehFCwu6/4iZTMSDDknCMk3gT0ViXMC9bFicjjHBUSOiEGsgzK6/zePz6+ftFHNwQrtiiJgp/fS80aqYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091522; c=relaxed/simple;
	bh=AGV7TpWAbuHR+4NIkQ+A/dRYpk+oNoFQjqvEjOi/Oz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E93tf1r/QxKXNtvbUAv8k/XotxvPw3oG62RX5vSlWDcgGd6WESzAlUPCjZ6mvaAFmWZ/6/NkI6rid7woAdXTUn1DF+VbM8La87dEHnWzH2bNMHr6UlNHfAv1hdADtYeR/aDdPkuKPsCeGM0oaZrykCc+hTjoKjdjtwYDbI3OED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tN/MglXb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tN/MglXb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E46CC1A1268;
	Sun, 26 Jul 2026 18:45:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9C99601BE;
	Sun, 26 Jul 2026 18:45:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95C8F11C10AB5;
	Sun, 26 Jul 2026 20:45:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785091513; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Lioi0R+t2IDoT+fROHX+0Wbiy21bEZAenbqlnSTDQ1Y=;
	b=tN/MglXbxViD0zpJku3numJ5lbg5lrGs89kQx0rTuZUPW4gt4Ou4x93KWSIYorQNFpIX8X
	QRNK3+3mIK5SrO7NCgJ0iXoez6WkO4CPKW0ZBcYPPv6SwzRWciLpf5AroSSTZR2csBm8mR
	RmNZZp+IzDMm/umDkhFA0O6bVC0Q24PvvTLUs4IoHU3Y7GU2n2MvqqcXHDLscaH0z1lvM0
	7uNCWfQTHsQEpd7lDPQiSnndUE46HLzaZdHhEHQh4rUB0dd8+4JmykbZbRrrDRTcc+GeIX
	s00ost8ARkNLtpuZm65BYvgH3pcxj+6Xo8W7vwMHYkDfkNnludyUkfzMGnbShw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sun, 26 Jul 2026 20:44:30 +0200
Subject: [PATCH v2 3/8] watchdog: w83627hf_wdt: Use private driver data
 structure
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-w83627hf_wdt-improvements-v2-3-3645a2a6c022@bootlin.com>
References: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
In-Reply-To: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785091497; l=3297;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=AGV7TpWAbuHR+4NIkQ+A/dRYpk+oNoFQjqvEjOi/Oz4=;
 b=SVByvQHoZ4tMRqoEztR2HmNTe+qCKMs/wWYkJCA2/6KbmRRnl5+ALlh+JeNDq6YxiyPlFtDZC
 QTWZVpC1Y7nC3RpadoxvYoEVxuYae+pxRDcAA0KYVtN5RcAipY5YNau
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
index 206ab91fdb2a..38cbc6d14f4c 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -130,6 +130,11 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
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
@@ -329,10 +334,6 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
  *	Kernel Interfaces
  */
 
-static struct watchdog_info wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-};
-
 static const struct watchdog_ops wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = wdt_start,
@@ -341,14 +342,6 @@ static const struct watchdog_ops wdt_ops = {
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
@@ -470,27 +463,43 @@ static int wdt_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	enum chips chip = id->driver_data;
 	struct device *dev = &pdev->dev;
+	struct watchdog_device *wdd;
+	struct w83627hf_data *data;
 	int ret;
 
 	dev_info(dev, "WDT driver initialising\n");
 
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
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to initialize watchdog\n");
 
-	ret = devm_watchdog_register_device(&pdev->dev, &wdt_dev);
+	ret = devm_watchdog_register_device(&pdev->dev, wdd);
 	if (ret)
 		return ret;
 
 	dev_info(dev, "initialized. timeout=%d sec (nowayout=%d)\n",
-		 wdt_dev.timeout, nowayout);
+		 wdd->timeout, nowayout);
 
 	return ret;
 }

-- 
2.55.0

