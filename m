Return-path: <mark.rutland@arm.com>
Date: Thu, 20 Oct 2016 16:32:45 +0100
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
Subject: Re: [PATCH v14 3/9] clocksource/drivers/arm_arch_timer: Improve
 printk relevant code
Message-ID: <20161020153244.GB27598@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-4-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475086637-1914-4-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Sep 29, 2016 at 02:17:11AM +0800, fu.wei@linaro.org wrote:
>  static void arch_timer_banner(unsigned type)
>  {
> -	pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
> -		     type & ARCH_CP15_TIMER ? "cp15" : "",
> -		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
> -		     type & ARCH_MEM_TIMER ? "mmio" : "",
> -		     (unsigned long)arch_timer_rate / 1000000,
> -		     (unsigned long)(arch_timer_rate / 10000) % 100,
> -		     type & ARCH_CP15_TIMER ?
> -		     (arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
> -			"",
> -		     type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
> -		     type & ARCH_MEM_TIMER ?
> -			arch_timer_mem_use_virtual ? "virt" : "phys" :
> -			"");
> +	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
> +		type & ARCH_CP15_TIMER ? "cp15" : "",
> +		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
> +		type & ARCH_MEM_TIMER ? "mmio" : "",
> +		(unsigned long)arch_timer_rate / 1000000,
> +		(unsigned long)(arch_timer_rate / 10000) % 100,
> +		type & ARCH_CP15_TIMER ?
> +		(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
> +		"",
Please restore the additional indent on this line...

> +		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
> +		type & ARCH_MEM_TIMER ?
> +		arch_timer_mem_use_virtual ? "virt" : "phys" :
> +		"");

... and these two.

No matter what checkpatch says, I prefer the code that way so as to keep
the ternary clear.

[...]

> @@ -768,7 +769,7 @@ static int __init arch_timer_init(void)
>  		return ret;
>  
>  	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
> -	
> +

Please mention the whitespace fixup in the commit message. It's
surprising otherwise.

With all that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
