Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47933 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbbHXRuq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Aug 2015 13:50:46 -0400
Date: Mon, 24 Aug 2015 19:50:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Fu Wei <fu.wei@linaro.org>
cc: Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	Arnd Bergmann <arnd@arndb.de>, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, leo.duran@amd.com,
	Jonathan Corbet <corbet@lwn.net>, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v7 8/8] clocksource: simplify ACPI code in
 arm_arch_timer.c
In-Reply-To: <1440435683-7343-9-git-send-email-fu.wei@linaro.org>
Message-ID: <alpine.DEB.2.11.1508241942450.3873@nanos>
References: <=fu.wei@linaro.org> <1440435683-7343-1-git-send-email-fu.wei@linaro.org> <1440435683-7343-9-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 25 Aug 2015, fu.wei@linaro.org wrote:

You Cc the world and some more on your patch, but you fail to add the
maintainers of the clocksource code to the Cc list. Sigh.

> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch update arm_arch_timer driver to use the function
> provided by the new GTDT driver of ACPI.
> By this way, arm_arch_timer.c can be simplified, and separate
> all the ACPI GTDT knowledge from this timer driver.

That's not a proper changelog and this patch want's to be split in two:

1) Implement the new ACPI function

2) Make use of it
 
> index 0aa135d..99505bb 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -817,68 +817,30 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>  		       arch_timer_mem_init);
>  
>  #ifdef CONFIG_ACPI
> -static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
> -{
> -	int trigger, polarity;
> -
> -	if (!interrupt)
> -		return 0;
> -
> -	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
> -			: ACPI_LEVEL_SENSITIVE;
> -
> -	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
> -			: ACPI_ACTIVE_HIGH;
> -
> -	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
> -}
> -
>  /* Initialize per-processor generic timer */
> -static int __init arch_timer_acpi_init(struct acpi_table_header *table)
> +void __init arch_timer_acpi_init(void)
>  {

And how is that supposed to work when we have next generation CPUs
which implement a different timer? You break multisystem kernels that
way.

Thanks,

	tglx
