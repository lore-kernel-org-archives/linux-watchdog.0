Return-Path: <SRS0=TCtj=SV=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0784C282E0
	for <linux-watchdog@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB5C222EB
	for <linux-watchdog@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfDSSQN (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:16:13 -0400
Received: from sauhun.de ([88.99.104.3]:50494 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfDSSQM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:12 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id B98202E354E;
        Fri, 19 Apr 2019 20:16:08 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 00/16] watchdog: refactor init_timeout and update users
Date:   Fri, 19 Apr 2019 20:15:45 +0200
Message-Id: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

When trying to add DT support to the DA9063 WDT, I didn't want to add yet
another error message when watchdog_init_timeout fails. The core could do this
with more detail, and also much more consistent. So, I refactored this routine
and removed error strings from its callers. Note that DA9063 support is not
added here but was sent seperately[1]. This series has been tested using the
renesas_wdt driver on a Renesas Salvator-XS board (R-Car M3N) and build bot is
happy, too.

A branch (based on Guenter's watchdog-next) for testing can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/wdt-handover

Changes since V2:

* refactored patch 2 to use pr_* instead of dev_* and fall back to wdt
  'identity' if there is no dev attached. Thanks Jerry for the report!
* added rev tag to patch 1 (thanks Guenter for the discussion!)
* added ack tag to patch 5 (thanks William!)

Changes since V1:

* return -EINVAL if DT supplied a value of '0' [patch 1]
* update kdoc to mention that DT cannot be '0' but module_param can be
  [patch 1]
* add Guenter's Rev-by to all patches except patch 1
* add driver maintainers to CC this time

I think we are ready to go now?

Thanks,

   Wolfram

[1] https://patchwork.kernel.org/patch/10899801/

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
 drivers/watchdog/watchdog_core.c | 42 ++++++++++++++++++++++++++--------------
 drivers/watchdog/xen_wdt.c       |  4 +---
 drivers/watchdog/ziirave_wdt.c   |  6 +-----
 14 files changed, 41 insertions(+), 63 deletions(-)

-- 
2.11.0

