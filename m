Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41454 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1XHg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 19:07:36 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 0/4] watchdog: prevent removing a driver if NOWAYOUT
Date: Tue, 28 Aug 2018 21:14:12 +0200
Message-Id: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

So, here is my second approach, now avoiding probe() and targetting the init
call. To avoid boilerplate, I introduced macros similar to module_driver(). It
still feels a little adventurous because of hard-coding '.remove' and
'.driver.suppress_bind_attts' in the macro and trusting various driver types
(like platform and PCI) to follow this structure.

Having all this said, it works nicely on my Renesas Salvator-XS (R-Car M3-N).
No reply from buildbot yet, but it is RFC only, so I'll send it out already. A
git branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/wdt-suppress-attr

Looking forward to comments.

Thanks,

   Wolfram

Wolfram Sang (4):
  watchdog: core: add mechanism to prevent removing if NOWAYOUT
  watchdog: renesas_wdt: avoid removing if NOWAYOUT
  watchdog: core: add module_watchdog_pci_driver()
  watchdog: i6300esb: avoid removing if NOWAYOUT

 drivers/watchdog/i6300esb.c    |  2 +-
 drivers/watchdog/renesas_wdt.c |  2 +-
 include/linux/watchdog.h       | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.11.0
