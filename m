Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35754 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbdASJQn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 04:16:43 -0500
Received: by mail-pf0-f179.google.com with SMTP id f144so12140270pfa.2
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Jan 2017 01:16:43 -0800 (PST)
Subject: Re: [PATCH v20 16/17] clocksource/drivers/arm_arch_timer: Add GTDT
 support for memory-mapped timer
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-17-fu.wei@linaro.org>
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
Message-ID: <ed4efe25-1b40-66e2-ae3f-77a4e32715b6@linaro.org>
Date: Thu, 19 Jan 2017 17:16:33 +0800
MIME-Version: 1.0
In-Reply-To: <20170118132541.8989-17-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2017/1/18 21:25, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> The patch add memory-mapped timer register support by using the
> information provided by the new GTDT driver of ACPI.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 79dc004..7ca2da7 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1077,10 +1077,36 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>  		       arch_timer_mem_of_init);
>
>  #ifdef CONFIG_ACPI_GTDT
> -/* Initialize per-processor generic timer */
> +static int __init arch_timer_mem_acpi_init(int platform_timer_count)
> +{
> +	struct arch_timer_mem *timer_mem;
> +	int timer_count, i, ret;
> +

if (!platform_timer_count)
	return 0;

Did I miss something?

Thanks
Hanjun

> +	timer_mem = kcalloc(platform_timer_count, sizeof(*timer_mem),
> +			    GFP_KERNEL);
> +	if (!timer_mem)
> +		return -ENOMEM;
> +
> +	ret = acpi_arch_timer_mem_init(timer_mem, &timer_count);
> +	if (ret || !timer_count)
> +		goto error;
> +
> +	for (i = 0; i < timer_count; i++) {
> +		ret = arch_timer_mem_init(timer_mem);
> +		if (!ret)
> +			break;
> +		timer_mem++;
> +	}
> +
> +error:
> +	kfree(timer_mem);
> +	return ret;
> +}
> +
> +/* Initialize per-processor generic timer and memory-mapped timer(if present) */
>  static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>  {
> -	int ret;
> +	int ret, platform_timer_count;
>
>  	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
>  		pr_warn("already initialized, skipping\n");
> @@ -1089,7 +1115,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>
>  	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
>
> -	ret = acpi_gtdt_init(table, NULL);
> +	ret = acpi_gtdt_init(table, &platform_timer_count);
>  	if (ret) {
>  		pr_err("Failed to init GTDT table.\n");
>  		return ret;
> @@ -1122,6 +1148,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>  	if (ret)
>  		return ret;
>
> +	if (arch_timer_mem_acpi_init(platform_timer_count))
> +		pr_err("Failed to initialize memory-mapped timer.\n");
> +
>  	return arch_timer_common_init();
>  }
>  CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
>
