Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F92309F00
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679999; cv=none; b=MWAf2spNwFVlph5ZQkjotKMC72xo+OyRaLMf2q5sWuEtrUKYWBAkeiKXI6W/zO29/TBfnhHyU+M6ygxd5ldyYROpmPcJPdGoBocWD8W7aBTL9u9Bk7a1ShQOvBPTnZ4gLvbviVaQuKi8xCBDfIc2bPpA6NmgEAjftbBU31ds/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679999; c=relaxed/simple;
	bh=E448ctvAsbyMRKRPnlBix0CmIiz8mOPi5UFpTBEIm28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrBWee7lnOHyOLB4PrEZTxNtVsFBJPIqy86vDLtecAIpGU9qdNburTdEXcisLT6h2qjiTz772PGhJv8Yo81oawj9Loa11cDLVc6hcH+3fr3OBkPUVxkEklzvbI3cJ8P9zXk3WsMIVI84uNsAPnHrj8OPHHoLgivFOny/qfKobgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=GnLVCkB9 reason="key not found in DNS"; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="GnLVCkB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780679992; x=1780939192;
	bh=yIrWc8wNoc75cAvtPZoI/WTAVLJ3Rtu/+7VIbF4n9Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GnLVCkB9fHMl8AhPNRNCEIE+RRKy9ceyTlDm0CLhsb8Ni7VLshCeOoggswoCEh60f
	 ragcXLAWZb5t5pBWz1ypEfjujYVXe/49JbP3PYx7zGTvM2ylIVm77ppq/Opf0o/nDm
	 /6TeyR1/GIMvIp1jpxdhO4Gz1eKWsFa6fJL4kJ9s0BQNT+ESH6nkT7aAT6OAeClsoJ
	 XdF7pRSRJ9fPSTmBxwzJWgdMFmhg+yDHlGhxNIdb55E8GFzgOI0Y/xUbCUjZh2WEwh
	 YG/ayxBv+eT6EkmDSwl2zZafOPHvsWSlBqGiuMKg2hOzMN8pFN1LXqXtvYMFfTiMU0
	 uQLUMuMqsI1SQ==
X-Pm-Submission-Id: 4gX7Tz1Dq7z1DDXY
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] watchdog: starfive: balance PM refcount and disable in probe error paths
Date: Fri,  5 Jun 2026 13:19:39 -0400
Message-ID: <bc680dec6d45a31a29db46a66968d054e22b19aa.1780666366.git.william@theesfeld.net>
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

The probe path takes a runtime PM reference via
pm_runtime_resume_and_get() (or enables the clocks directly when
runtime PM is unavailable), but several error paths after that point
do not release that reference before returning, and the two earliest
error paths return without calling pm_runtime_disable() at all even
though pm_runtime_enable() has already run.

Restructure the error handling into three labels so every failure
path balances exactly the resources it has acquired:

  err_pm_disable:     pm_runtime_enable() ran but no clock/refcount
                      was taken yet (resume_and_get / enable_clock
                      failed).
  err_put_pm:         clock or PM refcount is held; release it, then
                      fall through to disable runtime PM.
  err_unregister_wdt: watchdog_register_device() succeeded and the
                      success-path pm_runtime_put_sync() returned an
                      error.  The put has already decremented the
                      counter, so this path jumps directly to
                      err_pm_disable rather than falling through to
                      err_put_pm; otherwise the counter would be
                      decremented a second time and underflow.

Update the in-function goto targets to use these labels and remove
the early "return ret;" paths so pm_runtime_disable() is always run
once pm_runtime_enable() has been called.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index e047f52b0..856e55f04 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -460,17 +460,17 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	if (pm_runtime_enabled(&pdev->dev)) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
-			return ret;
+			goto err_pm_disable;
 	} else {
 		/* runtime PM is disabled but clocks need to be enabled */
 		ret = starfive_wdt_enable_clock(wdt);
 		if (ret)
-			return ret;
+			goto err_pm_disable;
 	}
 
 	ret = starfive_wdt_reset_init(&pdev->dev);
 	if (ret)
-		goto err_exit;
+		goto err_put_pm;
 
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 	wdt->wdd.info = &starfive_wdt_info;
@@ -482,7 +482,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	if (!wdt->freq) {
 		dev_err(&pdev->dev, "get clock rate failed.\n");
 		ret = -EINVAL;
-		goto err_exit;
+		goto err_put_pm;
 	}
 
 	wdt->wdd.min_timeout = 1;
@@ -498,7 +498,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	if (early_enable) {
 		ret = starfive_wdt_start(wdt);
 		if (ret)
-			goto err_exit;
+			goto err_put_pm;
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	} else {
 		starfive_wdt_stop(wdt);
@@ -506,7 +506,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret)
-		goto err_exit;
+		goto err_put_pm;
 
 	if (!early_enable) {
 		if (pm_runtime_enabled(&pdev->dev)) {
@@ -520,8 +520,20 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 
 err_unregister_wdt:
 	watchdog_unregister_device(&wdt->wdd);
-err_exit:
-	starfive_wdt_disable_clock(wdt);
+	/*
+	 * The only path into err_unregister_wdt is the post-register
+	 * pm_runtime_put_sync() that returned an error.  That call already
+	 * decremented the runtime PM usage counter, so falling through to
+	 * err_put_pm would put again and underflow the counter.  Jump
+	 * straight to err_pm_disable.
+	 */
+	goto err_pm_disable;
+err_put_pm:
+	if (pm_runtime_enabled(&pdev->dev))
+		pm_runtime_put_sync(&pdev->dev);
+	else
+		starfive_wdt_disable_clock(wdt);
+err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 
 	return ret;
-- 
2.54.0

