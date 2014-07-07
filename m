Return-Path: <akpm@linux-foundation.org>
Date: Mon, 7 Jul 2014 14:16:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas
 <catalin.marinas@arm.com>, Maxime Ripard
 <maxime.ripard@free-electrons.com>, Will Deacon <will.deacon@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>, Russell King
 <linux@arm.linux.org.uk>, Jonas Jensen <jonas.jensen@gmail.com>, Randy
 Dunlap <rdunlap@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo
 Molnar <mingo@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] arm64: Support restart through restart notifier
 call chain
Message-Id: <20140707141654.d7fb9f8839cdf58822cd43b9@linux-foundation.org>
In-Reply-To: <1404689900-27421-3-git-send-email-linux@roeck-us.net>
References: <1404689900-27421-1-git-send-email-linux@roeck-us.net>
	<1404689900-27421-3-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Sun,  6 Jul 2014 16:38:15 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> The kernel core now supports a notifier call chain to restart
> the system. Call it if arm_pm_restart is not set.
> 
> ...
>
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -174,6 +174,9 @@ void machine_restart(char *cmd)
>  	/* Now call the architecture specific reboot code. */
>  	if (arm_pm_restart)
>  		arm_pm_restart(reboot_mode, cmd);
> +	else
> +		blocking_notifier_call_chain(&restart_notifier_list,
> +					     reboot_mode, cmd);

It would be a bit neater to have a helper function to perform the call,
rather than directly accessing the notifier list.  Apart from anything
else, this hides the fact that the core code (presently!) uses the
blocking_ style notifiers.
