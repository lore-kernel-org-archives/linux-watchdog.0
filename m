Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483959;
	b=1eGHMBQLzrFCcD3MJxKHJUKkaJQwpk2a9ss9srYzFuGjoOneEURKLcS3k2eV2xD4EA1n
	 wULFwmEY4kaCXWlvm+sj5vfm+Po6SMmjtXkUhpke2aBJ2oIeQ2BJPu2+xkgmQT9gfV+zL
	 NycDVYLmKL44xAfODyDtQvJptVu0244/KencKWSGp1xBvOoVYrlF2AE8z+xP7AWkWYoRg
	 hbJvWppBNFKvKEp0pLLGI0PxiI6pnM1LdqmhKTrBPSfYHPkJuq7fW2mo6kWvNeXFIZoOb
	 +JxDjNF2KDuEv7Dy6rht4+Xd9xN4HY4nORfr5rnZnrKG99mhJqM+cZqimOA9thWFd0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483959;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=280qSqeSbTwCI3ZQbFfi/lhC965nrpU0MRF0T3Gfoaw=;
	b=B3PojWbWjnbZxNhjmiX28ZO1w+ipRLhf8QAVt8S1rV1OOBWPx/WJZt3oto8SwgtLALvm
	 7SJchfO9huFPtDfaqErRgraGaC+LUhwdR/wzKUQ9iAEeFI0iAxtrUghz7mBGi9Nyo4Nf+
	 4PYcmyg12OOsiS0Y7nP7mrJ6VOdE4eilhOX10KZgxv2Rg0usiYR4MySXfn1Otblhgz3JI
	 MtZ7tZ686J1j5XwU+Tx35N6V5gknRJle8layOu2CPG2VaSoLewLewbWwQtydC95LNDmPn
	 l00AmtvTUy/2xEvxtM1wwOQoMbXiuKvV8T371K/CZQm8ygYLkOGz+TL4wV3ZqwQQkfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EYLO6rZn;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA72606A328;
	Tue, 20 Oct 2026 08:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BA72606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EYLO6rZn
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E3EAC1A12A3;
	Tue, 20 Oct 2026 08:12:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B20B660393;
	Tue, 20 Oct 2026 08:12:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D510A10328D80;
	Tue, 20 Oct 2026 10:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792483957; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=280qSqeSbTwCI3ZQbFfi/lhC965nrpU0MRF0T3Gfoaw=;
	b=EYLO6rZny8j8y29bzdXIBS9wx3rFVhPZQ9h+NEMXuMvy7xTPNPFmHwkzdjfpDdoUo/HcBK
	Bvx2S20mVHOAY6rUAbv3dgaOc7WyQDB1TUs62GqPiEJqEqfsAF/jONYYPu2VN5JCRcYMme
	oYQqc/hXaxxQzVBgos+pqr83StAifa4pNddAIXfu8vY7ckqh1FfzU6rnEt4IjuS8aPSkU6
	MakoDWk9hapwu11moYV1ozMokhKmBuNXKzjQ1b4nr7o+iqsuSejAYpksLaWfhYjQu5iyfg
	yeTR2unVGYPfvn8APwahYNH8Fg+3j/vJ81CAf/Rlelna//q9yQ9hgClmc0axBA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 20 Oct 2026 10:11:58 +0200
Subject: [PATCH v5 5/5] watchdog: w83627hf_wdt: Add minute mode counting
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
Message-Id: <20261020-w83627hf_wdt-improvements-v5-5-90b226684fc7@bootlin.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483947; l=5711;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=v3v52jKJvRU4ASFHzp3ayX9EZQnxz/JS0PZb/nsB/bg=;
 b=YHp3DAcTwRSTJN61AF5HnVkNFm4uBQbA9ea60Nv+rgqOPmCIY1vIjIcBj0SRTVJ1IPHjQsVcW
 Ir1LWE50/OgCvftsmFe1QjGc6Trl94iyt+T3OFkckJ77kuVyyyuciuq
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
index 3d6f35e79631..c45d5b9b97b7 100644
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

