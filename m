Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F634390209
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680009; cv=none; b=OGPu8RuCvFMI3Jhaq7REJMHHRv8/Xifr80GyndkCdwiQQvVmscL4YLVmvHRg3/uPRl3eh7TdP188XmX13oZ3RYsGABTqW6wAdtLjFS/sEh+bg3ixYB2s2V1XROCW+w+bmmUdjAKuHkprNWWQfRTrAfAEa4AnC1PLgLUE8KowNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680009; c=relaxed/simple;
	bh=uX2OO8VIAJ98ooonTDAk3VBWuXWuFIjpzdpbBmNEyEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9lj7r32Ld2jGXIPMFpEECor8NBlXqm1+IgI6XeGfv2GiTzkAWulzmA3sgpBuHYHujxEws+tg71uFZT9yk3OyPWKHs9mlyYQ4a+v7a44XQtu4XFsZpV8O+y54uTFQf5dN6ZYPLERKdz39oijsbIc/ypLdNK5r/fw9CMPaAH4LqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=E/Q8XoPu reason="key not found in DNS"; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="E/Q8XoPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780679998; x=1780939198;
	bh=LGOXpfMPxFoQZg423hlG08nWuFFWTpOwynBjJFDYYww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=E/Q8XoPuaQXUrpNupbT8YcSJzN+wW+7SGf8jPXx2NVWLVYHlcHpIyiv1zZFFeB57p
	 SsKWC6ankURqaFWErXLYndtnR1dc5b5f1z9FuV0NXk9FylNKAIZl7aYFyV0wByhXox
	 xIPvFAGFNGJsz/ObS4FVNDE4mJCPoqoZTp+EeFOE7nsA8XnVRPcJnwy7z2LI1sUFvf
	 Q89ZfdAhieZ0TEvfLcmcbuYjO9u7lcqOZ3i1dLWd+BqFWBUGAgxNT2nvlQ/tngG3sa
	 3roY6p0HFlaCnca90Ikv6wI5fssDl/dh5Fid+N9tqHWRGmNaP9fXVMW8OrJ5cgUQMM
	 Ksew4un1mpnyg==
X-Pm-Submission-Id: 4gX7V25lvLz1DDXj
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] watchdog: starfive: avoid PM refcount underflow in shutdown
Date: Fri,  5 Jun 2026 13:19:41 -0400
Message-ID: <294a324adc8007768829613b03d0415a44b2af35.1780666366.git.william@theesfeld.net>
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

starfive_wdt_shutdown() unconditionally calls starfive_wdt_pm_stop(),
which drops a runtime PM reference via pm_runtime_put_sync().  If the
device was never opened (so there was no matching pm_start()), and
early_enable is also off (so probe already balanced its own get/put),
the counter is at zero and put_sync() drives it negative.

Only call pm_stop() when WDOG_ACTIVE is set (meaning a paired
pm_start() happened on open).  For the early_enable-and-never-opened
case, the framework state is WDOG_HW_RUNNING without WDOG_ACTIVE; in
that case stop just the hardware so the watchdog does not keep
ticking through shutdown, while leaving the PM refcount for the
remove path to release.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index e3a47c0c3..6137e98f1 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -557,7 +557,19 @@ static void starfive_wdt_shutdown(struct platform_device *pdev)
 {
 	struct starfive_wdt *wdt = platform_get_drvdata(pdev);
 
-	starfive_wdt_pm_stop(&wdt->wdd);
+	/*
+	 * Only drop a runtime PM reference when we actually hold one.  The
+	 * watchdog framework increments it via pm_start() on open; when
+	 * early_enable started the hardware without an open, the reference
+	 * was taken at probe time and the framework state reads as
+	 * WDOG_HW_RUNNING without WDOG_ACTIVE.  In the inactive-and-not-
+	 * running case there is nothing for us to do and dropping the
+	 * counter unconditionally would underflow it.
+	 */
+	if (watchdog_active(&wdt->wdd))
+		starfive_wdt_pm_stop(&wdt->wdd);
+	else if (test_bit(WDOG_HW_RUNNING, &wdt->wdd.status))
+		starfive_wdt_stop(wdt);
 }
 
 static int starfive_wdt_suspend(struct device *dev)
-- 
2.54.0

