Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912105;
	b=iec/Tm5/W1UCAnfCf+EqXuh2ngveQGG/NjrHvJpJksrDLrWZu81sKzYTD1bvxwcJk+On
	 ih6ZgCab7TIgODeT8KM6A/cFrw7T7o5VbBzpvwnPDkQOONK1KUkoANYqutZvFLXxupcwk
	 iCfjCyDc4P2bpHFHRM7LOgSatYqJ1xQMkjzjWIoB/cqPmTx4BK/kqEKwuYYuGScgtK+tK
	 nM3XJFR1o9x5Jh5m1tucWmH81Kel7XKI/qtSdq1FAdOlSfhWxNFNLHbHJZNJjEpV+Bh44
	 G7XhJEGpLVQPGN3U1ABXeD7BRGWKYrPxxYL7/xrOP/C4kdZVAkZtPvrVZmb0ZqIP6sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912105;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=lxBxby7GseHNWvedWcEPx/DCd8dfkDUfv43EA41t7es=;
	b=lYC6qwvhK04G0c/ys2N8NL35MDuQxG7oqyOO4sF3nHi+Iw1titUKXM9NKc2fXOFT1UAF
	 wNfZ92ShHsdATfNKXCnARZfjc4IKS8L9kEWri/P2aR/xGvWZ5Sz3F+eK8X4SUyx6gXkJA
	 Fl0PQbTCgAk/IajpoR3YgZCHxuMlLtn3wyb/JLneU3jiPZxvATOS5yWYQF9h9A1T3gek/
	 qR46JLtAzsn/7zAmNNvMEN5V5gT/Sm8KpFRiO6kbP/45BRfrjqDJgfU48bwBNrafjv7zR
	 73WhGptVUMafkZfiIHDHOYiXfFt8BluvLIwz9RcxfUuuSVDUJu21Bupn4CfxovYRt7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XV0DBogJ;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A0606A337;
	Tue, 17 Nov 2026 10:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 528A0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XV0DBogJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lx
	Bxby7GseHNWvedWcEPx/DCd8dfkDUfv43EA41t7es=; b=XV0DBogJJkLCFAc4R4
	baUwq55sXiYrdA9/rIY0qdrPqVFzyA8zoB4gSnTYD6lQj4Mbs91rIqr1K0FWhdPi
	m0ENP8OMve3DAiKn+G6aMGtc7dWw+P6uXXpkJnuMRojKzcNxSxqx7d4Cl5CP9WqY
	AybVtfQJJoqv6/3X/YmGXVpu0=
Received: from SYPC (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnD0FBL_xq7NVVIQ--.56040S2;
	Tue, 17 Nov 2026 18:41:06 +0800 (CST)
From: Yang Siyuan <hsyysy@163.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: sunxi_wdt: stop the watchdog across system suspend
Date: Tue, 17 Nov 2026 18:40:54 +0800
Message-ID: <20261117104054.17381-1-hsyysy@163.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117092036.12192-1-hsyysy@163.com>
References: <20261117092036.12192-1-hsyysy@163.com>
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
X-CM-TRANSID:_____wDnD0FBL_xq7NVVIQ--.56040S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1rury5ZF1ktF1UXryxXwb_yoW5Zw4fpF
	4Yya4F9rW0qr4avr4ayw1DAF1rC34vg34UAryxG34fA3Z8Gr1rG3W0qryjywsxGrWrGF1r
	CF1Ut3yxCayq9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jImhrUUUUU=
X-CM-SenderInfo: 5kv152r16rljoofrz/xtbC7QK16Wr8L0LQSwAA3T

The H616 watchdog has a maximum timeout of 16 seconds.  systemd keeps
/dev/watchdog0 open with RuntimeWatchdogSec=16s, but during system
suspend all userspace is frozen and the watchdog core does not stop the
hardware.  A suspend longer than the timeout therefore resets the board
before it can resume.

Add system sleep PM ops to stop the watchdog before suspend and restart
it after resume if it was running.  The driver did not store its private
data in the platform device, so add platform_set_drvdata() for the PM
callbacks.

Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so the callbacks are
still referenced when CONFIG_PM_SLEEP is disabled, and use
watchdog_hw_running() instead of a private flag to decide whether the
hardware needs to be stopped and restarted.

Tested on an Anbernic RG35XX-SP: a 30-second s2idle suspend resumes
without the 16-second watchdog reset, and /dev/watchdog0 keeps working
afterwards.

Signed-off-by: Yang Siyuan <hsyysy@163.com>
---
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

