Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43288 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdH3Ed6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 30 Aug 2017 00:33:58 -0400
Date: Tue, 29 Aug 2017 21:33:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Steven J. Hill" <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 6/8] watchdog: octeon-wdt: File cleaning.
Message-ID: <20170830043349.GB14791@roeck-us.net>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
 <1504021238-3184-7-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504021238-3184-7-git-send-email-steven.hill@cavium.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 29, 2017 at 10:40:36AM -0500, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
> * Update copyright and company name.
> * Remove unused headers.
> * Fix variable spelling and data type.
> * Use octal values for module parameters.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/octeon-wdt-main.c | 45 +++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
> index fbdd484..73b5102 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -1,7 +1,7 @@
>  /*
>   * Octeon Watchdog driver
>   *
> - * Copyright (C) 2007, 2008, 2009, 2010 Cavium Networks
> + * Copyright (C) 2007-2017 Cavium, Inc.
>   *
>   * Converted to use WATCHDOG_CORE by Aaro Koskinen <aaro.koskinen@iki.fi>.
>   *
> @@ -59,14 +59,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/watchdog.h>
>  #include <linux/cpumask.h>
> -#include <linux/bitops.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/string.h>
>  #include <linux/delay.h>
>  #include <linux/cpu.h>
> -#include <linux/smp.h>
> -#include <linux/fs.h>
>  #include <linux/irq.h>
>  
>  #include <asm/mipsregs.h>
> @@ -85,7 +80,7 @@ static unsigned int max_timeout_sec;
>  static unsigned int timeout_sec;
>  
>  /* Set to non-zero when userspace countdown mode active */
> -static int do_coundown;
> +static bool do_countdown;
>  static unsigned int countdown_reset;
>  static unsigned int per_cpu_countdown[NR_CPUS];
>  
> @@ -94,17 +89,22 @@ static cpumask_t irq_enabled_cpus;
>  #define WD_TIMO 60			/* Default heartbeat = 60 seconds */
>  
>  static int heartbeat = WD_TIMO;
> -module_param(heartbeat, int, S_IRUGO);
> +module_param(heartbeat, int, 0444);
>  MODULE_PARM_DESC(heartbeat,
>  	"Watchdog heartbeat in seconds. (0 < heartbeat, default="
>  				__MODULE_STRING(WD_TIMO) ")");
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> -module_param(nowayout, bool, S_IRUGO);
> +module_param(nowayout, bool, 0444);
>  MODULE_PARM_DESC(nowayout,
>  	"Watchdog cannot be stopped once started (default="
>  				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +static int disable;
> +module_param(disable, int, 0444);
> +MODULE_PARM_DESC(disable,
> +	"Disable the watchdog entirely (default=0)");
> +
>  static struct cvmx_boot_vector_element *octeon_wdt_bootvector;
>  
>  void octeon_wdt_nmi_stage2(void);
> @@ -140,7 +140,7 @@ static irqreturn_t octeon_wdt_poke_irq(int cpl, void *dev_id)
>  	unsigned int core = cvmx_get_core_num();
>  	int cpu = core2cpu(core);
>  
> -	if (do_coundown) {
> +	if (do_countdown) {
>  		if (per_cpu_countdown[cpu] > 0) {
>  			/* We're alive, poke the watchdog */
>  			cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
> @@ -324,11 +324,14 @@ static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
>  	int cpu;
>  	int coreid;
>  
> +	if (disable)
> +		return 0;
> +
>  	for_each_online_cpu(cpu) {
>  		coreid = cpu2core(cpu);
>  		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
>  		per_cpu_countdown[cpu] = countdown_reset;
> -		if ((countdown_reset || !do_coundown) &&
> +		if ((countdown_reset || !do_countdown) &&
>  		    !cpumask_test_cpu(cpu, &irq_enabled_cpus)) {
>  			/* We have to enable the irq */
>  			int irq = OCTEON_IRQ_WDOG0 + coreid;
> @@ -378,6 +381,9 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
>  
>  	octeon_wdt_calc_parameters(t);
>  
> +	if (disable)
> +		return 0;
> +
>  	for_each_online_cpu(cpu) {
>  		coreid = cpu2core(cpu);
>  		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
> @@ -394,13 +400,13 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
>  static int octeon_wdt_start(struct watchdog_device *wdog)
>  {
>  	octeon_wdt_ping(wdog);
> -	do_coundown = 1;
> +	do_countdown = 1;
>  	return 0;
>  }
>  
>  static int octeon_wdt_stop(struct watchdog_device *wdog)
>  {
> -	do_coundown = 0;
> +	do_countdown = 0;
>  	octeon_wdt_ping(wdog);
>  	return 0;
>  }
> @@ -473,6 +479,11 @@ static int __init octeon_wdt_init(void)
>  		return ret;
>  	}
>  
> +	if (disable) {
> +		pr_notice("disabled\n");
> +		return 0;
> +	}
> +
>  	cpumask_clear(&irq_enabled_cpus);
>  
>  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "watchdog/octeon:online",
> @@ -493,6 +504,10 @@ static int __init octeon_wdt_init(void)
>  static void __exit octeon_wdt_cleanup(void)
>  {
>  	watchdog_unregister_device(&octeon_wdt);
> +
> +	if (disable)
> +		return;
> +
>  	cpuhp_remove_state(octeon_wdt_online);
>  
>  	/*
> @@ -503,7 +518,7 @@ static void __exit octeon_wdt_cleanup(void)
>  }
>  
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Cavium Networks <support@caviumnetworks.com>");
> -MODULE_DESCRIPTION("Cavium Networks Octeon Watchdog driver.");
> +MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
> +MODULE_DESCRIPTION("Cavium Inc. OCTEON Watchdog driver.");
>  module_init(octeon_wdt_init);
>  module_exit(octeon_wdt_cleanup);
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
