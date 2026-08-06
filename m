Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949338331D
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996392; cv=none; b=DFoHu+CHLDfMZEpPblSyvIccjSF7OTzrQwnSku7ZyQjMiH3yBSfiLxYkeDIvOQZ9bBMHcbMIewlXATbgNSIGDQPAwa1WbVMS7qkqInl4MlHN8H7ox77Xx0h/3sngF4eMmfJb8j8IBvDbwFWfs9SiOqjZLiU57nXjxd1aSSYT+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996392; c=relaxed/simple;
	bh=lAaPM2w9u+cCvTXRIs+o6HBiM2nJ6K/V7j89teci3Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gst4d1IoX41bjOJgHeyhrinkLcv2HJAd1XeBC6gNhnXz60++uJbjhY6ia2BK1H2ltx0/DADyfg6XKwuXacC2QMXKMyDO7dUVlEUbvv9N/tSMkI2iteGfFHkSKfKPnZOHqz49AaBrSuerWEelRSy8qM3CxalHd9MZE7sAEmq9mjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=D6tKMZ/o; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="D6tKMZ/o"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48fb94a29;
	Thu, 6 Aug 2026 14:06:26 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] watchdog: at91sam9_wdt: prevent timer rearm during teardown
Date: Thu,  6 Aug 2026 14:06:13 +0800
Message-ID: <20260806060613.1830-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd5ae125b03a1kunm81202c9528934a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSh4eVk8YT08aT0wdTkJDSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=D6tKMZ/oRYV2G1NYOwLpvE3T+j2R7Qtzp1nvD5pHnc7HDgxgFuyswcqldRrr+KtHwrxGtTNJ2GrTcofCAXXkuweoql8PjMrsGwMHBS/M900FAL4hIILzetGgg/7h4q2shc+nY5FDs7mtIHC48d2rYWN01rxX/xl2XH6Qj4buy48=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=lH746+3EH6GJkB1AUd/CBfAlFUqYof4+aDGbhsiXTss=;
	h=date:mime-version:subject:message-id:from;

at91_ping() rearms the watchdog timer from its callback. timer_delete()
neither waits for a running callback nor prevents it from rearming the
timer, so probe failure or driver removal can leave the timer accessing the
devm-allocated at91wdt after it has been freed.

Use timer_shutdown_sync() on both teardown paths. It waits for a running
callback and rejects any attempt by the callback to rearm the timer.

Fixes: 5161b31dc39a ("watchdog: at91sam9_wdt: better watchdog support")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/watchdog/at91sam9_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index aba66b8e9d03..80ba04df54ad 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -242,7 +242,7 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	return 0;
 
 out_stop_timer:
-	timer_delete(&wdt->timer);
+	timer_shutdown_sync(&wdt->timer);
 	return err;
 }
 
@@ -378,7 +378,7 @@ static void at91wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&wdt->wdd);
 
 	pr_warn("I quit now, hardware will probably reboot!\n");
-	timer_delete(&wdt->timer);
+	timer_shutdown_sync(&wdt->timer);
 }
 
 #if defined(CONFIG_OF)
-- 
2.50.1.windows.1

