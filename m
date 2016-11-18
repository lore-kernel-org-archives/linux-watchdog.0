Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752018AbcKRUUp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Nov 2016 15:20:45 -0500
Date: Fri, 18 Nov 2016 20:20:00 +0000
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
Subject: Re: [PATCH v16 14/15] clocksource/drivers/arm_arch_timer: Add GTDT
 support for memory-mapped timer
Message-ID: <20161118202000.GP1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-15-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479304148-2965-15-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 16, 2016 at 09:49:07PM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch add memory-mapped timer register support by using the
> information provided by the new GTDT driver of ACPI.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index c494ca8..0aad60a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1067,7 +1067,28 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>  		       arch_timer_mem_of_init);
>  
>  #ifdef CONFIG_ACPI_GTDT
> -/* Initialize per-processor generic timer */
> +static int __init arch_timer_mem_acpi_init(void)
> +{
> +	struct arch_timer_mem *timer_mem;
> +	int ret = 0;
> +	int i = 0;
> +
> +	timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);

Why do you need it zeroed? You don't clear it between iterations, so
either you don't need this, or you have a bug in the loop.

> +	if (!timer_mem)
> +		return -ENOMEM;
> +
> +	while (!gtdt_arch_timer_mem_init(timer_mem, i)) {

Huh?

Why doesn't GTDT expose a function to fill in the entire arch_timer_mem
in one go?

There shouldn't be multiple instances, as far as I am aware. Am I
mistaken?

> +		ret = arch_timer_mem_init(timer_mem);
> +		if (ret)
> +			break;
> +		i++;
> +	}
> +
> +	kfree(timer_mem);
> +	return ret;
> +}


Regardless, arch_timer_mem is small enough that you don't need dynamic
allocaiton. Just put it on the stack, e.g.

static int __init arch_timer_mem_acpi_init(void)
{
	int i = 0;
	struct arch_timer_mem timer_mem;

	while (!gtdt_arch_timer_mem_init(timer_mem, i)) {
		int ret = arch_timer_mem_init();
		if (ret)
			return ret;
		i++
	}

	return 0;
}

Thanks,
Mark.
