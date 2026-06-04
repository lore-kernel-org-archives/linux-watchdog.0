Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BCA239085
	for <linux-watchdog@vger.kernel.org>; Thu,  4 Jun 2026 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535165; cv=none; b=HbPdbRpSkgM9dm9KWCmEvayGa8bH2YU0vowl/c+8fsc7p1x4PoELHUsM8IJHqgQpAp2KXG7So4X9rbX4LJSIQIP9xfHA5a3TVYLjJHaBkzrCIIuZ3UP0lO/RG+sSRjO8c8sAFL0VqGC602qMnLJ/nnzduTjdE687FQWT58LZNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535165; c=relaxed/simple;
	bh=1BVO5B6F+e++fyfcPkmh/wUWvp5N0OWIqOa+1VW5ETE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj4cepS/Nmqfy/spoDRBqJcOnWT12iJPDbrMRL7y3HDdCOpMDUOeMP34uEtwz944HaSC9aFjCR04e2WJqeQsIYD8URSCClJpuwDsZVX4oy2KJYNt/3f9VnwXzttpnrB9P7krv2KXbPkd81kTfgiGMXU4W6pAu4ZDfYzFr4hQxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPArYICa; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPArYICa"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so64574a91.1
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Jun 2026 18:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780535164; x=1781139964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9gEJWImTswB6lvU2PvICsMgm37R+YYrTrc943vxPQA=;
        b=LPArYICa3memQ4pC5GLZvFvEkmZe/fWt3+hZ9rFVUsxQ1Sag1MFoc+zMN11hxJ49QR
         zUEm0UjBc94Wp/Ra4CA6xn2JbzBetr7D9hbMDL9kzZlCm1pKLwZkPr6xlSD2p4GDp8t3
         YpNRodnrNvZofdjiihP1+/42bAKjPmWdKkKf+1jAPY+IPgcRsPsYghc0h3dzvgY4ZGwO
         ZF4a7Tix2E3P135SqsyACzXMTvrVQ/8cfOXn+hkvJxWibg1WOu0WsZmzQbYUSOFM8701
         kNi4QCI8Z/zSwp34dlmBGAMGJOtQXqES9+QD02xykx7sbLiZSGrujg7VYQ/VWNMlq8Py
         4tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780535164; x=1781139964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9gEJWImTswB6lvU2PvICsMgm37R+YYrTrc943vxPQA=;
        b=Sagvv6gz/rrJDkhBaL7Z6scNRrrQeCBtArA5MUqh62b/PAU15BJH9nanxWq7tHzeZc
         1E91i1jSPdcVJ/DQDdgZcmXoSpfMCUbHazI5kRS8eEoCypnfrsDef10uoU4B9sXfbH9f
         1oF7S6yYUl/Rw6HPpLfqJ+VQX5Oti11Nhr+WdPWUmBUbFW3hPrBRIg8kqZcViQJCiah8
         0MVk9Tn83keYDMhi3Oan867csUgBFju2cb5TeV8el8FNYnnvblYtAJT5LYiUe5Eqrx8y
         z5eIyixJBtl5AxKTpVhUpeeQ/iBbUXnkFPuv2q6sAEvACvh8saRloEtXwTyNUTeMMlfF
         G/dQ==
X-Gm-Message-State: AOJu0YyhF6TzNEwHRbUILHfQQddXjVLvFjh+7GD0Rt5XWyXGh08WfYE5
	93j0Na0duHMczP048AjMHG7udj2GJOdJl947cNrTvn4nbHR60yt6aGfQFQquRyFr
X-Gm-Gg: Acq92OGnLyJEyHEtwgvDq0zcAacSEgjy+VxLM8XRxEbSd6W7istY28sOeIsm9EEPXr/
	7IER2Neop+ZAUZh75bAQ/HhuEAJpk3OQ7niHLOmjUdVVlTjvytpi//RNwWNCI530S8mPR+FAa1x
	VnR4xIlgllqfbuvX3OrmLOjaNNCPgztO6QqeVNBnafDwNo5BJO6BZ9o4/icV802X8jdB+I2hnyc
	zxU5YI0XMzt9zpl3G3tmMvHUF6mUt8yd4ca2FReJ7R8GVDrtaE5S60RIi560aQZDkLH6WsZUvmV
	cSIur/U9hK51ApUBtkTD786/2h/WQlovqp8TKib9twIDQVIT2KuRZ//X7GcpDwf10Z5i8Co0/Ex
	sD3FB3bheeGQnEltjxskHObZH8m8WsrBYPi+s6V4+wMImkep9NMdJZn4A+4Opiq1tF8n7a1qxq2
	SGDgvrLgBJku3LyGaFoLStjQJeYMVzD26BHRpTk1GpQSP2+B/0+kxU1x1GqYXcSNZd822vBdxSg
	hjg62Kaz3tzU3m4EObdOu3vws1zOgQAFNCXIEDW6JtDIg==
X-Received: by 2002:a17:90b:3b49:b0:35b:9894:f6f9 with SMTP id 98e67ed59e1d1-36e3228676emr5020525a91.18.1780535163699;
        Wed, 03 Jun 2026 18:06:03 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e6d169abdsm2366747a91.0.2026.06.03.18.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 18:06:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] watchdog: sama5d4: use platform_get_irq_optional()
Date: Wed,  3 Jun 2026 18:05:42 -0700
Message-ID: <20260604010542.23177-3-rosenp@gmail.com>
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

irq_of_parse_and_map() requires irq_dispose_mapping() on failure. Don't
bother with it as platform_get_irq_optional() doesn't need it.

Also handle EPROBE_DEFER.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index b7a8cfed335d..030029d50257 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/watchdog.h>
@@ -245,7 +244,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	struct watchdog_device *wdd;
 	struct sama5d4_wdt *wdt;
 	void __iomem *regs;
-	u32 irq = 0;
+	int irq = 0;
 	u32 reg;
 	int ret;
 
@@ -281,8 +280,11 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		return ret;
 
 	if (wdt->need_irq) {
-		irq = irq_of_parse_and_map(dev->of_node, 0);
-		if (!irq) {
+		irq = platform_get_irq_optional(pdev, 0);
+		if (irq == -EPROBE_DEFER)
+			return irq;
+
+		if (irq < 0) {
 			dev_warn(dev, "failed to get IRQ from DT\n");
 			wdt->need_irq = false;
 		}
-- 
2.54.0

