Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36707 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbcJER0Z (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Oct 2016 13:26:25 -0400
Received: by mail-oi0-f43.google.com with SMTP id m72so110539180oik.3
        for <linux-watchdog@vger.kernel.org>; Wed, 05 Oct 2016 10:26:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5efae47c-e9b8-a93a-a040-a38fc388390f@huawei.com>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org> <5efae47c-e9b8-a93a-a040-a38fc388390f@huawei.com>
From: Fu Wei <fu.wei@linaro.org>
Date: Thu, 6 Oct 2016 01:26:23 +0800
Message-ID: <CADyBb7t2a9Z04q0i7xm+VOJrs42tmc_M-3QA03F8L1sdPyYhEg@mail.gmail.com>
Subject: Re: [PATCH v14 0/9] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        G Gregory <graeme.gregory@linaro.org>,
        Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
        Wei Huang <wei@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Leo Duran <leo.duran@amd.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Julien Grall <julien.grall@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Xiongfeng Wang,

On 30 September 2016 at 08:40, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
> for sbsa watchdog part,  Tested-by:  wangxiongfeng2@huawei.com on D05 board.

Got it, thanks again for your help

>
> On 2016/9/29 2:17, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>         1. Move some enums and marcos to header file;
>>         2. Add a new enum for spi type;
>>         3. Improve printk relevant code.
>>
>>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>>     memory-mapped timer and SBSA Generic Watchdog timer.
>>     This driver can help to simplify all the relevant timer drivers,
>>     and separate all the ACPI GTDT knowledge from them.
>>
>>     (3)Simplify ACPI code for arm_arch_timer
>>
>>     (4)Add GTDT support for ARM memory-mapped timer, also refactor
>>     original memory-mapped timer dt support for reusing some common
>>     code.
>>
>> This patchset depends on the following patchset:
>> [UPDATE PATCH V11 1/8] ACPI: I/O Remapping Table (IORT) initial support
>> https://lkml.org/lkml/2016/9/12/949
>>
>> This patchset has been tested on the following platforms:
>>     (1)ARM Foundation v8 model
>>
>> Changelog:
>> v14: https://lkml.org/lkml/2016/9/28/
>>      Separate memory-mapped timer GTDT support into two patches
>>          1. Refactor the timer init code to prepare for GTDT
>>          2. Add GTDT support for memory-mapped timer
>>
>> v13: http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1231717.html
>>      Improve arm_arch_timer code for memory-mapped
>>      timer GTDT support, refactor original memory-mapped timer
>>      dt support for reusing some common code.
>>
>> v12: https://lkml.org/lkml/2016/9/13/250
>>      Rebase to latest Linux 4.8-rc6
>>      Delete the confusing "skipping" in the error message.
>>
>> V11: https://lkml.org/lkml/2016/9/6/354
>>      Rebase to latest Linux 4.8-rc5
>>      Delete typedef (suggested by checkpatch.pl)
>>
>> V10: https://lkml.org/lkml/2016/7/26/215
>>      Drop the "readq" patch.
>>      Rebase to latest Linux 4.7.
>>
>> V9: https://lkml.org/lkml/2016/7/25/345
>>     Improve pr_err message in acpi gtdt driver.
>>     Update Commit message for 7/9
>>     shorten the irq mapping function name
>>     Improve GTDT driver for memory-mapped timer
>>
>> v8: https://lkml.org/lkml/2016/7/19/660
>>     Improve "pr_fmt(fmt)" definition: add "ACPI" in front of "GTDT",
>>     and also improve printk message.
>>     Simplify is_timer_block and is_watchdog.
>>     Merge acpi_gtdt_desc_init and gtdt_arch_timer_init into acpi_gtdt_init();
>>     Delete __init in include/linux/acpi.h for GTDT API
>>     Make ARM64 select GTDT.
>>     Delete "#include <linux/module.h>" from acpi_gtdt.c
>>     Simplify GT block parse code.
>>
>> v7: https://lkml.org/lkml/2016/7/13/769
>>     Move the GTDT driver to drivers/acpi/arm64
>>     Add add the ARM64-specific ACPI Support maintainers in MAINTAINERS
>>     Merge 3 patches of GTDT parser driver.
>>     Fix the for_each_platform_timer bug.
>>
>> v6: https://lkml.org/lkml/2016/6/29/580
>>     split the GTDT driver to 4 parts: basic, arch_timer, memory-mapped timer,
>>     and SBSA Generic Watchdog timer
>>     Improve driver by suggestions and example code from Daniel Lezcano
>>
>> v5: https://lkml.org/lkml/2016/5/24/356
>>     Sorting out all patches, simplify the API of GTDT driver:
>>     GTDT driver just fills the data struct for arm_arch_timer driver.
>>
>> v4: https://lists.linaro.org/pipermail/linaro-acpi/2016-March/006667.html
>>     Delete the kvm relevant patches
>>     Separate two patches for sorting out the code for arm_arch_timer.
>>     Improve irq info export code to allow missing irq info in GTDT table.
>>
>> v3: https://lkml.org/lkml/2016/2/1/658
>>     Improve GTDT driver code:
>>       (1)improve pr_* by defining pr_fmt(fmt)
>>       (2)simplify gtdt_sbsa_gwdt_init
>>       (3)improve gtdt_arch_timer_data_init, if table is NULL, it will try
>>       to get GTDT table.
>>     Move enum ppi_nr to arm_arch_timer.h, and add enum spi_nr.
>>     Add arm_arch_timer get ppi from DT and GTDT support for kvm.
>>
>> v2: https://lkml.org/lkml/2015/12/2/10
>>     Rebase to latest kernel version(4.4-rc3).
>>     Fix the bug about the config problem,
>>     use CONFIG_ACPI_GTDT instead of CONFIG_ACPI in arm_arch_timer.c
>>
>> v1: The first upstreaming version: https://lkml.org/lkml/2015/10/28/553
>>
>> Fu Wei (9):
>>   clocksource/drivers/arm_arch_timer: Move enums and defines to header
>>     file
>>   clocksource/drivers/arm_arch_timer: Add a new enum for spi type
>>   clocksource/drivers/arm_arch_timer: Improve printk relevant code
>>   acpi/arm64: Add GTDT table parse driver
>>   clocksource/drivers/arm_arch_timer: Simplify ACPI support code.
>>   acpi/arm64: Add memory-mapped timer support in GTDT driver
>>   clocksource/drivers/arm_arch_timer: Refactor the timer init code to
>>     prepare for GTDT
>>   clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped
>>     timer
>>   acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver
>>
>>  arch/arm64/Kconfig                   |   1 +
>>  drivers/acpi/arm64/Kconfig           |   3 +
>>  drivers/acpi/arm64/Makefile          |   1 +
>>  drivers/acpi/arm64/gtdt.c            | 309 ++++++++++++++++++++++++++++++++
>>  drivers/clocksource/Kconfig          |   2 +-
>>  drivers/clocksource/arm_arch_timer.c | 331 +++++++++++++++++++++--------------
>>  drivers/watchdog/Kconfig             |   1 +
>>  include/clocksource/arm_arch_timer.h |  32 ++++
>>  include/linux/acpi.h                 |   7 +
>>  9 files changed, 558 insertions(+), 129 deletions(-)
>>  create mode 100644 drivers/acpi/arm64/gtdt.c
>>
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
