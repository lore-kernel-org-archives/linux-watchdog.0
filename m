Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45426 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933197AbcBCRUT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 12:20:19 -0500
From: fu.wei@linaro.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, wim@iguana.be,
	linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com,
	will.deacon@arm.com, Suravee.Suthikulpanit@amd.com
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, dyoung@redhat.com, panand@redhat.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, jcm@redhat.com, arnd@arndb.de,
	leo.duran@amd.com, sudeep.holla@arm.com, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v10 0/5] Watchdog: introduce ARM SBSA watchdog driver
Date: Thu,  4 Feb 2016 01:18:38 +0800
Message-Id: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:
    (1)Introduce Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
    for FDT info of SBSA Generic Watchdog, and give two examples of
    adding SBSA Generic Watchdog device node into the dts files:
    foundation-v8.dts and amd-seattle-soc.dtsi.

    (2)Introduce ARM SBSA watchdog driver:
        a.Use linux kernel watchdog framework;
        b.Work with FDT on ARM64;
        c.Support getting timeout from parameter and FDT at the driver
          init stage.
        d.Separate the driver to two parts:
          (1) single stage timeout driver(ignore WS0 interrupt)
          (2) register WS0 interrupt for the half timeout panic
        e.Timeout is from watchdog enabled to WS1 triggered.
          User can disable "half timeout panic" by kernel config or
          module parameter panic_enabled.

Changelog:
v10:Delete pretimeout support
    Separate the driver to two parts:
        (1) single stage timeout driver(ignore WS0 interrupt)
        (2) register WS0 interrupt for the half timeout panic
    timeout == (enable --> WS1)

v9: https://lkml.org/lkml/2015/11/9/57
    Rebase to latest kernel version(4.3).
    Update the Documentation of sbsa-gwdt device node info of FDT:
        (1) move some introduction to pretimeout patch
        (2) delete WS1 value from "interrupts" of binding documentation,
            since WS1 won't be handled by Linux.

v8: https://lkml.org/lkml/2015/10/27/466
    Rebase to latest kernel version(4.3-rc7).
    Separate the patches of GTDT support and arm_arch_timer. This
    clocksource relevant patch will upstreamed in a individual patchset.
    Update all the default timeout and pretimeout to 30s and 60s.
    Improve documentation and inline comments.
    Fix a bug in pretimeout support which makes timeout and pretimeout
    parameters initialization fail.

v7: https://lkml.org/lkml/2015/8/24/611
    Rebase to latest kernel version(4.2-rc7).
    Improve FDT support: geting resource by order, instead of name.
    According to the FDT support, Update the example dts file, gtdt.c
    and sbsa_gwdt.c.
    Pass the sparse test, and fix the warning.
    Fix the max_pretimeout and max_timeout value overflow bug.
    Delete the WCV output value.
    

v6: https://lkml.org/lkml/2015/6/23/359
    Improve the dtb example files: reduce the register frame size to 4K.
    Improve pretimeout support:
        (1) improve watchdog_init_timeouts function
	(2) rename watchdog_check_min_max_timeouts back to the original name
        (1) improve watchdog_timeout_invalid/watchdog_pretimeout_invalid
    Add the new features in the sbsa_gwdt driver:
	(1) In the second stage, user can feed the dog without cleaning WS0.
	(2) In the second stage, user can trigger WS1 by setting pretimeout = 0.
	(3) expand the max value of pretimeout, in case 10 second is not enough
	    for a kdump kernel reboot in panic.

v5: https://lkml.org/lkml/2015/6/10/357
    Improve pretimeout support:
        (1)fix typo in documentation and comments.
	(2)fix the timeout limits validation bug.
    Simplify sbsa_gwdt driver:
	(1)integrate all the registers access functions into caller.

v4: https://lkml.org/lkml/2015/6/2/4
    Refactor GTDT support code: remove it from arch/arm64/kernel/acpi.c,
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

v3: https://lkml.org/lkml/2015/5/25/111
    Delete "export arch_timer_get_rate" patch.
    Driver back to use arch_timer_get_cntfrq.
    Improve watchdog_init_timeouts function and update relevant documentation.
    Improve watchdog_timeout_invalid and watchdog_pretimeout_invalid.
    Improve foundation-v8.dts: delete the unnecessary tag of device node.
    Remove "ARM64 || COMPILE_TEST" from Kconfig.
    Add comments in arch/arm64/kernel/acpi.c
    Fix typoes and incorrect comments.

v2: https://lkml.org/lkml/2015/5/21/172
    Improve watchdog-kernel-api.txt documentation for pretimeout support.
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

v1: https://lkml.org/lkml/2015/5/15/279
    The first version upstream patchset to linux mailing list.

Fu Wei (5):
  Documentation: add sbsa-gwdt driver documentation
  ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
  ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
  Watchdog: introduce ARM SBSA watchdog driver
  Watchdog: ARM SBSA Generic Watchdog half timeout panic support

 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     |  35 ++
 Documentation/watchdog/watchdog-parameters.txt     |   6 +
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |   9 +
 arch/arm64/boot/dts/arm/foundation-v8.dts          |   8 +
 drivers/watchdog/Kconfig                           |  27 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/sbsa_gwdt.c                       | 366 +++++++++++++++++++++
 7 files changed, 452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
 create mode 100644 drivers/watchdog/sbsa_gwdt.c

-- 
2.5.0

