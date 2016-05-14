Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 14 May 2016 18:36:23 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Richard Cochran <rcochran@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/5] watchdog: octeon: Handle the FROZEN hot plug notifier actions.
Message-ID: <20160514163623.GB20158@spo001.leaseweb.nl>
References: <1458336371-17748-2-git-send-email-rcochran@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458336371-17748-2-git-send-email-rcochran@linutronix.de>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Richard,

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
> ---
>  drivers/watchdog/octeon-wdt-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
