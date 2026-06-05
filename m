Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8854F798A;
	Fri,  5 Jun 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665138; cv=none; b=ZJB8ZoJEkoa3T/PNqs6RPDixc9iCJo6rsxv3emllf1IojzMvGmHXqCbuR8KzbXBip/kL+QT8HBLHTs/qQNJmT7VzqUNuQcc7Zuwf32AtsH/UAPbtnO6aaDB9uuJm54UGydMAqdhw2Crp5fZ/WWUhyVc3ZqD4onfFi54W2KX2db4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665138; c=relaxed/simple;
	bh=NAFUSSgnlQ4pMbtcP9tBqMKeCzvjYGIetfdKT6rzPes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBAYnSuPw5xP2pTl6Iy/hbyEJuJIW2wWjUoR9WWxEbT9TvxybCdUDLYs8ApOys9nwUahv7Mep8twPM5GIKGHz0pf1zZHhbHkqh57M4S26HCMQow3I0ND1d9xfdrqVt3mG8cJ6OWR8cfnoXuV7uP3pqsksGncMJdwU5pXTvjZrxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=ugD5mCCZ reason="key not found in DNS"; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="ugD5mCCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780665132; x=1780924332;
	bh=UB1CHAWwfhnxd5b6vqbN6UybwRRnHYPv9ADzmVFG8Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ugD5mCCZZGwng5KKAH71wIgmeEBR7Xn2j8qQYyh8G1KUPezsFXeqT4orGw59cQWQR
	 mPmjuHCrUoSAw882bwrx8ZcJD3ex37v5mbcxGfJQoCTmMK3+WrfHGbx3U6MJQdlLkI
	 y5Vz01N8UBP7XR69tzEGq2oDCj/nwZaPT57gOm/bJnir+CA4ByFpE2F+c7hiwMqr9i
	 AbbkPGAQjiLX/hxy2Lbr3XDJR4D3lZigquIN6thdMvllq70Prr4PPaFtWeVnL/nfkl
	 I0WIHWTxhcaPLDVPtKIMI45+L3k+mZtTBH5P1HbAWARBHVQoVvj0ctaEfWBQqBcpOX
	 fTt6/gTvqEfLw==
X-Pm-Submission-Id: 4gX20B54Xxz1DFSh
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] watchdog: starfive: release early_enable PM refcount on remove
Date: Fri,  5 Jun 2026 09:11:55 -0400
Message-ID: <57fe44ec9b838cdde9245b706f42053472efcade.1780664848.git.william@theesfeld.net>
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

When early_enable starts the hardware at probe time, the runtime PM
reference taken by pm_runtime_resume_and_get() is intentionally kept
to hold the device runtime-resumed.  In the normal (userspace-opened)
case the watchdog framework unwinds that reference via pm_stop() on
close, and again via stop_on_unregister() during
watchdog_unregister_device().

But watchdog_unregister_device() only runs the stop path when
WDOG_ACTIVE is set (see drivers/watchdog/watchdog_dev.c).  If
early_enable started the hardware and userspace never opened it,
WDOG_HW_RUNNING is set without WDOG_ACTIVE: unregister returns
without touching pm_stop, and the probe-time PM reference is leaked.

Drop that reference in starfive_wdt_remove() before
pm_runtime_disable() runs, when WDOG_HW_RUNNING is still asserted.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 848935dc6..d9175b045 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -538,6 +538,19 @@ static void starfive_wdt_remove(struct platform_device *pdev)
 	starfive_wdt_stop(wdt);
 	watchdog_unregister_device(&wdt->wdd);
 
+	/*
+	 * watchdog_unregister_device() only calls our pm_stop op when
+	 * WDOG_ACTIVE is set.  When early_enable started the hardware at
+	 * probe time and userspace never opened the watchdog, the framework
+	 * state is WDOG_HW_RUNNING without WDOG_ACTIVE: the unregister path
+	 * leaves the runtime PM reference taken at probe outstanding.  Drop
+	 * it here before disabling runtime PM so the usage counter does not
+	 * leak.
+	 */
+	if (test_bit(WDOG_HW_RUNNING, &wdt->wdd.status) &&
+	    pm_runtime_enabled(&pdev->dev))
+		pm_runtime_put_sync(&pdev->dev);
+
 	if (pm_runtime_enabled(&pdev->dev))
 		pm_runtime_disable(&pdev->dev);
 	else
-- 
2.54.0

