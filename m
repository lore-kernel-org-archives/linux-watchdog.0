Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D678C4332F
	for <linux-watchdog@archiver.kernel.org>; Wed, 16 Feb 2022 01:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiBPBps (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:45:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245593AbiBPBpi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Feb 2022 20:45:38 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8FFA203;
        Tue, 15 Feb 2022 17:45:26 -0800 (PST)
X-UUID: 1cb115f701f247ab9f007cfb0ab9a4f5-20220216
X-UUID: 1cb115f701f247ab9f007cfb0ab9a4f5-20220216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 837203341; Wed, 16 Feb 2022 09:45:21 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Feb 2022 09:45:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Feb
 2022 09:45:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 09:45:20 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <runyang.chen@mediatek.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [3/4] dt-bindings: reset: mt8186: add DSI reset bit for MMSYS
Date:   Wed, 16 Feb 2022 09:45:04 +0800
Message-ID: <20220216014505.28428-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add DSI software reset bit which is controlled by MMSYS for MT8186.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 include/dt-bindings/reset/mt8186-resets.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/reset/mt8186-resets.h b/include/dt-bindings/reset/mt8186-resets.h
index 36e5764e2e6c..5f850370c42c 100644
--- a/include/dt-bindings/reset/mt8186-resets.h
+++ b/include/dt-bindings/reset/mt8186-resets.h
@@ -30,4 +30,7 @@
 #define MT8186_TOPRGU_IMG2_SW_RST				22
 #define MT8186_TOPRGU_SW_RST_NUM				23
 
+/* MMSYS resets */
+#define MT8186_MMSYS_SW0_RST_B_DISP_DSI0			19
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8186 */
-- 
2.18.0

