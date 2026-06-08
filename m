Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD503E6DDB
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949395; cv=none; b=c7IVvW1A4fwRm0aAP2RX14sghsR3GBVpISu7cNaNKEsztj7snqg+HbiNKvSzrG4KKqM0vLkJcXXcRLqQAnR10lw72E48xWPustNCyPFfQe7SaGEbodE0TYS20crAu6wrBzZprkZby8/tc4fU35qTE9qJJC0anycTUIlscB2b29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949395; c=relaxed/simple;
	bh=hI8ofeME6QsuFmkBnr6+xLOjmpEZdZfLcwmX1PKaR90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFnjlM0EBUMActrHErh6HnnJxFiQf3uLj4KoEAmRwj3djrYf0fOS7CltQ1aKjM6cWpZLQ1pDvTMaBfrwtucb8KINeR5BAU15VL0KmUdxhfSmLmNyP5+Ncsjy5DujKBq6q4b7Ipz8TE+GjcGIVUjB5RMUyUISGAYTH5Z3HQFiuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0qZPsi7; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0qZPsi7"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7ea16f090b4so61157517b3.2
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 13:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780949393; x=1781554193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOc8M9GQ2VJe92KZSwyY8Mbp47Jr3fn4y/WOydvK80w=;
        b=p0qZPsi7D/gGESURtejlcBRhJE4BkAg+B0Q3ewBXk9pzhOkvHwLNCFKmr0xY1Koq/P
         JWav27oYtaw6w9De25FXH6Gri/o0+r+RKni52fYYcfKmfJ8+iOiNWFN4m1IrZh4Z/dwS
         f1bgmjwfVKEdx8eteVdnFXwpqgyXZ3Rz70NVUjzYH7m6uWOhso+4tLcBUlKQJZyC8BVc
         XmhPgno66CN+qoLyF9VJjSJNiSVTTUGtkrJWqLIzD7WAJJwFcOihIkO4d9AScOjpPbTK
         1fH83zXKuZTYHKt+z9BWBqaIEkiAsTMl5e4/7889hH5TMeN3/x++Ps/Gl/IMniE8IFav
         nAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949393; x=1781554193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOc8M9GQ2VJe92KZSwyY8Mbp47Jr3fn4y/WOydvK80w=;
        b=FNsVK3pn2yR2oyAiL3QJT9AHOfbjYfZ9oWDWKP8uSXFLFk0Aceh0jqR/pv/+4HYrC9
         opnUlpVByn+et5wjoQlcSIQ1QFwBQQt1YIzTa2u7Y0B5p+vHEZo05P+hufxM5j53RcKw
         PxfxG7i9z6mAbbAF93hDqRE6D2IyB6KoSW3R/VA8ZEzWvjs4UFJglVPEHK8gW64A4LVR
         E0350lx5BPI/692H8Ed6SbwnSTUwWfDwnQnxzwTUvLaReZ8uRQEOnooTB6X9fj1OC9Uj
         eGJjhSJUKW18DJWYNY3X/qKATiI8E4beW0DiNvdHeNcK+IZczcwxhT9VNRKc+Hi7sLRF
         xR+w==
X-Gm-Message-State: AOJu0Ywu3+e7Zjq9NbD44uF5K4PnQWiZ7BZxC3b+dod0y/oJZ1Z5Jch2
	YHNEQ2m7lIq4jTRmTyr++jyJnoUrDYdcCXc8wOl3zDoarQhdVufggibmnboV63hM
X-Gm-Gg: Acq92OG0ebVyys8i9Lv9bAO1BG5ZPYFmsR0MoUbDoWlvjmfyHQQuV+kKZN2OjLLTxEY
	3MK60A99rR83AHwuMt5KM3IYjH6ioNEix40vIj5W1fCfCyvCjQekNI3vZ+ZrGtoW9as7Qbozf3j
	znawOgFwavWX6GVBd94SjcXchmgwuWsd2JXaZEAswDTwggZwuH/DPeKGBscaZN5n9ibCmA/N8Vw
	tuQ8xErYIRf1MJNZqzpoeOLSF6c/fpa0Buhp4KKT7bcQ8NlJTFGenBj3LIUua6xygD/iHZ7WN3R
	NbdDgzxSFdUuP05vr3i6J35+2D6X72QuJX9v8kidol0OGy5dOU6aUlwxNGuJ2bzhOdS9zT+AUZB
	quV4XJUF+/TTM3AKwzLNcxrBgNCKqEOaEfX9O0FOsQVW6jwg8Ox5x4gE+P4UPXh7bC+n4PJlhg1
	XOmjKg5/3Nbz/eCj1zKHha0T5ipw+vsZhkm5HaMv2zGiE4lU+D+tP7RyN1azQUlB1wmE4it+yqW
	aij7T1dGaw9ssYcgAAF9gVu83xQqB5uGVuhMCnmCDMKYA==
X-Received: by 2002:a05:690c:3583:b0:7b3:b0a6:2c4a with SMTP id 00721157ae682-7ed0d1da632mr167209037b3.23.1780949392565;
        Mon, 08 Jun 2026 13:09:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea986bsm88688987b3.9.2026.06.08.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:09:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 1/3] watchdog: sama5d4: fix shared IRQ and hardcoded timeout issues
Date: Mon,  8 Jun 2026 13:09:31 -0700
Message-ID: <20260608200933.18669-2-rosenp@gmail.com>
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

Fix three pre-existing issues in the sama5d4 watchdog driver:

1. Unsafe IRQF_SHARED | IRQF_NO_SUSPEND combination: The watchdog
   interrupt is a dedicated peripheral line, not shared with other
   devices.

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
 drivers/watchdog/sama5d4_wdt.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 704b786cc2ec..f74f1e8956b5 100644
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

