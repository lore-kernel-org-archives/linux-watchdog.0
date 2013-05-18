Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:42477 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab3ERWh1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 May 2013 18:37:27 -0400
From: Tomasz Figa <tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, jhbird.choi@samsung.com,
	Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 0/6] Samsung watchdog support clean-up
Date: Sun, 19 May 2013 00:37:01 +0200
Message-Id: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This series is aiming at cleaning up a bit watchdog support on Samsung
SoCs. The patches tweak a bit all the watchdog handling code here and
there, with the goal of making it DT- and multiplatform-friendly.

See particular patches for more detailed descriptions.

On S3C6410-based Tiny6410 board (Mini6410-compatible):

Tested-by: Tomasz Figa <tomasz.figa@gmail.com>

Depends on:
 - [PATCH] ARM: s5p64x0: Use common uncompress.h part for plat-samsung

Tomasz Figa (6):
  watchdog: s3c2410_wdt: Use local register definitions
  ARM: SAMSUNG: uncompress: Use local definitions of watchdog registers
  ARM: SAMSUNG: Add watchdog reset driver
  ARM: SAMSUNG: Let platforms use the new watchdog reset driver
  ARM: SAMSUNG: Remove legacy watchdog reset code
  ARM: SAMSUNG: Remove unused plat/regs-watchdog.h header

 arch/arm/Kconfig                                   |  3 +
 arch/arm/mach-s3c24xx/Kconfig                      |  2 +
 arch/arm/mach-s3c24xx/s3c2410.c                    |  3 +-
 arch/arm/mach-s3c24xx/s3c244x.c                    |  3 +-
 arch/arm/mach-s3c64xx/common.c                     |  8 +-
 arch/arm/mach-s5p64x0/common.c                     |  4 +-
 arch/arm/mach-s5pc100/common.c                     |  3 +-
 arch/arm/plat-samsung/Kconfig                      |  6 ++
 arch/arm/plat-samsung/Makefile                     |  1 +
 arch/arm/plat-samsung/include/plat/regs-watchdog.h | 41 ---------
 arch/arm/plat-samsung/include/plat/uncompress.h    | 15 +++-
 .../arm/plat-samsung/include/plat/watchdog-reset.h | 38 ++-------
 arch/arm/plat-samsung/watchdog-reset.c             | 97 ++++++++++++++++++++++
 drivers/watchdog/s3c2410_wdt.c                     | 17 +++-
 14 files changed, 156 insertions(+), 85 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-watchdog.h
 create mode 100644 arch/arm/plat-samsung/watchdog-reset.c

-- 
1.8.2.1

