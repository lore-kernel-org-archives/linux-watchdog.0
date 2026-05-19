Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EE3B19AB
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226970; cv=none; b=GWwBvRo5jq2vru8ygpPuNPYRZSz+shoK0CAltRHAl6L/hNzSQbryMK1PDBufCix9C4oTejCaj0tJO2vxf4Vk2bIg2yCONvgVujFTNxUZPjM1iPUg7hpUj8Dd9gXsOqEA0jq2k9YaKf7RSmjTglRQUeFR16oLinVVfS9aclTnfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226970; c=relaxed/simple;
	bh=jKwoE7f+xHe2S/MA/4bEMucF7i7ljZauBbGXmqNgQUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3TaSd0ybjMcGcX1pfTKOB04GxWREitEd8ji5KSUMaKr6sQHEF3vIbg+EZTOpXwHSDMiU3clw0DII4cJlnSWmeRxDmzNH9Rp6KUAwdJTGN/BYvU8Iqq4JSVnc91wySqIzvV4NH7UXhiRnSybvn7Mb4m82PeCi00BlHu9UIu3gYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4ekO/0f; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4ekO/0f"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8173b2af32so3175485a12.0
        for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779226968; x=1779831768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KjYbSsnMBe85tT0ffPvsrkv+L06erhUlByiTI/tkbP8=;
        b=e4ekO/0fJDRc+eh3DlzFR/fpn/T6xeC4P40hik+71o9fu4WnefM7NMOva1eB7tBGtP
         47J9y2sWeGscvNniHIHGVPMDvpWp2w5SCWTMMLb6rfWO+Pl0V5oJroAWT8GP20o6JjyD
         hCFeFmXSAERvBGk/Gc2Af/TKp17/RFpugNLIkuxZfwUUAbALHl15c/93H3OCdsuBwDRb
         I0vYqVgbJv/Ej3U26eV9TjcDHV8Jhain48ybDGw5vVWgFpa959Lr1mYh52/pA8t48n5M
         URVHEpy36hGB92RmfhuUd6XO+ernwC4rxkGF0kxqdr9QqLib0rJqNlxFpPPV0LqDQQFy
         Kb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779226968; x=1779831768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjYbSsnMBe85tT0ffPvsrkv+L06erhUlByiTI/tkbP8=;
        b=PVLyB7qrstSQJXR/FOBSh9s0HC8acC8p/qnzkTcQ60ClaPz+xREOfLWx6MB84m0mde
         kRYL/apFzNU6ik3LDruRHX7qqM0M79rk6xB9RXcHb/PmfANbR4wSAmydqfOctqvh9X/t
         hWbs8E5MscZmtVsh6UL6CwGmjPEgK39izXvaV9DOYsGXYyjnrKE0vNIoTa6YxJyJI6WC
         96Y7Nvd3RNKpta79da06QbEQxRIZLoJRto/fgmGKMrj29jfCWgoWvrWZ4XcUCgihMazp
         lderi8vYc8MvglG1tXDovyxLRBoVFgOgDsQ10ncPgbtQYAK8qc0+jefuZ9G0NR3XSSEe
         SUHg==
X-Gm-Message-State: AOJu0Yzo+bKjx5UKjFasqB7bv2sFmRaQsVDqoxAJBD5bR152t7FLdHzn
	f3ZcPpW86xFGoLXdyD6/y8/FFIEQCR27fzojxmKkxyUhPlde4cjFMlYtfi3doUPs
X-Gm-Gg: Acq92OGvK0DtfnaCDfYxIeDXYe79nhYCctCt3PdffcBbORrDbnJ+XUKavL1hr72Ovyd
	ylc4Her6Ii9787wUERz1g4wQLhIGtT8WqFaedDIbVApDIsMP9Uaf3+qgQPJjyUm7jH+VTo+LQrK
	MBMYxl9bWGNqQsCWpLoIyw1zYu2DVRlLjZJMmACYexYrZZidJMB3dvou2x9K4NaFt/n3MqQ5IGq
	k905EkdKcQ+RClEtfrR0eZ07/O7whm46LapFPNT3Mge0Mh/g4IShBcRJarSPKsNVXXhTYcr0TLn
	epYJMobk3xdkHv8Ji50Nrg8n73vyWiXHcRHrt+K5h1f5+n/ptIAHeVP3d5/hzf6dAvdr5tGbxOF
	qBv2m5A4ufQSZmdr8FnPE6nDHggFyS9NE8CKeunHQmCJYkDjM62o/cmsl6sovdeSw/6yup7cPwk
	Y12Xac9JhoMZNzR7+QgJCp4v/4FkcvEmJ17zkvLDYaWuPGglfeyX1rBiJwr9vK4urD51MB1SdFu
	nX+0fLxQxuOvefpSJFPQEO5jTa8tAjGXHo=
X-Received: by 2002:a05:6a20:e293:b0:39b:9644:6e94 with SMTP id adf61e73a8af0-3b22e7b13a6mr23601286637.9.1779226967594;
        Tue, 19 May 2026 14:42:47 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb121cd6sm17601292a12.30.2026.05.19.14.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:42:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] watchdog: orion_wdt: Use devm APIs for clock and watchdog management
Date: Tue, 19 May 2026 14:42:29 -0700
Message-ID: <20260519214229.16656-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace clk_get/clk_prepare_enable/clk_put with devm_clk_get_enabled
and devm_clk_get_optional_enabled so the clock lifecycle is managed
automatically. Switch to devm_watchdog_register_device to eliminate
the manual remove callback and the disable_clk error path.

Switching to devm in these functions is fine as the proper
platform_device is passed in.

Assisted-by: Claude:Sonnet-4.6
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/orion_wdt.c | 64 +++++++-----------------------------
 1 file changed, 12 insertions(+), 52 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index a92701ff2653..85e9877de952 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -80,14 +80,9 @@ static int orion_wdt_clock_init(struct platform_device *pdev,
 {
 	int ret;
 
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
-	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		clk_put(dev->clk);
-		return ret;
-	}
 
 	dev->clk_rate = clk_get_rate(dev->clk);
 	return 0;
@@ -98,14 +93,9 @@ static int armada370_wdt_clock_init(struct platform_device *pdev,
 {
 	int ret;
 
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
-	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		clk_put(dev->clk);
-		return ret;
-	}
 
 	/* Setup watchdog input clock */
 	atomic_io_modify(dev->reg + TIMER_CTRL,
@@ -121,14 +111,11 @@ static int armada375_wdt_clock_init(struct platform_device *pdev,
 {
 	int ret;
 
-	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
-	if (!IS_ERR(dev->clk)) {
-		ret = clk_prepare_enable(dev->clk);
-		if (ret) {
-			clk_put(dev->clk);
-			return ret;
-		}
+	dev->clk = devm_clk_get_optional_enabled(&pdev->dev, "fixed");
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
 
+	if (dev->clk) {
 		atomic_io_modify(dev->reg + TIMER_CTRL,
 				WDT_AXP_FIXED_ENABLE_BIT,
 				WDT_AXP_FIXED_ENABLE_BIT);
@@ -138,16 +125,10 @@ static int armada375_wdt_clock_init(struct platform_device *pdev,
 	}
 
 	/* Mandatory fallback for proper devicetree backward compatibility */
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 
-	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		clk_put(dev->clk);
-		return ret;
-	}
-
 	atomic_io_modify(dev->reg + TIMER_CTRL,
 			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT),
 			WDT_A370_RATIO_MASK(WDT_A370_RATIO_SHIFT));
@@ -162,14 +143,9 @@ static int armadaxp_wdt_clock_init(struct platform_device *pdev,
 	int ret;
 	u32 val;
 
-	dev->clk = of_clk_get_by_name(pdev->dev.of_node, "fixed");
+	dev->clk = devm_clk_get_enabled(&pdev->dev, "fixed");
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
-	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		clk_put(dev->clk);
-		return ret;
-	}
 
 	/* Fix the wdt and timer1 clock frequency to 25MHz */
 	val = WDT_AXP_FIXED_ENABLE_BIT | TIMER1_FIXED_ENABLE_BIT;
@@ -612,7 +588,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 				       pdev->name, dev);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to request IRQ\n");
-			goto disable_clk;
+			return ret;
 		}
 	}
 
@@ -624,34 +600,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
 				       0, pdev->name, dev);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to request IRQ\n");
-			goto disable_clk;
+			return ret;
 		}
 	}
 
 
 	watchdog_set_nowayout(&dev->wdt, nowayout);
-	ret = watchdog_register_device(&dev->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &dev->wdt);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	pr_info("Initial timeout %d sec%s\n",
 		dev->wdt.timeout, nowayout ? ", nowayout" : "");
 	return 0;
-
-disable_clk:
-	clk_disable_unprepare(dev->clk);
-	clk_put(dev->clk);
-	return ret;
-}
-
-static void orion_wdt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdt_dev = platform_get_drvdata(pdev);
-	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
-
-	watchdog_unregister_device(wdt_dev);
-	clk_disable_unprepare(dev->clk);
-	clk_put(dev->clk);
 }
 
 static void orion_wdt_shutdown(struct platform_device *pdev)
@@ -662,7 +623,6 @@ static void orion_wdt_shutdown(struct platform_device *pdev)
 
 static struct platform_driver orion_wdt_driver = {
 	.probe		= orion_wdt_probe,
-	.remove		= orion_wdt_remove,
 	.shutdown	= orion_wdt_shutdown,
 	.driver		= {
 		.name	= "orion_wdt",
-- 
2.54.0

