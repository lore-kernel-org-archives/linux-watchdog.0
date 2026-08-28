Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06637F30A;
	Fri, 28 Aug 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933656; cv=none; b=L7seZ5JT4NBxs7xZODl+GJgRx555Y1eW5T36yxPDoymjvuhKvCXALeqyrWIYGoH63w36xRjrCixsTkZEXxwMmOTdrkPWhzhXdob9DyVaDEHFDQh6FszyF3AZE2fJm36ih/xYwsuFgVcOTvOu+szzNvpSShRTujEIeG/5fr0BAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933656; c=relaxed/simple;
	bh=CzNXetXzMpV5laXvu1UZuBL1MVCgiPCImOmLppOahzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnhFeTNpp3lwiA0SHH2airIRxTTjUAgzB8vT4W8GAPMcLqzi/oMyR39WZdjYPLCqK0ISIzXSLYE7u13UTkNGsUB9XMo7ZALp0qhMPo9DMHMGtIsN6kGyeZ36fo2k0KNuUeWL/lQ+bdkJ7cLIqtQ9sTDgDy8OzrjHY1UVErdXplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCh16YUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCh16YUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B9E1F000E9;
	Fri, 28 Aug 2026 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933654;
	bh=yyE0NU9jUPYovPGQZ2kNJN+/27g7SBh3xX6czLk4DQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCh16YUqWtR0nDpTCNgGe4aC4V96Yo0m6sd7o6aDUP/xDdPdg/SDbdiW+I6zo5xfb
	 6sl/2msranaaqzGKsP25j+eR+umf/5dzB32vBg78LJOGmnU3dW8ZVHqQ8RQpn23J4Q
	 QtEmPyjhufVYkduRvP4vHC8TBRr9Gi7yyvA9TiJaxyV4ZaQhFOfBA2ZYPOjyfKXo+g
	 e6ZhLc3uQz8lUzwnlpuKd+mXFwzTAaWESdG0+epIFScvaQKEfBzM/uGpGgq0Hp0cZr
	 KfZAArWfyh/cSbXL4xVdq3Y+G+S7SLysM3tHRMJNjmkIgPRk5Ahjbsl6NlfADANRbs
	 ywJ7Quz6NsTDA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 6/9] watchdog: msc313e: Fix undefined behavior
Date: Sat, 29 Aug 2026 00:13:45 +0800
Message-ID: <20260828161348.13212-7-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828161348.13212-1-tzungbi@kernel.org>
References: <20260828161348.13212-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

readw() returns a u16.  Left shifting a u16 by 16 bits yields undefined
behavior.

Cast to u32 explicitly before the shift.

Fixes: ffd264bd152c ("watchdog: msc313e: Check if the WDT was running at boot")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- New to the series.
---
 drivers/watchdog/msc313e_wdt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index c7d558fefc86..e28261c7a8d4 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -31,6 +31,16 @@ struct msc313e_wdt_priv {
 	struct clk *clk;
 };
 
+static u32 msc313e_wdt_get_hw_timeout(struct msc313e_wdt_priv *priv)
+{
+	u16 low, high;
+
+	low = readw(priv->base + REG_WDT_MAX_PRD_L);
+	high = readw(priv->base + REG_WDT_MAX_PRD_H);
+
+	return ((u32)high << 16) | low;
+}
+
 static void msc313e_wdt_set_hw_timeout(struct msc313e_wdt_priv *priv,
 				       unsigned int timeout)
 {
@@ -139,7 +149,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 		return ret;
 
 	/* If the period is non-zero the WDT is running */
-	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16)) {
+	if (msc313e_wdt_get_hw_timeout(priv)) {
 		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
 		/*
 		 * Keep the clock enabled. The watchdog core will skip the next
-- 
2.53.0

