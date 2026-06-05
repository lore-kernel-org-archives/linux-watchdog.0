Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F83DB300;
	Fri,  5 Jun 2026 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665134; cv=none; b=JYnLLxR+57Az4hAnMSRWuJaoxizMXwrxyzRxZoQcV/bdnN1wvDz05KWphIO1EB61KCgDv1HOgG6FHc256z4t8R3nGMG/Mthb2zW44yOrdUMZKWBJZ6Pvlc3Rh2PmMo1/9kPcrCfwHMg2hw8yH4Z1VKt3yQ3wnOFkmfvTnEklebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665134; c=relaxed/simple;
	bh=SndQsFKzfUAF6PDEXcFmKRk0KRajgFY+eCK6F1ndD90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc+8nBT6kDWUDsgCnNnGgXNYR2+cjI/BDh6TPNIEFil31zqSq9cxUBJAf9L77CU+WusqcGEI3bWnb0O1hIiMCZVnJBEaIoF4syRAm8pGvbnYNajxhSJuhUqrRHs9s9xOJXGrcx7xow6BPxhz5UN7MRfJkE5XJsXSB3bVeJrfN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=1ayrrRhP reason="key not found in DNS"; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="1ayrrRhP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780665130; x=1780924330;
	bh=ZmWBEBsS6wSxsZ3LY4CY6OHjojI2S0R+xj1CQoxBMNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=1ayrrRhP790LLqs55VwPJOOrck1KxXRbDGXX/NqThsz3FLHkoogkreqX0CxEnecGZ
	 Qz+2EPQRtKCGUh5QhWA+00Tt4sjiFlpEwuK2A3vsyfkVq3K/bQ8KPEICId2d/utQfp
	 lD4BoZT25CnYtAH+1IWh4VOpVcH+oY16CccI3r/Pct9DyhcO9SRHflz3joypImtxIZ
	 HP65DWtVmMPZQgwOoUEhUUdysoKBYdRniBXS9Ij3WwP3aBfh00Sd2Q9x8rw4YdTPk3
	 QGp74Gp6pffV69YlaIp9qak94dSdicjjAnngpKYPeONQR27+ddtwh9OW5sYvnoV128
	 8CPbI8hmB61CA==
X-Pm-Submission-Id: 4gX20820Ywz1DFSm
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] watchdog: starfive: avoid PM refcount underflow in shutdown
Date: Fri,  5 Jun 2026 09:11:54 -0400
Message-ID: <c7398cba84ea85ed041fe5fe7868ad445b40685f.1780664848.git.william@theesfeld.net>
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
index 4926984bf..848935dc6 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -549,7 +549,19 @@ static void starfive_wdt_shutdown(struct platform_device *pdev)
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

