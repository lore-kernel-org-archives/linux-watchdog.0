Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbdARN0L (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Jan 2017 08:26:11 -0500
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v20 00/17] acpi, clocksource: add GTDT driver and GTDT support in arm_arch_timer
Date: Wed, 18 Jan 2017 21:25:24 +0800
Message-Id: <20170118132541.8989-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:
    (1)Preparation for adding GTDT support in arm_arch_timer:
        1. Clean up printk() usage
        2. Rename the type macros
        3. Rename the PPI enum & enum values
        4. Move the type macro and PPI enum into the header file
        5. Add new enum for SPIs
        6. Rework PPI determination;
        7. Rework counter frequency detection;
        8. Refactor arch_timer_needs_probing, move it into DT init call
        9. Introduce some new structs and refactor the MMIO timer init code
        for reusing some common code.

    (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
    Parse all kinds of timer in GTDT table of ACPI:arch timer,
    memory-mapped timer and SBSA Generic Watchdog timer.
    This driver can help to simplify all the relevant timer drivers,
    and separate all the ACPI GTDT knowledge from them.

    (3)Simplify ACPI code for arm_arch_timer

    (4)Add GTDT support for ARM memory-mapped timer.

This patchset has been tested on the following platforms with ACPI enabled:
    (1)ARM Foundation v8 model

Changelog:
v20: https://lkml.org/lkml/2017/1/18/
     Reorder the first 4 patches and split the 4th patches.
     Leave CNTHCTL_* as they originally were.
     Fix the bug in arch_timer_select_ppi.
     Split "Rework counter frequency detection" patch.
     Rework the arch_timer_detect_rate function.
     Improve the commit message of "Refactor MMIO timer probing".
     Rebase to 4.10.0-rc4

v19: https://lkml.org/lkml/2016/12/21/25
     Fix a '\n' missing in a error message in arch_timer_mem_init.
     Add "request_mem_region" for ioremapping cntbase, according to
     f947ee1 clocksource/drivers/arm_arch_timer: Map frame with of_io_request_and_map()
     Rebase to 4.9.0-gfb779ff

v18: https://lkml.org/lkml/2016/12/8/446
     Fix 8/15 patch problem of "int ret;" in arch_timer_acpi_init.
     Rebase to 4.9.0-rc8-g9269898

v17: https://lkml.org/lkml/2016/11/25/140
     Take out some cleanups from 4/15.
     Merge 5/15 and 6/15, improve PPI determination code,
     improve commit message.
     Rework counter frequency detection.
     Move arch_timer_needs_of_probing into DT init call.
     Move Platform Timer scan loop back to timer init call to avoid allocating
     and free memory.
     Improve all the exported functions' comment.

v16: https://lkml.org/lkml/2016/11/16/268
     Fix patchset problem about static enum ppi_nr of 01/13 in v15.
     Refactor arch_timer_detect_rate.
     Refactor arch_timer_needs_probing.

v15: https://lkml.org/lkml/2016/11/15/366
     Re-order patches
     Add arm_arch_timer refactoring patches to prepare for GTDT:
         1. rename some  enums and defines, and some cleanups
         2. separate out arch_timer_uses_ppi init code and fix a potential bug
         3. Improve some new structs, refactor the timer init code.
     Since the some structs have been changed, GTDT parser for memory-mapped
     timer and SBSA Generic Watchdog timer have been update.

v14: https://lkml.org/lkml/2016/9/28/573
     Separate memory-mapped timer GTDT support into two patches
         1. Refactor the timer init code to prepare for GTDT
         2. Add GTDT support for memory-mapped timer

v13: http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1231717.html
     Improve arm_arch_timer code for memory-mapped
     timer GTDT support, refactor original memory-mapped timer
     dt support for reusing some common code.

v12: https://lkml.org/lkml/2016/9/13/250
     Rebase to latest Linux 4.8-rc6
     Delete the confusing "skipping" in the error message.

V11: https://lkml.org/lkml/2016/9/6/354
     Rebase to latest Linux 4.8-rc5
     Delete typedef (suggested by checkpatch.pl)

V10: https://lkml.org/lkml/2016/7/26/215
     Drop the "readq" patch.
     Rebase to latest Linux 4.7.

V9: https://lkml.org/lkml/2016/7/25/345
    Improve pr_err message in acpi gtdt driver.
    Update Commit message for 7/9
    shorten the irq mapping function name
    Improve GTDT driver for memory-mapped timer

v8: https://lkml.org/lkml/2016/7/19/660
    Improve "pr_fmt(fmt)" definition: add "ACPI" in front of "GTDT",
    and also improve printk message.
    Simplify is_timer_block and is_watchdog.
    Merge acpi_gtdt_desc_init and gtdt_arch_timer_init into acpi_gtdt_init();
    Delete __init in include/linux/acpi.h for GTDT API
    Make ARM64 select GTDT.
    Delete "#include <linux/module.h>" from acpi_gtdt.c
    Simplify GT block parse code.

v7: https://lkml.org/lkml/2016/7/13/769
    Move the GTDT driver to drivers/acpi/arm64
    Add add the ARM64-specific ACPI Support maintainers in MAINTAINERS
    Merge 3 patches of GTDT parser driver.
    Fix the for_each_platform_timer bug.

v6: https://lkml.org/lkml/2016/6/29/580
    split the GTDT driver to 4 parts: basic, arch_timer, memory-mapped timer,
    and SBSA Generic Watchdog timer
    Improve driver by suggestions and example code from Daniel Lezcano

v5: https://lkml.org/lkml/2016/5/24/356
    Sorting out all patches, simplify the API of GTDT driver:
    GTDT driver just fills the data struct for arm_arch_timer driver.

v4: https://lists.linaro.org/pipermail/linaro-acpi/2016-March/006667.html
    Delete the kvm relevant patches
    Separate two patches for sorting out the code for arm_arch_timer.
    Improve irq info export code to allow missing irq info in GTDT table.

v3: https://lkml.org/lkml/2016/2/1/658
    Improve GTDT driver code:
      (1)improve pr_* by defining pr_fmt(fmt)
      (2)simplify gtdt_sbsa_gwdt_init
      (3)improve gtdt_arch_timer_data_init, if table is NULL, it will try
      to get GTDT table.
    Move enum ppi_nr to arm_arch_timer.h, and add enum spi_nr.
    Add arm_arch_timer get ppi from DT and GTDT support for kvm.

v2: https://lkml.org/lkml/2015/12/2/10
    Rebase to latest kernel version(4.4-rc3).
    Fix the bug about the config problem,
    use CONFIG_ACPI_GTDT instead of CONFIG_ACPI in arm_arch_timer.c

v1: The first upstreaming version: https://lkml.org/lkml/2015/10/28/553

Fu Wei (17):
  clocksource/drivers/arm_arch_timer: Improve printk relevant code
  clocksource/drivers/arm_arch_timer: Rename the timer type macros.
  clocksource/drivers/arm_arch_timer: Rename the PPI enum and its
    values.
  clocksource/drivers/arm_arch_timer: Move enums and defines to header
    file.
  clocksource/drivers/arm_arch_timer: Add a new enum for spi type
  clocksource/drivers/arm_arch_timer: rework PPI determination
  clocksource/drivers/arm_arch_timer: Separate out device-tree code from
    arch_timer_detect_rate
  clocksource/drivers/arm_arch_timer: Rework counter frequency
    detection.
  clocksource/drivers/arm_arch_timer: Refactor arch_timer_needs_probing
  clocksource/drivers/arm_arch_timer: Move arch_timer_needs_of_probing
    into DT init call
  clocksource/drivers/arm_arch_timer: Introduce some new structs to
    prepare for GTDT
  clocksource/drivers/arm_arch_timer: Refactor MMIO timer probing.
  acpi/arm64: Add GTDT table parse driver
  clocksource/drivers/arm_arch_timer: Simplify ACPI support code.
  acpi/arm64: Add memory-mapped timer support in GTDT driver
  clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped
    timer
  acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver

 arch/arm64/Kconfig                   |   1 +
 drivers/acpi/arm64/Kconfig           |   3 +
 drivers/acpi/arm64/Makefile          |   1 +
 drivers/acpi/arm64/gtdt.c            | 374 ++++++++++++++++++++++++++
 drivers/clocksource/arm_arch_timer.c | 497 +++++++++++++++++++++--------------
 drivers/watchdog/Kconfig             |   1 +
 include/clocksource/arm_arch_timer.h |  35 +++
 include/linux/acpi.h                 |   7 +
 8 files changed, 717 insertions(+), 202 deletions(-)
 create mode 100644 drivers/acpi/arm64/gtdt.c

-- 
2.9.3

