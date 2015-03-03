Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36019 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752042AbbCCI5H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Mar 2015 03:57:07 -0500
Date: Tue, 3 Mar 2015 09:56:46 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
	Mike Turquette <mturquette@linaro.org>,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] ARM: at91: fix irq_pm_install_action WARNING
Message-ID: <20150303085646.GA3892@piout.net>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/03/2015 at 10:18:12 +0100, Boris Brezillon wrote :
> My apologies to those of you who already received this series, but I
> didn't increment the patch version and forgot some subsystem maintainers
> and MLs.
> 
> Commit cab303be91dc47942bc25de33dc1140123540800 [1] introduced a WARN_ON
> test which triggers a WARNING backtrace on at91 platforms.
> While this WARN_ON is absolutely necessary to warn users that they should
> not mix request with and without IRQF_NO_SUSPEND flags on shared IRQs,
> there is no easy way to solve this issue on at91 platforms.
> 
> The main reason is that the init timer is often using a shared irq line
> and thus request this irq with IRQF_NO_SUSPEND flag set, while other
> peripherals request the same irq line without this flag.
> 
> This problem has recently been addressed by this patch [2] which adds
> a new IRQF_COND_SUSPEND flag, that authorize mixing IRQF_NO_SUSPEND and
> !IRQF_NO_SUSPEND as long as irq handlers setting IRQF_COND_SUSPEND
> can safely be called in suspended state.
> 
> Doing this also implies taking care of system wakeup in devices handlers
> if they tag the IRQ line as a wakeup source.
> The first patch of this series exports the pm_system_wakeup symbol so
> that drivers can call pm_system_wakeup from their interrupt handler.
> 
> This series then patches all at91 drivers that can have devices sharing
> their IRQ line with a timer.
> 
> This series depends on [2].
> 

For the whole series:
Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
