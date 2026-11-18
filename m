Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963101;
	b=JIfjMfqTOQteLeR2LpVuAX1eJuZrsF1u012Slvi9+1217pZpQgdbzzfLeL9HYNg9DHcN
	 n8ATKSc3QbiUprMAYr01Ko6RWMo3qfXiT0YptyGrHYWV3B/qOyDAJ5pzAnlnloTZAxi4y
	 dqk4VPcgOEwCuSE3XvXvo5crK3JmFrDdGxjJO/JbxmFZbArVy8GgdxeQZsUGAIeDCSilM
	 vMkQQ0ty7G2Vx3sqwCeZL2gAAqAGmtjQU9rTf2/1fUOY9RtEmlWcYEnJCcXd53Kg9c/Y8
	 atz+Y2mPb31rSsBTX4S9AIbJiceHykR0wDSL5TYNEWTWIvRT4bXhQNNOcpu0DaE5c0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963101;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=E+RsS1tq+kLfqFUPfdWPYkZYK/Z9niwBH23LyHoXUfs=;
	b=CcptQ7kQqshaUzdAfJfASr/QJG0Y+WUj5RYv2RV3HHwBqN/Pb06E6c3qSq7s1ndHV83N
	 9OCXqJqeGu4h1xPpjTWyD17H4p9M2NM2EAZ6/TUTwJAgwYgGRY0OoiejCr4+bbR6qF+Ir
	 uka60IEHjygMrMiPSs72FyOd4MekHXWouT/TTrCX0gndb5uFJvrDSUMeZJ/6/UHjfP910
	 UL+TNViITrM6KqzZhvJXHoujuWwLaUMNdRiisRQpopSfpXs0S/y9+AwG47chw+hYxIjeE
	 XvL9QfvWOniM3BN5az1RMUb7GlsGcAWYLBo4mdmRiomKKlf8bK1fkmIq/G6dKG7SnAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="bG+Ue8f/";
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED86606A884;
	Wed, 18 Nov 2026 00:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ED86606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bG+Ue8f/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=E+
	RsS1tq+kLfqFUPfdWPYkZYK/Z9niwBH23LyHoXUfs=; b=bG+Ue8f/UZ5gtZAA+S
	Cfs1vGehNw0RAcWGiRrj0YkI3g4WPMgDuC44WvS4aFS+swNndP7XBUxl0N2m8fln
	CeP8a5WqncCJDI+hrMhqhK+dr0ugt0/PVQOgWmcHzzQTMXt+ETvqFzJgmfol3sxy
	pAtwybU1J3AVMga+Yh7MMQavU=
Received: from SYPC (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHsYd49vxqwTllGg--.46287S2;
	Wed, 18 Nov 2026 08:51:05 +0800 (CST)
From: Yang Siyuan <hsyysy@163.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] watchdog: sunxi_wdt: stop the watchdog across system suspend
Date: Wed, 18 Nov 2026 08:50:48 +0800
Message-ID: <20261118005048.385059-1-hsyysy@163.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <ece4aa08-fb86-4f76-b4b8-a9351a71df14@roeck-us.net>
References: <ece4aa08-fb86-4f76-b4b8-a9351a71df14@roeck-us.net>
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
X-CM-TRANSID:PygvCgBHsYd49vxqwTllGg--.46287S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1rury5ZF1ktF1UXF1UZFb_yoWrGr43pF
	4Yya4FkrW0qr4avr4aywnrAFn5G3ZYg34UAryxG34fA3Z8Gr1rGFy0qr1UAwsxGrWrGF1r
	uF1Ut3yxGayq9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVYLkUUUUU=
X-CM-SenderInfo: 5kv152r16rljoofrz/xtbC7Rm16Wr89nkdMgAA3e

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
Changes in v4:
- Drop __maybe_unused again.  The W=1 report was against v1, which used
  SET_SYSTEM_SLEEP_PM_OPS(); that macro expands to nothing when
  CONFIG_PM_SLEEP=n, so the callbacks were unused.  v2 already replaced it
  with DEFINE_SIMPLE_DEV_PM_OPS(), whose SYSTEM_SLEEP_PM_OPS() takes the
  callback addresses through pm_sleep_ptr() even with CONFIG_PM_SLEEP=n,
  so the functions are never unused.  The v3 change is reverted in v4.

Changes in v3:
- Mark the PM callbacks __maybe_unused, in response to a W=1 report that
  turned out to be against v1.  Reverted in v4.

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
+static int sunxi_wdt_suspend(struct device *dev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = dev_get_drvdata(dev);
+
+	if (watchdog_hw_running(&sunxi_wdt->wdt_dev))
+		sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
+
+	return 0;
+}
+
+static int sunxi_wdt_resume(struct device *dev)
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

