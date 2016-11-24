Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Nov 2016 08:10:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linuxtronix.de,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [11/20] watchdog/octeon: Convert to hotplug state machine
Message-ID: <20161124161054.GA20217@roeck-us.net>
References: <20161117183541.8588-12-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161117183541.8588-12-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Nov 17, 2016 at 07:35:32PM +0100, Sebastian Andrzej Siewior wrote:
> Install the callbacks via the state machine and let the core invoke
> the callbacks on the already online CPUs.
> 
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I don't really feel comfortable signing this off without Tested-by:.

Can someone please confirm that this is working as intended ?

Thanks,
Guenter

> ---
>  drivers/watchdog/octeon-wdt-main.c | 62 +++++++++-----------------------------
>  1 file changed, 15 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
> index b55981f88a08..529182d7d8a7 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -374,7 +374,7 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
>  	octeon_wdt_write_string("*** Chip soft reset soon ***\r\n");
>  }
>  
> -static void octeon_wdt_disable_interrupt(int cpu)
> +static int octeon_wdt_cpu_pre_down(unsigned int cpu)
>  {
>  	unsigned int core;
>  	unsigned int irq;
> @@ -392,9 +392,10 @@ static void octeon_wdt_disable_interrupt(int cpu)
>  	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
>  
>  	free_irq(irq, octeon_wdt_poke_irq);
> +	return 0;
>  }
>  
> -static void octeon_wdt_setup_interrupt(int cpu)
> +static int octeon_wdt_cpu_online(unsigned int cpu)
>  {
>  	unsigned int core;
>  	unsigned int irq;
> @@ -424,25 +425,8 @@ static void octeon_wdt_setup_interrupt(int cpu)
>  	ciu_wdog.s.len = timeout_cnt;
>  	ciu_wdog.s.mode = 3;	/* 3 = Interrupt + NMI + Soft-Reset */
>  	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
> -}
>  
> -static int octeon_wdt_cpu_callback(struct notifier_block *nfb,
> -					   unsigned long action, void *hcpu)
> -{
> -	unsigned int cpu = (unsigned long)hcpu;
> -
> -	switch (action & ~CPU_TASKS_FROZEN) {
> -	case CPU_DOWN_PREPARE:
> -		octeon_wdt_disable_interrupt(cpu);
> -		break;
> -	case CPU_ONLINE:
> -	case CPU_DOWN_FAILED:
> -		octeon_wdt_setup_interrupt(cpu);
> -		break;
> -	default:
> -		break;
> -	}
> -	return NOTIFY_OK;
> +	return 0;
>  }
>  
>  static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
> @@ -531,10 +515,6 @@ static int octeon_wdt_stop(struct watchdog_device *wdog)
>  	return 0;
>  }
>  
> -static struct notifier_block octeon_wdt_cpu_notifier = {
> -	.notifier_call = octeon_wdt_cpu_callback,
> -};
> -
>  static const struct watchdog_info octeon_wdt_info = {
>  	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity = "OCTEON",
> @@ -553,6 +533,7 @@ static struct watchdog_device octeon_wdt = {
>  	.ops	= &octeon_wdt_ops,
>  };
>  
> +static enum cpuhp_state octeon_wdt_online;
>  /**
>   * Module/ driver initialization.
>   *
> @@ -562,7 +543,6 @@ static int __init octeon_wdt_init(void)
>  {
>  	int i;
>  	int ret;
> -	int cpu;
>  	u64 *ptr;
>  
>  	/*
> @@ -610,14 +590,16 @@ static int __init octeon_wdt_init(void)
>  
>  	cpumask_clear(&irq_enabled_cpus);
>  
> -	cpu_notifier_register_begin();
> -	for_each_online_cpu(cpu)
> -		octeon_wdt_setup_interrupt(cpu);
> -
> -	__register_hotcpu_notifier(&octeon_wdt_cpu_notifier);
> -	cpu_notifier_register_done();
> -
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "watchdog/octeon:online",
> +				octeon_wdt_cpu_online, octeon_wdt_cpu_pre_down);
> +	if (ret < 0)
> +		goto err;
> +	octeon_wdt_online = ret;
>  	return 0;
> +err:
> +	cvmx_write_csr(CVMX_MIO_BOOT_LOC_CFGX(0), 0);
> +	watchdog_unregister_device(&octeon_wdt);
> +	return ret;
>  }
>  
>  /**
> @@ -625,22 +607,8 @@ static int __init octeon_wdt_init(void)
>   */
>  static void __exit octeon_wdt_cleanup(void)
>  {
> -	int cpu;
> -
>  	watchdog_unregister_device(&octeon_wdt);
> -
> -	cpu_notifier_register_begin();
> -	__unregister_hotcpu_notifier(&octeon_wdt_cpu_notifier);
> -
> -	for_each_online_cpu(cpu) {
> -		int core = cpu2core(cpu);
> -		/* Disable the watchdog */
> -		cvmx_write_csr(CVMX_CIU_WDOGX(core), 0);
> -		/* Free the interrupt handler */
> -		free_irq(OCTEON_IRQ_WDOG0 + core, octeon_wdt_poke_irq);
> -	}
> -
> -	cpu_notifier_register_done();
> +	cpuhp_remove_state(octeon_wdt_online);
>  
>  	/*
>  	 * Disable the boot-bus memory, the code it points to is soon
