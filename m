Return-Path: <sboyd@codeaurora.org>
Message-ID: <53D95330.1050904@codeaurora.org>
Date: Wed, 30 Jul 2014 13:18:56 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ingo Molnar <mingo@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-doc@vger.kernel.org,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Tomasz Figa <t.figa@samsung.com>,
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Jonas Jensen <jonas.jensen@gmail.com>,
 Wim Van Sebroeck <wim@iguana.be>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 1/7] kernel: Add support for kernel restart handler
 call chain
References: <1405668856-13738-1-git-send-email-linux@roeck-us.net> <1405668856-13738-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1405668856-13738-2-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 07/18/14 00:34, Guenter Roeck wrote:
> +/**
> + *	do_kernel_restart - Execute kernel restart handler call chain
> + *
> + *	Calls functions registered with register_restart_handler.
> + *
> + *	Expected to be called from machine_restart as last step of the restart
> + *	sequence.
> + *
> + *	Restarts the system immediately if a restart handler function has been
> + *	registered. Otherwise does nothing.
> + */
> +void do_kernel_restart(char *cmd)
> +{
> +	blocking_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
> +}

Has this been tested with scheduling while atomic checking
(CONFIG_DEBUG_ATOMIC_SLEEP) or lockdep (CONFIG_PROVE_LOCKING)? ARM would
call this with irqs disabled and blocking_notifier_call_chain() would
spit out a warning when it tries to down_read() on it's semaphore. This
should probably be an atomic notifier chain instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
