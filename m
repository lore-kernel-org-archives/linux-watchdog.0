Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:41071 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbdLKSUY (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 11 Dec 2017 13:20:24 -0500
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: davinici: move watchdog restart from mach to drivers
Date: Mon, 11 Dec 2017 11:21:07 -0600
Message-Id: <1513012869-7647-1-git-send-email-david@lechnology.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This series moves the watchdog restart code from arch/arm/mach-davinci
to drivers/watchdog.

Tested working on LEGO MINDSTORMS EV3 (TI AM1808 processor).

David Lechner (2):
  watchdog: davinci_wdt: add restart function
  ARM: davinci: remove watchdog reset

 arch/arm/mach-davinci/board-da830-evm.c     |  1 -
 arch/arm/mach-davinci/board-da850-evm.c     |  1 -
 arch/arm/mach-davinci/board-dm355-evm.c     |  1 -
 arch/arm/mach-davinci/board-dm355-leopard.c |  1 -
 arch/arm/mach-davinci/board-dm365-evm.c     |  1 -
 arch/arm/mach-davinci/board-dm644x-evm.c    |  1 -
 arch/arm/mach-davinci/board-dm646x-evm.c    |  2 -
 arch/arm/mach-davinci/board-mityomapl138.c  |  1 -
 arch/arm/mach-davinci/board-neuros-osd2.c   |  1 -
 arch/arm/mach-davinci/board-omapl138-hawk.c |  1 -
 arch/arm/mach-davinci/board-sffsdr.c        |  1 -
 arch/arm/mach-davinci/clock.h               |  3 --
 arch/arm/mach-davinci/da8xx-dt.c            |  1 -
 arch/arm/mach-davinci/devices-da8xx.c       | 13 -------
 arch/arm/mach-davinci/devices.c             |  7 +---
 arch/arm/mach-davinci/include/mach/common.h |  1 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |  1 -
 arch/arm/mach-davinci/time.c                | 57 -----------------------------
 drivers/watchdog/davinci_wdt.c              | 38 +++++++++++++++++++
 19 files changed, 39 insertions(+), 94 deletions(-)

-- 
2.7.4

