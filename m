Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39490 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964831AbbJ0QHN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Oct 2015 12:07:13 -0400
From: fu.wei@linaro.org
To: linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com,
	Suravee.Suthikulpanit@amd.com, robherring2@gmail.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v8 0/5] Watchdog: introduce ARM SBSA watchdog driver
Date: Wed, 28 Oct 2015 00:06:34 +0800
Message-Id: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:
    (1)Introduce Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
    for FDT info of SBSA Generic Watchdog, and give two examples of
    adding SBSA Generic Watchdog device node into the dts files:
    foundation-v8.dts and amd-seattle-soc.dtsi.

    (2)Introduce "pretimeout" into the watchdog framework, and update
    Documentation/watchdog/watchdog-kernel-api.txt to introduce:
        (1)the new elements in the watchdog_device and watchdog_ops struct;
        (2)the new API "watchdog_init_timeouts".

    (3)Introduce ARM SBSA watchdog driver:
        a.Use linux kernel watchdog framework;
        b.Work with FDT on ARM64;
        c.Use "pretimeout" in watchdog framework;
        d.Support getting timeout and pretimeout from parameter and FDT
          at the driver init stage.
        e.In the first timeout, do panic to save system context;
        f.In the second stage, user can still feed the dog without
          cleaning WS0. By this feature, we can avoid the panic infinite
          loops, while backing up a large system context in a server.
        g.In the second stage, can trigger WS1 by setting pretimeout = 0
          if necessary.

This patchset has been tested with watchdog daemon
(ACPI/FDT, module/build-in) on the following platforms:
    (1)ARM Foundation v8 model
    (2)AMD Seattle platform

This patchset has been tested with kdump successfully.

Changelog:
v8: Rebase to latest kernel version(4.3-rc7).
    Separate the patches of GTDT support and arm_arch_timer. This
    clocksource relevant patch will upstreamed in a individual patchset.
    Update all the default timeout and pretimeout to 30s and 60s.
    Improve documentation and inline comments.
    Fix a bug in pretimeout support which makes timeout and pretimeout
    parameters initialization fail.

v7: Rebase to latest kernel version(4.2-rc7).
    Improve FDT support: geting resource by order, instead of name.
    According to the FDT support, Update the example dts file, gtdt.c
    and sbsa_gwdt.c.
    Pass the sparse test, and fix the warning.
    Fix the max_pretimeout and max_timeout value overflow bug.
    Delete the WCV output value.
    

v6: Improve the dtb example files: reduce the register frame size to 4K.
    Improve pretimeout support:
        (1) improve watchdog_init_timeouts function
	(2) rename watchdog_check_min_max_timeouts back to the original name
        (1) improve watchdog_timeout_invalid/watchdog_pretimeout_invalid
    Add the new features in the sbsa_gwdt driver:
	(1) In the second stage, user can feed the dog without cleaning WS0.
	(2) In the second stage, user can trigger WS1 by setting pretimeout = 0.
	(3) expand the max value of pretimeout, in case 10 second is not enough
	    for a kdump kernel reboot in panic.

v5: Improve pretimeout support:
        (1)fix typo in documentation and comments.
	(2)fix the timeout limits validation bug.
    Simplify sbsa_gwdt driver:
	(1)integrate all the registers access functions into caller.

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
  Watchdog: enable ACPI GTDT support for ARM SBSA watchdog driver


Fu Wei (5):
  Documentation: add sbsa-gwdt driver documentation
  ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
  ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
  Watchdog: introdouce "pretimeout" into framework
  Watchdog: introduce ARM SBSA watchdog driver

 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     |  46 +++
 Documentation/watchdog/watchdog-kernel-api.txt     |  55 ++-
 Documentation/watchdog/watchdog-parameters.txt     |   6 +
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |   8 +
 arch/arm64/boot/dts/arm/foundation-v8.dts          |   7 +
 drivers/watchdog/Kconfig                           |  14 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/sbsa_gwdt.c                       | 459 +++++++++++++++++++++
 drivers/watchdog/watchdog_core.c                   | 127 ++++--
 drivers/watchdog/watchdog_dev.c                    |  53 +++
 include/linux/watchdog.h                           |  39 +-
 11 files changed, 773 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
 create mode 100644 drivers/watchdog/sbsa_gwdt.c

-- 
2.4.3

