Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957549;
	b=be0pWX7JlbncXmsB3iz0wpXIlRw+o7whHI7KA25yZhaQ/cWl5+uDk6raUc7aRD/FMI0b
	 a0fgXpKYrje9HYE5PrqqGyDDfGHXJNS/QHI/mw5mwn4kW9dMkqd6elKRazIrtcLApNMn3
	 1P6Yj9GDmLHbDbEAaYzJziqYb1fI8Oiry9U2ZZ7EYMfKnt8i1rqT4Q3bTlRCMm+kuWSEu
	 eewFTXCdJBmKvLhMy9sexxsSLiiyhNtXP4T8caaT61YEFVOyahlSDZDTzj2JeaZqII+O4
	 XYMAmRXguw7X9j9RFY1cihSM3l7lsJVZxohRE2BFM5roS0FnpjOwXSOctn5gdtRiEfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957549;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=taHVdrxL2EsPRjmw6qawffXd/pZALm22RNDv0mO72y4=;
	b=L687yKWyUe98xNutijJ09sAOQKtWHL3awJkpo3StfAqh3IbzYWhQEcOvPuHopU6ztQFG
	 Ys3hvUhN5sq7f1dcHG48+3C6aYNBgTqy2UZ77nJ001ay0+8lpxk3wOg09zs6FhMYk4Ad7
	 2JshRlZpmPaf+5KCeWj0scaWxG22KUpFBNguDK69RGSNDDMt8XUyFX5NVboimAiIogIQY
	 lyvaDajmezSDSovXSRoTWjyCpjeAmFbSEXZcv9f2kuB71VIvtm/hlFDJ2VWPcTLeylB8e
	 RQ1z4dGjuHSjhPqMGKsvtcSL6kZt97CGctzOdV14hcGnDxxPlggLoliXQ+ejtG6d9cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="H4/lTNlP";
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B574606A32A;
	Tue, 17 Nov 2026 23:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B574606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=H4/lTNlP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ta
	HVdrxL2EsPRjmw6qawffXd/pZALm22RNDv0mO72y4=; b=H4/lTNlPJkqWGJAb8H
	JUjTZyrheqOowE8EJNYMsGNJIw67TO7fe8WTJWsjSJEJ7DMkLf7Ys/jS0mih1uBK
	ht4JKHIpZH/UpVQeYawMgEud/Gw115AqeGxJH4aC4IcaZPsnzwhtuQzt8c27R8hP
	RUWPwtZH2LCKHcjkHBldYa7l4=
Received: from SYPC (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHdTzL4PxqjZGTGg--.50564S2;
	Wed, 18 Nov 2026 07:18:35 +0800 (CST)
From: Yang Siyuan <hsyysy@163.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] watchdog: sunxi_wdt: stop the watchdog across system suspend
Date: Wed, 18 Nov 2026 07:18:19 +0800
Message-ID: <20261117231819.264381-1-hsyysy@163.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <202611172344.RbQl66xu-lkp@intel.com>
References: <202611172344.RbQl66xu-lkp@intel.com>
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
X-CM-TRANSID:PigvCgCHdTzL4PxqjZGTGg--.50564S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1rury5ZF1ktF1UWw13CFg_yoWrJrW3pF
	45Aa4Y9rW0qr4avr4aywnrAFn5CwnYg34UAryxG34rX3Z8Gr1rGF1Iqryjy39xGrWrGF1r
	CF1Ut3yfGayq9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jso7tUUUUU=
X-CM-SenderInfo: 5kv152r16rljoofrz/xtbC7gxFeWr84MwGWwAA35

The H616 watchdog has a maximum timeout of 16 seconds.  systemd keeps
/dev/watchdog0 open with RuntimeWatchdogSec=16s, but during system
suspend all userspace is frozen and the watchdog core does not stop the
hardware.  A suspend longer than the timeout therefore resets the board
before it can resume.

Add system sleep PM ops to stop the watchdog before suspend and restart
it after resume if it was running.  The driver did not store its private
data in the platform device, so add platform_set_drvdata() for the PM
callbacks.

Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr(), and use
watchdog_hw_running() instead of a private flag to decide whether the
hardware needs to be stopped and restarted.

Tested on an Anbernic RG35XX-SP: a 30-second s2idle suspend resumes
without the 16-second watchdog reset, and /dev/watchdog0 keeps working
afterwards.

Signed-off-by: Yang Siyuan <hsyysy@163.com>
---
Changes in v3:
- Mark the PM callbacks __maybe_unused.  With CONFIG_PM_SLEEP=n the
  pm_sleep_ptr() references expand to NULL, so both callbacks were unused
  and a W=1 build warned about them.  Reported by the kernel test robot:
  https://lore.kernel.org/oe-kbuild-all/202611172344.RbQl66xu-lkp@intel.com/
- Reword the v2 changelog entry: pm_sleep_ptr() alone does not keep the
  callbacks referenced when CONFIG_PM_SLEEP is disabled.

Changes in v2:
- Use DEFINE_SIMPLE_DEV_PM_OPS()/pm_sleep_ptr() to avoid unused-function
  warnings with CONFIG_PM_SLEEP=n.
- Use watchdog_hw_running() instead of tracking running_at_suspend.
- Drop the inaccurate ping-worker reference from the comment.

 drivers/watchdog/sunxi_wdt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index a6500eb..3fdc7bf 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -225,6 +225,35 @@ static int sunxi_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+/*
+ * The hardware watchdog has a maximum timeout of 16 seconds.  A system
+ * suspend easily lasts longer than that, and the watchdog core does not
+ * stop the hardware during system sleep.  Stop the watchdog explicitly
+ * while suspended and re-arm it on resume if it was running.
+ */
+static int __maybe_unused sunxi_wdt_suspend(struct device *dev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = dev_get_drvdata(dev);
+
+	if (watchdog_hw_running(&sunxi_wdt->wdt_dev))
+		sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
+
+	return 0;
+}
+
+static int __maybe_unused sunxi_wdt_resume(struct device *dev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = dev_get_drvdata(dev);
+
+	if (watchdog_hw_running(&sunxi_wdt->wdt_dev))
+		sunxi_wdt_start(&sunxi_wdt->wdt_dev);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(sunxi_wdt_pm_ops,
+				sunxi_wdt_suspend, sunxi_wdt_resume);
+
 static const struct watchdog_info sunxi_wdt_info = {
 	.identity	= DRV_NAME,
 	.options	= WDIOF_SETTIMEOUT |
@@ -307,6 +336,8 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(sunxi_wdt->wdt_base))
 		return PTR_ERR(sunxi_wdt->wdt_base);
 
+	platform_set_drvdata(pdev, sunxi_wdt);
+
 	sunxi_wdt->wdt_dev.info = &sunxi_wdt_info;
 	sunxi_wdt->wdt_dev.ops = &sunxi_wdt_ops;
 	sunxi_wdt->wdt_dev.timeout = WDT_MAX_TIMEOUT;
@@ -348,6 +379,7 @@ static struct platform_driver sunxi_wdt_driver = {
 	.driver		= {
 		.name		= DRV_NAME,
 		.of_match_table	= sunxi_wdt_dt_ids,
+		.pm		= pm_sleep_ptr(&sunxi_wdt_pm_ops),
 	},
 };
 

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.1

