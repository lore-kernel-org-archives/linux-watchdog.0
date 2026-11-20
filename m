Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170243;
	b=Wc19nw09I1XroQz/dL+0S2og42/8nlxaDm29aDGb5qf2xxqk4fpWxlhNjTftq1UL+JRf
	 8TNjxiaWrcNIhOYGnteE+YIFo7/ixj4wejEDM76r6SgTnrob8gQcT8EuMdTHqqpkdY757
	 WKIpgkoU6BW+3VG3Dop3DdSRU8Fa8AiDZWTf48OnU39rcj9LvfUn0Jgoq5QRBbMu92fxQ
	 v2R6SY1G20lROn7iUl+j6l7s2TDCU+TyW8Vi0J4I2PcHpQ7NLrABUYD2u8MJO6xLoGR0O
	 40Xrrhnk5vMhjLDUkYGkU9JGQJKnQ5zSgU+nBcNgGnbXDLKgKrf0NErLpxS1NyU3DsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170243;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=cVfqNllX9psHaNp12DgFISsct/0PG6DEg+CaJsd/m3A=;
	b=yy+ZcJ5OmfAEydUNbqPklADYhwjdvsaWCt9Q0sasLJnWZvwtgYwF/SUsaMkSJBtmZTZO
	 A9Cy3UaNhcMvgu7fBg2Xf9lxaorlyC+T4UinKX/DZdKU5CpzVP/4PzmDi3MY0/FqSUjNa
	 IGPlWpDP3gYVPBO1nTm5Y5b9o5uD/MsYI2XFxStYlKTh40kVkSr6TmRli7kEvrbMgRnMX
	 FopS0HmYY2kJzBkeTlOarZIBqWwCiOKXXK0v82iZLnyLt4HcOkHZZe6f7l2/hIAMl5lnd
	 hGKxmtwRXlJIhy/3Ou7IhVM9lzCRSRsthIzqS/aD2zEGw2XNalo6w1qHhA43HA9n+5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=E9D0948W;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A75F606A325;
	Fri, 20 Nov 2026 10:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A75F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=E9D0948W
Received: from abreu.molgen.mpg.de (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BD7564C2F3FFBD;
	Fri, 20 Nov 2026 11:23:16 +0100 (CET)
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
Subject: [PATCH v2] watchdog: intel_oc_wdt: Stop the watchdog during system sleep
Date: Fri, 20 Nov 2026 11:23:09 +0100
Message-ID: <20261120102311.621074-1-pmenzel@molgen.mpg.de>
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
	t=1795170197; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=cVfqNllX9psHaNp12DgFISsct/0PG6DEg+CaJsd/m3A=; 
	b=E9D0948WYT4XQGSDlwqClbYwSMsgu4Z7IOCCeUZrEaXk4Xmivxu9lutVdODzUjX/JGyF7XUSEDWu
	27e7IHwkFSDbJ6Fd/5qeKoxJuIKs7QJzcsmWZjHmElbOQS17KVDBTRGSeyn90eWvB5kiNJAd9vcmvj
	Tf6ONk/mSwr8RKTtwZTuwOtt4cvWqGbYb1yTIAnlH+RtqibXY00wIZCV27OVtMB2ZQZu2RzcZf4K3y
	YkMjUD4FfKUn5VQ1X9CpinLrLNl5ZPNXWuEhT9RqVilhv1PepTdq7zfBfpNXc8FN1IzhL9WurCb9Dy
	XOhiz+Se8uDKX0G4rmSN/Jjyx2iEy1oA==

The driver has no system sleep callbacks, so a running watchdog keeps
counting in suspend-to-idle. Suspend-to-idle stops the tick, so neither
user space nor the watchdog core can ping it, and the watchdog resets
the machine once the timeout expires.

On a Dell XPS 13 9310 (Tiger Lake, BIOS 3.17.0, no ACPI S3) with systemd
`RuntimeWatchdogSec=30s` on /dev/watchdog-oc, both `rtcwake -m freeze -s
900` and `rtcwake -m freeze -s 60` resulted in a reset about 30 s after
entering suspend, without any message in the journal or in pstore. With
the systemd runtime watchdog disabled, the system stayed in
suspend-to-idle for 900 s and resumed normally.

Stop the watchdog in the noirq suspend phase and restart it, with a
reload, in the noirq resume phase, as iTCO_wdt does. Check the enable
bit in hardware rather than watchdog_active(), so a watchdog started by
the firmware, which only the watchdog core pings, is covered too. If the
control register is locked, the watchdog cannot be stopped, so leave it
alone.

Also program the timeout again on resume, whether or not the watchdog
was running: the platform firmware may reset the control register, and
when resuming from hibernation, it holds the timeout the boot kernel
set. intel_oc_wdt_start() only sets the enable bit, so a timeout set
with WDIOC_SETTIMEOUT would otherwise be lost.

Unlike iTCO_wdt, do this for all sleep states and not only for
suspend-to-idle, as it is not documented whether the platform firmware
stops the OC watchdog in ACPI S3 or S4. Hangs in the device suspend and
resume callbacks outside the noirq phases are still caught.

Tested on a Dell XPS 13 9310 (BIOS 3.17.0) with the module built for
7.4.0-rc1 and systemd RuntimeWatchdogSec=30s:

- rtcwake -m freeze -s 120 resumes normally; the stock module reset the
  machine in 2 of 2 attempts.
- TOV restore: with the watchdog armed, overwrite TOV with 0x3b (60 s) via
  outl, as the firmware might, then rtcwake -m freeze -s 60. v1: register
  0x0080603b after resume (TOV 60 s kept). v2: 0x0080601d (TOV 30 s
  restored, EN set), watchdog still running 40 s later.

Fixes: 535d1784d8a9 ("watchdog: Add driver for Intel OC WDT")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    Changes in v2:
    - Program the timeout (TOV) again on resume, also when the watchdog was
      not running, as the firmware or, after hibernation, the boot kernel may
      have changed it (Sashiko review of v1)
    
    v1: https://lore.kernel.org/all/20261119210358.610521-1-pmenzel@molgen.mpg.de/
    
    Tool use: Claude Code (claude-opus-5-5) found the reset while measuring
    s2idle power, wrote the change and the commit message; compile-tested with
    W=1 (CONFIG_PM_SLEEP=y/n), checkpatch-clean.

 drivers/watchdog/intel_oc_wdt.c | 52 +++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_oc_wdt.c
index 0b012aeb18e15..4400a2a8811c9 100644
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
@@ -212,6 +214,55 @@ static int intel_oc_wdt_probe(struct platform_device *pdev)
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
+	if (oc_wdt->locked)
+		return 0;
+
+	/*
+	 * The timeout in hardware may have been reset by the platform firmware
+	 * or, when resuming from hibernation, set by the boot kernel, and
+	 * intel_oc_wdt_start() does not program it.
+	 */
+	intel_oc_wdt_set_timeout(&oc_wdt->wdd, oc_wdt->wdd.timeout);
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
@@ -223,6 +274,7 @@ static struct platform_driver intel_oc_wdt_platform_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.acpi_match_table = intel_oc_wdt_match,
+		.pm = pm_sleep_ptr(&intel_oc_wdt_pm_ops),
 	},
 	.probe = intel_oc_wdt_probe,
 };
-- 
2.54.0

