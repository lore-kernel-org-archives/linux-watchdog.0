Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.115]:40912 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751294AbaEPPuH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 16 May 2014 11:50:07 -0400
Date: Fri, 16 May 2014 18:36:43 +0200
From: Andreas Werner <andreas.werner@men.de>
To: <linux-kernel@vger.kernel.org>
CC: <sameo@linux.intel.com>, <lee.jones@linaro.org>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>, <cooloney@gmail.com>,
	<rpurdie@rpsys.net>, <linux-leds@vger.kernel.org>,
	<johannes.thumshirn@men.de>, <thomas.schnuerer@men.de>,
	<wernerandy@gmx.de>
Subject: [PATCH 0/3] Introduce MEN 14F021P00 Board Management Controller
 driver set
Message-ID: <cover.1400258021.git.andreas.werner@men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch set add support for the MEN 14F021P00 Board Management Controller called BMC.

The BMC is a PIC Mikrocontroller which assembled on almost all
of our 3U Compact PCI CPU boards and a few Box PCs.
The main part of the BMC is to start and monitor the board,
but there are a lot more features which can be accessed using an I2C Host interface.

Features supported in this Patchset:
        - Watchdog
        - LEDs

The Patchset includes a MFD Core driver, Watchdog and LEDs driver.

Andreas Werner (3):
  drivers/mfd/menf21bmc: introduce MEN 14F021P00 BMC MFD Core driver
  drivers/watchdog/menf21bmc_wd: introduce MEN 14F021P00 BMC Watchdog
    driver
  drivers/leds/leds-menf21bmc: introduce MEN 14F021P00 BMC LED driver

 drivers/leds/Kconfig            |   6 +
 drivers/leds/Makefile           |   2 +-
 drivers/leds/leds-menf21bmc.c   | 135 +++++++++++++++++++++
 drivers/mfd/Kconfig             |  12 ++
 drivers/mfd/Makefile            |   1 +
 drivers/mfd/menf21bmc.c         | 193 +++++++++++++++++++++++++++++
 drivers/watchdog/Kconfig        |   7 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/menf21bmc_wd.c | 263 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/menf21bmc.h   |  32 +++++
 10 files changed, 651 insertions(+), 1 deletion(-)
 create mode 100644 drivers/leds/leds-menf21bmc.c
 create mode 100644 drivers/mfd/menf21bmc.c
 create mode 100644 drivers/watchdog/menf21bmc_wd.c
 create mode 100644 include/linux/mfd/menf21bmc.h

-- 
1.9.2

