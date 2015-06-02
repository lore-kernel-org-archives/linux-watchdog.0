Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35935 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbbFBEGD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Jun 2015 00:06:03 -0400
Received: by pdjm12 with SMTP id m12so40452703pdj.3
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Jun 2015 21:06:02 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v4 0/7] Watchdog: introduce ARM SBSA watchdog driver
Date: Tue,  2 Jun 2015 12:05:00 +0800
Message-Id: <1433217907-928-1-git-send-email-fu.wei@linaro.org>
In-Reply-To: <=fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:
    (1)Introduce Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
    for FDT info of SBSA Generic Watchdog, and give two examples of
    adding SBSA Generic Watchdog device node into the dts files:
    foundation-v8.dts and amd-seattle-soc.dtsi.

    (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
    Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
    and create a platform device with that information.
    This platform device can be used by This Watchdog driver.
    drivers/clocksource/arm_arch_timer.c is simplified by this GTDT support.

    (3)Introduce "pretimeout" into the watchdog framework, and update
    Documentation/watchdog/watchdog-kernel-api.txt to introduce:
        (1)the new elements in the watchdog_device and watchdog_ops struct;
        (2)the new API "watchdog_init_timeouts".

    (4)Introduce ARM SBSA watchdog driver:
        a.Use linux kernel watchdog framework;
        b.Work with FDT on ARM64;
        c.Use "pretimeout" in watchdog framework;
        d.In first timeout, do panic to save system context;
        e.Support getting timeout and pretimeout from parameter and FDT
          at the driver init stage.

This patchset has been tested with watchdog daemon
(ACPI/FDT, module/build-in) on the following platforms:
    (1)ARM Foundation v8 model

Changelog:
v4: Refactor GTDT support code: remove it from arch/arm64/kernel/acpi.c,
    put it into drivers/acpi/gtdt.c file.
    Integrate the GTDT code of drivers/clocksource/arm_arch_timer.c into
    drivers/acpi/gtdt.c.
    Improve pretimeout support, fix "pretimeout == 0" problem.
    Simplify sbsa_gwdt driver:
        (1)timeout/pretimeout limits setup;
        (2)keepalive function;
        (3)delete "clk == 0" check;
        (4)delete WS0 status bit check in interrupt routine;
        (5)sbsa_gwdt_set_wcv function.

v3: Delete "export arch_timer_get_rate" patch.
    Driver back to use arch_timer_get_cntfrq.
    Improve watchdog_init_timeouts function and update relevant documentation.
    Improve watchdog_timeout_invalid and watchdog_pretimeout_invalid.
    Improve foundation-v8.dts: delete the unnecessary tag of device node.
    Remove "ARM64 || COMPILE_TEST" from Kconfig.
    Add comments in arch/arm64/kernel/acpi.c
    Fix typoes and incorrect comments.

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

v1: The first version upstream patchset to linux mailing list.

Fu Wei (7):
  Documentation: add sbsa-gwdt.txt documentation
  ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
  ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
  Watchdog: introdouce "pretimeout" into framework
  Watchdog: introduce ARM SBSA watchdog driver
  ACPI: add GTDT table parse driver into ACPI driver
  clocksource: simplify ACPI code in arm_arch_timer.c

 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     |  36 ++
 Documentation/watchdog/watchdog-kernel-api.txt     |  47 ++-
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |  11 +
 arch/arm64/boot/dts/arm/foundation-v8.dts          |  10 +
 arch/arm64/kernel/time.c                           |   4 +-
 drivers/acpi/Kconfig                               |   9 +
 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/gtdt.c                                | 180 +++++++++
 drivers/clocksource/Kconfig                        |   1 +
 drivers/clocksource/arm_arch_timer.c               |  60 +--
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/sbsa_gwdt.c                       | 426 +++++++++++++++++++++
 drivers/watchdog/watchdog_core.c                   | 115 ++++--
 drivers/watchdog/watchdog_dev.c                    |  53 +++
 include/clocksource/arm_arch_timer.h               |   8 +
 include/linux/acpi.h                               |   5 +
 include/linux/clocksource.h                        |   4 +-
 include/linux/watchdog.h                           |  33 +-
 19 files changed, 927 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
 create mode 100644 drivers/acpi/gtdt.c
 create mode 100644 drivers/watchdog/sbsa_gwdt.c

-- 
1.8.3.1

