Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51F0C432BE
	for <linux-watchdog@archiver.kernel.org>; Thu,  2 Sep 2021 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FAD60234
	for <linux-watchdog@archiver.kernel.org>; Thu,  2 Sep 2021 08:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbhIBIGL (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 2 Sep 2021 04:06:11 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:52938 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243811AbhIBIFr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Sep 2021 04:05:47 -0400
X-UUID: 8395133794db431f8bef9fbc2284c027-20210902
X-UUID: 8395133794db431f8bef9fbc2284c027-20210902
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1283549218; Thu, 02 Sep 2021 16:04:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 16:04:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 16:04:45 +0800
From:   Fengquan Chen <Fengquan.Chen@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <fengquan.chen@mediatek.com>, <tinghan.shen@mediatek.com>,
        <randy.wu@mediatek.com>, <rex-bc.chen@mediatek.com>,
        <christine.zhu@mediatek.com>, <joe.yang@mediatek.com>,
        <zhishuang.zhang@mediatek.com>
Subject: [PATCH] watchdog: mtk: add disable_wdt_extrst support
Date:   Thu, 2 Sep 2021 16:04:40 +0800
Message-ID: <1630569881-6032-1-git-send-email-Fengquan.Chen@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: "fengquan.chen" <fengquan.chen@mediatek.com>

In some cases, we may need watchdog just to trigger an
internal soc reset without sending any output signal.

Provide a disable_wdt_extrst parameter for configuration.
We can disable or enable it just by configuring dts.

fengquan.chen (1):
  watchdog: mtk: add disable_wdt_extrst support

 drivers/watchdog/mtk_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
1.8.1.1.dirty

