Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56826 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbbCELxj (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Mar 2015 06:53:39 -0500
Date: Thu, 5 Mar 2015 11:53:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Mike Turquette <mturquette@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Message-ID: <20150305115307.GA14093@leverpostej>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150305121723.1da0d016@bbrezillon>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Boris,

TL;DR - I guess using IRQF_NO_SUSPEND for now is OK a a best-effort
approach for now, so don't let my comments block this patch.

However, there are still some potential issues in what would already be
a failure case: your usual wakeup mechanism not waking the system up in
time to poke the watchdog, and then the watchdog raising an IRQ that
never gets taken because the system is in a suspended state.

> > Is the timer we use to ping the watchdog guaranted to result in a wakeup
> > before an interrupt will be triggered? If so, then I think we're ok.
> 
> It should be (I don't recall exactly what the logic is, but it's at
> least half the watchdog time limit).

Ok. If that's the case then my main fear is gone.

[...]

> If we want the watchdog to be inactive when entering suspend, then we
> shouldn't reboot the machine when receiving a watchdog irq while the
> system is suspended.

For this I would expect IRQF_COND_SUSPEND, because we don't care about
the suspended case. We just don't want to negatively impact the timers.

> ITOH, with the hardware mode (reset handled by the watchdog IP) you
> can't disable the watchdog when entering suspend, so I would expect the
> same behavior for the SW mode.

For this I would expect IRQF_COND_SUSPEND and enable_irq_wake().

If we really want a wakeup IRQ guaranteed to be called immediately
(without bothering to do most of the resume work first), none of the
current semantics align.

> > Regardless, if the only reason we care about taking the interrupt during
> > the suspend/resume phases is due to the timer sharing the IRQ, then
> > shouldn't we be using IRQF_COND_SUSPEND?
> 
> I'm not sure, but IMO this interrupt should be flagged as NO_SUSPEND,
> because it's here to reset the system (even if it is suspended).
> If you flag the irq line as COND_SUSPEND, and atmel decide to give this
> peripheral its own IRQ line (on new SoCs), then your watchdog will not
> reboot the system when it is suspended.
> Another solution would be to support wakeup for this peripheral and
> delay the system reboot until it has resumed.

>From the above it sounds like we'd need wakeup and guaranteed immediate
handler calling. That either needs rethink of IRQF_NO_SUSPEND +
enable_irq_wake(), or something like a new IRQF_SW_WATCHDOG +
enable_irq_wake().

> Anyway, if we decide to go for the wakeup approach, I'd prefer to post
> another patch on top of this one.

If everyone else is happy with this using IRQF_NO_SUSPEND for now then
don't let my comments above block this patch.

Mark.
