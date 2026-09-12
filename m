Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933526AC5;
	Sat, 12 Sep 2026 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230838; cv=none; b=FoG79StY0yKRmlSQDs2oAiToWe3gQAklI+CAV5AmcUzaIymBrIiLygS7YiWnFNeM+HD6d84H20ijCkwhw7nO9Jdw4YOZiV8p/kAfc/d8dfH5p3pFsdK+lVTPHAjeUFAZb+dcXrNQ/loqcQkFsh7AMv/IYZ9qCOAQU3YqrLH6dKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230838; c=relaxed/simple;
	bh=TkVHVWcGPm5uj1JVBsyYcTfER6BzfnsdE3IClTS7oPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awQarI2pePX9ovf9go8G8ooK9rB09zkO2X4H5MGdrdBoKO2wvEDYCK6+D2rYwGAQ/JRAW6BzrMNoz0CJ0poWOXien8gm1Xr6F+Bmt1q7+tXwq5VMRzybRg/IOWG06Eod99VuKl7vPedksnTXkmuykXTMhxveiqFLVhu1XPLIDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3pjxBCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3pjxBCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC5E1F000FF;
	Sat, 12 Sep 2026 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230837;
	bh=Zaz1R6zpwtPnAuiwhreeEBCCVBgR+cQWFTbAoXP0vgw=;
	h=From:To:Cc:Subject:Date;
	b=Q3pjxBCBNy5gn0jUBmUSl0Ir9OgcwYweh3Sn5JnBPKdGIPopMj4O/WT+ByhOTXcQd
	 zYzEz7t91/6S2NzNoDT7EoOe8VQkDjzWP/XGTsNLPrpbYJpWMflhEovs4/o13VDIPw
	 LqCzf1yu67FD1YXBfJhXuUIvmk7eOkUTUE0MYCXSLb4zeQKe3NGczqLgGOvqucIDPe
	 Opc74tZt65rq4PByxNGTKCGtfcVv+ATaFe/hGWn69Nm8ujqBkwUqH5kYPwqHVti87i
	 Sb+07jBwgr5hc2DjZH3KSnurMJbkwpU/L7tmrxUpHeYDCAc66NhcRSkbQ8p3t7eMHd
	 vLE52E5KxK3dg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v3] watchdog: msc313e: Propagate error code in resume()
Date: Sun, 13 Sep 2026 00:33:34 +0800
Message-ID: <20260912163334.28636-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If msc313e_wdt_start() fails during system resume, the error is
currently ignored.  Consequently, the watchdog isn't running without the
user's knowledge.

Propagate the error code and print a message if msc313e_wdt_start()
fails.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v3:
- Don't clear WDOG_HW_RUNNING and WDOG_ACTIVE flags if
  msc313e_wdt_start() fails in msc313e_wdt_resume() which hides the dead
  state (Sashiko reported).

v2: https://lore.kernel.org/all/20260828161348.13212-9-tzungbi@kernel.org
- New to the series.
---
 drivers/watchdog/msc313e_wdt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index f5a5afd91b98..dc7bdd5660e6 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -191,11 +191,15 @@ static int msc313e_wdt_suspend(struct device *dev)
 static int msc313e_wdt_resume(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
+	int ret = 0;
 
-	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev))
-		msc313e_wdt_start(&priv->wdev);
+	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev)) {
+		ret = msc313e_wdt_start(&priv->wdev);
+		if (ret)
+			dev_err(dev, "Failed to restart watchdog (err=%d)\n", ret);
+	}
 
-	return 0;
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend, msc313e_wdt_resume);
-- 
2.53.0

