Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbcKRTbj (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Nov 2016 14:31:39 -0500
Date: Fri, 18 Nov 2016 19:30:54 +0000
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
Subject: Re: [PATCH v16 06/15] clocksource/drivers/arm_arch_timer: separate
 out arch_timer_uses_ppi init code to prepare for GTDT.
Message-ID: <20161118193054.GK1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-7-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479304148-2965-7-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 16, 2016 at 09:48:59PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch refactor original arch_timer_uses_ppi init code:
> (1) Extract a subfunction: arch_timer_uses_ppi_init
> (2) Use the new subfunction in arch_timer_of_init and
> arch_timer_acpi_init

This isn't a strict refactoring, since this now assigns
ARCH_TIMER_PHYS_NONSECURE_PPI to arch_timer_uses_ppi, which we didn't do
previously.

As a general note, please write your commit messages as prose rather
than a list of bullet points. Please also explain the rationale for the
change, rather than enumerating the changes. Call out things which are
important and/or likely to surprise reviewers, for example:

* Can 32-bit ARM still use non-secure interrupts afer this change?

* Does the "arm,cpu-registers-not-fw-configured"  proeprty still work?

That will make it vastly easier to have this code reviewed, and it will
be far more helpful for anyone looking at this in future.

For example:

  arm_arch_timer: rework PPI determination

  Currently, the arch timer driver uses ARCH_TIMER_PHYS_SECURE_PPI to
  mean the driver will use the secure PPI *and* potentialy also use the
  non-secure PPI. This is somewhat confusing.

  For arm64, where it never makes sense to use the secure PPI, this
  means we must always request the useless secure PPI, adding to the
  confusion. For ACPI, where we may not even have a valid secure PPI
  number, this is additionally problematic. We need the driver to be
  able to use *only* the non-secure PPI.

  The logic to choose which PPI to use is intertwined with other logic
  in arch_timer_init(). This patch factors the PPI determination out
  into a new function, and then reworks it so that we can handle having
  only a non-secure PPI.

[...]

> +/*
> + * If HYP mode is available, we know that the physical timer
> + * has been configured to be accessible from PL1. Use it, so
> + * that a guest can use the virtual timer instead.
> + *
> + * If no interrupt provided for virtual timer, we'll have to
> + * stick to the physical timer. It'd better be accessible...
> + * On ARM64, we we only use ARCH_TIMER_PHYS_NONSECURE_PPI in Linux.

It would be better to say that for arm64 we never use the secure
interrupt.

> + *
> + * On ARMv8.1 with VH extensions, the kernel runs in HYP. VHE
> + * accesses to CNTP_*_EL1 registers are silently redirected to
> + * their CNTHP_*_EL2 counterparts, and use a different PPI
> + * number.
> + */
> +static int __init arch_timer_uses_ppi_init(void)

It would be better to call this something like arch_timer_select_ppi().
As it stands, the name is difficult to read.

> @@ -902,6 +904,10 @@ static int __init arch_timer_of_init(struct device_node *np)
>  	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
>  		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
>  
> +	ret = arch_timer_uses_ppi_init();
> +	if (ret)
> +		return ret;

This is clearly broken if you consider what the statement above is
doing.

Thanks,
Mark.
