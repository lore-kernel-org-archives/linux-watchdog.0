Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC32147E5;
	Mon, 17 Aug 2026 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935238; cv=none; b=fK2/qsLede1XA8HR9zkQ7MXwjlXaCkRbbJStEdDsmk0yW7GEIKPAy07KGujORutQYA0/FE0N22htr1MWGZnIhXPLeNcJxec3GMi328kisGZ6i85EJp5fzld9/bPseeVhkOnacHR63/SoJxpJ4N4Kib4PvKs26VDFHQ20AEoDH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935238; c=relaxed/simple;
	bh=6YlV0a6pj/VmyxmxdH48LdM0sZ/TDxQoSqf6WBnTRbg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IBY0i010VVpRikQ8DKbXaOSUITqKZLLUJKqbatrTioYeRJLFXSkifOlMMKWED8eQ4tEK2QrvgADK//L/jpEi3G0iqGPU+n8gRPouvlsUCM36XleAjzzpwjVmL+0BZD/KkpP3lpPquMZZ1FFNEwQYbIMU9rOspw3KBu8BmNiztJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IiQ5fxPl; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IiQ5fxPl"
X-UUID: c2865ef099e411f1b1788b6acf885367-20260817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lhOKwsR5SDq98/XwAqYZPpTbBrVHGuqe8tfzF4XrU+Y=;
	b=IiQ5fxPldBGhv23nVcMVb1AWCVfvm/ZV9phPB4iPxleNcUyndQMjaDjULVrUtF8FeLbXnh2u8Oja3pJm9mUQn3FR7QPZ5AHa4QdFTu5zVlr+UODvxuddT6oVtb8lD4RDDY8jEMTAjfPNr/k3ANFNYOX8pN7iqhxHjjgi1obB4s0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f5ff4ea9-52c1-4252-840f-99a4a67075df,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:02378be2-71f1-405e-92eb-6802d6af74fd,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c2865ef099e411f1b1788b6acf885367-20260817
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ot_zexin.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1105771931; Mon, 17 Aug 2026 10:38:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 17 Aug 2026 10:38:40 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 17 Aug 2026 10:38:40 +0800
From: Zexin Wang <ot_zexin.wang@mediatek.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <light.chen@mediatek.com>, <Fred-WY.Chen@mediatek.com>,
	<Yt.Hsieh@mediatek.com>, Zexin Wang <ot_zexin.wang@mediatek.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4] watchdog: sbsa_gwdt: add early_enable module parameter
Date: Mon, 17 Aug 2026 10:37:49 +0800
Message-ID: <20260817023838.6459-1-ot_zexin.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On SBSA platforms using standard UEFI firmware (such as EDK II), the
watchdog timer is often enabled during early boot stages but explicitly
disabled by the firmware before handing over control to the OS (e.g.,
during ExitBootServices). This is done to prevent unintended resets
while the OS is loading, assuming the OS watchdog driver will take over.

However, this leaves a protection gap. If the system hangs between the
firmware handover and the userspace watchdog daemon startup, the hardware
watchdog will not fire to recover the system. For safety-critical systems
that require continuous hardware watchdog protection from the earliest
possible moment, this gap is problematic.

Add an 'early_enable' module parameter to allow the kernel driver to
re-enable the watchdog immediately during probe if it was left disabled
by the firmware. By setting the WDOG_HW_RUNNING status bit, the watchdog
core is instructed that the hardware is active. As a result, the core's
pre-userspace handler (controlled by 'handle_boot_enabled') will
automatically issue periodic keepalives until userspace opens the device.

This bridges the protection gap seamlessly without requiring firmware
modifications and without risking unintended resets during kernel boot.

The parameter defaults to false to preserve the traditional behavior.

Signed-off-by: Zexin Wang <ot_zexin.wang@mediatek.com>
---
Changes in v4:
- Remove unnecessary dev_info() log message
- Remove dev_err() on register failure
- Remove clear_bit(WDOG_HW_RUNNING) on register failure

Changes in v3:
- Fix indentation of `early_enable` in watchdog-parameters.rst to ensure
  it renders as a separate parameter rather than part of `nowayout`'s
  description.

Changes in v2:
- Rename `force_enable` to `early_enable` as suggested by Guenter.
- Update commit message to explain the UEFI handover gap motivation.
- Add documentation for the new parameter.

 .../watchdog/watchdog-parameters.rst          |  2 ++
 drivers/watchdog/sbsa_gwdt.c                  | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
index 502cb6adbeda..348229ffcb43 100644
--- a/Documentation/watchdog/watchdog-parameters.rst
+++ b/Documentation/watchdog/watchdog-parameters.rst
@@ -515,6 +515,8 @@ sbsa_gwdt:
     nowayout:
 	Watchdog cannot be stopped once started
 	(default=kernel config parameter)
+    early_enable:
+	Watchdog is started on module insertion (default=0)
 
 -------------------------------------------------
 
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index e04d42cc7774..3c5bfd8641c6 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -122,6 +122,11 @@ MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
 		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+static bool early_enable;
+module_param(early_enable, bool, 0);
+MODULE_PARM_DESC(early_enable,
+		 "Watchdog is started on module insertion (default=0)");
+
 /*
  * Arm Base System Architecture 1.0 introduces watchdog v1 which
  * increases the length watchdog offset register to 48 bits.
@@ -296,6 +301,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	struct sbsa_gwdt *gwdt;
 	int ret, irq;
 	u32 status;
+	bool early_action;
 
 	gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
 	if (!gwdt)
@@ -386,14 +392,23 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	 */
 	sbsa_gwdt_set_timeout(wdd, wdd->timeout);
 
+	early_action = early_enable && !(status & SBSA_GWDT_WCS_EN);
+	if (early_action) {
+		sbsa_gwdt_start(wdd);
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	}
+
 	watchdog_stop_on_reboot(wdd);
 	ret = devm_watchdog_register_device(dev, wdd);
-	if (ret)
+	if (ret) {
+		if (early_action)
+			sbsa_gwdt_stop(wdd);
 		return ret;
+	}
 
 	dev_info(dev, "Initialized with %ds timeout @ %u Hz, action=%d.%s\n",
 		 wdd->timeout, gwdt->clk, action,
-		 status & SBSA_GWDT_WCS_EN ? " [enabled]" : "");
+		 watchdog_hw_running(wdd) ? " [enabled]" : "");
 
 	return 0;
 }
-- 
2.45.2

