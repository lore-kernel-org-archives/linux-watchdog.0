Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A3412BE4;
	Thu, 27 Aug 2026 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822794; cv=none; b=WvXBzv8t25MIqBRLtW6wROPCAPIVKj8U5hfFjVu1AIPuzeXtxbHXFcYX0u+y96nnK7Ckp2r900UFpjQXugllyTeSydcdbJNYopG/k6iBGhuZJSUU1YXdzoWnw/XliEKxZXvozWSQm8SHWL7FB1xdTnv8SuVlyymRO54FF2rZb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822794; c=relaxed/simple;
	bh=EUFsHtZRsv0ddmvm4C7650wWkHpkskwQBbetolaW+yY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZBUT8U40w3qoZUP0i9J3c4x51WfCESuktq0jpc+2mpBxKMJXXT2ZTMXVWOQ2sNzcbpWJab24CINPMVM6/+YFNsRvIRcbdHpCDq6KQmsASBcqNkphDjR7xZmHgYam7SF+TBjnRfRJ+cmQOrkqhgPfDBDyir9QX/Zt3kpkFayJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rJ2Iecz1; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rJ2Iecz1"
X-UUID: 5d45039ea1f911f1b1788b6acf885367-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+/4zG/rocKpdtGp5a19MvF6vR/w5a841RTKI8Ud0lAA=;
	b=rJ2Iecz1PCMOy4UclRsxTpu6zFVaUHgPWkOT4S8tCuZ5nyBqO2kaZ8MlLQ0DgZjETPkWm5y5sD2M8NH3jWIKiMI45qitvcUfer8xY0/RhEop+rphT8n+AeBVi54A80qpN1mb+qfgRIdnXXxuQslZMIEn1ca3eHrumGmkaR7ggqU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b5031976-dc3f-4c86-83a0-74c72db020b6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:80e6f96e-d4b4-449a-a450-812cb2b13b0e,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d45039ea1f911f1b1788b6acf885367-20260827
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <wanming.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 997661539; Thu, 27 Aug 2026 17:26:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 17:26:19 +0800
Received: from gcnsap21.gcn.mediatek.inc (10.17.81.22) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 17:26:18 +0800
From: Wanming Gao <wanming.gao@mediatek.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Wim Van Sebroeck
	<wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wanming.gao@mediatek.com>, <wallace.yu@mediatek.com>,
	<Jarried.Lin@mediatek.com>, <vince-wl.liu@mediatek.com>
Subject: [PATCH v2] watchdog: mediatek: acknowledge pretimeout interrupt
Date: Thu, 27 Aug 2026 17:26:12 +0800
Message-ID: <20260827092616.2724197-1-wanming.gao@mediatek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The MediaTek watchdog pretimeout interrupt is level-triggered and does
not have a separate acknowledge register. The interrupt is cleared by
changing WDT_MODE_IRQ_LEVEL_EN and then restoring it to its original
state. Without this transition, the interrupt may remain asserted and
cause an interrupt storm.

After changing WDT_MODE_IRQ_LEVEL_EN, wait 70 us before restoring it.
This is longer than two 32 kHz watchdog clock cycles, allowing the
level change to propagate across the clock domain.

WDT_MODE is also updated by the watchdog start, stop, and pretimeout
operations. Protect its read-modify-write sequences and the complete
IRQ acknowledge sequence with the watchdog spinlock so that concurrent
updates cannot overwrite the temporary IRQ level state.

Signed-off-by: Wanming Gao <wanming.gao@mediatek.com>
---
 drivers/watchdog/mtk_wdt.c | 62 ++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index d9c30e4c80e3..ddc4d2ff9d9f 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -35,6 +35,7 @@
 #define WDT_MAX_TIMEOUT		31
 #define WDT_MIN_TIMEOUT		2
 #define WDT_LENGTH_TIMEOUT(n)	((n) << 5)
+#define WDT_IRQ_LEVEL_SYNC_US	70
 
 #define WDT_LENGTH		0x04
 #define WDT_LENGTH_KEY		0x8
@@ -49,6 +50,7 @@
 #define WDT_MODE_EXRST_EN	(1 << 2)
 #define WDT_MODE_IRQ_EN		(1 << 3)
 #define WDT_MODE_AUTO_START	(1 << 4)
+#define WDT_MODE_IRQ_LEVEL_EN	(1 << 5)
 #define WDT_MODE_DUAL_EN	(1 << 6)
 #define WDT_MODE_CNT_SEL	(1 << 8)
 #define WDT_MODE_KEY		0x22000000
@@ -72,7 +74,7 @@ static unsigned int timeout;
 struct mtk_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
-	spinlock_t lock; /* protects WDT_SWSYSRST reg */
+	spinlock_t lock; /* protects WDT_MODE and WDT_SWSYSRST reg */
 	struct reset_controller_dev rcdev;
 	bool disable_wdt_extrst;
 	bool reset_by_toprgu;
@@ -212,8 +214,6 @@ static int toprgu_register_reset_controller(struct platform_device *pdev,
 	int ret;
 	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
 
-	spin_lock_init(&mtk_wdt->lock);
-
 	mtk_wdt->rcdev.owner = THIS_MODULE;
 	mtk_wdt->rcdev.nr_resets = rst_num;
 	mtk_wdt->rcdev.ops = &toprgu_reset_ops;
@@ -302,12 +302,15 @@ static int mtk_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base = mtk_wdt->wdt_base;
+	unsigned long flags;
 	u32 reg;
 
+	spin_lock_irqsave(&mtk_wdt->lock, flags);
 	reg = readl(wdt_base + WDT_MODE);
 	reg &= ~WDT_MODE_EN;
 	reg |= WDT_MODE_KEY;
 	iowrite32(reg, wdt_base + WDT_MODE);
+	spin_unlock_irqrestore(&mtk_wdt->lock, flags);
 
 	return 0;
 }
@@ -317,12 +320,14 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
 	u32 reg;
 	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base = mtk_wdt->wdt_base;
+	unsigned long flags;
 	int ret;
 
 	ret = mtk_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
 	if (ret < 0)
 		return ret;
 
+	spin_lock_irqsave(&mtk_wdt->lock, flags);
 	reg = ioread32(wdt_base + WDT_MODE);
 	if (wdt_dev->pretimeout)
 		reg |= (WDT_MODE_IRQ_EN | WDT_MODE_DUAL_EN);
@@ -334,6 +339,7 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
 		reg |= WDT_MODE_CNT_SEL;
 	reg |= (WDT_MODE_EN | WDT_MODE_KEY);
 	iowrite32(reg, wdt_base + WDT_MODE);
+	spin_unlock_irqrestore(&mtk_wdt->lock, flags);
 
 	return 0;
 }
@@ -343,7 +349,11 @@ static int mtk_wdt_set_pretimeout(struct watchdog_device *wdd,
 {
 	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdd);
 	void __iomem *wdt_base = mtk_wdt->wdt_base;
-	u32 reg = ioread32(wdt_base + WDT_MODE);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&mtk_wdt->lock, flags);
+	reg = ioread32(wdt_base + WDT_MODE);
 
 	if (timeout && !wdd->pretimeout) {
 		wdd->pretimeout = wdd->timeout / 2;
@@ -352,19 +362,54 @@ static int mtk_wdt_set_pretimeout(struct watchdog_device *wdd,
 		wdd->pretimeout = 0;
 		reg &= ~(WDT_MODE_IRQ_EN | WDT_MODE_DUAL_EN);
 	} else {
+		spin_unlock_irqrestore(&mtk_wdt->lock, flags);
 		return 0;
 	}
 
 	reg |= WDT_MODE_KEY;
 	iowrite32(reg, wdt_base + WDT_MODE);
+	spin_unlock_irqrestore(&mtk_wdt->lock, flags);
 
 	return mtk_wdt_set_timeout(wdd, wdd->timeout);
 }
 
+static void mtk_wdt_deassert_irq(struct watchdog_device *wdd)
+{
+	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdd);
+	void __iomem *wdt_base = mtk_wdt->wdt_base;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&mtk_wdt->lock, flags);
+
+	reg = ioread32(wdt_base + WDT_MODE);
+	reg ^= WDT_MODE_IRQ_LEVEL_EN;
+	iowrite32(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);
+
+	/*
+	 * Wait for two 32 kHz watchdog clock cycles so the IRQ level
+	 * change can propagate across the clock domain.
+	 */
+	udelay(WDT_IRQ_LEVEL_SYNC_US);
+
+	reg = ioread32(wdt_base + WDT_MODE);
+	reg ^= WDT_MODE_IRQ_LEVEL_EN;
+	iowrite32(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);
+
+	/*
+	 * Flush the posted write before releasing the lock and notifying
+	 * the watchdog core.
+	 */
+	ioread32(wdt_base + WDT_MODE);
+
+	spin_unlock_irqrestore(&mtk_wdt->lock, flags);
+}
+
 static irqreturn_t mtk_wdt_isr(int irq, void *arg)
 {
 	struct watchdog_device *wdd = arg;
 
+	mtk_wdt_deassert_irq(wdd);
 	watchdog_notify_pretimeout(wdd);
 
 	return IRQ_HANDLED;
@@ -406,6 +451,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	if (!mtk_wdt)
 		return -ENOMEM;
 
+	spin_lock_init(&mtk_wdt->lock);
+
 	platform_set_drvdata(pdev, mtk_wdt);
 
 	mtk_wdt->wdt_base = devm_platform_ioremap_resource(pdev, 0);
@@ -414,8 +461,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0) {
-		err = devm_request_irq(&pdev->dev, irq, mtk_wdt_isr, 0, "wdt_bark",
-				       &mtk_wdt->wdt_dev);
+		err = devm_request_irq(&pdev->dev, irq, mtk_wdt_isr, IRQF_NO_AUTOEN,
+				       "wdt_bark", &mtk_wdt->wdt_dev);
 		if (err)
 			return err;
 
@@ -447,6 +494,9 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	if (unlikely(err))
 		return err;
 
+	if (irq > 0)
+		enable_irq(irq);
+
 	dev_info(dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
 		 mtk_wdt->wdt_dev.timeout, nowayout);
 
-- 
2.45.2

