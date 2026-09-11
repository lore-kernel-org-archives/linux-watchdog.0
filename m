Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602144F565
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125481; cv=none; b=nFgB3dq+QdJLu3d0kXEoOFszq+FW6faPJMmzSYQHcx/uf1FDlXplwe2wENtH+bDPqdNKQ98wjfCxsyU8j5DsRZLnYDQ2cWuAmTdY2GAqKX1T09pY33yjc/aaRxKCd/cCrQr3qBt84dl7kHXtb45d1KNwRFKAhpQdjV/fDFuzncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125481; c=relaxed/simple;
	bh=o2Tt/yZd0egGDvWknmiYQzQA8JdKjOEMa19faoQ8SpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7ch7xZjXxuI5uDg3bLN+P9B6Cgs0+kkp8GDb3aL8osLqTPq37J6PSWYnfzkhqRNYJ/dvXaLOQi2zNbAHZji6wR+OipevgddVRsVvo3fOtIMbd0Y//VyCidi+KIsyZAkfbgciX4crJGbwh11rbqvHQ8gDWEMLFyg0ld4nCsCIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc/nwl8k; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc/nwl8k"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so5029625e9.2
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125466; x=1789730266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXZjEIsYlhrDTNZ38lYdKcFWIDewXWmia/iEsbM8DKc=;
        b=fc/nwl8k8UamwQgYFr+A3yqxLg9VTSJ9yGavNWm1xg3BDgbMggz26LDX+cAOWdg7q7
         UvCiArina7hDecsq+tieOLKCNormSkdujrzWTBGxmwxhQ96bOyFGPzIhptWjXB+3e2za
         ltdMOYRwGxu36ha/QQEk6BDhz1KOpAOHjmvEMpcRrvyes3aWb7AYeZaZv2TnnJpHorkT
         6ErG+rGuvTbXX/YebLkIcTz6L6IbhZSNTfC65jRpD52tVxS9ui4Ngdo9B7fQBzrpdoEZ
         K5FfHkBxjeML0/Exht3NiJzwnKlUv0ns99H6/fnss+SfkhW8wYvuID06Pgd1A1SDA3tj
         MPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125466; x=1789730266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NXZjEIsYlhrDTNZ38lYdKcFWIDewXWmia/iEsbM8DKc=;
        b=ieLXlT6OcykTJ6atuJF7km/ImaCJFb7AOdj16F0ZMRUrQMKCvphf9GOoUSMxNqOykK
         6W19MWpE4ObN7wKl4ae2I8nl1l/qYF924cVh808d+swbRspzv4hFrGGj8Fpi8Uuyq2a4
         ts7JA/vT2d6rA8LKKUrKfDIuo7E1DixPN0aIujwmQP5xgjBhdEVKCc0hcvRZ+xne470A
         3YjPIRCuqz2p1vVMkcm84EkTUQi10HycyrjfJ0Zx4ldBG9WGC6ImE7aISKjdjZKVYvqW
         DAY77CadPlfVSBasNfHSZyKXKizkrgKA/H8lBCfGnOACo5DuXaMVsBbuRuqNpC8qk9/8
         QxeQ==
X-Forwarded-Encrypted: i=1; AKwUvByt5dPiCQZa/t4/H6Q+HRY2TlKwHIjEH55+k6Id9upVBby8QcVTDGD6MzAeGrYzui8ZiLjLwUNhNhibPG8o6g==@vger.kernel.org
X-Gm-Message-State: AFuF++ni3rqQx+p2yABVt53DXKjFDlX0XA05muJDx6EN2dNhnn6dP7wS
	/UrGnyHlWmXqjNUuM5ku374BBYUemvRhzBwF/ErJmsp3kgVCKWfVmHKs
X-Gm-Gg: AYBFou3HaXVUdW5TQeOBq948pxqhUqJM0v1K5/ClfGIS4k6fEB5uqbrx913w8XewP95
	7GUkRb8ZGIXGYkkIgaKKyPnd3w9dwc5QcdQmgat/FE0FaPSOeJ+5J/MQn+yCQiVYH/eNOCGQ5Pn
	pFlZSBL7JNmTQJdMHU/AOEsGJGwlbknu/ixmKHtdYM88/i1bDTdsWl5nsGm5NLV7JfdMaxiscEc
	IYDvwOqj0qQkvaFDTwFvmV2F/3+NvzRyvYtJt+0NBJZsWTn99hZtl8GAvw29I4JxlB0fDh7JXff
	t9N84Uc1LJ62TGm5reky7+GePWAmIQALCErlYdeOUJhLdGJ0xbIinD4PgDyyDy5Xn8vnz9wp+En
	3AuP9Ae3DTXMvaGZNzuy1ZFzbgeTPeoZppvPGZLuND2Uqu3s6f6jdjyX5U5sgHnmEWASVhkeN4d
	/oH3kiYiXwrVTgDyIrO6bto3Xxdk+Vmg44F6MIfXjQU+/MhkjB62kqLT8JCCzdYjHohS6P7K7o+
	RQw7EapuSc3BrXT8ieS/XHJtHextViaainQgGUthxW16w5da7JEQovXRsYloIIIWPMHkFwVTz/l
	9XZOUq0JxP4Qn8XClkSWOGZtHaO5xLA=
X-Received: by 2002:a05:600c:a40e:b0:49e:65ac:eb5f with SMTP id 5b1f17b1804b1-49e65aced4bmr38572495e9.10.1789125466496;
        Fri, 11 Sep 2026 04:17:46 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:3de1:9f21:e874:3931])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf23sm5438182f8f.5.2026.09.11.04.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:17:46 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 3/8] watchdog: rzv2h: Propagate WDTDCR access errors
Date: Fri, 11 Sep 2026 12:17:26 +0100
Message-ID: <20260911111731.3404308-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The WDTDCR helpers access the register directly using readl()/writel() and
therefore cannot report failures to their callers. WDTDCR is located in a
shared syscon region and will be accessed through regmap in a subsequent
change, where register accesses can fail.

Make rzt2h_wdt_wdtdcr_count_start() and rzt2h_wdt_wdtdcr_count_stop()
return an error so their callers can propagate failures.

Handle these errors in the watchdog start and stop paths and unwind the
resources acquired before the WDTDCR access, restoring the reset state.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- Dropped checking rzt2h_wdt_wdtdcr_count_start() return value in
  restart path.

v2->v3:
- New patch, split from v2 patch #1 to make thing easier to review.
---
 drivers/watchdog/rzv2h_wdt.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 7c6a4855bd8a..cbf414e0c9a3 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -87,18 +87,22 @@ static int rzv2h_wdt_ping(struct watchdog_device *wdev)
 	return 0;
 }
 
-static void rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
+static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
 {
 	u32 reg = readl(priv->wdtdcr + WDTDCR);
 
 	writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+
+	return 0;
 }
 
-static void rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
+static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
 {
 	u32 reg = readl(priv->wdtdcr + WDTDCR);
 
 	writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
+
+	return 0;
 }
 
 static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
@@ -148,8 +152,14 @@ static int rzv2h_wdt_start(struct watchdog_device *wdev)
 	rzv2h_wdt_setup(wdev, of_data->cks_max | WDTCR_RPSS_100 |
 			WDTCR_RPES_0 | of_data->tops);
 
-	if (priv->of_data->wdtdcr)
-		rzt2h_wdt_wdtdcr_count_start(priv);
+	if (priv->of_data->wdtdcr) {
+		ret = rzt2h_wdt_wdtdcr_count_start(priv);
+		if (ret) {
+			reset_control_assert(priv->rstc);
+			pm_runtime_put(wdev->parent);
+			return ret;
+		}
+	}
 
 	/*
 	 * Down counting starts after writing the sequence 00h -> FFh to the
@@ -169,8 +179,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (ret)
 		return ret;
 
-	if (priv->of_data->wdtdcr)
-		rzt2h_wdt_wdtdcr_count_stop(priv);
+	if (priv->of_data->wdtdcr) {
+		ret = rzt2h_wdt_wdtdcr_count_stop(priv);
+		if (ret) {
+			reset_control_deassert(priv->rstc);
+			return ret;
+		}
+	}
 
 	pm_runtime_put(wdev->parent);
 
@@ -219,8 +234,10 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
 	rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
 			WDTCR_RPES_75 | WDTCR_TOPS_1024);
 
-	if (priv->of_data->wdtdcr)
+	if (priv->of_data->wdtdcr) {
+		/* best effort, ignore ret */
 		rzt2h_wdt_wdtdcr_count_start(priv);
+	}
 
 	rzv2h_wdt_ping(wdev);
 
@@ -251,11 +268,11 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	rzt2h_wdt_wdtdcr_count_stop(priv);
+	ret = rzt2h_wdt_wdtdcr_count_stop(priv);
 
 	pm_runtime_put(&pdev->dev);
 
-	return 0;
+	return ret;
 }
 
 static int rzv2h_wdt_probe(struct platform_device *pdev)
-- 
2.55.0

