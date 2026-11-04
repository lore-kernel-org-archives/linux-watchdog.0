Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=60.244.123.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781446;
	b=mVzlFIxd57X1yxKW3emJoiQ2s+QQUzqiZIEcpdlBkAKKaESLFHfoyc/+I66Ok25lpKVr
	 o8oBo9hscsncZQVCwEtsDRDWppt2jgRxIXj9VVl7kD0YRAcVUfI3/CueiNpwBJBPamnHS
	 D3uAPiuP8AHgZZR0XXl2RMYlWzzofokUTAMf5KFCs1GWAfNavtTZCmWfqE7kW5SccL+zl
	 2Ha6T2RnqPFmb8u00REpcoC1t7X9JNRb4SA0RpwC3fhJZOpa1OtNROfLeBOguRXQMEua+
	 0pC0kKvRMdI9Z0h1kpR8eqHEgQNKF4jJtwK90YOvggSpR/7QQ4uFjsUX8gwGrlOAt8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781446;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=BQ87gBPtkwxoz8xl4Pe/IUMApvOi36VjXgZ8bl6jw0Y=;
	b=3OKeXpc/YF3pRahXPHzFGueWpaMj7tCrQckTy5IGRf3LUs5iBS06Xk0oWf3pCtL7laJs
	 +ngu4IHtVjvYaK1Sk2uJVAbL9B0XLSHAVGWQlPQltf7K/a7QRLNtKPnfExZ7TJvvXduoe
	 Gxe6qmv2vF9ZChSGGjR73r5kXhha2jBTZcDa0fsmjptrSD0o1UqDUqynO8LJcqzMSKIMB
	 X8hTLW6jmykL5lbNbxw/2pab8m7GwO6IwkfPrzIXnw80CmsweMk+1+6ZMEkRXidHUWPMD
	 1HBFwe7mQ6A736g09m2pr2HKfN9/s4lABoRYw5LpRz13+ILH1po9fFgACvuPNuGlz/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=vFvvQ5wF;
	arc=none smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4A606A31B;
	Wed,  4 Nov 2026 08:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AE4A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=vFvvQ5wF
X-UUID: f32fa3ded82a11f1b1788b6acf885367-20261104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BQ87gBPtkwxoz8xl4Pe/IUMApvOi36VjXgZ8bl6jw0Y=;
	b=vFvvQ5wFm21BJG4i+zgcMs84ELWwisuox3ZO3lFd9uTZDVpRQJHYocGnljAFm5zypOR+8VyKUxX93bFAJ4b95MFMC4/u/gBUDE576jkQDDvNrv1ST+O15jFPVifUv7MiTD+iC/H/iugUwiLoOtHeQHWOnGylsdwi8JwRiGzCLlc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:07fc2c8b-494c-427b-b0a3-89e0d03958fc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0318ac,CLOUDID:e1a6c6ce-02bc-447e-ab88-2baec399874a,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f32fa3ded82a11f1b1788b6acf885367-20261104
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ot_zexin.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1677457733; Wed, 04 Nov 2026 16:37:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 4 Nov 2026 16:37:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 4 Nov 2026 16:37:18 +0800
From: Zexin Wang <ot_zexin.wang@mediatek.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <light.chen@mediatek.com>, <Fred-WY.Chen@mediatek.com>,
	<Yt.Hsieh@mediatek.com>, Zexin Wang <ot_zexin.wang@mediatek.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] watchdog: sbsa_gwdt: Limit the MediaTek WS0 race workaround to revision 0
Date: Wed, 4 Nov 2026 16:37:02 +0800
Message-ID: <20261104083714.3026535-1-ot_zexin.wang@mediatek.com>
X-Mailer: git-send-email 2.43.0
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
Content-Type: text/plain

The WS0 race workaround is currently enabled for all MediaTek SBSA
Generic Watchdog revisions in single-stage mode. However, only
revision 0 is affected by the race condition.

Read the revision field from W_IIDR and enable the workaround only for
MediaTek watchdogs with revision 0 in single-stage mode. This avoids
unnecessarily restricting the minimum timeout and adjusting the
keepalive interval on unaffected revisions.

Signed-off-by: Zexin Wang <ot_zexin.wang@mediatek.com>
---
 drivers/watchdog/sbsa_gwdt.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 3c5bfd8641c6..eb79c8049f95 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -71,12 +71,16 @@
 #define SBSA_GWDT_WCS_WS0	BIT(1)
 #define SBSA_GWDT_WCS_WS1	BIT(2)
 
-#define SBSA_GWDT_VERSION_MASK  GENMASK(3, 0)
-#define SBSA_GWDT_VERSION_SHIFT 16
+#define SBSA_GWDT_VERSION_MASK		GENMASK(3, 0)
+#define SBSA_GWDT_VERSION_SHIFT		16
 
-#define SBSA_GWDT_IMPL_MASK	GENMASK(11, 0)
-#define SBSA_GWDT_IMPL_SHIFT	0
-#define SBSA_GWDT_IMPL_MEDIATEK	0x426
+#define SBSA_GWDT_REVISION_MASK		GENMASK(3, 0)
+#define SBSA_GWDT_REVISION_SHIFT	12
+#define SBSA_GWDT_REV_RACE_WA		0x0
+
+#define SBSA_GWDT_IMPL_MASK			GENMASK(11, 0)
+#define SBSA_GWDT_IMPL_SHIFT		0
+#define SBSA_GWDT_IMPL_MEDIATEK		0x426
 
 /**
  * struct sbsa_gwdt - Internal representation of the SBSA GWDT
@@ -238,15 +242,17 @@ static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
 static void sbsa_gwdt_get_version(struct watchdog_device *wdd)
 {
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
-	int iidr, ver, impl;
+	int iidr, ver, rev, impl;
 
 	iidr = readl(gwdt->control_base + SBSA_GWDT_W_IIDR);
 	ver = (iidr >> SBSA_GWDT_VERSION_SHIFT) & SBSA_GWDT_VERSION_MASK;
+	rev = (iidr >> SBSA_GWDT_REVISION_SHIFT) & SBSA_GWDT_REVISION_MASK;
 	impl = (iidr >> SBSA_GWDT_IMPL_SHIFT) & SBSA_GWDT_IMPL_MASK;
 
 	gwdt->version = ver;
 	gwdt->need_ws0_race_workaround =
-		!action && (impl == SBSA_GWDT_IMPL_MEDIATEK);
+		!action && (impl == SBSA_GWDT_IMPL_MEDIATEK) &&
+		(rev == SBSA_GWDT_REV_RACE_WA);
 }
 
 static int sbsa_gwdt_start(struct watchdog_device *wdd)
-- 
2.45.2

