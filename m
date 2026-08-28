Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86937E5D0;
	Fri, 28 Aug 2026 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933660; cv=none; b=C6z1ibCfetYcp1C4XrdjtzQL5dUvVfz3Y1HtL11igxgglR9c4y9YtaNUmgIVJZAHYp21C69iV7tWZhLkkw6qG8fwZKrfpGZCq2e8zSoIfLAfIGFShMIToCk2y8gAl13B8x0VfoYpARqxBoBXiMv0T5p8C0KhVMSDVsltaUv/R6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933660; c=relaxed/simple;
	bh=ghgsdUJbjxaKgxTgH8Wu37cUASStopDWJUZzYgevVCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsRSjDS12rEmSTODSZkqhFrJiBIuV8qwHJ5+662lZqnhIWqsVbQ71MApnkuoQgyfdhBDzE76S8tRoom8zgQsIBnpff4boTyhgJZTEqTQb3CuS8YLLSel39/3dbX25FLVMhpPVtz7cXTzMpfy4+MiiYvhE38cyk/XMSA0FoMWkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+cP7HP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+cP7HP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A63C1F000E9;
	Fri, 28 Aug 2026 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933658;
	bh=ZbDGeNSgdoxsaEjVkrddzqnoUdHJdNf2C4trTgK/gG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+cP7HP7XObtptQOXxraoBCABMvEGlZgHqyt58NVO9M1LMolrvLXRAHvVgh75gueN
	 qssWKccw0sKwH4OoVU7KDkYDSKXBi/uRBo66W2dqiCTIT6ZuDLQzEYsOd8f3jqWATo
	 A/7g0fiepWLIEshxGhNhmDKEUUMdyEPexmiKI+7jhcQH9F3uYPvu7WcKXczyFa9is5
	 2XHeMinyhU05+OVRDFYakhvEiXA3m6kcirGIyJvfyWBGfiWfvkNYgmUXGI1z3kAXyX
	 3Muhi/kY0dfuP4LN4DlsE0ayPqQryZe6As2iwJaarIyAk3beMeaUDCMpIPyeVO5MoU
	 yIZuy0ptNmioQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 8/9] watchdog: msc313e: Propagate error code in resume()
Date: Sat, 29 Aug 2026 00:13:47 +0800
Message-ID: <20260828161348.13212-9-tzungbi@kernel.org>
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

If msc313e_wdt_start() fails during system resume, the error is
currently ignored.  Consequently, the watchdog isn't running without the
user's knowledge.

Propagate the error code, print a message, and explicitly clear both the
WDOG_HW_RUNNING and WDOG_ACTIVE flags if start fails.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- New to the series.
---
 drivers/watchdog/msc313e_wdt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index 4a5cce2a16b1..6af865750ad0 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -191,11 +191,19 @@ static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
 static int __maybe_unused msc313e_wdt_resume(struct device *dev)
 {
 	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
+	int ret = 0;
 
-	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev))
-		msc313e_wdt_start(&priv->wdev);
+	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev)) {
+		ret = msc313e_wdt_start(&priv->wdev);
+		if (ret) {
+			dev_err(dev, "Failed to restart watchdog (err=%d)\n", ret);
 
-	return 0;
+			clear_bit(WDOG_HW_RUNNING, &priv->wdev.status);
+			clear_bit(WDOG_ACTIVE, &priv->wdev.status);
+		}
+	}
+
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(msc313e_wdt_pm_ops, msc313e_wdt_suspend, msc313e_wdt_resume);
-- 
2.53.0

