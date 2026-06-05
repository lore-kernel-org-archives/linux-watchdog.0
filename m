Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28A336ECF;
	Fri,  5 Jun 2026 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665131; cv=none; b=P6+T9HyE5XU4mlzdTRk3U4y2THEYdkipmdjlJG96vyza57PdDM7bIeAQQ2ysv+iW2HGNG5kA+GOUGs7o3kNtMaHvA+vsB/fo7m5Gr2ocu9QcqAZ7NX4zkA5El7QhBJVfulDtYE2a//1qHeJYmh69qhJlGystH7cBfDCzbeIuQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665131; c=relaxed/simple;
	bh=sarV9ZnJceZxz4q6gqxxsk1ZLAhzHDUNx3scqu+cfko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU0yGMkqw9guUA/NUHcpT843JXWDVsOlr83j1CqTE2+7iG8BorOrc90tBhG1Iwq2zDo+jHxccXZQlO5w3ash6EtKuXiFuNMN4oFuXLy1CZ3a8VUdWQNVfGNfsNg2Brgeo6QmOb318pCGxYeA5dATtz/x6EhCHjKE9rdfxUPfg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=cYZ5nrr8 reason="key not found in DNS"; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="cYZ5nrr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780665128; x=1780924328;
	bh=5qNukEK/rBUeJ+sg8uGW3tFF+vu84wXy1cVEbIckFns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cYZ5nrr8G6nWCjqbtvXGZXHfWBTZGfBKcLLQr0zZJdsX7M3DRyilO0/p+CyxeQejp
	 y8r/8+pOa75OpcNM5/h3JLrnACQMyA2IQpTmATdcWYgm/IRo70TDV0pDBbGhRycJ96
	 BmcU87g0Vk6Gd+grg7T10CqvVY04LZKptbVVHC/sqr83QqPWfCWDB9IS1ey/nvqz+A
	 Or5fVJpC/PSdVyW02CBPScxhjMFrj6E3ps8NyL4zeVKw8ZyosNDQKecJ9Nln8KMETh
	 818/X2e5ROMWPbrv73SBdGmrYkaOEDtvaPoTK4SsZhIZ0kI9xIM5YdTPeyHujn+JE3
	 ZSzC82v/D6SAw==
X-Pm-Submission-Id: 4gX2055Gprz1DFSh
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] watchdog: starfive: guard system suspend/resume hardware access
Date: Fri,  5 Jun 2026 09:11:53 -0400
Message-ID: <d65217907ee0eaff853e50c46658919436b9f1ef.1780664848.git.william@theesfeld.net>
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

starfive_wdt_suspend() reads from STARFIVE_WDT_VALUE and writes to
WDOGCONTROL via starfive_wdt_get_count() and starfive_wdt_stop()
before calling pm_runtime_force_suspend().  If the device was already
runtime-suspended when system suspend began, the apb and core clocks
are gated and those register accesses produce a synchronous external
abort.

starfive_wdt_resume() has the mirror problem: it unconditionally
restores the WDOGLOAD value after pm_runtime_force_resume() returns,
but pm_runtime_force_resume() leaves the device in whichever runtime
PM state it was in pre-suspend.  If the device stays suspended, the
restore writes race with gated clocks.

Gate both halves with pm_runtime_status_suspended() so the hardware
is only touched when it is actually active.  When the watchdog was
suspended at runtime PM level there is no state to save or restore.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 6539bf089..4926984bf 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -556,11 +556,16 @@ static int starfive_wdt_suspend(struct device *dev)
 {
 	struct starfive_wdt *wdt = dev_get_drvdata(dev);
 
-	/* Save watchdog state, and turn it off. */
-	wdt->reload = starfive_wdt_get_count(wdt);
-
-	/* Note that WTCNT doesn't need to be saved. */
-	starfive_wdt_stop(wdt);
+	/*
+	 * Only access the hardware while the device is runtime-resumed; if
+	 * runtime PM has already suspended the device, its clocks are gated
+	 * and a register read/write would trigger a synchronous external
+	 * abort.  WTCNT does not need to be saved.
+	 */
+	if (!pm_runtime_status_suspended(dev)) {
+		wdt->reload = starfive_wdt_get_count(wdt);
+		starfive_wdt_stop(wdt);
+	}
 
 	return pm_runtime_force_suspend(dev);
 }
@@ -574,8 +579,16 @@ static int starfive_wdt_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * pm_runtime_force_resume() leaves the device in whichever runtime
+	 * PM state it was in before system suspend.  Only restore hardware
+	 * state when the device is actually resumed; otherwise the register
+	 * writes below would race with gated clocks.
+	 */
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
 	starfive_wdt_unlock(wdt);
-	/* Restore watchdog state. */
 	starfive_wdt_set_reload_count(wdt, wdt->reload);
 	starfive_wdt_lock(wdt);
 
-- 
2.54.0

