Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468D3845A6
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680008; cv=none; b=IA0/LrXBZde/OewcfybUeVfIirJfbazvpMQeOpY2h8ltC+gWHEWUPFq5UZf2Ki+oFH9v+CW4L1Ml4LBotX1M9gTrs+4w60pXzPamL1jqqjbroHRMSeRMFRBQNImWMHvwoUKpj5b0MhMOYB4pghW72z+gPH2MGB0I5xvOKOJD4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680008; c=relaxed/simple;
	bh=/v+yP0ivLjzr+EfkSnCQP+66rJZUsfB/jdnnERhaeKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+Y8CBOe3ZiV9onTQFNri6E8L22IPkxu91aVdG5Pp5ddnPS246yf+6BxeCNb6TfVgsB99+nceR8AJ6lgu4Vb/y4bwOZKJRCLT5KrZzJbgdU+83qASZgb09ZzsEFt2R5ms1TsncuL98GgAxGAkNRWjTn8YKHtAmI3EooLnLVMhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=10q2aav7 reason="key not found in DNS"; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="10q2aav7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780679994; x=1780939194;
	bh=y+AkXVLiX4yk/y/C0+/Mp3RGJYbGlRAkuJKjAOT4gWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=10q2aav76oa1bw2VsSQ/rBV42AsFkrzcLKJlJXUIpTovSrYQKirylKzprWqGiAp5v
	 yvar/xSI2dGb1DE11ULvd3bI5rqY1Ff4mdrcIBlkXCzQy7QRKowdnfl38Br9HtSsNj
	 79PXkM3utYCHUteChJWZBJTpxOHB5rBD0PKXKVI+Q5f7MIOXL1Y0lvnXgLoFXDCR6p
	 Tr9nug+LrVxqu1FIUlRP6J69hfcaK8t2etvKhAOMcki9tm5pbmMeBbVZxEfOB8TIRj
	 LO5TMMGmA5v/T3uDacwFjA7fGBhCedgomcSwbDPmAD7VyGR+GqF91vfFpJWBJsI7AE
	 Djg57cr3eRLNw==
X-Pm-Submission-Id: 4gX7V10BkQz1DDXg
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] watchdog: starfive: guard system suspend/resume hardware access
Date: Fri,  5 Jun 2026 13:19:40 -0400
Message-ID: <790637054268689cf06f47cac161118864edab8f.1780666366.git.william@theesfeld.net>
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

Additionally, restart the hardware on resume for the early_enable
case (WDOG_HW_RUNNING set without WDOG_ACTIVE).  Without this, a
system suspend stops the early-enabled hardware via the suspend
callback above, but the resume callback only restarts when
watchdog_active() is true, leaving the watchdog permanently stopped
after the suspend/resume cycle.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 34 ++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 856e55f04..e3a47c0c3 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -564,11 +564,16 @@ static int starfive_wdt_suspend(struct device *dev)
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
@@ -582,12 +587,27 @@ static int starfive_wdt_resume(struct device *dev)
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
 
-	if (watchdog_active(&wdt->wdd))
+	/*
+	 * Restart the hardware on resume for both userspace-opened
+	 * watchdogs (WDOG_ACTIVE) and watchdogs started via early_enable
+	 * (WDOG_HW_RUNNING).  Checking only WDOG_ACTIVE leaves the
+	 * early_enable case stopped after a suspend/resume cycle even
+	 * though the framework still considers the hardware running.
+	 */
+	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
 		return starfive_wdt_start(wdt);
 
 	return 0;
-- 
2.54.0

