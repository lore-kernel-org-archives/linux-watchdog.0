Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDFC3C9EF3;
	Sun, 13 Sep 2026 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282147; cv=none; b=qXxnScZUl8pZJ9IV73vMGGPsxrTPRFe4VO8u3QzEQwXa4R9HTUOYTdes6N5Fb02aOPLOlfA5YKHZROKCoKaLngYZfcObwhn+WdeLYiwd6CYYvWGDI2wYNP2AhUAruTD8kpF0tdH2sYXuJDyhFwPAGbFjxJBKQcQuCXxTwFu4PrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282147; c=relaxed/simple;
	bh=LhYpJ485ik2w81eWufq8H1TOWNuj5hgG26G3w9ZImN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAv2p5DeMTkD7hI3CYtFZnkPvqh4SC0xCHNz7MfyPTIyvpsdsRs9UnzqBhqs3uaGgZzospqthZ0fFCwjqHwGpICsGqPjoA2s+aZLnWU662KLfAfobqXrZ/3sJX0G3BYaLeBdmwR2UtVDtOWm0JRZX4LAP1nNahuypGXFBl0YULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK3kBiin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK3kBiin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BC01F00898;
	Sun, 13 Sep 2026 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789282145;
	bh=XKqnaSQmKuSO22y7wuizhyR47ub2Nz2pDtirMarQmXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BK3kBiinbza54tXVCGMTi/ymbCbFXEU04osBef/03viMesZ+PPQiAQ7l7FnSLkJmk
	 RrJEp3IQoHBR1hNO8wgiEf8AfGEF0uEMKGJIT3YpsRB4xyYJMkpLvE1HoDa61mhpZp
	 CX1APxHKbUox4RBNj+o+0yK9u+Ib4EVBqEYRw3TOaAV1kJxOy/QyJKQZafLXknr56t
	 yikfx1RT6iXqt7sN9172Z2EkY982D0JoIZtYLFE+DZAXaDaTPgoZr5pEMvj6yH4EF0
	 3o6QpahtKkCmTMppOLE/dzaQuBILTWF6brBVKFhB9eFy5n9uEWZZqcXioc0fTFkEjh
	 EGSc17Z13eEfA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Baruch Siach <baruch@tkos.co.il>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH 1/3] watchdog: digicolor: Avoid division by zero
Date: Sun, 13 Sep 2026 14:48:49 +0800
Message-ID: <20260913064851.8239-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913064851.8239-1-tzungbi@kernel.org>
References: <20260913064851.8239-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_get_rate() could return 0.  Avoid a division by zero panic.

Since get_timeleft() cannot propagate errors, check the clock rate early
in probe() and cache the rate in the driver data as it is unlikely to
change at runtime.

Fixes: 336694a01dae ("watchdog: digicolor: driver for Conexant Digicolor CX92755 SoC")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/watchdog/digicolor_wdt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 073d37867f47..de1a3267a972 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -25,6 +25,7 @@ struct dc_wdt {
 	void __iomem		*base;
 	struct clk		*clk;
 	spinlock_t		lock;
+	unsigned long		rate;
 };
 
 static unsigned timeout;
@@ -61,7 +62,7 @@ static int dc_wdt_start(struct watchdog_device *wdog)
 {
 	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
 
-	dc_wdt_set(wdt, wdog->timeout * clk_get_rate(wdt->clk));
+	dc_wdt_set(wdt, wdog->timeout * wdt->rate);
 
 	return 0;
 }
@@ -79,7 +80,7 @@ static int dc_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
 {
 	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
 
-	dc_wdt_set(wdt, t * clk_get_rate(wdt->clk));
+	dc_wdt_set(wdt, t * wdt->rate);
 	wdog->timeout = t;
 
 	return 0;
@@ -90,7 +91,7 @@ static unsigned int dc_wdt_get_timeleft(struct watchdog_device *wdog)
 	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
 	uint32_t count = readl_relaxed(wdt->base + TIMER_A_COUNT);
 
-	return count / clk_get_rate(wdt->clk);
+	return count / wdt->rate;
 }
 
 static const struct watchdog_ops dc_wdt_ops = {
@@ -130,7 +131,11 @@ static int dc_wdt_probe(struct platform_device *pdev)
 	wdt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(wdt->clk))
 		return PTR_ERR(wdt->clk);
-	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
+
+	wdt->rate = clk_get_rate(wdt->clk);
+	if (!wdt->rate)
+		return -EINVAL;
+	dc_wdt_wdd.max_timeout = U32_MAX / wdt->rate;
 	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
 	dc_wdt_wdd.parent = dev;
 
-- 
2.53.0

