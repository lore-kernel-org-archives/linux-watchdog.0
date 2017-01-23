Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdAWSz1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 23 Jan 2017 13:55:27 -0500
Date: Mon, 23 Jan 2017 18:54:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
        harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org,
        graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
        wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, Suravee.Suthikulpanit@amd.com,
        leo.duran@amd.com, wim@iguana.be, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, tn@semihalf.com,
        christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v20 00/17] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Message-ID: <20170123185418.GA961@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Wed, Jan 18, 2017 at 09:25:24PM +0800, fu.wei@linaro.org wrote:
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

I've taken these few patches onto a preliminary/unstable branch [1].

I haven't had the time to take a look at the rest of the series yet. I
intend to go over that tomorrow, picking what I can, and leaving
feedback for anything that will need rework.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arch-timer/updates
