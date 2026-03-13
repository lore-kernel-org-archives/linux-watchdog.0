Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245836F432;
	Fri, 13 Mar 2026 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393885; cv=none; b=tt+NdY0XyNQZz4u9GNySBrcKndSmmYVLXu0tIijFpWFNwxxe54FANdkZrLoU1LKoxk89gPXDbtgAcPoPO7xtqBzrGHYLYJWxYRZcQ6//Y1kM4CAqvy1nkXkjHb+xuw1Rt7xcCxbsqRb0H5EW14r9sAYpvgOHl/iJAMm7bpafCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393885; c=relaxed/simple;
	bh=qkCssjwQ6xHfILIG/0YeecVw+n9kEcmrQqoPICmcohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9EeHFCmBboANco96IzMkElxYle1nM4bcxJSqSelxX8eT51VWt5o3XvK+X2nFlG3bUGfhBW2wuG5bCoZqfSY6RWqZYjcRqjAi4vaB0pQemY8XHJkmG+c40nJnOnQqiHqazKh2gxR3VPcxg9b4YJBopJfRylmkRNh9YfXf5T9QyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NE7nEJJu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NE7nEJJu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 083651A2E23;
	Fri, 13 Mar 2026 09:24:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CB87A60027;
	Fri, 13 Mar 2026 09:24:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C560910369DD1;
	Fri, 13 Mar 2026 10:24:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773393881; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HeFNpkruOmIcHovjLW+aFCk9gvji8MHWFyaMG1utC/c=;
	b=NE7nEJJuD2qHF1ZHgOaxOemSVCA+tqOhHLJlECdWKUe1DY1Sl6BZo9/UjP7VblAgGBCh+X
	szluIutldeoIhmwdo14noIxQgE0GURUIWftMI1Eq2ngcQxPNeGGE0koijlVfHp2b8DkE5K
	RbUqM4Q0yl21SwGQ8CIznjhkXUdry4Z//LRGb3IQMwkHpbHTyAiTN5OzxmbQZ+ubIQN4dm
	VNOP8ZktWcvLCTZchjJj5N/rMFVOtPnGmIbbVcYcBv0eJig9oqel9XrN0nlXMJMZl6WzS+
	HnXsd9/vZkTEGncQw+IhsZGkdSp2APjkKsyW2GUhyYSUJ3na2FH3jCYNcvg9VQ==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Subject: [PATCH v2 1/3] watchdog: rzn1: Fix reverse xmas tree declaration
Date: Fri, 13 Mar 2026 10:24:14 +0100
Message-ID: <20260313092417.294356-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313092417.294356-1-herve.codina@bootlin.com>
References: <20260313092417.294356-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Variables declared in probe() don't follow the reverse xmas
tree convention.

Fix the declaration in order to follow the convention.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
---
 drivers/watchdog/rzn1_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
index 96fd04fbc2a2..b7034eac91d0 100644
--- a/drivers/watchdog/rzn1_wdt.c
+++ b/drivers/watchdog/rzn1_wdt.c
@@ -101,10 +101,10 @@ static const struct watchdog_ops rzn1_wdt_ops = {
 static int rzn1_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct rzn1_watchdog *wdt;
 	struct device_node *np = dev->of_node;
-	struct clk *clk;
+	struct rzn1_watchdog *wdt;
 	unsigned long clk_rate;
+	struct clk *clk;
 	int ret;
 	int irq;
 
-- 
2.53.0

