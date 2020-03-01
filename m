Return-Path: <SRS0=wJ0A=4S=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6BEC3F2CE
	for <linux-watchdog@archiver.kernel.org>; Sun,  1 Mar 2020 10:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C75214DB
	for <linux-watchdog@archiver.kernel.org>; Sun,  1 Mar 2020 10:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgCAKHz (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 1 Mar 2020 05:07:55 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:38437 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgCAKHz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 1 Mar 2020 05:07:55 -0500
X-Greylist: delayed 1569 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 05:07:51 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 0219eg7I028745;
        Sun, 1 Mar 2020 11:40:42 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id B51436032E; Sun,  1 Mar 2020 11:40:42 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, avifishman70@gmail.com,
        tali.perry1@gmail.com, yuenn@google.com, benjaminfair@google.com
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/4] watchdog: npcm: support new capabilities
Date:   Sun,  1 Mar 2020 11:40:36 +0200
Message-Id: <20200301094040.123189-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

This patch set adds last reset bootstatus and restart priority
support in watchdog the Nuvoton NPCM Baseboard Management
Controller (BMC).

The NPCM watchdog driver tested on NPCM750 evaluation board.

Tomer Maimon (4):
  dt-binding: watchdog: add restart priority documentation
  watchdog: npcm: add restart priority support
  dt-binding: watchdog: add bootstatus reset type documentation
  watchdog: npcm: sets card ext1 and ext2 bootstatus during probe

 .../bindings/watchdog/nuvoton,npcm-wdt.txt    |  32 ++++
 drivers/watchdog/npcm_wdt.c                   | 138 ++++++++++++++++--
 2 files changed, 157 insertions(+), 13 deletions(-)

-- 
2.22.0

