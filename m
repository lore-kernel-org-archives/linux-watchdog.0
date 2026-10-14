Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28C31E84F
	for <linux-watchdog@vger.kernel.org>; Wed, 14 Oct 2026 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017579; cv=none; b=FfktEqtaWyjAzQqZvq7x9lrE+SSl+xlVlZtXddW28vvaOntK5ZpbS84rtzAa3lOA3lsxwvX7Qb8gX3vHVC1nBSIVv2iW3qABp9gcnYviL9t0cLksigZYX4nFogpKnPvkmTcrlUSILoemyhLWyxhTxGZNalhKq2AGG2gOmnQJ/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017579; c=relaxed/simple;
	bh=AX2OgX9JNXXhk55wwwVTWor2YrgAG8rtLyuifTHXGqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pboOQceeYNMqpIyLYSiN0VE9ZhdioCLsu1TKza8JM/OdTNxTj+UhH6q3KlO0rlqJ/9tzRbLO3NLwu5fOQ+V5HxFHmjHtK1+Q5cs0EJI54I38fPWaDgu7MN0sy6AeY7UERDZlS95k+yRg0M1ezxXsJZ8tKyivYI3Jodl4kupCTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvbStanm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvbStanm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8361F000C4;
	Wed, 14 Oct 2026 22:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792017578;
	bh=mxl7bKnMGGFXkps2Wgm0oQQDOv6wA4YQaW/l0sVA49A=;
	h=From:Date:Subject:To:Cc;
	b=EvbStanm58VNLEZ+JGYF7YPuPiXOV3b+KmR1mRz27eC18hJTgNSS6GoVbaT3Mk55/
	 Dm337L44Qgxq5lY7BxX+GMXhKJ56iRZjITD+ftjQm3UUh4vD/y6S8nqRM8vzReIzi2
	 Dqn3ajAREZe2nnTcPfnfxmHDDYf14+juOvjeTj8wrdLPNtiTAr1aJQWYLbaM8w6D88
	 qCaqp5UDwdXOYIV6pmC6tRQ2sOmb7v6eTPotUwKXBY+BZAT5cVYW12YZ/LbSOyNFh4
	 uQC8R4bXbACO+1hZQmfcksP8+yimaSnPeR7YJ6AF9XmkKPsujJpum6oMlyB8KO6x7m
	 FiHFJ4aKnfxfA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 00:39:29 +0200
Subject: [PATCH] watchdog: bcm7038: Add a restart callback
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrDIBAF0KuEWXdAgzFtr1K6EP01szHFCY0Qc
 vdKlm/zDlJUgdJzOKjiJypr6bC3geISSgZL6qbRjN4a6zijoIlyy/7uPO9hi0taM1coNk7ORf+
 YwjzDUD++FR9p1/96n+cfqcEBkm8AAAA=
X-Change-ID: 20261014-genexis-xg6846-watchdog-reset-d44c695a77e0
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-watchdog@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The watchdog in BCM6846 can reset the system, but bcm7038_wdt
does not provide a restart callback. Add this.

The vendor kernel also uses a short watchdog timeout to reset
this SoC.

Implement the restart operation by stopping the watchdog, loading the
minimum count of two ticks and starting it again. A count below two
does not trigger a reset, as also documented by the U-Boot BCM6345
watchdog driver.

Disable local interrupts across the register sequence and
reset wait  so preemptible uniprocessor MIPS kernels cannot run
a competing watchdog operation.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/watchdog/bcm7038_wdt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index e038dd66b819..1637e32ac02e 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -5,8 +5,10 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irqflags.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -113,6 +115,32 @@ static unsigned int bcm7038_wdt_get_timeleft(struct watchdog_device *wdog)
 	return time_left / wdt->rate;
 }
 
+static int bcm7038_wdt_restart(struct watchdog_device *wdog,
+			       unsigned long action, void *data)
+{
+	struct bcm7038_watchdog *wdt = watchdog_get_drvdata(wdog);
+	unsigned long flags;
+
+	/*
+	 * Prevent runtime watchdog operations from interfering on
+	 * uniprocessor systems where restart handlers are preemptible.
+	 */
+	local_irq_save(flags);
+
+	/* Stop the timer before changing its reload value. */
+	bcm7038_wdt_stop(wdog);
+	/* The watchdog does not fire with a count below two. */
+	bcm7038_wdt_write(2, wdt->base + WDT_TIMEOUT_REG);
+	bcm7038_wdt_ping(wdog);
+
+	/* Flush the writes and wait for the reset to take effect. */
+	bcm7038_wdt_read(wdt->base + WDT_CMD_REG);
+	mdelay(500);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
 static const struct watchdog_info bcm7038_wdt_info = {
 	.identity	= "Broadcom BCM7038 Watchdog Timer",
 	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
@@ -125,6 +153,7 @@ static const struct watchdog_ops bcm7038_wdt_ops = {
 	.stop		= bcm7038_wdt_stop,
 	.set_timeout	= bcm7038_wdt_set_timeout,
 	.get_timeleft	= bcm7038_wdt_get_timeleft,
+	.restart	= bcm7038_wdt_restart,
 };
 
 static int bcm7038_wdt_probe(struct platform_device *pdev)
@@ -167,6 +196,7 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.max_timeout	= 0xffffffff / wdt->rate;
 	wdt->wdd.parent		= dev;
 	watchdog_set_drvdata(&wdt->wdd, wdt);
+	watchdog_set_restart_priority(&wdt->wdd, 128);
 
 	watchdog_stop_on_reboot(&wdt->wdd);
 	watchdog_stop_on_unregister(&wdt->wdd);

---
base-commit: 164778eff84a0ee908db0b28136a6f7d7f785c33
change-id: 20261014-genexis-xg6846-watchdog-reset-d44c695a77e0

Best regards,
--  
Linus Walleij <linusw@kernel.org>

