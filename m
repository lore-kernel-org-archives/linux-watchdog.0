Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:32937 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbbEUIdO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 04:33:14 -0400
Received: by pdbqa5 with SMTP id qa5so100533922pdb.0
        for <linux-watchdog@vger.kernel.org>; Thu, 21 May 2015 01:33:13 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v2 0/7] Watchdog: introduce ARM SBSA watchdog driver
Date: Thu, 21 May 2015 16:32:29 +0800
Message-Id: <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
In-Reply-To: <=fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:

    (1)Export "arch_timer_get_rate" in arm_arch_timer.c for the
    other drivers, like SBSA watchdog driver

    (2)Introduce Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
    for FDT info of SBSA Generic Watchdog, and give two examples of
    adding SBSA Generic Watchdog device node into the dts files:
    foundation-v8.dts and amd-seattle-soc.dtsi.

    (3)Introduce "pretimeout" into the watchdog framework, and update
    Documentation/watchdog/watchdog-kernel-api.txt to introduce:
        (1)the new elements in the watchdog_device and watchdog_ops struct;
        (2)the new API "watchdog_init_timeouts".

    (4)Introduce ARM SBSA watchdog driver:
        a.Use linux kernel watchdog framework;
        b.Work with FDT on ARM64;
        c.Use "pretimeout" in watchdog framework;
        d.In first timeout(WS0), do panic to save system context;
        e.Support geting timeout and pretimeout from parameter and FDT
          at the driver init stage.

    (5)Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
    and create a platform device with that information.
    This platform device can be used by This Watchdog driver.

This patchset has been tested with watchdog daemon
(ACPI/FDT, module/build-in) on the following platforms:
    (1)ARM Foundation v8 model
    (2)AMD Seattle B0

Changelog:
v2: Improve watchdog-kernel-api.txt documentation for pretimeout support.
    Export "arch_timer_get_rate" in arm_arch_timer.c.
    Add watchdog_init_timeouts API for pretimeout support in framework.
    Improve suspend and resume foundation in driver
    Improve timeout/pretimeout values init code in driver.
    Delete unnecessary items of the sbsa_gwdt struct and #define.
    Delete all unnecessary debug info in driver.
    Fix 64bit division bug.
    Use the arch_timer interface to get watchdog clock rate.
    Add MODULE_DEVICE_TABLE for platform device id.
    Fix typoes.

v1: The first version upstream patchset to linux mailing list

Fu Wei (7):
  clocksource: export "arch_timer_get_rate" for the other drivers
  Documentation: add sbsa-gwdt.txt documentation
  ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
  ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
  Watchdog: introduce "pretimeout" into framework
  Watchdog: introduce ARM SBSA watchdog driver
  ACPI: import watchdog info of GTDT into platform device

 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     |  36 ++
 Documentation/watchdog/watchdog-kernel-api.txt     |  62 ++-
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |  11 +
 arch/arm64/boot/dts/arm/foundation-v8.dts          |  10 +
 arch/arm64/kernel/acpi.c                           | 136 ++++++
 drivers/clocksource/arm_arch_timer.c               |   1 +
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/sbsa_gwdt.c                       | 476 +++++++++++++++++++++
 drivers/watchdog/watchdog_core.c                   | 103 +++--
 drivers/watchdog/watchdog_dev.c                    |  48 +++
 include/linux/watchdog.h                           |  30 +-
 12 files changed, 891 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
 create mode 100644 drivers/watchdog/sbsa_gwdt.c

-- 
1.9.1

