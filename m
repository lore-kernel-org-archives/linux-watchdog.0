Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32976 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbdASJ3M (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 04:29:12 -0500
Received: by mail-pf0-f179.google.com with SMTP id y143so12263933pfb.0
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Jan 2017 01:29:11 -0800 (PST)
Subject: Re: [PATCH v20 00/17] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
References: <20170118132541.8989-1-fu.wei@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <bddc52ed-d1c9-c3c9-cb79-2c15d97450cc@linaro.org>
Date: Thu, 19 Jan 2017 17:20:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fuwei,

On 2017/1/18 21:25, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer:
>         1. Clean up printk() usage
>         2. Rename the type macros
>         3. Rename the PPI enum & enum values
>         4. Move the type macro and PPI enum into the header file
>         5. Add new enum for SPIs
>         6. Rework PPI determination;
>         7. Rework counter frequency detection;
>         8. Refactor arch_timer_needs_probing, move it into DT init call
>         9. Introduce some new structs and refactor the MMIO timer init code
>         for reusing some common code.
>
>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>     memory-mapped timer and SBSA Generic Watchdog timer.
>     This driver can help to simplify all the relevant timer drivers,
>     and separate all the ACPI GTDT knowledge from them.
>
>     (3)Simplify ACPI code for arm_arch_timer
>
>     (4)Add GTDT support for ARM memory-mapped timer.
>
> This patchset has been tested on the following platforms with ACPI enabled:
>     (1)ARM Foundation v8 model
>
> Changelog:
> v20: https://lkml.org/lkml/2017/1/18/
>      Reorder the first 4 patches and split the 4th patches.
>      Leave CNTHCTL_* as they originally were.
>      Fix the bug in arch_timer_select_ppi.
>      Split "Rework counter frequency detection" patch.
>      Rework the arch_timer_detect_rate function.
>      Improve the commit message of "Refactor MMIO timer probing".
>      Rebase to 4.10.0-rc4

Other than some minor comments I raised, the patch set
looks fine to me, and I tested this patch set on D03,
the percpu arch timer works fine as before.

With the comments fixed,
Reviewed-by: Hanjun Guo <hanjun.gu@linaro.org>
Tested-by: Hanjun Guo <hanjun.gu@linaro.org>

Thanks
Hanjun
