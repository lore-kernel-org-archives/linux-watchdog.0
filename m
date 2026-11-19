Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106943;
	b=ZtL2sf5Id3XO9T8QT++FNDEgfyRsjDmllg5kQOepeZGYkL+YwRmNAnONBxBzdW+sa6y3
	 ZUk7gnQR4mbnLfWFh/iyZT8Ti8rnmC6IPVJhsFqdDjJU7y1UR4NKPvp39AmUIYqYCA8UF
	 L//Z8/YUUXJGZvKywBvI/WQA/cP73moxOXvi2oji3PVGUL+x0wKUpHk2yIWjOufmkWG46
	 GPEQZf+1e/NXmLxVXXnKM1GKB3K0poyu7nCRxgrcQmqLccg1d9/ojxYlKssVE/4h08YHM
	 13oOEmuQUBZeEHEpRHQkTQDTWT4sdissFNfZazEG8bG81HGLlrJDe2MMxhJpADJxQWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZMPheRzDd1YHr1QUJ9JxTtEYcWTfkEtW99n5PgbERIY=;
	b=H9OwCogFgxz6x6GR5I02UiP8OeQ63HQ/+sYhBGETTPit1s6+ZZfsR7TwIlHHsBHsOWsi
	 sMjyofGCOHgpp2uSmqzVoWRctF1n9jCx0prkMHQ5SJdQHT6uo67846awC8h5YeS2TmTu5
	 g1e1DJErZzhffwXLi31ciJxpR5Vo6r0ifpRUliWIDor5pDgQTLuWuakAd6nuq1oKMzVI1
	 Tz02RJqdgY4j+9swvaNsMMIHlsZl1dwHDy/6mT6uv6Wb+ZsL9eyuPTyTtj8JOlu11/kFK
	 tEQ7eEbYUXFzM43j8muH/LhUvBifLDbhy4r9NE1tLynx8jjmA35sHpCGDFRoe9Z1IXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zVjme470;
	arc=none smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A4606A331
	for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 16:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C71A4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zVjme470
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bccecba199so2376743e87.1
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 08:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795106941; x=1795711741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZMPheRzDd1YHr1QUJ9JxTtEYcWTfkEtW99n5PgbERIY=;
        b=zVjme470Sv2ijY7fzWSAITq6EqG4nmv3ggBADUa/j0lVaUlRMfqrjX3OgwfEzSAWCF
         O/hevpXCgcxQffXlbrv+ubUtF/1tTtfjV76HoiKi+4tc7D0xLPAEcNquuesAzVYF2JDH
         LuuVCr/3khlqphgCT8pBTLfHQNTFlWAyl0tNYCrcJyXZp3I5dXgtv41XWn2B/Ir1xULL
         fNf1lAmK86Dm589yxim0NWb9flsXmWsNmK1cnCee3sPkeAbSN6h2ALy9Vd1Rn7UHq9UA
         W7Qd4xWbXWx815fkyqOPVW6WcCerMSW/wt1kzP+bcB9VAo4F21itd2ojFDFmpBHPpTPd
         v8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795106941; x=1795711741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMPheRzDd1YHr1QUJ9JxTtEYcWTfkEtW99n5PgbERIY=;
        b=07QsKotj7lMwWDDKi9S6JAVT+0R4mL/C8jGEEZ1oy2T0r2rZw/7y97VmPUFTNslc/g
         7gHa+N24vChu/2CwnRYp3/VVXXVdFh9H6waowRLrwzwpYFOTNdBklnTQWPTgHYlH1hBM
         LhdtNkSnqiQOQLgkP0jPRzn9sS27Lnj6DDtlu2KkJS9jkGEbx7WNiPq//pz9UKnuuSMN
         jHCyDYk9nz+28UgORe+sPcFAbNgCkwPpQKUEDWbdvh3Va6vih4p0gX6W/tKk8OlEBE21
         CNiVDHWT68MJMKufOOv2Jv3O7TtVCAdeJZcuFwGX/AKcMxHxY692AI6T9+uGZU0OGpOV
         VhiQ==
X-Gm-Message-State: APuU4Z9hW4sNoLdIVWEFUlT2VGsPcjgEVAMRDhfi1Cv2UQopfHbA5fI2
	fPvbTgc1GNGySKylF9rE4OuwTWo20U2U0RQ+rhFmgcqZenBNoRz6PgDr
X-Gm-Gg: AYBFou1hRE+CFFrS00hJo8JHZH6XdQQVEPbGM77AxtD4uaGcexyp17FDIZPikvWLhg4
	ULFB7WfKI0cZeAWIc0ZtwWr0aWANIkh18pexbho7Z3dvBAcvRkEIy9CbOgGpfrtwDUakUAAsdmp
	bFsO9xINE7FAH40du9c6TOYjisNTlYzxPMy2BfZP96VPIU2qYADk53zNTA3slQAbv4kCqp8Smn1
	H6oaPziSk8AlnFHeXeSLWUd+T1XQIWENmb8RYo4dnFf7cPYmqGiQK5jBH7CZ+aTCHa4hLy5HnUX
	aUCd/bdsOlcM9Swd5TpB4nmlinB/l8P1/SKp/2gM/v9sAkyeIeVqhrCNS5wzpsLzMtlrru6d7kR
	xxi9hbb95lM7dtxCwYr8gOR8V4f5upEIyvO6ZUQZzS9vvDXGhasPmSz8NpNI292o+cLO0CMNq9D
	ieCw4rPHoMvOxohUuB+nq+LB/hkn1/SJ7pMbTZnyLacE2h9FKmhHZxaudALw5zwdyWucHlIycDx
	r4QpLgRqxvnnpi3cfm5lgDGnk3TTlaqAx3OWaonyOi5fBQUnm7VlupXb6ufD/4yk82DPeMSEzlt
	L2ZPIj8emd+To2FJOK9WOmR65RJE/L8UwG+gj6t2wWzyowG8Ld5aJuVCXXmpVxGqQKMt4Qz5N4a
	rmh6lpKYz3WCCT8g8UhCePqZ3MQ==
X-Received: by 2002:ac2:4e07:0:b0:5c1:ad4b:4bc8 with SMTP id 2adb3069b0e04-5c1bc7da07emr107942e87.33.1795106940819;
        Thu, 19 Nov 2026 08:49:00 -0800 (PST)
Received: from localhost ([2a02:fe1:8175:9200:d77a:e280:1a11:2086])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1aa77ebecsm1705162e87.50.2026.11.19.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:49:00 -0800 (PST)
From: Sven Ulland <sven.ulland@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sven Ulland <sven.ulland@gmail.com>
Subject: [PATCH] watchdog: gpio: Keep GPIO level when taking over a running watchdog
Date: Thu, 19 Nov 2026 17:48:41 +0100
Message-ID: <20261119164841.1847870-1-sven.ulland@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a watchdog with the always-running property, the driver takes over
at probe: it requests a toggle GPIO as input, and gpio_wdt_start()
then drives it low and toggles it. These level changes happen within
microseconds, and a watchdog that needs hw-min-interval-ms resets the
system when pinged that fast, so taking over from the bootloader can
trigger a reset.

The Aruba AP-305 access point (Qualcomm IPQ4029) has an external
watchdog that resets the board when its GPIO is toggled every 6 ms or
faster. Even with hw-min-interval-ms set to 100 ms, 7 of 10 boots
started from the bootloader still reset within two seconds of the kernel
starting.

If the watchdog has both always-running and hw-min-interval-ms, request
the GPIO as is and keep its current level. The watchdog core then sends
the first ping once the minimum interval has passed. Other watchdogs are
unaffected.

Tested on the Aruba AP-305 with this change backported to Linux 6.18,
and 10 of 10 boots survived.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Sven Ulland <sven.ulland@gmail.com>
---
This applies on top of watchdog-next, as it depends on Florian's commit
2791c2bc6aca ("watchdog: gpio: Support watchdogs with a minimum
heartbeat interval").

 drivers/watchdog/gpio_wdt.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 1c79498db69e..4f4f9e9a7031 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -79,6 +79,20 @@ static int gpio_wdt_start(struct watchdog_device *wdd)
 	return gpio_wdt_ping(wdd);
 }
 
+/* Take over a running watchdog without changing the GPIO level */
+static int gpio_wdt_adopt(struct gpio_wdt_priv *priv)
+{
+	int level = gpiod_get_value_cansleep(priv->gpiod);
+
+	if (level < 0)
+		return level;
+
+	priv->state = level;
+	set_bit(WDOG_HW_RUNNING, &priv->wdd.status);
+
+	return gpiod_direction_output(priv->gpiod, priv->state);
+}
+
 static int gpio_wdt_stop(struct watchdog_device *wdd)
 {
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
@@ -112,6 +126,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	enum gpiod_flags gflags;
 	unsigned int hw_margin;
 	const char *algo;
+	bool adopt = false;
 	int ret;
 
 	priv = devm_kzalloc_obj(dev, *priv);
@@ -120,12 +135,17 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	priv->always_running = device_property_read_bool(dev, "always-running");
+
 	ret = device_property_read_string(dev, "hw_algo", &algo);
 	if (ret)
 		return ret;
 	if (!strcmp(algo, "toggle")) {
 		priv->hw_algo = HW_ALGO_TOGGLE;
-		gflags = GPIOD_IN;
+		/* Switching the GPIO to input could cause an edge */
+		adopt = priv->always_running &&
+			device_property_present(dev, "hw-min-interval-ms");
+		gflags = adopt ? GPIOD_ASIS : GPIOD_IN;
 	} else if (!strcmp(algo, "level")) {
 		priv->hw_algo = HW_ALGO_LEVEL;
 		gflags = GPIOD_OUT_LOW;
@@ -168,8 +188,6 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
-	priv->always_running = device_property_read_bool(dev, "always-running");
-
 	watchdog_set_drvdata(&priv->wdd, priv);
 
 	priv->wdd.info		= &gpio_wdt_ident;
@@ -184,8 +202,13 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 
 	watchdog_stop_on_reboot(&priv->wdd);
 
-	if (priv->always_running)
+	if (adopt) {
+		ret = gpio_wdt_adopt(priv);
+		if (ret)
+			return ret;
+	} else if (priv->always_running) {
 		gpio_wdt_start(&priv->wdd);
+	}
 
 	return devm_watchdog_register_device(dev, &priv->wdd);
 }

base-commit: 865c2d0f1dd3f0937865dd11819eeb59298a814c
-- 
2.43.0

