Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C93390233;
	Fri,  5 Jun 2026 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680010; cv=none; b=j3m/aPYmLrtCWK77WC1LOO41DUsBiGk+KRely0tqm6uQjkLu6//ZCLzzgJ9cnnngGuBwhoUrOSUczLGyc5I0CFCuehzdu38h8PRG+lc3tUlhzzdTxLg3ccddz/Gvhl05jNChXRlJOQBkByQeiGBs4rT1BekA3NSS/jAfSFBLD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680010; c=relaxed/simple;
	bh=TFR2ZDOLwSO8KpMOXTu/BFfjmT3o4oODxCQYDa4Xidk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+W8UnzOJApaJ6IczICQ1XDXwniYS08578rZXLP/LF9y4U6eMsOfgpNIyvQt2OCpGS5ZKz0t7CA4rtvDTfI1CEbLvpu1UC04Mkxy91vg5fEu5+M/ypflucgDJ4+aqKl7a7BDyxcoKTrYlmNbRsby95EbVn00jOg2qoH4bmEYdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=c52++xfr reason="key not found in DNS"; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="c52++xfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780679992; x=1780939192;
	bh=j9kCO9GTcIPjil62JnvoovkenD2UMj5ouvi3yiRJ8x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=c52++xfrChGEpiB99Z8fZsUYnH1+kRZTkRNx39NMnWvxSN3438p3n5cWFPPlXTjcD
	 fYUFSjvtypIJaTfvCSIkuXfyiCjrsLdZXLqBbM+WUISTs67abueGCF+SXQ2aJGM6hk
	 +7wA54Tv+2On4DVlMXpZc1Nwx4x0oWcOmdgt+t6qdDeRuz0uaYxKc7uZUlnXLot3gY
	 5gHQ5xJydlUd79JhyKD0416BEjvvzrhvM+uKRQBnnDXjMMozjZRMAUarrsgPhdp03C
	 lnT0+F/Yy9kPeQgmz2ru9J3rEq4xhpxUus5DaNTrfMQR8DA/gTdsY5d56yBmNFGiO2
	 7Ca80gULPNvLg==
X-Pm-Submission-Id: 4gX7Tw6GTVz1DDXp
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] watchdog: starfive: treat pm_runtime_put_sync() positive return as success
Date: Fri,  5 Jun 2026 13:19:38 -0400
Message-ID: <d3940b490ca9ba7e23bf90b4b2aefc23ca2facf9.1780666366.git.william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780666366.git.william@theesfeld.net>
References: <cover.1780664848.git.william@theesfeld.net> <cover.1780666366.git.william@theesfeld.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_sync() can return a positive value to signal a
non-error condition (for example, the device was already in the
requested state); only negative return values are real errors.

Both starfive_wdt_pm_stop() and starfive_wdt_probe() currently treat
any non-zero return as failure: pm_stop returns the value verbatim,
which the watchdog framework propagates as an error, and probe takes
the err_unregister_wdt path even on a successful but non-zero return.

Mask off the positive return value in pm_stop and tighten the probe
check to "< 0" so the legitimate positive return is no longer
mishandled.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index ed8c5711a..e047f52b0 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -386,9 +386,17 @@ static int starfive_wdt_pm_start(struct watchdog_device *wdd)
 static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
 {
 	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
 
 	starfive_wdt_stop(wdt);
-	return pm_runtime_put_sync(wdd->parent);
+	ret = pm_runtime_put_sync(wdd->parent);
+	/*
+	 * pm_runtime_put_sync() can return a positive value to signal a
+	 * non-error condition (for example, the device was already in the
+	 * requested state and no suspend callback was needed).  Only
+	 * propagate negative return values as failures.
+	 */
+	return ret < 0 ? ret : 0;
 }
 
 static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
@@ -503,7 +511,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	if (!early_enable) {
 		if (pm_runtime_enabled(&pdev->dev)) {
 			ret = pm_runtime_put_sync(&pdev->dev);
-			if (ret)
+			if (ret < 0)
 				goto err_unregister_wdt;
 		}
 	}
-- 
2.54.0

