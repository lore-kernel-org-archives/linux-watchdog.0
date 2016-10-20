Return-path: <mark.rutland@arm.com>
Date: Thu, 20 Oct 2016 15:45:39 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
	sudeep.holla@arm.com, hanjun.guo@linaro.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
	catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org, tn@semihalf.com,
	christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v14 1/9] clocksource/drivers/arm_arch_timer: Move enums
 and defines to header file
Message-ID: <20161020144510.GJ10234@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-2-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475086637-1914-2-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

On Thu, Sep 29, 2016 at 02:17:09AM +0800, fu.wei@linaro.org wrote:
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index caedb74..6f06481 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -19,6 +19,9 @@

Please add:

#include <linux/bitops.h>

... immediately before the includes below; it's needed to ensure that
BIT() is defined in all cases. Previously we were relying on implicit
header includes, which is not good practice.

>  #include <linux/timecounter.h>
>  #include <linux/types.h>
>  
> +#define ARCH_CP15_TIMER			BIT(0)
> +#define ARCH_MEM_TIMER			BIT(1)

If we're going to expose these in a header, it would be better to rename
them to something that makes their usage/meaning clear. These should
probably be ARCH_TIMER_TYPE_{CP15,MEM}.

I guess this can wait for subsequent cleanup.

> +enum ppi_nr {
> +	PHYS_SECURE_PPI,
> +	PHYS_NONSECURE_PPI,
> +	VIRT_PPI,
> +	HYP_PPI,
> +	MAX_TIMER_PPI
> +};

Please rename this to arch_timer_ppi_nr (updating the single user in 
drivers/clocksource/arm_arch_timer.c). That'll avoid the potential for
name clashes in files this happens to get included in (potentially
transitively via other headers).

With those changes (regardless of the ARCH_TIMER_TYPE_* bits):

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> +
>  #define ARCH_TIMER_PHYS_ACCESS		0
>  #define ARCH_TIMER_VIRT_ACCESS		1
>  #define ARCH_TIMER_MEM_PHYS_ACCESS	2
> -- 
> 2.7.4
> 
