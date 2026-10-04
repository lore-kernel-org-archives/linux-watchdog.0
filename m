Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814A43E08C
	for <linux-watchdog@vger.kernel.org>; Sun,  4 Oct 2026 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116003; cv=none; b=lofInzANp/dcstVEC+xIAkyKnT/ym9wTjvziqWqVcg32MzGnoW4p3JK9hFCwN/pBouX544TYGfRTU/049qgwD0ttXM47sGlJafxFU5Fy1tYxrO9vLf5xTT48sCMw3hSvLcKhV6IP0tJ+qmu2jNX4yqx9rzNCNMGDvme330lktA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116003; c=relaxed/simple;
	bh=Ph44fWpNnPg1q9mR/Sz6hwAlreDOn3nWHp7pwC8+4bY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZlX42R82EGlP56s4GuzZt1KNL7f79jMHyGNAvs9YUWsbPZrjdyk93Mc/AGYRU26phq4cytslXsyLl47IG9l4AQaNSErFANOn1NqdTiwD3rNKL0dcOoBe17MhkPNwpwUlvuGCvux4QL1uz7MadmoXGjI/y/mtd4JM5yart8sAiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PHiD8TfS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PHiD8TfS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 59B374E4115C
	for <linux-watchdog@vger.kernel.org>; Sun,  4 Oct 2026 12:13:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F2C0604FE;
	Sun,  4 Oct 2026 12:13:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3BEE10328384;
	Sun,  4 Oct 2026 14:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791115999; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CCHanrAvXnwrCW0kvSPsvZwe7oX8vovWU42J0DG2CRY=;
	b=PHiD8TfSWhBF2w6dGlfiTVlvalyYhyVhRye2b7jo5YwLmadDhf/VKWaVEFmqxr7M7mioip
	rJ9U7SgEpTp5BqkLMxz02jiTgJf04CDeCIOLFuFezQAmhMytt9nlJk5Wd7iapHAkLU4zbC
	7HnPsQ8Tq2zk3xrhoqEUIguhpxdEy2EuinAAkaiOfAliUUV0bEvlpTTzFkp+zvlAbZOVQS
	G182D46sqJzkMR7JBetRGqaZUgRGy29hE2m6Y5c9K0apwlFNmrjiQsSxe/gkkeU/x6Lv9z
	G/AN91+ii1CitarR7GFWoVJVnD1rjnY3h5VgAWCcb5BgdjOdtnWLkpOo3yyiOQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sun, 04 Oct 2026 14:12:53 +0200
Subject: [PATCH v3 5/6] watchdog: w83627hf_wdt: Add minute mode counting
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-w83627hf_wdt-improvements-v3-5-8e27b518595e@bootlin.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791115992; l=5729;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=Ph44fWpNnPg1q9mR/Sz6hwAlreDOn3nWHp7pwC8+4bY=;
 b=aBj8kZbJTkj/eLgW2ES/TjHrslAhfXHG6n08BV5hS1N3jZJCW8vMqxZMXW9nQ0JDDrALEeUMd
 yqnadKUwtHBD6ikIm6byxwlXk4xO+9ciGS/aFwWq69nzxB0PNdKpM4c
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

All of the chips supported by the driver can be set to minute mode,
allowing timeout value up to 255 minutes.
Add it to the driver.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 70 +++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 1ef7b61d7e55..1aba9efa27fe 100644
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
 	int sioaddr;
 	int siocfg_enter;
 	int siocfg_leave;
+	bool minute_mode;
+	u8 early_timer_val;
+	u8 timer_val;
 };
 
 static void superio_outb(int base, int reg, int val)
@@ -258,22 +263,11 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 		break;
 	}
 
-	t = superio_inb(data->sioaddr, data->reg.timeout);
-	if (t != 0) {
-		if (early_disable) {
-			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
-			superio_outb(data->sioaddr, data->reg.timeout, 0);
-		} else {
-			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
-				wdog->timeout);
-			superio_outb(data->sioaddr, data->reg.timeout, wdog->timeout);
-			set_bit(WDOG_HW_RUNNING, &wdog->status);
-		}
-	}
+	data->early_timer_val = superio_inb(data->sioaddr, data->reg.timeout);
 
-	/* set second mode & disable keyboard reset turning off watchdog */
+	/* disable keyboard reset turning off watchdog */
 	t = superio_inb(data->sioaddr, data->reg.control) &
-	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
+	    ~WDT_CTRL_RISING_EDGE_KBD_RESET;
 	superio_outb(data->sioaddr, data->reg.control, t);
 
 	t = superio_inb(data->sioaddr, data->reg.csr);
@@ -292,6 +286,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 {
 	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
+	unsigned char ctrl;
 	int ret;
 
 	ret = superio_enter(data->sioaddr, data->siocfg_enter);
@@ -299,6 +294,15 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 		return ret;
 
 	superio_select(data->sioaddr, W83627HF_LD_WDT);
+
+	ctrl = superio_inb(data->sioaddr, data->reg.control);
+
+	if (data->minute_mode)
+		ctrl |= WDT_CTRL_MINUTE_MODE;
+	else
+		ctrl &= ~WDT_CTRL_MINUTE_MODE;
+
+	superio_outb(data->sioaddr, data->reg.control, ctrl);
 	superio_outb(data->sioaddr, data->reg.timeout, timeout);
 	superio_exit(data->sioaddr, data->siocfg_leave);
 
@@ -307,7 +311,9 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 
 static int wdt_start(struct watchdog_device *wdog)
 {
-	return wdt_set_time(wdog, wdog->timeout);
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
+
+	return wdt_set_time(wdog, data->timer_val);
 }
 
 static int wdt_stop(struct watchdog_device *wdog)
@@ -317,6 +323,17 @@ static int wdt_stop(struct watchdog_device *wdog)
 
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
@@ -334,6 +351,8 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 
 	superio_select(data->sioaddr, W83627HF_LD_WDT);
 	timeleft = superio_inb(data->sioaddr, data->reg.timeout);
+	if (data->minute_mode)
+		timeleft *= 60;
 	superio_exit(data->sioaddr, data->siocfg_leave);
 
 	return timeleft;
@@ -487,7 +506,7 @@ static int wdt_probe(struct platform_device *pdev)
 	wdd->ops = &wdt_ops;
 	wdd->timeout = WATCHDOG_TIMEOUT;
 	wdd->min_timeout = 1;
-	wdd->max_timeout = 255;
+	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
 
 	data->sioaddr = pdata->sioaddr;
 	data->siocfg_enter = pdata->siocfg_enter;
@@ -512,10 +531,27 @@ static int wdt_probe(struct platform_device *pdev)
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
 		return ret;

-- 
2.55.0

