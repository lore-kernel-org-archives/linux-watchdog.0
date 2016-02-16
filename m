Return-path: <fu.wei@linaro.org>
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
        graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org,
        jcm@redhat.com, arnd@arndb.de, leo.duran@amd.com, sudeep.holla@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v13 0/4] Watchdog: introduce ARM SBSA watchdog driver
Date: Wed, 17 Feb 2016 01:08:46 +0800
Message-Id: <1455642530-19103-1-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

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
        d.The driver works in two modes:
          (1) single stage timeout (ignore WS0 interrupt)
          (2) two stages timeout (register WS0 interrupt, do panic in routine)
        e.User can config working mode by module parameter "action".

This patchset has been tested with watchdog daemon
(ACPI/FDT, module/build-in) on the following platforms:
    (1)ARM Foundation v8 model
    (2)AMD Seattle platform

This patchset has been tested with kdump successfully.

Changelog:
v13:Fix a dev_warn message typo"signle"-->"single"
    Add MODULE_ALIAS
    Add more *ed-by in commit message.

v12:https://lkml.org/lkml/2016/2/16/154
    Fix a dev_warn message typo"fall"--"falling"
    Remove unnecessary "status" in dts
    Add more *ed-by in commit message.

v11:https://lkml.org/lkml/2016/2/9/577
    Merge patch 4 and 5.
    Improve some comments.
    The driver works in two modes, it's configured by "action"(instead of
    panic_enabled).
    Improve the initialization of the timeout limits.
    Feeding dog by writing "0" to WRR.

v10:https://lkml.org/lkml/2016/2/3/817
    Delete pretimeout support.
    Separate the driver to two parts:
        (1) single stage timeout driver(ignore WS0 interrupt);
        (2) register WS0 interrupt for the half timeout panic.
    timeout == (enable --> WS1).

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

Fu Wei (4):
  Documentation: add sbsa-gwdt driver documentation
  ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
  ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
  Watchdog: introduce ARM SBSA watchdog driver

 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     |  31 ++
 Documentation/watchdog/watchdog-parameters.txt     |   7 +
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |   8 +
 arch/arm64/boot/dts/arm/foundation-v8.dts          |   7 +
 drivers/watchdog/Kconfig                           |  20 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/sbsa_gwdt.c                       | 404 +++++++++++++++++++++
 7 files changed, 478 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
 create mode 100644 drivers/watchdog/sbsa_gwdt.c

-- 
2.5.0
