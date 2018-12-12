Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:59136 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeLLXv7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Dec 2018 18:51:59 -0500
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v4 0/5] BCM2835 PM driver
Date: Wed, 12 Dec 2018 15:51:45 -0800
Message-Id: <20181212235150.6491-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

v4 adds the system-power-controller node to the binding as requested
by Stefan.  No driver changes are added to make the power controller
behavior optional yet, since it's really unrelated to this series.

Eric Anholt (5):
  dt-bindings: soc: Add a new binding for the BCM2835 PM node. (v4)
  bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
  soc: bcm: bcm2835-pm: Add support for power domains under a new
    binding.
  ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block.
    (v4)
  ARM: bcm283x: Switch V3D over to using the PM driver instead of
    firmware.

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |  46 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |   4 -
 arch/arm/boot/dts/bcm283x.dtsi                |  17 +-
 arch/arm/mach-bcm/Kconfig                     |   1 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/bcm2835-pm.c                      |  92 +++
 drivers/soc/bcm/Kconfig                       |  11 +
 drivers/soc/bcm/Makefile                      |   1 +
 drivers/soc/bcm/bcm2835-power.c               | 661 ++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c                |  26 +-
 include/dt-bindings/soc/bcm2835-pm.h          |  28 +
 include/linux/mfd/bcm2835-pm.h                |  14 +
 12 files changed, 878 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/mfd/bcm2835-pm.c
 create mode 100644 drivers/soc/bcm/bcm2835-power.c
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h
 create mode 100644 include/linux/mfd/bcm2835-pm.h

-- 
2.20.0.rc1
