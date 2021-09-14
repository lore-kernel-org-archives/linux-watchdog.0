Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6848C433EF
	for <linux-watchdog@archiver.kernel.org>; Tue, 14 Sep 2021 12:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE18F6109E
	for <linux-watchdog@archiver.kernel.org>; Tue, 14 Sep 2021 12:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhINMgZ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:36:25 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:49802 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232759AbhINMgQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Sep 2021 08:36:16 -0400
X-UUID: 9e388ca7b8c248c4a6c8e95bb01aa8cc-20210914
X-UUID: 9e388ca7b8c248c4a6c8e95bb01aa8cc-20210914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 36665046; Tue, 14 Sep 2021 20:34:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 20:34:55 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 20:34:53 +0800
From:   Fengquan Chen <Fengquan.Chen@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <fengquan.chen@mediatek.com>, <tinghan.shen@mediatek.com>,
        <randy.wu@mediatek.com>, <rex-bc.chen@mediatek.com>,
        <christine.zhu@mediatek.com>, <joe.yang@mediatek.com>,
        <zhishuang.zhang@mediatek.com>
Subject: [v3,0/2] update mediatek wdt driver and dt-binding
Date:   Tue, 14 Sep 2021 20:34:52 +0800
Message-ID: <20210914123454.32603-1-Fengquan.Chen@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

1. update watchdog dt-binding
2. add disable_wdt_extrst to support disable reset signal output

fengquan.chen (2):
  dt-bindings: watchdog: mtk-wdt: add disable_wdt_extrst support
  watchdog: mtk: add disable_wdt_extrst support

 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 2 ++
 drivers/watchdog/mtk_wdt.c                             | 7 +++++++
 2 files changed, 9 insertions(+)

-- 
2.25.1

