Return-path: <tn@semihalf.com>
Subject: Re: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: fu.wei@linaro.org, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
 tglx@linutronix.de, marc.zyngier@arm.com, sudeep.holla@arm.com,
 linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
 timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org,
 jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be,
 catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com,
 leo.duran@amd.com, linux@roeck-us.net, linux-watchdog@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
Date: Thu, 11 Aug 2016 11:37:41 +0200
MIME-Version: 1.0
In-Reply-To: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Fu,

Do you mind if I send IORT series where new drivers/acpi/arm64 directory 
would be introduced in first place ? This means your GTDT set would 
depend on IORT.

Thanks,
Tomasz

On 26.07.2016 14:19, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer:
>         1. Move some enums and marcos to header file;
>         2. Add a new enum for spi type;
>         3. Improve printk relevant code.
>
>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>     memory-mapped timer and SBSA Generic Watchdog timer.
>     This driver can help to simplify all the relevant timer drivers,
>     and separate all the ACPI GTDT knowledge from them.
>
>     (3)Simplify ACPI code for arm_arch_timer
>
>     (4)Add GTDT support for ARM memory-mapped timer
>
> This patchset has been tested on the following platforms:
>     (1)ARM Foundation v8 model
>
> Changelog:
> V10: https://lkml.org/lkml/2016/7/26/
>      Drop the "readq" patch.
>      Rebase to latest Linux 4.7.
>
> V9: https://lkml.org/lkml/2016/7/25/345
>     Improve pr_err message in acpi gtdt driver.
>     Update Commit message for 7/9
>     shorten the irq mapping function name
>     Improve GTDT driver for memory-mapped timer
>
> v8: https://lkml.org/lkml/2016/7/19/660
>     Improve "pr_fmt(fmt)" definition: add "ACPI" in front of "GTDT",
>     and also improve printk message.
>     Simplify is_timer_block and is_watchdog.
>     Merge acpi_gtdt_desc_init and gtdt_arch_timer_init into acpi_gtdt_init();
>     Delete __init in include/linux/acpi.h for GTDT API
>     Make ARM64 select GTDT.
>     Delete "#include <linux/module.h>" from acpi_gtdt.c
>     Simplify GT block parse code.
>
> v7: https://lkml.org/lkml/2016/7/13/769
>     Move the GTDT driver to drivers/acpi/arm64
>     Add add the ARM64-specific ACPI Support maintainers in MAINTAINERS
>     Merge 3 patches of GTDT parser driver.
>     Fix the for_each_platform_timer bug.
>
> v6: https://lkml.org/lkml/2016/6/29/580
>     split the GTDT driver to 4 parts: basic, arch_timer, memory-mapped timer,
>     and SBSA Generic Watchdog timer
>     Improve driver by suggestions and example code from Daniel Lezcano
>
> v5: https://lkml.org/lkml/2016/5/24/356
>     Sorting out all patches, simplify the API of GTDT driver:
>     GTDT driver just fills the data struct for arm_arch_timer driver.
>
> v4: https://lists.linaro.org/pipermail/linaro-acpi/2016-March/006667.html
>     Delete the kvm relevant patches
>     Separate two patches for sorting out the code for arm_arch_timer.
>     Improve irq info export code to allow missing irq info in GTDT table.
>
> v3: https://lkml.org/lkml/2016/2/1/658
>     Improve GTDT driver code:
>       (1)improve pr_* by defining pr_fmt(fmt)
>       (2)simplify gtdt_sbsa_gwdt_init
>       (3)improve gtdt_arch_timer_data_init, if table is NULL, it will try
>       to get GTDT table.
>     Move enum ppi_nr to arm_arch_timer.h, and add enum spi_nr.
>     Add arm_arch_timer get ppi from DT and GTDT support for kvm.
>
> v2: https://lkml.org/lkml/2015/12/2/10
>     Rebase to latest kernel version(4.4-rc3).
>     Fix the bug about the config problem,
>     use CONFIG_ACPI_GTDT instead of CONFIG_ACPI in arm_arch_timer.c
>
> v1: The first upstreaming version: https://lkml.org/lkml/2015/10/28/553
>
> Fu Wei (8):
>   clocksource/drivers/arm_arch_timer: Move enums and defines to header
>     file
>   clocksource/drivers/arm_arch_timer: Add a new enum for spi type
>   clocksource/drivers/arm_arch_timer: Improve printk relevant code
>   acpi/arm64: Add GTDT table parse driver
>   clocksource/drivers/arm_arch_timer: Simplify ACPI support code.
>   acpi/arm64: Add memory-mapped timer support in GTDT driver
>   clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped
>     timer
>   acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver
>
>  arch/arm64/Kconfig                   |   1 +
>  drivers/acpi/Kconfig                 |   5 +
>  drivers/acpi/Makefile                |   1 +
>  drivers/acpi/arm64/Kconfig           |   5 +
>  drivers/acpi/arm64/Makefile          |   1 +
>  drivers/acpi/arm64/acpi_gtdt.c       | 309 +++++++++++++++++++++++++++++++++++
>  drivers/clocksource/Kconfig          |   2 +-
>  drivers/clocksource/arm_arch_timer.c | 225 +++++++++++++++++--------
>  drivers/watchdog/Kconfig             |   1 +
>  include/clocksource/arm_arch_timer.h |  32 ++++
>  include/linux/acpi.h                 |   7 +
>  11 files changed, 518 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/acpi/arm64/Kconfig
>  create mode 100644 drivers/acpi/arm64/Makefile
>  create mode 100644 drivers/acpi/arm64/acpi_gtdt.c
>
