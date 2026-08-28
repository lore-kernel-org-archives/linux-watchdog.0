Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DD37DABD;
	Fri, 28 Aug 2026 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933660; cv=none; b=AZFtO9PMJ3Gs+3oR3Lftl3u1cQdK34WpqgMmbJ5i2b9+SI5D7k64vB7izEjJgaLN0NO8oXHFqeov/zqAqbud33JyFK0LBOiyW5rbTOM5z1qVkvrmOhnbx/44511lvYviG0abYnGJEb+YayrwWkeFGMjc/lLg0GwLH4m4A7PS7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933660; c=relaxed/simple;
	bh=oOkpWtUMAUJLti+Ijk/FxgjRTu/C2Jf5f3qJLsk+4OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPr3Hvb+79TvGroUTNOKf2yYw/XQg7mFRpySe1t+Og7sPokO9i8X2WPAd25gLQPA9x9SEGXjP+sY5H8nqvvwH9fFKT+0YOA1QsAlGoIF9r158OHWVpCPS6Nuai2oVxR1xpNK/ugUApvTLMoT4/ZByYzRT5O8ua0O5dP+uNUo3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9YyrebN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9YyrebN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314A41F00A3E;
	Fri, 28 Aug 2026 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933656;
	bh=z+AQ26u/l1sde0n0uA4+tLVnvqdLJJKD0io6VCXqwM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P9YyrebNW5Yi8+4elIylFL3RLEATSwPy5yrruZaSAKmUqyWI5oxJxuZVlw5E9jhne
	 ZIzmnTfZ1FTRBEMfujuo5JfFq9bmntTnCLxUDxlGvIx0MnaRFV31WN5PDx3KQwz/P5
	 7pLePq/qLcJ70Z1HlSWWiXfrhaBfFBlR6Um+PE04b/wi4F8iCZ7XJurHz0Li0ER257
	 kVo3LCwC3/GpnjmEshhlCDCsL0bk419IOyZWthn8FJGYJGyynMRRSg2jxZ6jlne/rb
	 O586bZX59/717yiKmt09BGcg7aW40dGYIFbwSvanvkcpSYkx8gTii9fyGYPwkqm2fu
	 IpXdzfPrkDw3w==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 7/9] watchdog: msc313e: Sync timeout value if WDT was running at boot
Date: Sat, 29 Aug 2026 00:13:46 +0800
Message-ID: <20260828161348.13212-8-tzungbi@kernel.org>
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

If WDT was running at boot, the hardware timeout might be set to values
other than the final software timeout.

To be consistent, set the hardware timeout to match the final software
timeout (i.e., after watchdog_init_timeout()) if WDT was running.

Fixes: ffd264bd152c ("watchdog: msc313e: Check if the WDT was running at boot")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- New to the series.
---
 drivers/watchdog/msc313e_wdt.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index e28261c7a8d4..4a5cce2a16b1 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -144,12 +144,21 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	priv->wdev.max_timeout = U32_MAX / rate;
 	priv->wdev.timeout = MSC313E_WDT_DEFAULT_TIMEOUT;
 
+	watchdog_set_drvdata(&priv->wdev, priv);
+	platform_set_drvdata(pdev, priv);
+
+	watchdog_init_timeout(&priv->wdev, timeout, dev);
+	watchdog_stop_on_reboot(&priv->wdev);
+	watchdog_stop_on_unregister(&priv->wdev);
+	watchdog_stop_ping_on_suspend(&priv->wdev);
+
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
 		return ret;
 
 	/* If the period is non-zero the WDT is running */
 	if (msc313e_wdt_get_hw_timeout(priv)) {
+		msc313e_wdt_set_hw_timeout(priv, priv->wdev.timeout);
 		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
 		/*
 		 * Keep the clock enabled. The watchdog core will skip the next
@@ -160,14 +169,6 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 		clk_disable_unprepare(priv->clk);
 	}
 
-	watchdog_set_drvdata(&priv->wdev, priv);
-	platform_set_drvdata(pdev, priv);
-
-	watchdog_init_timeout(&priv->wdev, timeout, dev);
-	watchdog_stop_on_reboot(&priv->wdev);
-	watchdog_stop_on_unregister(&priv->wdev);
-	watchdog_stop_ping_on_suspend(&priv->wdev);
-
 	ret = devm_watchdog_register_device(dev, &priv->wdev);
 
 	/* If the WDT is running and anything goes wrong, disable the clock. */
-- 
2.53.0

