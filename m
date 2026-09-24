Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEC3B8405
	for <linux-watchdog@vger.kernel.org>; Thu, 24 Sep 2026 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219452; cv=none; b=OBEL15fqJBG7oloxDFPDXtAfnZMC+Si3riVtX34KfWciQ0pxbdlYI/6u2dlsUMas4WDMaC9x7ODO754zWia/mOsdVW8I9+fUcheD+scC3+Ww6YBwqF8l3qvmgLzB7dNYr4AiBstH788JZ/YN+gxdv8LGJrPI1mtpKkqokQ+AsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219452; c=relaxed/simple;
	bh=Wv/Q/eibR9/8UNWYWEXMi5HVbkom6Ngkl4aD5jL1RW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eZaFL2lL2mwdSmhfT0ipIouPKNYevIVCeqYt1EBe4Jr38PlLCCU2fjtdD4ti8938TwunszGTJ23zmj7NxtRP8x3v+lSp4UNlN8kDS0Ed7ZDCcP9Wz8pGE6Z+QnzP9jAac/y0lsKMJYjYMd/XgK9OcHYD5kFHz3BAqI6OsgBfqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMtTSHHa; arc=none smtp.client-ip=74.125.231.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMtTSHHa"
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-47bd4bcc3e2so740005fac.1
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219450; x=1790824250; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=weznhsdlOq6RIl6RLEBM2onzEOR0sehn1VqOBbe70/Q=;
        b=AMtTSHHanAtlihvBFZRy4nae8dcfP2WXjv4X5kKeD5YKBpWq8162AwR0UkZsLX11v+
         MCG/EpsKOOccoSvy71DmJU2UBK/0vyCS89W8nlEOmK3SyCdpCV9k6ydhoJaHdck263Bu
         pVpceuTwi1OJPxzN9FQ/5exlqjkESk3VUPXOnU0wNQAdr1Touf+bhZFzKNiNCDnSqalo
         vIg8VlgLixqgEr0scuvXOqCGgs7YETBm/Jlxe5jr6BEvaUO3MXKcCRR+TTvVK8Yot1Vb
         xo5BcjMtEzJtX5rLNmcDJsOcEy3ldKgcjYBH1Ify6zzPqIJE3Zty2WBvjI4j8ZLwvWM+
         scXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219450; x=1790824250;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=weznhsdlOq6RIl6RLEBM2onzEOR0sehn1VqOBbe70/Q=;
        b=yixddLxPRNUWzIVwD88dg2hVbJTYwMSVT9KROcQIF2FuTkE1q9QbykaeMsttDXlj2b
         ymFIpBDhsBOBUp3lDpDat94DzeIQ7zMQXMBfwCZAUF8OKoGkh0toLXpIV05JrPk/iUN2
         Q+8gMybpIVtgyhavyy3EL//Ast3u7/gnIabGs2zHHn992Vsh+712QZZm2Ae6jmrrRENk
         w9lOy3+akfz2oeLOXnOWFlqAy6ivXYvlFWBrAll49t0bm9jfxBXN37iK+OUdBXvmhhG3
         kWVBco4WaoAHI4a2uj3HapBXykSwag/jcieAaD808bSlG1O6MlH8rAplg6gCe5ZY9smV
         2oZg==
X-Gm-Message-State: AFuF++myHxyUBpScpOlyg1Sr4+hlGZdLEfdPzZzunGpVrbMtV7lPKi0F
	fXUwcBBiMp+dkkhl8bTM9bpQf5ep/ithuAPRWjFmOQY9FaYhbpAQzetG
X-Gm-Gg: AYBFou13/8E43nrpZN6DJg4B55UPvIyD6IlGEgXWgchByBBKPJHeUYcqDIAm5bRvhnX
	S9yTXjf6B/Bdl3XEO7oOsJiWLMNJsJ8CZGV0Gl0BFkTSHVdOKH3tM7SeIqm9dvegb1Zv9bSxV1J
	3jdzabBcUChTx2iCrnJhL/Yedc/W2p2bMMiTYSovPpgelTwmCp32NzWW3Y6SkzObn029W5uH6wM
	jvTrH8bO8GRAI8DlExnjtlT3jHZV1tjXGfNOBHdka4kyyxbR7IkeZxlCswGHpP3TQhTtiz1ZPuM
	5R2b90VbNi5KlU0BJmyfsKTyCECHK1istKHwsmHJBDQUpX8yvhzL//uveMmE3vQSPXaBzQhZnmS
	opZC+o4V+3jWEpGdBJJqf/Q7ILmZcInPARdoXqi2GIlA7G506RlUbBbotX9zVC8TismhMdqIx0y
	m5Ubji7qds85b7nFE4vtvskutfJ2DGu96UeJk706LDjKNiF7Y6Hp+YBlSfcL6Kbr0LGw==
X-Received: by 2002:a05:6808:c187:b0:4b9:e6ab:d07a with SMTP id 5614622812f47-4d72cb39b25mr1219299b6e.26.1790219449792;
        Wed, 23 Sep 2026 20:10:49 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c4bf8e14sm3893842b6e.14.2026.09.23.20.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:10:48 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 23 Sep 2026 22:10:41 -0500
Subject: [PATCH] watchdog: mediatek: Apply the driver's mode to a watchdog
 left running
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-rbrue-suez-upstreaming-mtk-wdt-dual-mode-v1-1-0970852315e4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQ6CMBBA0auQWTsJ1kipVzEsih1woi1kplUj4
 e42Lt/m/w2UhEnh0mwg9GLlJVUcDw3c7j7NhByqwbSma505oYxSCLXQF8uqWchHTjPG/MB3yBi
 Kf2JcAmFnzz3ZsbduclBzq9DEn//qOuz7D4S6ytZ6AAAA
X-Change-ID: 20260923-rbrue-suez-upstreaming-mtk-wdt-dual-mode-6758e7b879f9
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "freddy.hsin" <freddy.hsin@mediatek.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790219446; l=4049;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=Wv/Q/eibR9/8UNWYWEXMi5HVbkom6Ngkl4aD5jL1RW8=;
 b=u/GAfKCmgfS6yqJtSJBYgi0CdZm5MqDZ1SAsZGK9ZcrBpAZEMAT3l9eouuHXlc8qWODTBEB1Q
 XFRXWn46T0VArMVB7GfAKkxDnqc11EQrfVB1wPFyafDxWf9KgzaTvYJ
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

When the bootloader leaves the watchdog enabled, probe only marks it
running and sets the timeout, so WDT_MODE keeps whatever the bootloader
wrote. The Amazon Fire HD 10 (2017) bootloader leaves dual mode with the
bark IRQ enabled, and no pretimeout is configured, so each timeout only
raises the IRQ and restarts the count: with the 20 s timeout systemd
sets, a hung system was reset after 37.95-39.76 s, and after 18.25-20.92 s
once IRQ_EN was cleared by hand.

Program the mode as mtk_wdt_start() does, which also applies
mediatek,disable-extrst and mediatek,reset-by-toprgu to a running
watchdog; read those two properties first.

Fixes: bbece05c0d3a ("watchdog: mtk_wdt: Remove mtk_wdt_stop() in probe() to prevent the system freeze and it doesn't reboot by watchdog problem")
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Found on an Amazon Fire HD 10 (2017), an MT8173 board that is not upstream
yet. Its watchdog node has no interrupt, so no pretimeout is set up. The
timings in the commit message were taken from the host side of the USB
link; with this patch a hung reboot resets after 18.35-18.45 s (n=3).

It is based on v7.3-rc4 but it also applies cleanly to watchdog-next,
where "watchdog: mediatek: acknowledge pretimeout interrupt" moves
spin_lock_init() ahead of mtk_wdt_init(), so calling mtk_wdt_start() from
there is safe on both.
---
 drivers/watchdog/mtk_wdt.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index d9c30e4c80e3..b12ea113b63e 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -285,19 +285,6 @@ static int mtk_wdt_set_timeout(struct watchdog_device *wdt_dev,
 	return 0;
 }
 
-static void mtk_wdt_init(struct watchdog_device *wdt_dev)
-{
-	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
-	void __iomem *wdt_base;
-
-	wdt_base = mtk_wdt->wdt_base;
-
-	if (readl(wdt_base + WDT_MODE) & WDT_MODE_EN) {
-		set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
-		mtk_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
-	}
-}
-
 static int mtk_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
@@ -338,6 +325,24 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static void mtk_wdt_init(struct watchdog_device *wdt_dev)
+{
+	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base;
+
+	wdt_base = mtk_wdt->wdt_base;
+
+	/*
+	 * The bootloader may have left it in dual mode, where a timeout only
+	 * raises the bark IRQ and the reset comes one timeout later. Apply
+	 * this driver's mode instead, as mtk_wdt_start() does.
+	 */
+	if (readl(wdt_base + WDT_MODE) & WDT_MODE_EN) {
+		set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
+		mtk_wdt_start(wdt_dev);
+	}
+}
+
 static int mtk_wdt_set_pretimeout(struct watchdog_device *wdd,
 				  unsigned int timeout)
 {
@@ -440,6 +445,12 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&mtk_wdt->wdt_dev, mtk_wdt);
 
+	mtk_wdt->disable_wdt_extrst =
+		of_property_read_bool(dev->of_node, "mediatek,disable-extrst");
+
+	mtk_wdt->reset_by_toprgu =
+		of_property_read_bool(dev->of_node, "mediatek,reset-by-toprgu");
+
 	mtk_wdt_init(&mtk_wdt->wdt_dev);
 
 	watchdog_stop_on_reboot(&mtk_wdt->wdt_dev);
@@ -460,12 +471,6 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 		mtk_wdt->has_swsysrst_en = wdt_data->has_swsysrst_en;
 	}
 
-	mtk_wdt->disable_wdt_extrst =
-		of_property_read_bool(dev->of_node, "mediatek,disable-extrst");
-
-	mtk_wdt->reset_by_toprgu =
-		of_property_read_bool(dev->of_node, "mediatek,reset-by-toprgu");
-
 	return 0;
 }
 

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260923-rbrue-suez-upstreaming-mtk-wdt-dual-mode-6758e7b879f9

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

