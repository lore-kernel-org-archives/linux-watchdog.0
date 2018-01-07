Return-Path: <david@lechnology.com>
Return-path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: davinici: move watchdog restart from mach to drivers
Date: Sat,  6 Jan 2018 21:10:13 -0600
Message-Id: <1515294615-5473-1-git-send-email-david@lechnology.com>
List-ID: <linux-watchdog@vger.kernel.org>

This series moves the watchdog restart code from arch/arm/mach-davinci
to drivers/watchdog.

Tested working on LEGO MINDSTORMS EV3 (TI AM1808 processor).

v2 changes:
* rebased on linux-davinci/master (fixed conflict with clock.h)

There is also still the unresolved question from Sekhar:

> Hi Wim,
> 
> How do you want to handle this series? Patch 2/2 definitely needs to go
> through my tree as it will clash with other code I am queuing.
> 
> I can either take 1/2 also through ARM-SoC with your ack (preferred) or
> if you give me an immutable commit/tag over v4.15-rc1, I can merge that
> to preserve bisect-ability.

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
