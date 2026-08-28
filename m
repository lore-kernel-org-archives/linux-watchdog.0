Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD637F315;
	Fri, 28 Aug 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933654; cv=none; b=hnNrNq8hb/zJDMGvKgZ6CcugQhwSa/2deK3RzHDSw0y7rDlHQgHBaPFt1KvwTAmfMKCXj5KtCOD1R4UnHzjhBmuD9pNpcPL7/VeYW4fv7FN26lUwh+m0rBt7pWQrr9Mw2vFufwhRqPSIlxhqSx+tpHrKQsE8oSWXsx8CPEk1kXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933654; c=relaxed/simple;
	bh=78UyeKnTuR1HMcTrBPFeRNj9ltmFhAMuhAPCzXgaBqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNaDVUqEnqcIltu4Jiupcwwh7eR2yER2JdSNYbkxJHzKrCNlOj/UVOjJFER6hU287FeU3AKO3u55HjXBUcnwobOe+hrjDf2OYgw9YexuPYdieD1mbr5hEmcEyrCzKlUrcmUvT93tBLL8cogJOOeERCtz+ST1eP8xQ21tZx+3juA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/3Ati08; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/3Ati08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554031F00A3E;
	Fri, 28 Aug 2026 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933652;
	bh=UZiMUMZYTeZUMYYUpWKxLwPcbLWlj/7++vEMATDzQBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/3Ati08HIfdhNltaq77WQBwct+hxmieGIobP1T2DvWuN7Iry3MGyHUuBCIuA5+59
	 wgkXX8MsLEJ28xOlFj+uV8QoG5Ytp+iEdlySkI66+r10zSfPEYvaWSA3Au6LUQcIyq
	 cAv1ukct9/7kdCXaV2a3FMTGjIBtB63IdPKSeiC5Z7y40yX8xXXvrUYG9SMhzfIjaM
	 faATB/fAAafeHyKZNwyUzRwfSO+hrQ1NVW+Rum4cwZGXgJVRooLzgh/jPdxJd8VHAI
	 hcMFX6qo0rXeyMftcVt0yG6Xt51blq3NUQg4zoUElpXiOCjkSA+ShdEgmDaCRHi4ws
	 BZYpYeBPXMuGg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 5/9] watchdog: msc313e: Fix spurious reset on suspend
Date: Sat, 29 Aug 2026 00:13:44 +0800
Message-ID: <20260828161348.13212-6-tzungbi@kernel.org>
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

If the hardware watchdog was started by the bootloader and the device is
suspended before userspace opens it, the ping worker (from watchdog
core) is frozen and the active hardware timer continues running.  This
leads to a spurious system reset.

Check both watchdog_active() and watchdog_hw_running() when deciding
whether to start or stop the watchdog during suspend and resume.

Additionally, call watchdog_stop_ping_on_suspend() to ensure the ping
worker be correctly paused and restarted during suspend and resume.

Fixes: ffd264bd152c ("watchdog: msc313e: Check if the WDT was running at boot")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- New to the series.
---
 drivers/watchdog/msc313e_wdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index 7c4593566781..c7d558fefc86 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -156,6 +156,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&priv->wdev, timeout, dev);
 	watchdog_stop_on_reboot(&priv->wdev);
 	watchdog_stop_on_unregister(&priv->wdev);
+	watchdog_stop_ping_on_suspend(&priv->wdev);
 
 	ret = devm_watchdog_register_device(dev, &priv->wdev);
 
@@ -170,7 +171,7 @@ static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
 
-	if (watchdog_active(&priv->wdev))
+	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev))
 		msc313e_wdt_stop(&priv->wdev);
 
 	return 0;
@@ -180,7 +181,7 @@ static int __maybe_unused msc313e_wdt_resume(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
 
-	if (watchdog_active(&priv->wdev))
+	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev))
 		msc313e_wdt_start(&priv->wdev);
 
 	return 0;
-- 
2.53.0

