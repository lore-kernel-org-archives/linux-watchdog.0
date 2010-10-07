From: David Daney <ddaney@caviumnetworks.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: David Daney <ddaney@caviumnetworks.com>,
        Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 00/14] Add initial support for Octeon CN63XX
Date: Thu,  7 Oct 2010 16:03:39 -0700
Message-Id: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
Return-Path: <David.Daney@caviumnetworks.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

The OCTEON II CN63XX is a new member of the OCTEON family of SOCs.  It
has up to 6 CPU cores and the programing its I/O blocks is similar to
previous OCTEON parts.  There are however, some differences, hence
this patch set.

With these first 14 patches, we support everything *except* USB, PCIe and
Ethernet.  Patches to add support for those will follow.

The Compact Flash and Watchdog patches are the only ones that fall
outside of the MIPS architecture part of the tree.  Since these are
trivial one-liners, it may be possible to merge them via Ralf's
linux-mips.org tree.

David Daney (14):
  MIPS: Octeon: Update register definitions for CN63XX chips
  MIPS: Octeon: Add cn63XX to Octeon chip detection macros.
  MIPS: Octeon: Update L2 Cache code for CN63XX
  MIPS: Add identifiers for Octeon II CPUs.
  MIPS: Octeon: Handle Octeon II caches.
  MIPS: Octeon: Probe for Octeon II CPUs.
  MIPS: Octeon: Enable Read Inhibit / eXecute Inhibit on Octeon II.
  MIPS: Octeon: Scale Octeon2 clocks in  octeon_init_cvmcount()
  MIPS: Octeon: Remove bogus code from octeon_get_clock_rate()
  MIPS: Octeon: Add octeon_get_io_clock_rate() for cn63xx
  MIPS: Octeon: Use I/O clock rate for calculations.
  ata: pata_octeon_cf: Use I/O clock rate for timing calculations.
  watchdog: octeon-wdt: Use I/O clock rate for timing calculations.
  MIPS: Octeon: Apply CN63XXP1 errata workarounds.

 arch/mips/Makefile                                 |    1 +
 arch/mips/cavium-octeon/Kconfig                    |   11 +
 arch/mips/cavium-octeon/csrc-octeon.c              |   34 +-
 arch/mips/cavium-octeon/executive/cvmx-l2c.c       |  811 +++++++++++--------
 arch/mips/cavium-octeon/octeon-platform.c          |    2 +-
 arch/mips/cavium-octeon/serial.c                   |    2 +-
 arch/mips/cavium-octeon/setup.c                    |  120 ++-
 arch/mips/include/asm/cpu.h                        |    3 +-
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    2 +-
 arch/mips/include/asm/octeon/cvmx-agl-defs.h       |  616 ++++++++++-----
 arch/mips/include/asm/octeon/cvmx-asm.h            |   11 +
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       |  857 ++++++++++++++++++--
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h      |   74 ++-
 arch/mips/include/asm/octeon/cvmx-iob-defs.h       |  242 ++++--
 arch/mips/include/asm/octeon/cvmx-ipd-defs.h       |  314 +++++---
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h       |  738 +++++++++++++++--
 arch/mips/include/asm/octeon/cvmx-l2c.h            |  225 +++---
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h       |   38 +-
 arch/mips/include/asm/octeon/cvmx-l2t-defs.h       |    5 +-
 arch/mips/include/asm/octeon/cvmx-led-defs.h       |   41 +-
 arch/mips/include/asm/octeon/cvmx-mio-defs.h       |  807 ++++++++++++++-----
 arch/mips/include/asm/octeon/cvmx-mixx-defs.h      |  200 ++++--
 arch/mips/include/asm/octeon/cvmx-npei-defs.h      |  681 +++++++---------
 arch/mips/include/asm/octeon/cvmx-npi-defs.h       |  362 +++------
 arch/mips/include/asm/octeon/cvmx-pci-defs.h       |  265 ++----
 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h   |  435 +++++++----
 arch/mips/include/asm/octeon/cvmx-pescx-defs.h     |   50 +-
 arch/mips/include/asm/octeon/cvmx-pexp-defs.h      |  378 +++++-----
 arch/mips/include/asm/octeon/cvmx-pow-defs.h       |  157 +++--
 arch/mips/include/asm/octeon/cvmx-rnm-defs.h       |   67 ++-
 arch/mips/include/asm/octeon/cvmx-smix-defs.h      |   46 +-
 arch/mips/include/asm/octeon/octeon-model.h        |   36 +-
 arch/mips/include/asm/octeon/octeon.h              |    1 +
 arch/mips/kernel/cpu-probe.c                       |    7 +
 arch/mips/mm/c-octeon.c                            |   16 +-
 arch/mips/mm/uasm.c                                |   20 +-
 drivers/ata/pata_octeon_cf.c                       |    2 +-
 drivers/watchdog/octeon-wdt-main.c                 |    4 +-
 38 files changed, 5049 insertions(+), 2632 deletions(-)

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
-- 
1.7.2.3
