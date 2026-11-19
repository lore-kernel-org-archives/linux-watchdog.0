Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122294;
	b=qAchKV789my2banAE2W2xwsg2xuN44uN6pI4JzjZ46Mpn+c51CTKf/zbd7Eql+EzKOmv
	 d1KuPaJkjdP81t5/ui6blfNpOKeuZGZq4moo7Vc9rs8Su4ZKldxC2ia77QOnkXu5w8buF
	 qy18fvupq8oYqNLDmqWofs9WE2lhPNqCZC6LHBV/XiUlo2ek8FgY3IxJDfknGzgXq7z+l
	 wEz1URWQleGV6gfvB3sjvbepYkT50fi+m4hT5NQpl8Qr34OuXLD3NUCd2jwnEH31ZkZbY
	 Nl3A60MVgky5xiS9dWVQ5CI9pCpCjSc6HAWZSzriJ62Zo9c+oOresgOgaVw/0EZrX+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122294;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=9oNljlNwScWT0AEm1avJ0WNN8F5rqnN+cRA8L0ZtGMY=;
	b=stDAi58zYGh462BjwndnbVeWgEXrizxo5RB5Jk9Pa4ZQVmo3BLExoYPic3qAiSHoXbUo
	 bkPxSB8WhpU/i5cHCnMd1mMAEq7FoeXKHR50QqBA6raATQwm/lkfW1s7KUdwAXlGauaRN
	 5upLR5z+kjXoMQEVAa16vJkQi6ZjjPa9uschg0lmTzJ7HSZMS2GInW69AKzDyinMCA+1N
	 puZxr+I8vOyIC3Ci/H88OsxpJZ9ue8QD3YGRKULc9H/NYJqxKSw1vpDG5g1yp5R20Vbi/
	 P2kVDKBcW/A7mGdnq/su3gOPq0Fk6QuVztgvdEDhOL4gkjLGaPile1cvYs4C+U37/WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=JATdUMx+;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63053606A320;
	Thu, 19 Nov 2026 21:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63053606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=JATdUMx+
Received: from abreu.speedport.ip (p5dc55a94.dip0.t-ipconnect.de [93.197.90.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9DC574C442F80A;
	Thu, 19 Nov 2026 22:04:07 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: intel_oc_wdt: Stop the watchdog during system sleep
Date: Thu, 19 Nov 2026 22:03:56 +0100
Message-ID: <20261119210358.610521-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1795122248; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=9oNljlNwScWT0AEm1avJ0WNN8F5rqnN+cRA8L0ZtGMY=; 
	b=JATdUMx+cNrNSSPaOrn7AigoYzP3eP0lI1gRsP/Hc3U0KIAH6IYIbfZsQe1xfMz9p3/g00IFkjiM
	dBiGpBKSoBAH3pNF+UAElNKgEgtaTa9sbBqDP0M0/s2adZwGLrKFOVwJ5UBEEIZ3GP3VH+8ppXAOW6
	lLAuawLe38sKSATr4mSlRplWu8CZa1lpvkBbY5sfCK+bsIbGMzxF+jztRXHHmxULfSL8/jT6Nfp3+6
	xOtwiVFi55kwnk69jGWKVlu/Q8ExVb3Q3vP2IKTSS24xXXLPaFcxJAAF2zj8MSpqNbdxLd86naLkxa
	94wsdAHfV0ZUjshoJZSaJ97h7y4AktLQ==

The driver has no system sleep callbacks, so a running watchdog keeps
counting in suspend-to-idle. Suspend-to-idle stops the tick, so neither
user space nor the watchdog core can ping it, and the watchdog resets
the machine once the timeout expires.

On a Dell XPS 13 9310 (Tiger Lake, BIOS 3.17.0, no ACPI S3) with systemd
`RuntimeWatchdogSec=30s` on /dev/watchdog-oc, both `rtcwake -m freeze -s
900` and `rtcwake -m freeze -s 60` result in a reset about 30 s after
entering suspend, without any message in the journal or in pstore. With
the systemd runtime watchdog disabled, the system stayed in
suspend-to-idle for 900 s and resumed normally.

Stop the watchdog in the noirq suspend phase and restart it, with a
reload, in the noirq resume phase, as iTCO_wdt does. Check the enable
bit in hardware rather than watchdog_active(), so a watchdog started by
the firmware, which only the watchdog core pings, is covered too. If the
control register is locked, the watchdog cannot be stopped, so leave it
alone.

Unlike iTCO_wdt, do this for all sleep states and not only for
suspend-to-idle, as it is not documented whether the platform firmware
stops the OC watchdog in ACPI S3 or S4. Hangs in the device suspend and
resume callbacks outside the noirq phases are still caught.

Tested on the Dell XPS 13 9310 with the patched module built for
7.4.0-rc1 and systemd RuntimeWatchdogSec=30s: rtcwake -m freeze -s 120
resumed normally on the same boot, the OC watchdog enable bit (I/O
0x1854, 0x0080601d) was set before and after, and the watchdog kept
running afterwards. The stock module reset the machine in 2 of 2
attempts.

Fixes: 535d1784d8a9 ("watchdog: Add driver for Intel OC WDT")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    Tool use: Claude Code (claude-opus-5-5) found the reset while
    measuring s2idle power on ortiz, wrote the change and the commit
    message; compile-tested with W=1 (CONFIG_PM_SLEEP=y/n) and
    checkpatch-clean.

 drivers/watchdog/intel_oc_wdt.c | 42 +++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_oc_wdt.c
index 0b012aeb18e15..da93db34dfd2f 100644
--- a/drivers/watchdog/intel_oc_wdt.c
+++ b/drivers/watchdog/intel_oc_wdt.c
@@ -44,6 +44,7 @@ struct intel_oc_wdt {
 	struct resource *ctrl_res;
 	struct watchdog_info info;
 	bool locked;
+	bool suspended;
 };
 
 static int heartbeat;
@@ -204,6 +205,7 @@ static int intel_oc_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	platform_set_drvdata(pdev, oc_wdt);
 	watchdog_set_drvdata(wdd, oc_wdt);
 	watchdog_set_nowayout(wdd, nowayout);
 	watchdog_stop_on_reboot(wdd);
@@ -212,6 +214,45 @@ static int intel_oc_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, wdd);
 }
 
+/*
+ * Neither user space nor the watchdog core can ping the watchdog while the
+ * system sleeps, and in suspend-to-idle the counter keeps running, so stop the
+ * watchdog late in suspend and restart it early in resume. Check the hardware
+ * enable bit, as the watchdog may also have been started by the firmware.
+ */
+static int intel_oc_wdt_suspend_noirq(struct device *dev)
+{
+	struct intel_oc_wdt *oc_wdt = dev_get_drvdata(dev);
+
+	oc_wdt->suspended = false;
+
+	if (oc_wdt->locked ||
+	    !(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & INTEL_OC_WDT_EN))
+		return 0;
+
+	intel_oc_wdt_stop(&oc_wdt->wdd);
+	oc_wdt->suspended = true;
+
+	return 0;
+}
+
+static int intel_oc_wdt_resume_noirq(struct device *dev)
+{
+	struct intel_oc_wdt *oc_wdt = dev_get_drvdata(dev);
+
+	if (!oc_wdt->suspended)
+		return 0;
+
+	intel_oc_wdt_start(&oc_wdt->wdd);
+	intel_oc_wdt_ping(&oc_wdt->wdd);
+	oc_wdt->suspended = false;
+
+	return 0;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(intel_oc_wdt_pm_ops, intel_oc_wdt_suspend_noirq,
+			       intel_oc_wdt_resume_noirq);
+
 static const struct acpi_device_id intel_oc_wdt_match[] = {
 	{ "INT3F0D" },
 	{ "INTC1099" },
@@ -223,6 +264,7 @@ static struct platform_driver intel_oc_wdt_platform_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.acpi_match_table = intel_oc_wdt_match,
+		.pm = pm_sleep_ptr(&intel_oc_wdt_pm_ops),
 	},
 	.probe = intel_oc_wdt_probe,
 };
-- 
2.54.0

