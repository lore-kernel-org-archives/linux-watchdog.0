Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701C38B7C4
	for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138616; cv=none; b=S/ilWjCaXqiM5lyy0ZqseMtlZFslvTZQZbuckJ8IZX1atsmb4q1dPMVgTFnTcLB2u++DgyWMCzJxaOXp3tgn/fDhQCDTXAcbLp0NjaMFIPJ4yGl2AIp79jcjk0Vxv9YxRfPL0ehUMa4/3rqHQtjfl9T0z0gJWPzbbBFdYEgO2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138616; c=relaxed/simple;
	bh=b7hZEdF9gGm5SUGjirtVoYQHtnJkko9xW3itleM/3Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGAJF1nQ/uf6g3XyRnwDYo+GzqxE4Obvppmf7wpS9Ztg2r284cGFwhIT3G/1Ey8wmdMlfz6RmswzIQD/lDrLTdwXrwswQkFxEeh+TR+HszJ6fpgAxTrPsKXpQq49fJPuyAN8y6/k38MBUYkzpI8YA3TSTLfrp8bE+72sjVx1s14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r99czIOy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r99czIOy"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c801b30188dso1270928a12.3
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779138615; x=1779743415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLbBePjPrv6qNDD1/f9ZKyQ/SjpAXnBSe6vKkphP87A=;
        b=r99czIOyve+HCGzT2HB1fxk3DnfPSZ919GMq+sdx7NGXBhaRPqDaLFEyX+w9CqYr1K
         HO9tCSV5IHT3M4IMIxccPOxdxMSs7dnSL0TUtqATDgZlRYMxFVEN82RpkPk0h64/qkmX
         0Oszo9WnmZgX7ATVe4k1rDL4ewx0c8t9EugfbkPGg+rwVMaRwnyFaUFeenDslKD1JXCy
         x21FTHi2QpLtDpckVQgIhk5p+nLJ4sYKuwLQkrpMc4Slpa0zOzNLIPpYU2l/qUGJPF1V
         u6SHXsZ7rlf3ra6bnZlFjWTbuhvuft5i6yx4Zarc0RSVsakKdJcNeF9eLAZt7RCq9H+x
         11Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779138615; x=1779743415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLbBePjPrv6qNDD1/f9ZKyQ/SjpAXnBSe6vKkphP87A=;
        b=CQN6bfzgbZyyjnexmaDz5Gjhajk7DE8K/4JnZ25rHkmrsjJb+8IN90nK3f12xAztHe
         TdeXwqcXM1DmTGPLaFtREB9FgCqsoJiSHRWRYtJ/Ilj6vG8xqfnMKw5x6d6YW3zSYFyl
         R2m7mz5AiIgKUjHzvsb/eM4X+idhAeGVRYrnml7OFo081tETlIQp3d47WOl8NuBldAFx
         SWybL76qEcY4b2agJcWRxUoEWWsS/x5vjfdK7qklpSAb9r13zuSz1trxGTF+wBiPpi28
         GHJtCtty4ZtulKcPjzZ0AWxYfHwZBa31x6us5qzICTP93hCwQWiVh0nh6s8H4VQbf8ez
         NEKg==
X-Gm-Message-State: AOJu0Yxx2o2Uxp0ab9WHkq3LYP+sKhozd5aeTkPTcb944j6H2Q3PsqMh
	xtKJkYaZTvQ0BaMosUyxmjTbStGbmAsblDsZq0fkQk0VluJwhxrFHn05t1W6GUnq
X-Gm-Gg: Acq92OGwomebI+3kwiyMo2BkMIp7QzEbqSs6LqlaLFSghiuD7OFjj9/mol7BnRAefqO
	blvkfbiX5ZNYqtrjsuIDD33/XIcnD18kR2apghw+rIbQfAEv5VuQdIZSokmnC83q//I8w62sr5A
	XpsoTR38qwS60HS2I+AN/kBERR5PGYgGN+oN1hkSYazoAA0lfKQttmASpA4TS9RU3HWD9RXbCzN
	8NbKGLTGX6jGsCtqH9EMOkk5yOAs14raIxNnjFqX5ADA0syWhfY2DHFn1///gU5177dRvLreMbf
	Kj7ejTZtrL/mFXSLq3+EitUjYwXjOzj00UMtOUsfwJU6+miA2X4qSI57aK56rAQwWqWop0dvGM2
	QNK+fisAkrIrxdoLqVFKr4xcZRwqoF8OMbhNrMN/qV4rxqnI0Avdb6ELWlFo9cB5+lrcG2T3HxM
	/BOIclqk1/2T8+OkXUDj7EqdLq7rgr/zxZP2NfBKYQ2fEaD+oZKgdxlbLy8YS5S12wU7Tgrjj30
	Dof5j5ZfC1vHQgRHZ7X4pLbHjkMr6F+Fj0=
X-Received: by 2002:a17:902:da90:b0:2ba:6ebe:4897 with SMTP id d9443c01a7336-2bd7e8ae0afmr194708835ad.3.1779138614785;
        Mon, 18 May 2026 14:10:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0f8efesm165637945ad.55.2026.05.18.14.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:10:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] watchdog: ath79_wdt: select OF and COMPILE_TEST
Date: Mon, 18 May 2026 14:09:57 -0700
Message-ID: <20260518210957.10545-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has always been an OF driver. Select OF in Kconfig.

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

