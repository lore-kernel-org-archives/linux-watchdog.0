Return-Path: <anholt@anholt.net>
Return-path: <anholt@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH v3 0/5] BCM2835 PM driver (MFD version respin)
Date: Fri, 30 Nov 2018 12:27:38 -0800
Message-Id: <20181130202743.20585-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Guenter had some minor changes to patch #2, which I've done in this
version.

Eric Anholt (5):
  dt-bindings: soc: Add a new binding for the BCM2835 PM node.
  bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
  soc: bcm: bcm2835-pm: Add support for power domains under a new
    binding.
  ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block.
  ARM: bcm283x: Switch V3D over to using the PM driver instead of
    firmware.

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |  42 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |   4 -
 arch/arm/boot/dts/bcm283x.dtsi                |  16 +-
 arch/arm/mach-bcm/Kconfig                     |   1 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/bcm2835-pm.c                      |  92 +++
 drivers/soc/bcm/Kconfig                       |  11 +
 drivers/soc/bcm/Makefile                      |   1 +
 drivers/soc/bcm/bcm2835-power.c               | 661 ++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c                |  26 +-
 include/dt-bindings/soc/bcm2835-pm.h          |  28 +
 include/linux/mfd/bcm2835-pm.h                |  14 +
 12 files changed, 873 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/mfd/bcm2835-pm.c
 create mode 100644 drivers/soc/bcm/bcm2835-power.c
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h
 create mode 100644 include/linux/mfd/bcm2835-pm.h

-- 
2.20.0.rc1
