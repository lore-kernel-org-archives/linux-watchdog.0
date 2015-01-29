Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:56294 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886AbbA2RWa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 29 Jan 2015 12:22:30 -0500
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: [PATCH 0/4] watchdog: MAX63xx cleanup and platform settings
Date: Thu, 29 Jan 2015 12:15:41 -0500
Message-Id: <1422551745-29101-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The purpose of this patchset is to add a platform data structure for the
max63xx_wdt driver in order to setup the device in a platform code. This is
especially handy if the driver is built-in and/or the device registers aren't
memory mapped.

First, fix the Kconfig entry to allow building the support for architectures
other than ARM. Then clean up the driver to help distinguish different device
connections and to ease the introduction of new features: support for GPIO
wired MAX63xx devices and heartbeat as a platform setting.

Tested with a GPIO wired MAX6373 on an Atom platform, with a built-in driver.

Vivien Didelot (4):
  watchdog: MAX63XX_WATCHDOG does not depend on ARM
  watchdog: max63xx: cleanup
  watchdog: max63xx: add GPIO support
  watchdog: max63xx: add heartbeat to platform data

 drivers/watchdog/Kconfig                  |   9 +-
 drivers/watchdog/max63xx_wdt.c            | 297 +++++++++++++++++++-----------
 include/linux/platform_data/max63xx_wdt.h |  29 +++
 3 files changed, 226 insertions(+), 109 deletions(-)
 create mode 100644 include/linux/platform_data/max63xx_wdt.h

-- 
2.2.2

