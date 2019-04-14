Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0E2C282DA
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3D0218D3
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfDNK0f (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:26:35 -0400
Received: from sauhun.de ([88.99.104.3]:32872 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfDNK0f (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 06:26:35 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id B91A32CF687;
        Sun, 14 Apr 2019 12:26:32 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 00/16] watchdog: refactor init_timeout and update users
Date:   Sun, 14 Apr 2019 12:26:11 +0200
Message-Id: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

When trying to add DT support to the DA9063 WDT, I didn't want to add yet
another error message when watchdog_init_timeout fails. The core could do this
with more detail, and also much more consistent. So, I refactored this routine
and removed error strings from its callers. Note that DA9063 support is not
added here because I still need to think about another issue. But this series
has been tested using the renesas_wdt driver on a Renesas Salvator-XS board
(R-Car M3N) and build bot is happy, too.

Looking forward to comments.

Thanks,

   Wolfram

Wolfram Sang (16):
  watchdog: refactor watchdog_init_timeout
  watchdog: add error messages when initializing timeout fails
  watchdog: cadence_wdt: drop warning after calling
    watchdog_init_timeout
  watchdog: cadence_wdt: still probe if user supplied timeout is invalid
  watchdog: ebc-c384_wdt: drop warning after calling
    watchdog_init_timeout
  watchdog: hpwdt: drop warning after calling watchdog_init_timeout
  watchdog: i6300esb: drop warning after calling watchdog_init_timeout
  watchdog: imx_sc_wdt: drop warning after calling watchdog_init_timeout
  watchdog: ni903x_wdt: drop warning after calling watchdog_init_timeout
  watchdog: nic7018_wdt: drop warning after calling
    watchdog_init_timeout
  watchdog: renesas_wdt: drop warning after calling
    watchdog_init_timeout
  watchdog: sp5100_tco: drop warning after calling watchdog_init_timeout
  watchdog: st_lpc_wdt: drop warning after calling watchdog_init_timeout
  watchdog: stm32_iwdg: drop warning after calling watchdog_init_timeout
  watchdog: xen_wdt: drop warning after calling watchdog_init_timeout
  watchdog: ziirave_wdt: drop warning after calling
    watchdog_init_timeout

 drivers/watchdog/cadence_wdt.c   |  7 +------
 drivers/watchdog/ebc-c384_wdt.c  |  5 +----
 drivers/watchdog/hpwdt.c         |  3 +--
 drivers/watchdog/i6300esb.c      |  5 +----
 drivers/watchdog/imx_sc_wdt.c    |  5 +----
 drivers/watchdog/ni903x_wdt.c    |  4 +---
 drivers/watchdog/nic7018_wdt.c   |  5 +----
 drivers/watchdog/renesas_wdt.c   |  4 +---
 drivers/watchdog/sp5100_tco.c    |  4 +---
 drivers/watchdog/st_lpc_wdt.c    |  4 +---
 drivers/watchdog/stm32_iwdg.c    |  6 +-----
 drivers/watchdog/watchdog_core.c | 39 ++++++++++++++++++++++++---------------
 drivers/watchdog/xen_wdt.c       |  4 +---
 drivers/watchdog/ziirave_wdt.c   |  6 +-----
 14 files changed, 37 insertions(+), 64 deletions(-)

-- 
2.11.0

