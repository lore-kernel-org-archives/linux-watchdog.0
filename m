Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6375532E757
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680008; cv=none; b=Toqnml5W4nJkWPqG7Ej9l5/Fbyg/dXanI45uqA+yMDMj9G95CG/2vfXzwRetYAwfPjo6oog9qaiRbLnUETdAQsCmv7waWrbvR+PY+eWJw4scUCjjoPk2NpEn+rabhZY/ZatGvrsYzB6ZQdqfCP7DJklrHFmzMPcg1gB2cD+6jKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680008; c=relaxed/simple;
	bh=PqgK0cYWrHnGTwh5lFEXBxUzY1qNaTyQRbMI+o9rCX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmYViEXloduR9MZGUq+uQ5bOyKtBelRIEIqdiDBqL6h5xpmlmRgSCoNlEEZ9SfTLYMpJTLMPkDMQmDQ7Sm2hDH9X/1+Qtd8uqpDnHmDURg38ExZT3U25el6l+DTqhwbEyxLiAW+ACg3zUVZYYosVCUjh20AqsVnLuc8eWB1JlJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=V8gO0Xl4 reason="key not found in DNS"; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="V8gO0Xl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780680000; x=1780939200;
	bh=XTUAzXgAtMCDdvg+7OgksKUkAdhwoiglQ/p5dcwkckc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=V8gO0Xl41/AKYrVm2GPbrPu9NxCg0WOU6/xCmwe+LczVNJnjPNnDJHNJFeyuNcHA3
	 0CIR650rOmYBrYjz3LM9qK6BQdVxqqLbPyTVJoaIgfIkvY+mxvl0NAQww50g3jeDla
	 yfU7hPLTFCGxOY1o+X11pgi+/6Nw8XcRZ6xLmDQTacSB8d+1BaSihWQs17CD6Q6RNw
	 jJD/3+3uxIhR+DsuGx63KRahKXt+cvtXv50B9jlsYR5E/RV5MSc6RKXXqe3o+zjqxa
	 NhNdAQvKrIhA2yIlVKCUX3udqk5d9AWtUdBReN6GtrKbwCPJ1tZ/a17/3dr/s5DWaj
	 dcIjv8t48+fsQ==
X-Pm-Submission-Id: 4gX7V573skz1DDXY
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] watchdog: starfive: release early_enable PM refcount on remove
Date: Fri,  5 Jun 2026 13:19:42 -0400
Message-ID: <5e900cfc2e6441207930b3bda3ec0bc818c2087c.1780666366.git.william@theesfeld.net>
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
index 6137e98f1..ad5bb67d4 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -546,6 +546,19 @@ static void starfive_wdt_remove(struct platform_device *pdev)
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

