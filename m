Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600403F824B;
	Tue, 13 Oct 2026 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899954; cv=none; b=TvYBjMatpyzxZej3jISqM/0bMkeJP2/xDblvGXQlFX1M9uffgMK7E5WEqtcm62DRO1uxfrumcEt8VGv3iXeCUBlOXvYzlS6dNVdRH5Q1Y9iRyMGYS90EI3y2FOvdYwgdJj6W8x+o8QGRZaJC+pePoewWcY5RXDP43GJYBMxvWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899954; c=relaxed/simple;
	bh=JzDisuZ2zA+RdRPZHkSm2Vaice3V923Kr27ZTHkO8AM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aP6Xr04FlD4FB2fyP/rsB69GKvN4tgYDXYOSxiVC/t/bj8zevHpQO6xJ+qc8qmL61NhEJ0tvMVNyaFZ1x3z+KlsdMzwOfVeo7V0DqEOE9csv3s6OAr4LHU76kKPKO8eHLwflHX9YGihm2BAT5v8pHSXIuPPtyX6VFNC8jm8BrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pjtjvNqE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pjtjvNqE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DF0934E4120F;
	Tue, 13 Oct 2026 13:59:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B3F2560362;
	Tue, 13 Oct 2026 13:59:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CCE511D713D2;
	Tue, 13 Oct 2026 15:59:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791899950; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hPZdn5ELLgjiRjUUiwxg87QAgCasv7yyE9Fs/5cLbHY=;
	b=pjtjvNqEPELtlosd+y6TgL3W+Y/0K4hPiAApaA/n2r9s7latw4dTEje0KUU/uQlEogfjkK
	lVeSMys84Hohe3Ssngf0ydCofH6VWoeQllYDDGSN2qA9zz0XKSsrHDzW0dlGTE9A2SX/JS
	YgimMnsfpVAGYYg4cNIAp1sMR9hlpJmxJy8FvuGZeNBlMAC3arq52k20b6d0uxOP5uEZFB
	hqcn6I3O4Cdm6N/cCXiAjpmHi14Ueu0H1qgoZvd3hnrLXiNtwYn8Oc+rYHcdaIUXCTzj7Y
	zPyI8bMUfA9PWeJiRwMLsBwx0Fz5IeFo/872hlYzPzXCUf++HQf2phgQ2gDiAw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 13 Oct 2026 15:58:50 +0200
Subject: [PATCH v4 6/6] watchdog: w83627hf_wdt: Add minute mode counting
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-w83627hf_wdt-improvements-v4-6-b6f6b60a9566@bootlin.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791899939; l=5711;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=JzDisuZ2zA+RdRPZHkSm2Vaice3V923Kr27ZTHkO8AM=;
 b=1fJfPeRvkCEngYpL4FjCL4uohKKVZa0tY00nLDuRbaOLEoEHNKhT6VpEP85QmA7USGYY2UiAs
 JQi/peBIj1vCIEfcNkOqbz9/2LOBNhpqPPfipGgz7LZhCV9KdhERqAp
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

All of the chips supported by the driver can be set to minute mode,
allowing timeout value up to 255 minutes.
Add it to the driver.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 68 +++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 0b9195e7e95e..8f78fe64acde 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -40,6 +40,7 @@
 
 #define WATCHDOG_NAME "w83627hf/thf/hg/dhg WDT"
 #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
+#define WATCHDOG_MAX_TIMEOUT (255 * 60)
 
 enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
 	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
@@ -49,7 +50,8 @@ enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
 static int timeout;			/* in seconds */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
-		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
+		"Watchdog timeout in seconds. 1 <= timeout <= "
+				__MODULE_STRING(WATCHDOG_MAX_TIMEOUT) ", default="
 				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -139,6 +141,9 @@ struct w83627hf_data {
 	struct watchdog_info info;
 	const struct w83627hf_reg *reg;
 	const struct w83627hf_sio_pdata *sio;
+	bool minute_mode;
+	u8 early_timer_val;
+	u8 timer_val;
 };
 
 static void superio_outb(int base, int reg, int val)
@@ -258,21 +263,10 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 		break;
 	}
 
-	t = superio_inb(data->sio->addr, data->reg->timeout);
-	if (t != 0) {
-		if (early_disable) {
-			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
-			superio_outb(data->sio->addr, data->reg->timeout, 0);
-		} else {
-			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
-				wdog->timeout);
-			superio_outb(data->sio->addr, data->reg->timeout, wdog->timeout);
-			set_bit(WDOG_HW_RUNNING, &wdog->status);
-		}
-	}
+	data->early_timer_val = superio_inb(data->sio->addr, data->reg->timeout);
 
 	t = superio_inb(data->sio->addr, data->reg->control) &
-	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
+	    ~WDT_CTRL_RISING_EDGE_KBD_RESET;
 	superio_outb(data->sio->addr, data->reg->control, t);
 
 	t = superio_inb(data->sio->addr, data->reg->csr);
@@ -290,6 +284,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 {
 	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
+	unsigned char ctrl;
 	int ret;
 
 	ret = superio_enter(data->sio->addr, data->sio->cfg_enter);
@@ -297,6 +292,15 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 		return ret;
 
 	superio_select(data->sio->addr, W83627HF_LD_WDT);
+
+	ctrl = superio_inb(data->sio->addr, data->reg->control);
+
+	if (data->minute_mode)
+		ctrl |= WDT_CTRL_MINUTE_MODE;
+	else
+		ctrl &= ~WDT_CTRL_MINUTE_MODE;
+
+	superio_outb(data->sio->addr, data->reg->control, ctrl);
 	superio_outb(data->sio->addr, data->reg->timeout, timeout);
 	superio_exit(data->sio->addr, data->sio->cfg_leave);
 
@@ -305,7 +309,9 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 
 static int wdt_start(struct watchdog_device *wdog)
 {
-	return wdt_set_time(wdog, wdog->timeout);
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
+
+	return wdt_set_time(wdog, data->timer_val);
 }
 
 static int wdt_stop(struct watchdog_device *wdog)
@@ -315,6 +321,17 @@ static int wdt_stop(struct watchdog_device *wdog)
 
 static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
 {
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
+
+	if (timeout > 255) {
+		data->minute_mode = true;
+		data->timer_val = DIV_ROUND_UP(timeout, 60);
+		timeout = data->timer_val * 60;
+	} else {
+		data->minute_mode = false;
+		data->timer_val = timeout;
+	}
+
 	wdog->timeout = timeout;
 
 	return 0;
@@ -332,6 +349,8 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 
 	superio_select(data->sio->addr, W83627HF_LD_WDT);
 	timeleft = superio_inb(data->sio->addr, data->reg->timeout);
+	if (data->minute_mode)
+		timeleft *= 60;
 	superio_exit(data->sio->addr, data->sio->cfg_leave);
 
 	return timeleft;
@@ -504,7 +523,7 @@ static int wdt_probe(struct platform_device *pdev)
 	wdd->ops = &wdt_ops;
 	wdd->timeout = WATCHDOG_TIMEOUT;
 	wdd->min_timeout = 1;
-	wdd->max_timeout = 255;
+	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
 
 	switch (chip) {
 	case nct6102:
@@ -526,10 +545,27 @@ static int wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(wdd, nowayout);
 	watchdog_stop_on_reboot(wdd);
 
+	wdt_set_timeout(wdd, wdd->timeout);
+
 	ret = w83627hf_init(wdd, chip);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to initialize watchdog\n");
 
+	if (data->early_timer_val) {
+		if (early_disable) {
+			dev_warn(dev, "Stopping previously enabled watchdog until userland kicks in\n");
+			ret = wdt_stop(wdd);
+		} else {
+			dev_info(dev, "Watchdog already running. Resetting timeout to %d sec\n",
+				 wdd->timeout);
+			ret = wdt_start(wdd);
+			set_bit(WDOG_HW_RUNNING, &wdd->status);
+		}
+
+		if (ret)
+			return ret;
+	}
+
 	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register watchdog\n");

-- 
2.56.0

