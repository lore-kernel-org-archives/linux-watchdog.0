Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:19314
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752836AbdH2Pm6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 11:42:58 -0400
From: "Steven J. Hill" <steven.hill@cavium.com>
To: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 0/8] Update Octeon watchdog driver.
Date: Tue, 29 Aug 2017 10:40:30 -0500
Message-Id: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patchset updates the Octeon watchdog with bug fixes and new
platforms. This code has been tested on our 70xx and 78xx development
boards as well as an EdgeRouter PRO.

* The time it takes for the watchdog to trigger is now 1 second
  for all tested platforms. The various cores have different
  divisor values. Some of these were just plain wrong. Example:
  On our 78xx platform, it took 1m20s for the watchdog to trigger
  and reset the board.
* Support has been added for newer 7xxx SOCs.
* The boot vector code has been simplified and updated.

These watchdog driver changes are dependant on MIPS architecture
code changes. Would the watchdog driver maintainers be willing to
allow Ralf to include the driver code along with the next MIPS
architecture update? Thanks for considering. -Steve


Carlos Munoz (1):
  watchdog: octeon-wdt: Add support for 78XX SOCs.

David Daney (1):
  watchdog: octeon-wdt: Add support for cn68XX SOCs.

Steven J. Hill (6):
  MIPS: Octeon: Add support for accessing the boot vector.
  watchdog: octeon-wdt: Remove old boot vector code.
  MIPS: Octeon: Watchdog registers for 70xx, 73xx, 78xx, F75xx.
  MIPS: Octeon: Make CSR functions node aware.
  MIPS: Octeon: Allow access to CIU3 IRQ domains.
  watchdog: octeon-wdt: File cleaning.

 arch/mips/cavium-octeon/executive/Makefile         |   2 +-
 .../cavium-octeon/executive/cvmx-boot-vector.c     | 167 ++++++++++
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |  85 +++++
 arch/mips/cavium-octeon/octeon-irq.c               |   9 +
 arch/mips/include/asm/octeon/cvmx-boot-vector.h    |  53 +++
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |  28 ++
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       |  10 +
 arch/mips/include/asm/octeon/cvmx.h                |  28 ++
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 drivers/watchdog/octeon-wdt-main.c                 | 354 ++++++++++-----------
 drivers/watchdog/octeon-wdt-nmi.S                  |  42 ++-
 11 files changed, 592 insertions(+), 188 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
 create mode 100644 arch/mips/include/asm/octeon/cvmx-boot-vector.h

-- 
2.1.4

