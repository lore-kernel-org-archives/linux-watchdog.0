Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08521A434
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779587463; cv=none; b=tDff6T0s5eVvbi5zVbTphuLR93ksZNn7Npg1U4SEr83n0XKjaw1yBb8IPtHaMxxH7U0gp1VWETRKTuq5xGx2j5RxQqWW9zJJIEoeQNJ0sg/Ae9Hwb4r1ujWqcDSAsfj8C1s3GDYC0uX3LnDuZ3QEYKv3AYvSq7sGKnCds09ERrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779587463; c=relaxed/simple;
	bh=hIc/byYoMdLJAGzfsxGwujOA4zlDwtIfi1dIFR6AzRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4ih6wlITRQTN2E0aZef59WpOqJ/nW1X2g1T1S/UDj8uKXVOSMYNG/xESWVHpaRAYzhI1ZkA40D0stN/CjGE9zvxHTS/DMhIPG1H+QJpiI4oAEi7wz1rHhQsojAZST6lsvIBmmA6Cnee0So2neiMulze7m+ztDAUT3+Q1V2l2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/QT/Tbb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/QT/Tbb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2be75f658f3so37559185ad.1
        for <linux-watchdog@vger.kernel.org>; Sat, 23 May 2026 18:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779587462; x=1780192262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wenMRhfkixVC5M9rbX7j7cv58qZfwInWcDqwBH9WT8=;
        b=q/QT/TbbpWWyDD3hi4lLUclrHBNYGAeb+jlF8gzyLP81qFC06XXZasMmb+QhSWRkxi
         +fXKbyl/6hoo2AzuVLD29u6pq+0tLtL4uX2W8D1wbXm2YpcoR+/WAGYuWMPn9YPxdmfW
         5qy3ETAfSWxxfXvL17NrrR6EMada3yoywCdTxTNvc+h4JuYRuYoKrgNsiCC6ye+mHTCO
         MQ8rffFOnXLdKS5j1x5sjnzzz/qYGPvZjIeHEb96LQ+eppiax4ojaHD2tPU8aNCe8DpE
         ++9yvvvqImrsL3JcS+kI322n3g+uwxruCcVsS2KnS0iRwenZ+x7vqWNGNGokI5LzcOXn
         lUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779587462; x=1780192262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wenMRhfkixVC5M9rbX7j7cv58qZfwInWcDqwBH9WT8=;
        b=nl7Fw0xFiTm0TeKa1wSOL4VzsAo0XcQ6S8Hqi0VCLYfWqPel6Tj+Fy9O7rMf6rEnEx
         X8ZZd0Ucr4q4gBvnOmHkIXzLm6wW09q5vRROV4YrDDwV1xQ9wlsROwxTfe+N9s4cFbgU
         WzjPldBLDZS3Fe+wL59rJM2o0ebUz1h/+MpRAd3HpRXqhZFsgE8H0GFfh3vNBtbEkcCK
         U6Ywb54h9mj3TcGBZRROVIdaqfZUjPeNPXUNzCOYg70PS+7pVgNMB42nWLLWqJMJKMuq
         kVJXFdKzYxJXwoXCLFkToJ1aZzb6VkaU5vsBmB12cuPa1WDSkhA4WLGv6eMhNwnKBWtE
         ghAQ==
X-Gm-Message-State: AOJu0YzenJWJBvbRXFXm+g34/5J98gjOD1LugZBgx9VfhLTBCF0gAPjp
	p5CPNxn+4UjQyu9g3hatx8+pWmqZ9yFbGDeciDLBM6bAvSU6u/DGKnfmXsbz6Q==
X-Gm-Gg: Acq92OHJCsdZUI3QcfW//oanbGI3FtyRjrQn/HY2D7GJVWr3fTuNxlcK7uKo/O1mXq5
	qR2lZsYO1WUTozri3i1cjt1oyW1JqB247H0Ryh+y4ehnR1Bk38JSMTMeU/SJFZcuPs01jQeZtyf
	BCvw6m/hKvPqju5/wkBMVAya8xudpi6JVnS7TNmn4zB3+rc8mQ/XI3ZJl9YOmsnblW+8BHcr+xv
	34QZI+RGs3IWHi2dOeF9jdKqSL/v8rnWJYRTFzwRzbjSyWfMXDw1UNWc9x1pa1ai3VW5hh4LV+L
	PLJUUwEcIBAWkat9K5TTF/9HA9hhshPU5yA3FQDF5wN3MYDRJ9ZkmxTpNR9e3VZR6QwUoYOHJAo
	4kTGxKWYTTpXprUYjUmIC79D36h89mTPERwyHRAi++BGY+goeeWXT+VwGl7sc+U+wJ0vNye0gOI
	ujmMQPEEd9UnTSiJVdLtvk+Tw0y9SrMA2DnqEkO9YFGcL17HeWcXiUljX2WsWxRVxERaCApcWsB
	eh7Op9tm/TgYy6hry9y2dUZUypa/D3cOq8=
X-Received: by 2002:a17:902:e74f:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2beb07da2dcmr93544305ad.36.1779587461647;
        Sat, 23 May 2026 18:51:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm54822965ad.58.2026.05.23.18.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 18:51:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 1/2] watchdog: ath79_wdt: select OF and COMPILE_TEST
Date: Sat, 23 May 2026 18:50:41 -0700
Message-ID: <20260524015042.175271-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524015042.175271-1-rosenp@gmail.com>
References: <20260524015042.175271-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has always been an OF driver. Depend on OF in Kconfig.

Add COMPILE_TEST for all platforms, not just ARM.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/Kconfig     | 3 ++-
 drivers/watchdog/ath79_wdt.c | 4 +---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08cb8612d41f..8319c503319a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1785,7 +1785,8 @@ config M54xx_WATCHDOG

 config ATH79_WDT
 	tristate "Atheros AR71XX/AR724X/AR913X hardware watchdog"
-	depends on ATH79 || (ARM && COMPILE_TEST)
+	depends on ATH79 || COMPILE_TEST
+	depends on OF
 	help
 	  Hardware driver for the built-in watchdog timer on the Atheros
 	  AR71XX/AR724X/AR913X SoCs.
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 7df703e9852a..409a40b14901 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -295,13 +295,11 @@ static void ath79_wdt_shutdown(struct platform_device *pdev)
 	ath79_wdt_disable();
 }

-#ifdef CONFIG_OF
 static const struct of_device_id ath79_wdt_match[] = {
 	{ .compatible = "qca,ar7130-wdt" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ath79_wdt_match);
-#endif

 static struct platform_driver ath79_wdt_driver = {
 	.probe		= ath79_wdt_probe,
@@ -309,7 +307,7 @@ static struct platform_driver ath79_wdt_driver = {
 	.shutdown	= ath79_wdt_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
-		.of_match_table = of_match_ptr(ath79_wdt_match),
+		.of_match_table = ath79_wdt_match,
 	},
 };

--
2.54.0

