Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976942777F3
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665131; cv=none; b=Q30A3QNVGV8Ko/So0Fw+Qj2LlrRhmcFlpUivMnM4BKKZLbT7tw1K5k3VfBQLnAMdt4iESsYEzYKpiHsCZ0xNhV/1nFAkVIZbFK/C8tvancHU42Z2A2lk19PHjiSWw0KMq06eHBc/DiBL7AA/N2+ZPZCKHUmqUns4P+VXFxasyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665131; c=relaxed/simple;
	bh=5Ou2UWIsXRf5J1leh8L9HfwC/eZC+QTqHG4JBfxHCX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUcQQjgn9ckJwS8iEUaq/U1XFT+YgYPHNK+01EUm0KoV8xLPjukDJN12QPdDUIfJmPqflqj/4ClM3l8eeblMwlGulrq5LO7IWDAjCtgYIEVeLhHw0V/fLmKFBAShugbt9TWvhSWRwe5MeB2NErF3lzqS9lk8yDeeBJiuHNCU0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=etW/9ZF1 reason="key not found in DNS"; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="etW/9ZF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780665126; x=1780924326;
	bh=Oyj4FE/DQKQtHKcOpW57XDJVXp6PwZIsXvfERmGaalM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=etW/9ZF1M1h3SPuph049Irk9qZhsOb23HnJPVFx2QTsuE1KtgzHMpMc3oDba96aQm
	 R+pmU0oEZgn/ySXcaAMHuBnEt+Qqyo3yuiwOYCP/hKZITqeV2lW9of/Z7H2I+me/Y6
	 snwIDtsPE9NsWdx/42XjYWzRa9XOaVWDGdKBmMPT+Ct1GmJN3RcRn4Y0BmoOgkv9VQ
	 9n3oZCyjsfZsK38LomTlKh8rmXi42ah7WgFK7ZVulC6CNHrx5y7pwBPqEfo+qxDLcO
	 Au+AYqukh3DwE8a0oPdj3kB4jnEoewWc66mcvPDC3mL+AzO+F0AezgW8ZtrW6aVYl2
	 bz1HzH+8SP3qw==
X-Pm-Submission-Id: 4gX2040WMNz1DFSn
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] watchdog: starfive: balance PM refcount and disable in probe error paths
Date: Fri,  5 Jun 2026 09:11:52 -0400
Message-ID: <21de4987785fbde29d23f5fde53dc1012e0ae768.1780664848.git.william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780664848.git.william@theesfeld.net>
References: <20260605122336.159546-1-william@theesfeld.net> <cover.1780664848.git.william@theesfeld.net>
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

  err_pm_disable: pm_runtime_enable() ran but no clock/refcount was
                  taken yet (resume_and_get / enable_clock failed).
  err_put_pm:     clock or PM refcount is held; release it, then
                  fall through to disable runtime PM.
  err_unregister_wdt: watchdog_register_device() succeeded; unregister
                  before releasing the refcount.

Update the in-function goto targets to use these labels and remove
the early "return ret;" paths so pm_runtime_disable() is always run
once pm_runtime_enable() has been called.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index c821b38d2..6539bf089 100644
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
@@ -520,8 +520,12 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 
 err_unregister_wdt:
 	watchdog_unregister_device(&wdt->wdd);
-err_exit:
-	starfive_wdt_disable_clock(wdt);
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

