Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9626B0A9
	for <linux-watchdog@vger.kernel.org>; Tue, 16 Jun 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623519; cv=none; b=iX109ysmw7+UkWiW1/f/rn1SnuAT79S5UFr/pZFxAIIK6KWnrh2+xQ7D0zE6+YTVNtYSSt2Z0+qc8RZYIo9mwWIoThwycUss+CoFYUBUDMqHyU6SNcVmpgSySgifxNr0/kW2o4mBXIoxpS+EYr23sHqwMpN/dH/Obu6KfSxbmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623519; c=relaxed/simple;
	bh=8Do0/Gmhw6ltI9mpVBm/qlIPlAc9kV/2B7BnKQhmBas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ntnPGSCWz2GXv4C7p0XJH1dHhezipEHiIQ7IxNVU54FxcPVyuwIqv5bC/qI4MIQ0Lr1m1JTHqYQHtAlbzWvUhHPAtWUd79MHG8nVs5ZiOFf4La0OEpikBvgMdiIeJyfQgD0LQVjVnrprK1J8TXkszlAV3doABn9B5mzcJxKL9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Vl0G/Fzu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Vl0G/Fzu"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so3494059f8f.0
        for <linux-watchdog@vger.kernel.org>; Tue, 16 Jun 2026 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781623517; x=1782228317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wP/c0gNpqY5LNcbKDFRKj9Q6nBUrqhFWzOWi/LSGp7M=;
        b=Vl0G/FzuehVtzrbzaIMy7FGgN3ek8KyVBNxCC5axnnuf77TY/TyBrLE92OGzG5aGCT
         10YEpI1VH6xmtZWqpCS+8ClKlibbQWJsfpTxsjKVla0Y0uTeV6A31lct0WlhaIonGlOf
         5feJzVBSXSsC3Uu+6R+15Hsgpo5sDkdrhYVoWrE0dvh42ytf4vkmZYnL5+V26ZQPpGgy
         /jZqDdOEM7MSTQnS3V9ULcuBjPPm+IEBTiTflDzKvQ3ES1BvehTL61mFOMPnwfQ2hskT
         fVDWTfyZ5uVOJ603UhudZMDYYnIiF9akj6jgDx6VlqsnZeh+axlBgUMsV/RTTPys+Nf5
         Bo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623517; x=1782228317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP/c0gNpqY5LNcbKDFRKj9Q6nBUrqhFWzOWi/LSGp7M=;
        b=OnJT2OFoJlAEdVmITJhOqCGWM3t4H9mtHV0mM6M2/wie1Nit5DIFCCS9VEWbPnqWaK
         IgovUo01LMejvwlxu3F0aVwcj+dylJXbfroZF+YMiunJCSSEsbijG4lN9uh0br1+vHEH
         XCiG0T01mhXjKcXjnP04Q1JcwMVz81cRbtDTM5w8R1W5xE8NrVK8HLt4kLMljGHF+xWU
         JXi5JESpXjiJjaEMYTWnRiELmydgbHxTkv+qIeQTS4Vjr1rTk5aIgE70mR2NK0s9NL3Y
         88QWnvmilzwKGzxVPggbv+Vg8sLIyKlWGPDxsGyKPX0+Z6aQBjv5O0umqGAG+M4CX3Dq
         1Btw==
X-Forwarded-Encrypted: i=1; AFNElJ/xw/m/JsnmNhXLuh5fmkI1AajjDm/PwySwiLwr9AYFm1DtzVWIDeC6nFQ1m8G/u9oq2Hk3tEaFz/hGyMvrlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Cutm6C8Dcd/7n9NCNrfpf79Ys+y4qrD6ioj+LrFpU5gs/aNY
	Z37s0+r3cOODRigD7w3mTrrn2V1ZQkpekXE/gKeOIPshreaPU0ycr0Kz1LAws22dA+Q=
X-Gm-Gg: Acq92OHZ6sdE9n9Q/TZPSgQP0VX74hEYY1aP3bujYAQ/7WUmEbn1U/tqjxAldYVLHph
	sr6MyubJIxvU1mCSmSWwIJA2j4+PA7WLxoOxjBAguKnVY7iHfTaNFd6lSw3fQ3GsSdiXmyGdQEX
	nj1UUM7vKM8HL3nGk/Fotiepn+Muli3/vDiaAVswDzmCT8RyQzaOg3vT8bGFV+cZHhhtzScsdz7
	exZSoMCqd4XVcXSkTeemAimjRXjm2gELaD27Uku8Q7sCW6RZjjdtq5yKYaTHZ+Dsegg3G1SdszI
	Og+DI8gaEHNjZY1t8DMKXzqF6cx6/tD4qO+tGwhxHLA0A8jtcZBc/JhTPp6Ae0kyCUMiCpi5haP
	etHqRsOlAqyNfMVARRLGxdHgz3U4hu4RV0ByKXrKuL5aRkYhkOIKER8CPxtJS0jsKi4QnG4jOBs
	dpa2oPrWJPv7mp0oWBcpExOP/pBOzEnEofjgZMBiWyV8qRZVPq5CRo2CJR5GenJWfBC1QHg2A6+
	U24s4FKWoZ7igA=
X-Received: by 2002:a05:6000:2210:b0:45e:ee20:b897 with SMTP id ffacd0b85a97d-46074a87ca2mr23613397f8f.6.1781623516607;
        Tue, 16 Jun 2026 08:25:16 -0700 (PDT)
Received: from localhost (p200300f65f47db04ed78e379f226b032.dip0.t-ipconnect.de. [2003:f6:5f47:db04:ed78:e379:f226:b032])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4620b3ed0d2sm1816788f8f.22.2026.06.16.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:25:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Lukasz Majczak <lma@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] watchdog: Use named initializers for platform_device_id arrays
Date: Tue, 16 Jun 2026 17:25:10 +0200
Message-ID:  <22bc09d0c9c8dfe75a205b0a9ccc98ccfba1de10.1781622532.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3508; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8Do0/Gmhw6ltI9mpVBm/qlIPlAc9kV/2B7BnKQhmBas=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqMWrWWE0nZRp4GqdbQXe4aP4fME3UWtjjcmwvO 8WKqbamVhqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajFq1gAKCRCPgPtYfRL+ Tv38B/9T700anrvQRxS1B18P2WEvmz9ayzQirez2YoCgbiAkQckIoPGISOelfxOqYiNLLmTcArX GrVLYvSpkdnxRrwVcZTYM/bmRpSacgTsM9yzlSczdb+zeJaPfMWuMhZbKRAJbpFBh5rvfJSNjv9 ZbxN3R1fYMPQTg/nZSFpeu7F7jOAGyjV9krX0DFClTYlnP0DEa4cJIvIrlQ42AMBFs2hrt1ptx9 2zQOE/LSObjBDsQSaCpJDgGe1bt7HsenggHr18bS/LNLLac90VMLeeYz90lFRma9HAq7JKMy+Qq xjYuTPaNWVkBPWqKLNiSv6x82xz1WEHq7T1Q+uWEKV7RZLJn
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct platform_device_id replacing .driver_data by an anonymous union.

For one driver drop the unused assignment to .driver_data instead.

While touching these arrays unify spacing and usage of commas.

There is no effect on the compiled arrays.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this is similar in spirit as the i2c patches merged during the current
merge window:

c574bdb52409 ("watchdog: ziirave_wdt: Use named initializers for struct i2c_device_id")
54c726fbb533 ("watchdog: sc1200: Drop unused assignment of pnp_device_id driver data")

but for platform_device_id.

Best regards
Uwe

 drivers/watchdog/cros_ec_wdt.c  |  4 ++--
 drivers/watchdog/max63xx_wdt.c  | 14 +++++++-------
 drivers/watchdog/max77620_wdt.c |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/cros_ec_wdt.c b/drivers/watchdog/cros_ec_wdt.c
index 9ffe7f505645..180784e92f2f 100644
--- a/drivers/watchdog/cros_ec_wdt.c
+++ b/drivers/watchdog/cros_ec_wdt.c
@@ -179,8 +179,8 @@ static int __maybe_unused cros_ec_wdt_resume(struct platform_device *pdev)
 }
 
 static const struct platform_device_id cros_ec_wdt_id[] = {
-	{ DRV_NAME, 0 },
-	{}
+	{ .name = DRV_NAME },
+	{ }
 };
 
 static struct platform_driver cros_ec_wdt_driver = {
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 21935f9620e4..a9db6118fdfa 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -246,13 +246,13 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id max63xx_id_table[] = {
-	{ "max6369_wdt", (kernel_ulong_t)max6369_table, },
-	{ "max6370_wdt", (kernel_ulong_t)max6369_table, },
-	{ "max6371_wdt", (kernel_ulong_t)max6371_table, },
-	{ "max6372_wdt", (kernel_ulong_t)max6371_table, },
-	{ "max6373_wdt", (kernel_ulong_t)max6373_table, },
-	{ "max6374_wdt", (kernel_ulong_t)max6373_table, },
-	{ },
+	{ .name = "max6369_wdt", .driver_data = (kernel_ulong_t)max6369_table },
+	{ .name = "max6370_wdt", .driver_data = (kernel_ulong_t)max6369_table },
+	{ .name = "max6371_wdt", .driver_data = (kernel_ulong_t)max6371_table },
+	{ .name = "max6372_wdt", .driver_data = (kernel_ulong_t)max6371_table },
+	{ .name = "max6373_wdt", .driver_data = (kernel_ulong_t)max6373_table },
+	{ .name = "max6374_wdt", .driver_data = (kernel_ulong_t)max6373_table },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, max63xx_id_table);
 
diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index d3ced783a5f4..5fa891818e8d 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -236,9 +236,9 @@ static int max77620_wdt_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id max77620_wdt_devtype[] = {
-	{ "max77620-watchdog", (kernel_ulong_t)&max77620_wdt_data },
-	{ "max77714-watchdog", (kernel_ulong_t)&max77714_wdt_data },
-	{ },
+	{ .name = "max77620-watchdog", .driver_data = (kernel_ulong_t)&max77620_wdt_data },
+	{ .name = "max77714-watchdog", .driver_data = (kernel_ulong_t)&max77714_wdt_data },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, max77620_wdt_devtype);
 

base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
-- 
2.47.3

