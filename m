Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbdDCJt2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Apr 2017 05:49:28 -0400
Date: Mon, 3 Apr 2017 10:49:45 +0100
From: Will Deacon <will.deacon@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
        harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org,
        graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
        wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
Message-ID: <20170403094944.GC5706@arm.com>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-10-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331175105.8370-10-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> On platforms booting with ACPI, architected memory-mapped timers'
> configuration data is provided by firmware through the ACPI GTDT
> static table.
> 
> The clocksource architected timer kernel driver requires a firmware
> interface to collect timer configuration and configure its driver.
> this infrastructure is present for device tree systems, but it is
> missing on systems booting with ACPI.
> 
> Implement the kernel infrastructure required to parse the static
> ACPI GTDT table so that the architected timer clocksource driver can
> make use of it on systems booting with ACPI, therefore enabling
> the corresponding timers configuration.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/arm64/gtdt.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h      |   1 +
>  2 files changed, 147 insertions(+)

We need Lorenzo's ack on this.

Will
