Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbcKRUNf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Nov 2016 15:13:35 -0500
Date: Fri, 18 Nov 2016 20:12:50 +0000
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
Subject: Re: [PATCH v16 11/15] acpi/arm64: Add GTDT table parse driver
Message-ID: <20161118201250.GO1197@leverpostej>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-12-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479304148-2965-12-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 16, 2016 at 09:49:04PM +0800, fu.wei@linaro.org wrote:

> +#define for_each_platform_timer(_g) for (; _g; _g = next_platform_timer(_g))

This doesn't fit the usual for_each_* pattern, since _g has to be
manually initialised first. Either come up with a way of maknig this fit
the usual pattern, or get rid of this, and use:

	t = however_you_get_the_first_timer();

	if (!t)
		bailt_out_somehow();
	
	do { 
		...
	} while (t = next_platform_timer(t));

> +/*
> + * Release the memory we have allocated in acpi_gtdt_init.
> + * This should be called, when the driver who called "acpi_gtdt_init" previously
> + * doesn't need the GTDT info anymore.
> + */
> +void __init acpi_gtdt_release(void)
> +{
> +	kfree(timer_block);
> +	kfree(watchdog);
> +	timer_block = NULL;
> +	watchdog = NULL;
> +}

Why is this not simply in the error path of acpi_gtdt_init()?

> +
> +/*
> + * Get some basic info from GTDT table, and init the global variables above
> + * for all timers initialization of Generic Timer.
> + * This function does some validation on GTDT table.
> + */
> +int __init acpi_gtdt_init(struct acpi_table_header *table)
> +{

> +	timer_block = kcalloc(timer_count,
> +			      sizeof(struct acpi_gtdt_timer_block *),
> +			      GFP_KERNEL);
> +	if (!timer_block)
> +		return -ENOMEM;
> +
> +	watchdog = kcalloc(timer_count, sizeof(struct acpi_gtdt_watchdog *),
> +			   GFP_KERNEL);
> +	if (!watchdog) {
> +		kfree(timer_block);
> +		timer_block = NULL;
> +		return -ENOMEM;
> +	}

Please have a common error path below, and branch to that when you need
to free these.

> +error:
> +	acpi_gtdt_release();
> +	return -EINVAL;
> +}

[...]

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 61a3d90..a1611d1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -577,6 +577,13 @@ enum acpi_reconfig_event  {
>  int acpi_reconfig_notifier_register(struct notifier_block *nb);
>  int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
>  
> +#ifdef CONFIG_ACPI_GTDT
> +int acpi_gtdt_init(struct acpi_table_header *table);
> +int acpi_gtdt_map_ppi(int type);
> +bool acpi_gtdt_c3stop(int type);
> +void acpi_gtdt_release(void);

Why do these need to be here?

What possible value is ther in exporting acpi_gtdt_release() !?

Thanks,
Mark.
