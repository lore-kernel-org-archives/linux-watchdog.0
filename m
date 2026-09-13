Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBB3C5546;
	Sun, 13 Sep 2026 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282306; cv=none; b=ZpBNjJ1AFhnwfuQJnsZgq4hVU7s+PEPFihENwCYkzXITUUYginpIz+hMnNtMhUP6PyPlvru454yWbetlXVVUsmDnnCzGOnnyLafkxDz3yEiNjJBsz54llVFPkre/zj2j074DKPLIACxZUxlTPn29KTmUn67N661Wb5LAhQVaspY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282306; c=relaxed/simple;
	bh=fcaJHkHVNIDCbPBs47jJjMIvqIcpA0ePW375pEcfxcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpncUElaAKFdhe9kx14pjG3nrdD0HAtLHPyliRebFtdEvSWctolRxMRbjxLrLlvVr6nRgvNX72ezT8A9w8mKuRuUQFo8d54UejTwQNj6GmLwkt5riCBVJTor2O3g4ZvDqSVe48qSlnckDFE7O67Xa13FjIR4ijX3aBMR7PFeGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS25O4ZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS25O4ZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EA71F000FF;
	Sun, 13 Sep 2026 06:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789282301;
	bh=NvlXi29UW+lhoY1tSTI0DBTTqIv0jJalOwCYNxonEVk=;
	h=From:To:Cc:Subject:Date;
	b=QS25O4ZECg6TyKeIb3M/TJBsz2HNQ0zLsE04McJM7mqInwmgf8F7HfDjxUPsgsM/T
	 vIsxj4TOb5eBD2e/wCHywZeuV2/JmYBzOeYnVTdErSKDpp8yKVYf7Z+iprtRhqq4QM
	 zWjyjLaWJQFZf7Dl2o5vPUgBkDHxkOjleabfftO33VrlALyVip4LkUgbnG6F+OfSqM
	 oKmNqUgTpkCHgxw8CI/w+WJkAfLwdGSjAxu5XFdTWNVsroQ5ickGcvNSxCOu8GlINv
	 mpvA2JCdGBGSCCCf4B2LPZ+O5xZiXFeq37mjoH2OCGtcj4mVenyux5R6N7QlSQo+5/
	 jORdHT6Lx8J0w==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH] watchdog: msc313e: Fix premature reset during timeout update
Date: Sun, 13 Sep 2026 14:51:26 +0800
Message-ID: <20260913065126.8350-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating the 32-bit hardware timeout requires writing to two 16-bit
registers sequentially.  If the watchdog is actively running, this
non-atomic update might trigger a premature system reset.

Clear the watchdog counter before updating the registers to prevent the
timer from timing out prematurely against an intermediate threshold.

Fixes: e9800b799464 ("watchdog: Add Mstar MSC313e WDT driver")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
This fixes a Sashiko report [1].

[1] https://lore.kernel.org/all/20260828162210.3C2881F000E9@smtp.kernel.org
---
 drivers/watchdog/msc313e_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index dc7bdd5660e6..0a68be7a217b 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -46,6 +46,9 @@ static void msc313e_wdt_set_hw_timeout(struct msc313e_wdt_priv *priv,
 {
 	u32 t = timeout * clk_get_rate(priv->clk);
 
+	/* Clear before to prevent premature reset during non-atomic updates. */
+	writew(1, priv->base + REG_WDT_CLR);
+
 	writew(t & 0xffff, priv->base + REG_WDT_MAX_PRD_L);
 	writew((t >> 16) & 0xffff, priv->base + REG_WDT_MAX_PRD_H);
 	writew(1, priv->base + REG_WDT_CLR);
@@ -76,6 +79,9 @@ static int msc313e_wdt_stop(struct watchdog_device *wdev)
 {
 	struct msc313e_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
+	/* Clear before to prevent premature reset during non-atomic updates. */
+	writew(1, priv->base + REG_WDT_CLR);
+
 	writew(0, priv->base + REG_WDT_MAX_PRD_L);
 	writew(0, priv->base + REG_WDT_MAX_PRD_H);
 	writew(0, priv->base + REG_WDT_CLR);
-- 
2.53.0

