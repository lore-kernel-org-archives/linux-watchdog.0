Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39100 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbeH1OMu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 10:12:50 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] watchdog: fix OOPS when using stop_on_unregister and use it for R-Car
Date: Tue, 28 Aug 2018 12:13:46 +0200
Message-Id: <20180828101348.12443-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I wanted to activate 'stop_on_unregister' for the Renesas R-Car driver (see
patch 2) and stumbled over an OOPS when using it. So, patch 1 addresses this
problem to the best of my knowledge. Looking forward to comments.

Happy hacking,

   Wolfram


Wolfram Sang (2):
  watchdog: core: fix null pointer dereference when releasing cdev
  watchdog: renesas_wdt: stop when unregistering

 drivers/watchdog/renesas_wdt.c  |  1 +
 drivers/watchdog/watchdog_dev.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.11.0
