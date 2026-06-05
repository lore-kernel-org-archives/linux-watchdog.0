Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE5288C2D
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665128; cv=none; b=NiqrICEMyp4V7HJJQmaSAqliutpM9mls2i4QEHJE5FAgUfJhAhQ7VykYYWad0bKKe0ZStc4c1I2FWCx6NJF1YetozkO+bg1UkOvGB2dca62cRIQIfuYN8aLqa1ZBqoqiQZplAV5CaZ7B+oem5rdi5ZH/Tdk6WWG0stU1Dxz2ckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665128; c=relaxed/simple;
	bh=PR0LqjuezAQWrOubsNhn8MiAWagy5o3pKfuOGpAVcRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN4Rt/RGiJumNBhezcrVRjIV0qastjeCdlouZeSSnBh8zQTmYmrXzeIJ6JnBzptO3ngxGultKkwhjdKIx5ZVPfty6VYzeu0Xt+1TiZlZYPRApdTxOtxGKP+kIRVhFQytIU+TTpoKfda0xOY6Ib5Bm9O5GEVA5TIgE1dW+jMv22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=HxrSfdpv reason="key not found in DNS"; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="HxrSfdpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780665123; x=1780924323;
	bh=v7CBWfDdEsACDlG8ioC8xdoQIRvy+Z9zowW0MU+qJvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HxrSfdpvqBlkD/X9wMDU1mDKEq+jurwUkxBJ3m05iLYs18L8nIAzEcQGycuGVyXv1
	 2KIq6sUXmD4DGoMgGJZvO1etPNkxoaF6ikQKi8L7Ta+Q25ybfVoxCoHEYycrYjArFW
	 bPWccXx/6qYeMmtXJgAO8ol9+u9b1Mm5VWyLcBES2ZgDJEzvWavcz5YfcQ26+g48p9
	 LU+eK9oSxosRj2/g3hw3WqyvsgfacbJjND/YFleGP7DSTjOP7LJVasuwZ3DJu0WH29
	 yYe+mqYRkm1O1ZN/W81oyaMSPSmt07bj+q22q7mfsy00oshceFGDNTohgoINAcTdP6
	 AHwRTt5ZG3EjQ==
X-Pm-Submission-Id: 4gX2014h4Qz1DFSq
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] watchdog: starfive: treat pm_runtime_put_sync() positive return as success
Date: Fri,  5 Jun 2026 09:11:51 -0400
Message-ID: <bc91d669bb732784d1e28d4bd259612b6dd07342.1780664848.git.william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780664848.git.william@theesfeld.net>
References: <20260605122336.159546-1-william@theesfeld.net> <cover.1780664848.git.william@theesfeld.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_sync() returns 1 when the device cannot be suspended
because it is still in use (typically due to other runtime PM users
holding references); only negative return values are real errors.

Both starfive_wdt_pm_stop() and starfive_wdt_probe() currently treat
any non-zero return as failure: pm_stop returns the value verbatim,
which the watchdog framework propagates as an error, and probe takes
the err_unregister_wdt path even on a successful but non-zero return.

Mask off the positive return value in pm_stop and tighten the probe
check to "< 0" so the legitimate non-suspended case is no longer
mishandled.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index ed8c5711a..c821b38d2 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -386,9 +386,17 @@ static int starfive_wdt_pm_start(struct watchdog_device *wdd)
 static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
 {
 	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
 
 	starfive_wdt_stop(wdt);
-	return pm_runtime_put_sync(wdd->parent);
+	ret = pm_runtime_put_sync(wdd->parent);
+	/*
+	 * pm_runtime_put_sync() can return 1 when the device is still in
+	 * use (and therefore did not actually suspend).  That is not an
+	 * error from the caller's point of view; only propagate negative
+	 * return values.
+	 */
+	return ret < 0 ? ret : 0;
 }
 
 static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
@@ -503,7 +511,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	if (!early_enable) {
 		if (pm_runtime_enabled(&pdev->dev)) {
 			ret = pm_runtime_put_sync(&pdev->dev);
-			if (ret)
+			if (ret < 0)
 				goto err_unregister_wdt;
 		}
 	}
-- 
2.54.0

