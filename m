Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33115 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbcDGNT0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Apr 2016 09:19:26 -0400
Date: Thu, 7 Apr 2016 06:19:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Cochran <rcochran@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [2/5] watchdog: octeon: Handle the FROZEN hot plug notifier
 actions.
Message-ID: <20160407131927.GA28746@roeck-us.net>
References: <1458336371-17748-2-git-send-email-rcochran@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458336371-17748-2-git-send-email-rcochran@linutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 18, 2016 at 10:26:08PM +0100, Richard Cochran wrote:
> When performing a suspend operation, the kernel brings all of the
> non-boot CPUs offline, calling the hot plug notifiers with the flag,
> CPU_TASKS_FROZEN, set in the action code.  Similarly, during resume,
> the CPUs are brought back online, but again the notifiers have the
> FROZEN flag set.
> 
> While some very few drivers really need to treat suspend/resume
> specially, this driver unintentionally ignores the notifications.
> 
> This patch changes the driver to disable the watchdog interrupt
> whenever the CPU goes offline, and to enable it whenever the CPU goes
> back online.  As a result, the suspended state is no longer a special
> case that leaves the watchdog active.
> 
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Richard Cochran <rcochran@linutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/octeon-wdt-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
> index 14521c8..b55981f 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -431,7 +431,7 @@ static int octeon_wdt_cpu_callback(struct notifier_block *nfb,
>  {
>  	unsigned int cpu = (unsigned long)hcpu;
>  
> -	switch (action) {
> +	switch (action & ~CPU_TASKS_FROZEN) {
>  	case CPU_DOWN_PREPARE:
>  		octeon_wdt_disable_interrupt(cpu);
>  		break;
