Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34261 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcERIVT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 May 2016 04:21:19 -0400
Received: by mail-pa0-f66.google.com with SMTP id yl2so4212002pac.1
        for <linux-watchdog@vger.kernel.org>; Wed, 18 May 2016 01:21:18 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: linux@roeck-us.net, wim@iguana.be, robh@kernel.org
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jk@ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH v3 0/2]  watchdog: Add Aspeed watchdog driver
Date: Wed, 18 May 2016 17:50:58 +0930
Message-Id: <1463559661-14170-1-git-send-email-joel@jms.id.au>
In-Reply-To: <1463062631-16432-1-git-send-email-joel@jms.id.au>
References: <1463062631-16432-1-git-send-email-joel@jms.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

These patches add support for the watchdog timer found in Aspeed ast2400 and
ast2500 BMC SoCs.

The u-boot that ships on the edk and with many systems leaves the watchdog
running when jumping to the kernel, making this driver required for operation.

It has been tested on the ast2400 in an OpenPower Palmetto, and the ast2500-edk
dev board.

Changes in v3:
 - remove rate from struct aspeed_wdt in favour of #define
 - don't start the timer when setting the timeout
 - wait after initiaitng the reboot so it catches
 - remove dev_info from startup

 - update bindings following review from Rob (this didn't make it to the
 mailing list in v2)

Changes in v2:

Addressed review from Guenter:
 - dropped the drv_dbgs
 - added defines for all of the constants
 - clarified the type of reset we want
 - leaves the watchdog running

Cheers,

Joel

Joel Stanley (2):
  doc/devicetree: Add Aspeed watchdog timer bindings
  watchdog: Add Aspeed watchdog driver

 .../devicetree/bindings/watchdog/aspeed-wdt.txt    |  16 ++
 drivers/watchdog/Kconfig                           |  13 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/aspeed_wdt.c                      | 212 +++++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
 create mode 100644 drivers/watchdog/aspeed_wdt.c

-- 
2.8.1

