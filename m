Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45319C433ED
	for <linux-watchdog@archiver.kernel.org>; Fri, 23 Apr 2021 03:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33F76145A
	for <linux-watchdog@archiver.kernel.org>; Fri, 23 Apr 2021 03:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbhDWDBO (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 22 Apr 2021 23:01:14 -0400
Received: from mail-m17640.qiye.163.com ([59.111.176.40]:34812 "EHLO
        mail-m17640.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhDWDBN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Apr 2021 23:01:13 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Apr 2021 23:01:12 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.229])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id A94DF54039F;
        Fri, 23 Apr 2021 10:53:38 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH V7 0/2] watchdog: mtk: support pre-timeout when the bark irq is available
Date:   Fri, 23 Apr 2021 10:53:21 +0800
Message-Id: <1619146403-12769-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0pNHVYeTUIYS05JTEtNTx9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6TCo*AT8STw00SzI3ECgh
        Hh4aCh1VSlVKTUpCSk9NT0pCSE5JVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUJZV1kIAVlBSk1CTzcG
X-HM-Tid: 0a78fca5ab2fd995kuwsa94df54039f
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Use the bark interrupt as the pretimeout notifier if available.
The pretimeout notification shall occur at timeout-sec/2.

Wang Qing (2):
  watchdog: mtk: support pre-timeout when the bark irq is available
  doc: mtk-wdt: support pre-timeout when the bark irq is available

 .../devicetree/bindings/watchdog/mtk-wdt.txt       |  5 ++
 drivers/watchdog/mtk_wdt.c                         | 76 ++++++++++++++++++++--
 2 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.7.4

