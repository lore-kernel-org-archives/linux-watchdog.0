Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1B37E5D2;
	Fri, 28 Aug 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933652; cv=none; b=lR60AG43D7bxJdJNysAl97C+ZXN583oIjvHiSOXBsnSYoW9tqBANuQ+1mbUBrAI+CQoiA3CO8FMnpgw9hK6Wh+0LEdkuEzucmxxTxdzhPlvu76wUcFhCvLrrt/0kLHPS57nS6YXu3qaKSktRODsMA8mn+Vo2dDfo6mRWVimRJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933652; c=relaxed/simple;
	bh=KvPX89e/Pc7vuzH/R6tsZQ9S5MksA7zPyxXeBhJRgIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDstbx9DIBtEXauENxhdilrgQKPMP+a9if9rvK9e9nAdfQmErsiLKqFj4fSGxk+ZRq/hwDRoE69auiuwetJFjqWy8QX0hppsz3sR3AjPFuS+qTAsC1HcLzqkzD5J+ev4nr8g7QhkyFp8EWlrphnKROGrxuo1Ao9UuPt6yS4DN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze40caVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze40caVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDC31F00A3D;
	Fri, 28 Aug 2026 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933649;
	bh=hfZ1+eqosKhDqwThr4Dsvg9FoS2dJuKMoaU3lxy4VVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ze40caVRAOqysKX9yWo4u2ijWcMVLmja9Uju1hH/Xu1fE1fSt62MjBbu6qinF415N
	 V5KJzsEdR/F0rBGgWvCNss4VQcXH1hdKUPIN9qy5pi1cFyAPn+AVQv8ygbMmwSrrvx
	 NwFACOk/vo8ylZiciJodz1lebn9VLRXYBQ4/OfSAzvRAgOw9Nlr8GSr3ibt/JF043e
	 lR5dnZ9XWIpSqLVFbeycwVQPpVxq8uC88+F6Lxx0iF14tODE4vxmqjKV/A3m2Hk1yl
	 g3ZRRe24B2k2NhI+uLCM8Bj7qRwq3jAnYUbmCi8URWZzTWmMB5NHdWqF8hLC8TgAO+
	 N5l+OBc/OInFg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 3/9] watchdog: msc313e: Fix clock leak and spurious timer in settimeout()
Date: Sat, 29 Aug 2026 00:13:42 +0800
Message-ID: <20260828161348.13212-4-tzungbi@kernel.org>
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

msc313e_wdt_settimeout() unconditionally calls msc313e_wdt_start() which
introduces two severe bugs:

1. If the watchdog is already active, calling start() again will
   increase the reference count of the clock again.  However stop() is
   only called once, the reference count is unbalance.
2. If the watchdog is stopped, calling settimeout() will start
   the hardware timer accidentally.

Factor out the register-writing logic into a helper function.  Only call
it in settimeout() if the watchdog is running.  Otherwise, simply update
`wdev->timeout`.

Fixes: e9800b799464 ("watchdog: Add Mstar MSC313e WDT driver")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- New to the series.
---
 drivers/watchdog/msc313e_wdt.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index c3018b970164..8ce24df8e338 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -31,20 +31,26 @@ struct msc313e_wdt_priv {
 	struct clk *clk;
 };
 
+static void msc313e_wdt_set_hw_timeout(struct msc313e_wdt_priv *priv,
+				       unsigned int timeout)
+{
+	u32 t = timeout * clk_get_rate(priv->clk);
+
+	writew(t & 0xffff, priv->base + REG_WDT_MAX_PRD_L);
+	writew((t >> 16) & 0xffff, priv->base + REG_WDT_MAX_PRD_H);
+	writew(1, priv->base + REG_WDT_CLR);
+}
+
 static int msc313e_wdt_start(struct watchdog_device *wdev)
 {
 	struct msc313e_wdt_priv *priv = watchdog_get_drvdata(wdev);
-	u32 timeout;
 	int err;
 
 	err = clk_prepare_enable(priv->clk);
 	if (err)
 		return err;
 
-	timeout = wdev->timeout * clk_get_rate(priv->clk);
-	writew(timeout & 0xffff, priv->base + REG_WDT_MAX_PRD_L);
-	writew((timeout >> 16) & 0xffff, priv->base + REG_WDT_MAX_PRD_H);
-	writew(1, priv->base + REG_WDT_CLR);
+	msc313e_wdt_set_hw_timeout(priv, wdev->timeout);
 	return 0;
 }
 
@@ -69,9 +75,13 @@ static int msc313e_wdt_stop(struct watchdog_device *wdev)
 
 static int msc313e_wdt_settimeout(struct watchdog_device *wdev, unsigned int new_time)
 {
+	struct msc313e_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
 	wdev->timeout = new_time;
 
-	return msc313e_wdt_start(wdev);
+	if (watchdog_hw_running(wdev) || watchdog_active(wdev))
+		msc313e_wdt_set_hw_timeout(priv, wdev->timeout);
+	return 0;
 }
 
 static const struct watchdog_info msc313e_wdt_ident = {
-- 
2.53.0

