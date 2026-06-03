Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F72D94A0
	for <linux-watchdog@vger.kernel.org>; Wed,  3 Jun 2026 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448872; cv=none; b=CuCPhoZoSUtmOK6BLlCZiOBGSSnIB0Kb50GUWHrIIW9pWP3UX9LETvN2PlruPL/00Tfv83e0ut8WmT4vmPLCutO9QiO73Y7WwnmZze3qKPgPy5oNk1YsLOLPOvOCh+kYopiJMQM3Cc0KVxwbXk8sNPZ5QbvHw02BKdxapH7VBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448872; c=relaxed/simple;
	bh=jDrNY7qqpefAynj+fbrrtFDytYZBB9Nln9W+goFTlQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN5tUQ3RV1BL6iJHQofZ/o4AQx28U/yctafo+bi1dS9GwQxBkgjylNisrDKBImtIOJnYKuBAh4fMkq/K2/BElgznHv1/mAqB3p9nQHqIPhbTejRb6gwUERrzAhK/vQOYYTx5v3dSy6dtKxBTwboM01lUuCHh0RFJi5urExvd490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECm/tfwu; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECm/tfwu"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5177b9a02bdso2203451cf.1
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Jun 2026 18:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448870; x=1781053670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMCZ3kwt54+wBckEugkgYH3+Oq9j8RKzLnXGdNOFnIY=;
        b=ECm/tfwuS+00T0YZRg8/sX4rA1kY9pTodpawKKNgDbLG+TSAgFGp5ot8yhEK6A0XuM
         kXbZD9yLumJQn8P2dHTgRKhYXOuImC8j9dmPPnNzOFnp9T4/9ukfs1eY1rZ9r/KpHV2t
         q7PyFUw5t+NrjdvQFWVfsjGpJZNv4CXuDHSdIcni1u3drD385FceIku7RjejWQPDZsTp
         tvmFGOl11Awkad/qmEIp0wS+yyPZi1aA/upQQEKvpP3FkhGySD7F4HRCadCJRfprU2f9
         wg3Vi5gy9Q4CFVcIDUL5vAS6zLEjfyy9ah2vuW9t4LGbQrwzx1z6peSLxJrkr9JwWrHo
         INOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448870; x=1781053670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMCZ3kwt54+wBckEugkgYH3+Oq9j8RKzLnXGdNOFnIY=;
        b=XZc5Oqp7i9UB+ywTZp8pzvXNXhG4ekURW2LAg/kWK+XejvtZIPX/MCvsoOpF52UUA1
         eplnzPnrLRTsARv5YfZYMTn7QCg2p3UX+RhM3zaU4c4yW2IhghNTO4qh1r4+Os7rRijy
         UEKmPh3ffDxwexjFNtMGiQiYO+P1B9cyXGTbna+NAzoLN1hdzWSi+3Zm59edwIFaK+SR
         rieicSCqqRnGxzHclAt97NJ3xSF7oLjJUXmsSw870mEJdqlLqEUz+2yJf2X7oht5liOs
         aavLcCzFueeXAmbxGBomoCNF8nmmcy1ylpg1PGCwpJB8/0245hoyVuS6HHc6IqXywUAl
         yBwg==
X-Gm-Message-State: AOJu0Ywl7B8x4GPsFlgmeCPomiw1R04OJBmQAXEZVEKVtEHWKwJtHrBu
	HjR61C5gqyayuyOi1CSrawO4cDvpNmVlgLStdtNb2wgrF+Ua+66pFvPDtKDvdodX
X-Gm-Gg: Acq92OG+b7VkJQOw6gEqHcAgR258VA8bhF8hLfjQkNDE0baI2l9jhFXNxS3T3SpsUHo
	Gq+tTd5j6R6pSpHWT31nB22B/pnkuj2dd7VmfZtKjb3Um67v7gFlrSdV74PGxT9w0L1f9oc02wb
	KqWU/5yIGdkn5jYbGCLc+SLVmC1tHqRK25KEbgnj1xp6oOvvkOPaV/HIZwJCVVjRX8qOCRPbHoa
	91CU9/wj0GLsJOXRpm9Rk49BKiNM+VXpjg9cNw8JfcFAQgGvmkl4a2/2Fco1Nzg6eQ99EQKb4M7
	oHit8KiVrfqAdeMBwmscRz2uvzcVaP4dGdQx/OUoD323ZUrQneLUkjmcWMjMxcZKSTwEvdXG2ZN
	e8cqjo/4PM0hqfQSYrExrvHuaRoeLwt+4iUaq2I252/KSNYSeAG2RnMfcZeIebARbFx0/eYgRMr
	NCPEAlD7t04zksjz+evnDk2W5G22dtWZWSfLmFlfvzj1dbM/aYdIXuRfvs54kstuEaRBJhJUaCP
	3qtCBIfa1ZpyqJSZqCVr3vPsDqaxlXAl/0WipCYvUsuhPZ7R0jCbQ8o
X-Received: by 2002:ac8:5dd0:0:b0:517:6665:2a9a with SMTP id d75a77b69052e-517787bf3d1mr23491841cf.50.1780448869820;
        Tue, 02 Jun 2026 18:07:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b9d5sm7037416d6.44.2026.06.02.18.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:07:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] watchdog/sama5d4: set platform driver data before requesting IRQ
Date: Tue,  2 Jun 2026 18:07:31 -0700
Message-ID: <20260603010731.230581-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sama5d4_wdt_probe() requests a shared IRQ before calling
platform_set_drvdata().  Because the IRQ is shared, the handler
(sama5d4_wdt_irq_handler) can fire immediately, at which point
platform_get_drvdata() returns NULL and the subsequent dereference
of wdt->sam9x60_support causes a NULL pointer crash.

Move platform_set_drvdata() to the beginning of probe, right after
watchdog_set_drvdata(), so the handler always sees valid driver data.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index e82b91513fa8..024300299b57 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -267,6 +267,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 						: AT91_WDT_WDDIS;
 
 	watchdog_set_drvdata(wdd, wdt);
+	platform_set_drvdata(pdev, wdt);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -315,8 +316,6 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, wdt);
-
 	dev_info(dev, "initialized (timeout = %d sec, nowayout = %d)\n",
 		 wdd->timeout, nowayout);
 
-- 
2.54.0

