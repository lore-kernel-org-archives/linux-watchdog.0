Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A523CC433EF
	for <linux-watchdog@archiver.kernel.org>; Tue,  7 Sep 2021 20:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5A161106
	for <linux-watchdog@archiver.kernel.org>; Tue,  7 Sep 2021 20:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbhIGUk4 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:40:56 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:33912 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244893AbhIGUk4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 7 Sep 2021 16:40:56 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Sep 2021 16:40:55 EDT
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 19CEC409F1; Tue,  7 Sep 2021 21:11:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 19CEC409F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1631041900;
        bh=oF4tV9tT0lEW5+fDZWp/p1gtYiPQDgBBm60Kv8UoD7k=;
        h=Date:From:To:Cc:Subject:From;
        b=sgDV98R4n/im3kbQWE1ogD7fDLYq+VlBeTeaAesMygfXnFuXnG/uKG4LWOBVZyK+7
         2k7wzpa2jCu6o3rj7jzPn1gkJ8OFOG1fHu7EQhNKR9FnGbsUgVg51KIh1caRKg4t7X
         uoOtGzbd8qXk9x2NgyNlnFN+RfX/rkVhx9O0wcZk=
Date:   Tue, 7 Sep 2021 21:11:39 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christine Zhu <Christine.Zhu@mediatek.com>,
        Curtis Klein <curtis.klein@hpe.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [GIT PULL REQUEST] watchdog - v5.12 Merge window
Message-ID: <20210907191139.GA18865@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v5.12 release cycle.

This series contains:
* Add Mediatek MT7986 & MT8195 wdt support
* Add Maxim MAX63xx
* Drop bd70528 support
* rewrite ixp4xx to watchdog framework
* Constify static struct watchdog_ops for sl28cpld_wdt, mpc8xxx_wdt and tqmx86
* Introduce watchdog_dev_suspend/resume
* Several fixes and improvements


The output from git request-pull:
----------------------------------------------------------------
The following changes since commit d992fe5318d8d7af9510b879439a3c7f283da442:

  Merge tag 'soc-fixes-5.14-3' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2021-08-19 15:32:58 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.15-rc1

for you to fetch changes up to 41e73feb1024929e75eaf2f7cd93f35a3feb331b:

  dt-bindings: watchdog: Add compatible for Mediatek MT7986 (2021-08-22 10:28:12 +0200)

----------------------------------------------------------------
linux-watchdog 5.15-rc1 tag

----------------------------------------------------------------
Christine Zhu (2):
      dt-bindings: reset: mt8195: add toprgu reset-controller header file
      watchdog: mediatek: mt8195: add wdt support

Curtis Klein (2):
      watchdog: only run driver set_pretimeout op if device supports it
      watchdog: Fix NULL pointer dereference when releasing cdev

Grzegorz Jaszczyk (2):
      watchdog: introduce watchdog_dev_suspend/resume
      watchdog: imx2_wdg: notify wdog core to stop ping worker on suspend

Jan Kiszka (2):
      watchdog: iTCO_wdt: Fix detection of SMI-off case
      watchdog: Start watchdog in watchdog_set_last_hw_keepalive only if appropriate

Linus Walleij (3):
      dt-bindings: watchdog: Add Maxim MAX63xx bindings
      watchdog: max63xx_wdt: Add device tree probing
      watchdog: ixp4xx: Rewrite driver to use core

Matti Vaittinen (1):
      watchdog: bd70528 drop bd70528 support

Rikard Falkeborn (3):
      watchdog: sl28cpld_wdt: Constify static struct watchdog_ops
      watchdog: mpc8xxx_wdt: Constify static struct watchdog_ops
      watchdog: tqmx86: Constify static struct watchdog_ops

Sam Shih (1):
      dt-bindings: watchdog: Add compatible for Mediatek MT7986

Stefan Wahren (1):
      watchdog: bcm2835_wdt: consider system-power-controller property

 .../bindings/watchdog/maxim,max63xx.yaml           |  44 ++++
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |   1 +
 drivers/clocksource/timer-ixp4xx.c                 |  48 +++-
 drivers/watchdog/Kconfig                           |  13 +-
 drivers/watchdog/Makefile                          |   1 -
 drivers/watchdog/bcm2835_wdt.c                     |  10 +-
 drivers/watchdog/bd70528_wdt.c                     | 291 ---------------------
 drivers/watchdog/iTCO_wdt.c                        |   2 +-
 drivers/watchdog/imx2_wdt.c                        |   1 +
 drivers/watchdog/ixp4xx_wdt.c                      | 283 +++++++++-----------
 drivers/watchdog/max63xx_wdt.c                     |  24 +-
 drivers/watchdog/mpc8xxx_wdt.c                     |   2 +-
 drivers/watchdog/mtk_wdt.c                         |   6 +
 drivers/watchdog/sl28cpld_wdt.c                    |   2 +-
 drivers/watchdog/tqmx86_wdt.c                      |   2 +-
 drivers/watchdog/watchdog_core.c                   |  37 +++
 drivers/watchdog/watchdog_dev.c                    |  57 +++-
 include/dt-bindings/reset/mt8195-resets.h          |  29 ++
 include/linux/watchdog.h                           |  10 +
 19 files changed, 368 insertions(+), 495 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
 delete mode 100644 drivers/watchdog/bd70528_wdt.c
 create mode 100644 include/dt-bindings/reset/mt8195-resets.h
----------------------------------------------------------------

Kind regards,
Wim.

