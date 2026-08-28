Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B9374A0C;
	Fri, 28 Aug 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933648; cv=none; b=rjzjlnlFrCPCnqqkkYQVkTVPItWBkPof31jTP4AWOMh7VA/L51LTCsm9EOQL9mqtv/Quw4K40jo6lcPMi9ru8HAl9mS099AlPUKHwDE30Y3RwtsrS1sueXQvnScwcD8cwPyJ2iA3fQq/tqnkjV9zrPe0tDwnR29PktCqrqw8uEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933648; c=relaxed/simple;
	bh=OI1gnMNlvOgrvAGGV2Cm5sMcmuSRCXQ1XJJXH6CRrO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yx+URF79Omcbabkd1LvJxYLjHtf1kMDvu1Bkju0Fjk5qDlPwpGd1WgmA2YextXFNF7TGErzCmfc5ttvoOJwiEYX6BrPQqSaFqbX+Lb36AUvUavFBSTGqPtAIImiSqi0q/qnWCI2BqPeHdzuJn0ck+/svoA4A7XUU5g6EKH+gErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1Ebrr4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1Ebrr4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7F51F000E9;
	Fri, 28 Aug 2026 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933647;
	bh=lVZVYg+bDdK1zVHqn8k5MSf2PwzC871N3x+gQ/FCclE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d1Ebrr4Gr3uRXuLIyvSiM/awqnfTJZFvwWzfvneayBDm/mkzw+AK4G7M3mAjBgqyH
	 wkdV5WiiqEVPEn69UxRfXBAyOcZolZfPSc29dGhSCUScInNRKj5+J7FOh0l8xaZLuD
	 VPnF9wpo13SrZRhohjKHZjueqHohCghXsc6mGCtF5BkGv68zlHZ1KJ0uBSwBpjABky
	 GFqja39xzFHdUq2h2IDRnOz5oq5Xt99Gu83h+Wwm73bYptI7S1DVqJtBQwhZ0xQzJm
	 U513gDXZG1j7KD6lMzGVS0LKZswknwwNGtvkrxfm/xxZlhAsrTRGEhyIqCpwkTJF1n
	 HQGgzf0bhTM4Q==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 2/9] watchdog: msc313e: Avoid division by zero
Date: Sat, 29 Aug 2026 00:13:41 +0800
Message-ID: <20260828161348.13212-3-tzungbi@kernel.org>
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

clk_get_rate() could return 0.  Avoid a division by zero panic.

Fixes: e9800b799464 ("watchdog: Add Mstar MSC313e WDT driver")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Simply browsed code under drivers/watchdog/, the following drivers also
use clk_get_rate() as a denominator directly:
- drivers/watchdog/digicolor_wdt.c
- drivers/watchdog/rtd119x_wdt.c
- drivers/watchdog/rzv2h_wdt.c

Let me know if you think we should fix them as well.
---
v2:
- New to the series.
---
 drivers/watchdog/msc313e_wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index f69d66971c41..c3018b970164 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -97,6 +97,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct msc313e_wdt_priv *priv;
+	unsigned long rate;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -116,7 +117,10 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	priv->wdev.ops = &msc313e_wdt_ops,
 	priv->wdev.parent = dev;
 	priv->wdev.min_timeout = MSC313E_WDT_MIN_TIMEOUT;
-	priv->wdev.max_timeout = U32_MAX / clk_get_rate(priv->clk);
+	rate = clk_get_rate(priv->clk);
+	if (!rate)
+		return -EINVAL;
+	priv->wdev.max_timeout = U32_MAX / rate;
 	priv->wdev.timeout = MSC313E_WDT_DEFAULT_TIMEOUT;
 
 	/* If the period is non-zero the WDT is running */
-- 
2.53.0

