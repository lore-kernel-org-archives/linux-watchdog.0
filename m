Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbdDDUjJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 16:39:09 -0400
Subject: Re: [PATCH v23 00/11] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
        wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, Suravee.Suthikulpanit@amd.com,
        leo.duran@amd.com, wim@iguana.be, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, tn@semihalf.com,
        christoffer.dall@linaro.org, julien.grall@arm.com
References: <20170331175105.8370-1-fu.wei@linaro.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <58003cb9-e190-925d-f5af-947159cbd040@codeaurora.org>
Date: Tue, 4 Apr 2017 15:39:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/31/2017 12:50 PM, fu.wei@linaro.org wrote:
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer:
>         1. Introduce a MMIO CNTFRQ helper.
>         2. separate out device-tree code from arch_timer_detect_rate
>         3. remove arch_timer_detect_rate use arch_timer_*get_cntfrq directly
>         4. Refactor arch_timer_needs_probing, and move it into DT init call
>         5. Introduce some new structs and refactor the MMIO timer init code
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
> v23: https://lkml.org/lkml/2017/3/31/

v23:

Tested-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
