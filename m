Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44848 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbeH2LiS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Aug 2018 07:38:18 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v3 0/4] watchdog: prevent removing a driver if NOWAYOUT
Date: Wed, 29 Aug 2018 09:42:37 +0200
Message-Id: <20180829074241.1943-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

So, here is my second approach, now avoiding probe() and targetting the init
call. To avoid boilerplate, I introduced macros similar to module_driver(). It
still feels a little adventurous because of hard-coding
'.driver.suppress_bind_attts' in the macro and trusting various driver types
(like platform and PCI) to follow this structure.

Having all this said, it works nicely on my Renesas Salvator-XS (R-Car M3-N).
build bot is happy. A git branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/wdt-suppress-attr

Looking forward to comments.

Thanks,

   Wolfram

Changes since V2:
	* keep the remove callback valid
	* remove 'if' from macro

Wolfram Sang (4):
  watchdog: core: add mechanism to prevent removing if NOWAYOUT
  watchdog: renesas_wdt: avoid removing if NOWAYOUT
  watchdog: core: add module_watchdog_pci_driver()
  watchdog: i6300esb: avoid removing if NOWAYOUT

 drivers/watchdog/i6300esb.c    |  2 +-
 drivers/watchdog/renesas_wdt.c |  2 +-
 include/linux/watchdog.h       | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.11.0
