Return-Path: <SRS0=s/UX=4U=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C744C3F2C6
	for <linux-watchdog@archiver.kernel.org>; Tue,  3 Mar 2020 10:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECAA20873
	for <linux-watchdog@archiver.kernel.org>; Tue,  3 Mar 2020 10:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgCCKCi (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:02:38 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:38679 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728041AbgCCKCi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Mar 2020 05:02:38 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 023A1GLr019840;
        Tue, 3 Mar 2020 12:01:16 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 9C23F6032E; Tue,  3 Mar 2020 12:01:16 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, avifishman70@gmail.com,
        tali.perry1@gmail.com, yuenn@google.com, benjaminfair@google.com
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/3] watchdog: npcm: add last bootstatus support
Date:   Tue,  3 Mar 2020 12:01:11 +0200
Message-Id: <20200303100114.87786-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

This patch set adds last reset bootstatus support in 
watchdog the Nuvoton NPCM Baseboard Management Controller (BMC).

The NPCM watchdog driver tested on NPCM750 evaluation board.

Addressed comments from:.
 - Guenter Roeck: https://www.spinics.net/lists/kernel/msg3425926.html 
 - Guenter Roeck: https://lkml.org/lkml/2020/3/1/144 
				  
Changes since version 1:
 - Remove restart priority support.
 - Modify commit message.
 - Modify define in alphabetic order.
 - Add reset bootstatus remarks.
 - Remove and modify whitespace.

Tomer Maimon (3):
  dt-binding: watchdog: add bootstatus reset type documentation
  watchdog: npcm: sets card ext1 and ext2 bootstatus during probe
  watchdog: npcm: remove whitespaces

 .../bindings/watchdog/nuvoton,npcm-wdt.txt    |  30 ++++
 drivers/watchdog/npcm_wdt.c                   | 131 ++++++++++++++++--
 2 files changed, 151 insertions(+), 10 deletions(-)

-- 
2.22.0

