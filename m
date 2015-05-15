Return-path: <fu.wei@linaro.org>
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com,
	graeme.gregory@linaro.org,
	al.stone@linaro.org,
	hanjun.guo@linaro.org,
	timur@codeaurora.org,
	ashwin.chaugule@linaro.org,
	arnd@arndb.de,
	linux@roeck-us.net,
	vgandhi@codeaurora.org,
	wim@iguana.be,
	jcm@redhat.com,
	leo.duran@amd.com,
	corbet@lwn.net,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH 0/6] Watchdog: introdouce ARM SBSA watchdog driver
Date: Fri, 15 May 2015 19:08:04 +0800
Message-Id: <1431688090-2145-1-git-send-email-fu.wei@linaro.org>
In-Reply-To: <=fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fu Wei <fu.wei@linaro.org>

This patchset:

    (1)Introdouces Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
    for FDT info of SBSA Generic Watchdog, and give two examples of
    adding SBSA Generic Watchdog device node into the dts files:
    foundation-v8.dts and amd-seattle-soc.dtsi

    (2)Introdouce "pretimeout" into the watchdog framework

    (3)Introdouces ARM SBSA watchdog driver
        a.Use linux kernel watchdog framework
        b.Work with FDT on ARM64
        c.Use "pretimeout" in watchdog framework
        d.In first timeout(WS0), do panic to save system context
        e.Support geting timeout and pretimeout from
          parameter and FDT at the driver init stage

    (4)Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
       and create a platform device with that information
       This platform device can be used by This Watchdog driver

This patchset has been tested with watchdog daemon
(ACPI/FDT, module/build-in) on the following platforms:
    (1)ARM Foundation v8 model
    (2)AMD Seattle B0

Fu Wei (6):
  Documentation: add sbsa-gwdt.txt documentation
  ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
  ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
  Watchdog: introdouce "pretimeout" into framework
  Watchdog: introdouce ARM SBSA watchdog driver
  ACPI: import watchdog info of GTDT into platform device

 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     |  36 ++
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |  11 +
 arch/arm64/boot/dts/arm/foundation-v8.dts          |  10 +
 arch/arm64/kernel/acpi.c                           | 136 +++++
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/sbsa_gwdt.c                       | 553 +++++++++++++++++++++
 drivers/watchdog/watchdog_core.c                   |  66 +++
 drivers/watchdog/watchdog_dev.c                    |  48 ++
 include/linux/watchdog.h                           |  19 +
 10 files changed, 890 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
 create mode 100644 drivers/watchdog/sbsa_gwdt.c

-- 
1.9.1
