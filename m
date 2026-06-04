Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DF223DCE
	for <linux-watchdog@vger.kernel.org>; Thu,  4 Jun 2026 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535164; cv=none; b=HPlSmKNOqnlKTXw/lOQBKLAI2PoIXWhe6vbfbsPvWOa823kosi1cQGaKdOTV9+eloBuOTaP6mUmlQluASP2y0uMmc6h8osq5l11tStFQB8CK6o09GUXc/3nIJRUQXUzqPTbtSUt2DFqsrnWhKTEAymVJz1UGtARG7ludW+asvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535164; c=relaxed/simple;
	bh=vcT4NW81m8XsoLMhxNoDk1/yerEMrmMNVMicm6D6waA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSz7qLvx+v4rZaTKKeFapJZEk0YsEKmfi6FAYYFgHqL8PQJduOe/DhYNY8sA6EM/hkbWOVax8akqjGfRpSWWplI6R5it1z96QUAIN6A7lsRBgZuz/5VN/rhV0fSEorMM8KNBScmLgXAaElA7lA/MD0nqwMByD/I9AUdiJLUG/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGHSEUNv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGHSEUNv"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so90631a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Jun 2026 18:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780535162; x=1781139962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/BQtNunbqSxrovheX7WXW6K0SrGGYRahvXKwiLXth4=;
        b=ZGHSEUNv3xHRKro0yNcdjES2kdnVSW5/KGXvwx0N5sKWEUaycUtpA/XuC+ZJsCp9q0
         HYT0TGmEPPVkznVm/ylvKpQrv/7d9+xp4A1PXfuYTTKeAlmlqo4lhq99JlA97WS9lIXN
         qtccJUy+/khI+1IbwFhH9SLUi+kWQChwpRBpmKs7hREPbbZGvbhmff8nxKV2Pjvwt11u
         J2rL6KRVdixwDfQA2pftFFH7zbLVjA6AhwZ7xI8MivI1efol8vrwisbvTj9QQGT/P9q3
         dg2sFbQRygZVthpBo+jKkKhbh1DIGmHO5Y5gSh/mwPZ0RDBULmZsgYUZjXDDH7j01au3
         226w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780535162; x=1781139962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/BQtNunbqSxrovheX7WXW6K0SrGGYRahvXKwiLXth4=;
        b=pEyUk9YkS15Bno+ECqothZh+m8XGo1Tqa7lR9VQ9o16pshvzI1rAwM880fhls6GEkz
         O5rmA9TJsycQdZSQ94RNdErveOab5uAlIg3g6x9Q8hvzFqnyv3TLCH8ejihh+VFJ18Yw
         75a0Z2o8TI0Hcqjq/ZPAxYDAu0sPpJyZVkFyXX4MR49Au4nrAbcPHv8gg3v23jl2WWWk
         WLJOFKnxsd9XcOheoaloqTO7HaJp6FRyXtSfawwVBDvQ5mi/DVeef/GCZnG1EPwnI1ry
         +F743CcW0b/SKM8NIkZ7fhbOYVTa40XpZebq7TKrMUQLLstRq2QEbRWW5QkPJJJqpym1
         5EVw==
X-Gm-Message-State: AOJu0YxTzUe+c2uCOqeM1gqtMeQp8RbIh2OfiVNpfm1ag4B6Yp+IqueV
	RlVG2DIiGw5Jot2uY62Mv8u4m1Oi691/jh9FbwePSaddtScEzYrbejKa4EFsdGX8
X-Gm-Gg: Acq92OHkPrv+taef+dCissUG7/kit2nZy74r6QciXQRezhEZFojHsM9n7IONpF5G1w5
	aRH68qvU3t1EU8iLW0KB+xL/y4IknrEHliaNk0SndzcWKBSVFHrIiQCAKfm9O3rCYQ850sfXL+x
	3HPKektejYL3bTY/VO8glTMXf82/srN3k40FjSimVwNm+ZmYx1kebblY8YfRclxvC5EBaC9T+q4
	vAfUtsIi7bZDBQ3WMh+5zZ120ZYYUV+/qjomvLK75z6DK8UXi6r6PHLEhX3O+MUPWiheYWCRSYK
	nYrGWw9gkPTEVPe3Yr4BKpn/rrSMC+I1D7oK/sBIU97MTCkUYW/8yEF+dE8Tta3tk48pUDtYbcr
	v5xFxuLBadNER0wiulp2GcMVGTCxaUtRS/i87zkVBxKAB51iN+MlBa+H6Ya3mVMGSfMqqI4qPXc
	2JS9poelZv9s8bP6TtnWQhIurHzRQkP9lw3zbaVDksMuczoDPxoPklmETuLJOOVOXHa93Sbp194
	PSerg+StbalhnU2p2bCcRikbc/qYuyBP1/j/EbIpopmtw==
X-Received: by 2002:a17:90b:4fcf:b0:36d:ae6a:22ed with SMTP id 98e67ed59e1d1-36e310ff0bdmr6115504a91.22.1780535162396;
        Wed, 03 Jun 2026 18:06:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e6d169abdsm2366747a91.0.2026.06.03.18.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 18:06:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] watchdog: sama5d4: fix shared IRQ and hardcoded timeout issues
Date: Wed,  3 Jun 2026 18:05:41 -0700
Message-ID: <20260604010542.23177-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604010542.23177-1-rosenp@gmail.com>
References: <20260604010542.23177-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three pre-existing issues in the sama5d4 watchdog driver:

1. Unsafe IRQF_SHARED | IRQF_NO_SUSPEND combination: The watchdog
   interrupt is a dedicated peripheral line, not shared with other
   devices.  Drop IRQF_SHARED to avoid the documented unsafe interaction
   where IRQF_NO_SUSPEND keeps the line enabled during suspend while
   other sharing devices may be powered down.

2. Unconditional IRQ_HANDLED on shared line: The handler returned
   IRQ_HANDLED even when the status register indicated no watchdog
   interrupt was pending.  Return IRQ_NONE in that case so the kernel
   can properly detect spurious interrupts on the line.

3. Hardcoded 16-second timeout: sama5d4_wdt_init() unconditionally
   used WDT_DEFAULT_TIMEOUT (16s) for the hardware timeout, ignoring
   any timeout configured via device tree (watchdog_init_timeout) or
   userspace.  Pass wdd->timeout to sama5d4_wdt_init() so the
   configured timeout is honored during probe and resume.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 704b786cc2ec..b7a8cfed335d 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -169,11 +169,12 @@ static irqreturn_t sama5d4_wdt_irq_handler(int irq, void *dev_id)
 	else
 		reg = wdt_read(wdt, AT91_WDT_SR);
 
-	if (reg) {
-		pr_crit("Atmel Watchdog Software Reset\n");
-		emergency_restart();
-		pr_crit("Reboot didn't succeed\n");
-	}
+	if (!reg)
+		return IRQ_NONE;
+
+	pr_crit("Atmel Watchdog Software Reset\n");
+	emergency_restart();
+	pr_crit("Reboot didn't succeed\n");
 
 	return IRQ_HANDLED;
 }
@@ -197,11 +198,11 @@ static int of_sama5d4_wdt_init(struct device_node *np, struct sama5d4_wdt *wdt)
 	return 0;
 }
 
-static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
+static int sama5d4_wdt_init(struct sama5d4_wdt *wdt, unsigned int timeout)
 {
 	u32 reg, val;
 
-	val = WDT_SEC2TICKS(WDT_DEFAULT_TIMEOUT);
+	val = WDT_SEC2TICKS(timeout);
 	/*
 	 * When booting and resuming, the bootloader may have changed the
 	 * watchdog configuration.
@@ -289,8 +290,8 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 
 	if (wdt->need_irq) {
 		ret = devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
-				       IRQF_SHARED | IRQF_IRQPOLL |
-				       IRQF_NO_SUSPEND, pdev->name, pdev);
+				       IRQF_IRQPOLL | IRQF_NO_SUSPEND,
+				       pdev->name, pdev);
 		if (ret) {
 			dev_err(dev, "cannot register interrupt handler\n");
 			return ret;
@@ -305,7 +306,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
-	ret = sama5d4_wdt_init(wdt);
+	ret = sama5d4_wdt_init(wdt, wdd->timeout);
 	if (ret)
 		return ret;
 
@@ -358,7 +359,7 @@ static int sama5d4_wdt_resume_early(struct device *dev)
 	 * This should only be done when the registers are lost on suspend but
 	 * there is no way to get this information right now.
 	 */
-	sama5d4_wdt_init(wdt);
+	sama5d4_wdt_init(wdt, wdt->wdd.timeout);
 
 	if (watchdog_active(&wdt->wdd))
 		sama5d4_wdt_start(&wdt->wdd);
-- 
2.54.0

