Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lb1-smtp-cloud6.xs4all.net ([194.109.24.24]:60958 "EHLO
	lb1-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752407AbbEHLrJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 May 2015 07:47:09 -0400
Message-ID: <1431085625.13593.39.camel@x220>
Subject: Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as sched
 clock' capability
From: Paul Bolle <pebolle@tiscali.nl>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net
Date: Fri, 08 May 2015 13:47:05 +0200
In-Reply-To: <20150508102938.GD29044@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
	 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
	 <1431074699.13593.4.camel@x220> <20150508093603.GB29044@x1>
	 <1431078730.13593.14.camel@x220> <20150508102938.GD29044@x1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 2015-05-08 at 11:29 +0100, Lee Jones wrote:
> Ah, you mean from menuconfig.  I almost forgot what that was. ;)
> 
> I can add a menu option, no problem.

It's not just menuconfig:
    $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config 
    CONFIG_ARCH_STI=y
    CONFIG_CLKSRC_ST_LPC=y
    CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=y
    $ vim .config 
    $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config 
    CONFIG_ARCH_STI=y
    # CONFIG_CLKSRC_ST_LPC is not set
    # CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK is not set
    $ make ARCH=arm silentoldconfig
    scripts/kconfig/conf  --silentoldconfig Kconfig
    #
    # configuration written to .config
    #
    $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config 
    CONFIG_ARCH_STI=y
    CONFIG_CLKSRC_ST_LPC=y
    CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=y

So I think that, if you want to be able to set
CLKSRC_ST_LPC_TIMER_SCHED_CLOCK to 'n' even though CLKSRC_ST_LPC is 'y',
you need to add a prompt. Or have you found a way around this?

Thanks,


Paul Bolle

