Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45E2C433EF
	for <linux-watchdog@archiver.kernel.org>; Fri, 25 Feb 2022 17:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiBYRyD (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiBYRyC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 25 Feb 2022 12:54:02 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A59875211;
        Fri, 25 Feb 2022 09:53:28 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,136,1643641200"; 
   d="scan'208";a="111603438"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Feb 2022 02:53:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.192])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3A0164006DFB;
        Sat, 26 Feb 2022 02:53:24 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 0/7] RZG2L_WDT Fixes and Improvements
Date:   Fri, 25 Feb 2022 17:53:13 +0000
Message-Id: <20220225175320.11041-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The first 4 patch in this series fixes the below issues
1) 32 bit overflow issue
2) Runtime PM usage count issue
3) BUG: Invalid context during reset.
4) Reset control imbalance

The later 3 patches are enhancements to the WDT driver.
1) Adding error check for reset_control_deassert() and fixing reset_control imbalance.
2) Generate Parity error for WDT reset
3) Add support for set_timeout callback

v4->v5:
 * Updated commit description of patch#4
 * Added Rb tag from Geert.
 * Separated reset control imbalance from patch#4

Biju Das (7):
  watchdog: rzg2l_wdt: Fix 32bit overflow issue
  watchdog: rzg2l_wdt: Fix Runtime PM usage
  watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'
  watchdog: rzg2l_wdt: Fix reset control imbalance
  watchdog: rzg2l_wdt: Add error check for reset_control_deassert
  watchdog: rzg2l_wdt: Use force reset for WDT reset
  watchdog: rzg2l_wdt: Add set_timeout callback

 drivers/watchdog/rzg2l_wdt.c | 83 ++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 36 deletions(-)

-- 
2.17.1

