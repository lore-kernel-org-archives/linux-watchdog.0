Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40992 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754268Ab1BGBGa (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 6 Feb 2011 20:06:30 -0500
Subject: Re: [PATCH] watchdog: booke_wdt: clean up status messages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org
In-Reply-To: <1295299780-27338-1-git-send-email-timur@freescale.com>
References: <1295299780-27338-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 12:06:12 +1100
Message-ID: <1297040772.14982.25.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2011-01-17 at 15:29 -0600, Timur Tabi wrote:
> Improve the status messages that are displayed during some operations of the
> PowerPC watchdog timer driver.  When the watchdog is enabled, the timeout is
> displayed as a number of seconds, instead of an obscure "period".  The "period"
> is the position of a bit in a 64-bit timer register.  The higher the value,
> the quicker the watchdog timeout occurs.  Some people chose a high "period"
> value for the timer and get confused as to why the board resets within a
> few seconds.
> 
> Messages displayed during open and close are now debug messages, so that they
> don't clutter the console by default.  Finally, printk() is replaced with the
> pr_xxx() equivalent.

Minor nit bu
>  
> -	printk(KERN_INFO "PowerPC Book-E Watchdog Timer Loaded\n");
> +	pr_info("PowerPC Book-E Watchdog Timer Loaded\n");
>  	ident.firmware_version = cur_cpu_spec->pvr_value;
>  
>  	ret = misc_register(&booke_wdt_miscdev);
>  	if (ret) {
> -		printk(KERN_CRIT "Cannot register miscdev on minor=%d: %d\n",
> -				WATCHDOG_MINOR, ret);
> +		pr_err("booke_wdt: cannot register device (minor=%u, ret=%i)\n",
> +		       WATCHDOG_MINOR, ret);
>  		return ret;
>  	}
>  
>  	spin_lock(&booke_wdt_lock);
>  	if (booke_wdt_enabled == 1) {
> -		printk(KERN_INFO
> -		      "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
> -				booke_wdt_period);
> +		pr_info("booke_wdt: watchdog enabled (timeout = %llu sec)\n",
> +			period_to_sec(booke_wdt_period));
>  		on_each_cpu(__booke_wdt_enable, NULL, 0);
>  	}

If you're going to cleanup the messages, then I think displaying:

PowerPC Book-E Watchdog Timer Loaded
booke_wdt: watchdog enabled (timeout = xxx sec)

Isn't very nice.

Lacks consistency ... you can prefix both lines the same way, or
maybe better print only one line with all the necessary info.

Ben.


