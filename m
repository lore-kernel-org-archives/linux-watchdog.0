Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B43CBE72
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2026 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422356; cv=none; b=s3cMJFntOk8UaWzaSlZOgK/txF4gZsJ/EaXWpBAI/A3AwLn22EJPmKReObthIcrgVtJmPFYt4YceNQDxYmxJcTgRpDDvXBPsx42QLzTkCerZy2nKdXKvwyITXa3CvJRRM7PA4Jrmw0m20aGwqNa7vRQEEBncoC0fQjFX8Uyg++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422356; c=relaxed/simple;
	bh=dWlzpIRpWhs//KGkXhRaKZ5Oy2VekU+zobFeCi2zWjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5RPEPLyZ4pvWpAuMVVsv0iWoqtO5WdMvyBLRxlbuaHw2SsjqknukfSJup9/a7kC3SWWlaKXD7XFYXc0GvJoW6UQm4+lDuARU34LbuV3gplIkAodnKV2UI6ixMr00W8k8eot9N3NG6GA4+Dj13IzFMEs+u+FKhL2Zgy/+YXZWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=GYi8Tijs; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="GYi8Tijs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=d1IfdCdIdQyJxZ
	ZoIlmhwvV8tc1Lvx3UnGZzC6QnBI8=; b=GYi8TijsZpLel+79c9SJGwivZJtQIJ
	0/TgGNItio3hO7a1sGgWNH1MPOOaUz8Vtuc1k7jSLUaUQXxfBYLG/UyH7LFzPuoO
	7MANHznyKUFuFyyTYSyOIsdOTrZVkTV3SwMqmjGrC8rXlE31nl+5xlEICBu2zvEC
	Mbf4hmqXdjcjP5VJLltQ9a9/cFWHKeKs/reIvdMQ7zxLmrON2D25ykZ+zopPjngH
	1G7pD4Sw+KRtp8exr9d2QPmr8ISsg6H+qV9vOoGy2Byd0icnCNJmMF0o11ggwW2b
	fXl9kI+ZRV9Qzb30VLs/8wogOfkR7Tv/8S1nOslAEejqgdcImi/qnPSQ==
Received: (qmail 390599 invoked from network); 13 Mar 2026 18:19:13 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Mar 2026 18:19:13 +0100
X-UD-Smtp-Session: l3s3148p1@7kZhEetMrrIujnuR
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [RFC PATCH] watchdog: rzn1: remove now obsolete interrupt support
Date: Fri, 13 Mar 2026 18:16:42 +0100
Message-ID: <20260313171858.8317-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, it was overlooked that the watchdog could reset the system
directly. So, a workaround using the interrupt which called
emergency_restart() was implemented. We now configure the controller
when booting properly to allow watchdog resets directly. Thus, remove
the interrupt workaround.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Depends on Herve's series[1]. I'll resend it once his changes are
upstream. But maybe people want to discuss it already?

[1] https://lore.kernel.org/r/20260313092417.294356-1-herve.codina@bootlin.com

"[PATCH v2 0/3] watchdog: rzn1: Add support for direct hardware reset"

 drivers/watchdog/rzn1_wdt.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
index 98978b5cc5b4..0494a817b20a 100644
--- a/drivers/watchdog/rzn1_wdt.c
+++ b/drivers/watchdog/rzn1_wdt.c
@@ -79,14 +79,6 @@ static int rzn1_wdt_start(struct watchdog_device *w)
 	return 0;
 }
 
-static irqreturn_t rzn1_wdt_irq(int irq, void *_wdt)
-{
-	pr_crit("RZN1 Watchdog. Initiating system reboot\n");
-	emergency_restart();
-
-	return IRQ_HANDLED;
-}
-
 static struct watchdog_info rzn1_wdt_info = {
 	.identity = "RZ/N1 Watchdog",
 	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
@@ -101,12 +93,10 @@ static const struct watchdog_ops rzn1_wdt_ops = {
 static int rzn1_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct rzn1_watchdog *wdt;
 	unsigned long clk_rate;
 	struct clk *clk;
 	int ret;
-	int irq;
 
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
@@ -116,15 +106,6 @@ static int rzn1_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_irq(dev, irq, rzn1_wdt_irq, 0,
-			       np->name, wdt);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to request irq %d\n", irq);
-
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get the clock\n");
-- 
2.47.3

