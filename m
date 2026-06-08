Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88F3E7BB0
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949398; cv=none; b=o4xhTAxIWWwKxU2MFKqK2isXS1f/pzyHTFhNmpCotVh2e+2FgGKxYhscj8BQrnncI8yfeu2cgsvdxKl25AJwxxK4vrgYjyLmBwHgqjce3iGngSsMfp6cLaaS1bMGiusPKFUMqe3hmZqeQkrhBLMGZERY1r2IUL8IV2rVZQ6MFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949398; c=relaxed/simple;
	bh=louR7FGrIJjSfJWVx0mXfpfHnnBnvP7COW3dXLPkNp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbW9zc4yzzhEsbhj2C+4VW8I885VKviCf+4eeZgt9+ifRYK/iNF5dAhTHlaiHMgubYmZXcfr+Y435/qsC0uxLup9eFQ9Zc7sNFI0KTJr9m6SOs6ulMFAwn2lkDMH3yGjPL3KdO7tAQGU7fuygxtyLampE8dcfhJ6w+uFidwk/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPMVvuiM; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPMVvuiM"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7e8833c99fcso54612157b3.3
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780949396; x=1781554196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcanDgo3AUrD75pAr7Q6B0AchjycHv4iLbSmE1inK6Q=;
        b=UPMVvuiMMcIWvFf5+jkHY7VQjk3ClsNe909HUlI15IYNyd/BVZyqvOaIAC/aYB7rKw
         s+uVn3hotlXa3r+gc/RpdxEZLw829RDcntCwNbMvcJ9LOgINsjuYTGjmsnDJYlhzzJdT
         5O+OA6CQLBAKs7BEIL9OYLysPIgjuy74r3n5SNBPcMZHFzBsbVqLaSXbXGDK3xgcmLfX
         IspbcCnTKEb0s+Mbxx7y+3V8Hpe2JzvPzZ87IdLtJp1v5YKihw27Dtc6Zcj2a7wwbN5M
         zjpurJWgCntPZ6qWdLcMaO0ta2E69hsAvm+GVEQv9C+bsIKHZcBXKRR7mMo6Z9CpJmOK
         k/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949396; x=1781554196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcanDgo3AUrD75pAr7Q6B0AchjycHv4iLbSmE1inK6Q=;
        b=d8Ch9GJKMgKylUCE9giloWc80UX2zjxQ4w86Iv7nUwWerjZiBn9umtNEYPM8Dqsnvw
         F8ke7qZ3s1SnSfurae6Sg3O2r0inxycYQd9IdOzIxlcQnxjwMxQx6Kd2J6mNwHU4euCN
         AhigXVoZjRVvLg2EH11maqWphs6c89gUc3g5NHT4xNYAGcKwthrLsZKy6oeUHKekWlAS
         ii1OPr+LB9rvXPxHWv9T/qM4x7onTJaF0cfUVCk4OVSIrC0ijs8yX7/9M0aCbCuaeiyi
         Q6b+sN8aKMCJMvZcrl9JrUJOFHyJoqe1jx9052aPR2VPk7DA3qRWJIc5imfDYv79ON82
         geag==
X-Gm-Message-State: AOJu0YxY5LEyL1w+fNmRzYUloaEj6Y6jtGemq3uKGpqiQxJodX2spLLu
	/nJ2QH254dkzFhnZURC7osE4fV5qYSrZOd/Yq2ju4v7tesqNOYnLAkfKm5xTcQHr
X-Gm-Gg: Acq92OHuVGYLWJ8bHqiyXicYjZbS92BdzZQq+ZYgM67XTnkAcEkx5qZum48B3NTOiEj
	+xD/6eIV2GmXJhgYdMkB8LHhY2naICv1WKpJHnVUHMHfEB1GLY5w838+tGVCAYUIRRyguCO585z
	WlhcqR3EY1lSIkRCupuZethiMJ6nrMZfNbYZ0vE36AKUEvm1rGhKxOogmh0BDWSH5qs5vGctGKh
	+VN6yz6t0Se0s+GXBHWxrwFpcSJW+3R9Mgm7Olro38ajBXxDZewUoijkBVfzZ+n5HyAyc92OF8J
	yZHJ4v7hpHFdD5BwOeSOR4ZWtbomJPq82ZyDXEZEptp7+4AcX0/T1zbfDUW3Yv2VdQnzxby9/w8
	nRueGK7Pg9JKytDCI+K69X3T0NdeDTpSl8ziODPsqCDwbVqAupaZ5Yrv9129+Vk4FimtnwOvXz3
	bgcRKQGUTAQSxgXdA5uMKUIcTB7WNxUhngDrIJvfuoZY+5AFCgYd8/QxLAr2DHhYhZOkA0+4t7n
	KhbWQaxac3P1V5Te4SbwGfKN2tyncI1qE0W8RkYeFutvQ==
X-Received: by 2002:a05:690c:350a:b0:7e9:ab56:3c4e with SMTP id 00721157ae682-7ed0d5bfcf5mr147641987b3.18.1780949396178;
        Mon, 08 Jun 2026 13:09:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea986bsm88688987b3.9.2026.06.08.13.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:09:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 3/3] watchdog: sama5d4: fix NULL deref in irq handler
Date: Mon,  8 Jun 2026 13:09:33 -0700
Message-ID: <20260608200933.18669-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608200933.18669-1-rosenp@gmail.com>
References: <20260608200933.18669-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move platform_set_drvdata() before devm_request_irq() so that the
interrupt handler can safely dereference the driver data via
platform_get_drvdata().  An interrupt on the shared System IRQ line
(SAM9X60/SAM9X7) could fire between request_irq and the late
platform_set_drvdata() call, causing the handler to dereference NULL.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 2536e2f2ab32..7cd6f35c8e21 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -268,6 +268,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 						: AT91_WDT_WDDIS;
 
 	watchdog_set_drvdata(wdd, wdt);
+	platform_set_drvdata(pdev, wdt);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -319,8 +320,6 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, wdt);
-
 	dev_info(dev, "initialized (timeout = %d sec, nowayout = %d)\n",
 		 wdd->timeout, nowayout);
 
-- 
2.54.0

