Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59920 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbbCFNK5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Mar 2015 08:10:57 -0500
Date: Fri, 6 Mar 2015 13:10:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20150306131025.GH8700@leverpostej>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <CAJZ5v0h8vn26BeWPVhC4e_KNhBu15-mshnbq0K=OQ1M36vPQEQ@mail.gmail.com>
 <20150305163227.GF14093@leverpostej>
 <1696230.CygTkv53VA@vostro.rjw.lan>
 <20150306110618.GC8700@leverpostej>
 <CAJZ5v0jA-hRUnP_+mOdFw7vN7CGZ4o0FjUVu81rq7foi92f63g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jA-hRUnP_+mOdFw7vN7CGZ4o0FjUVu81rq7foi92f63g@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> >> > We seem to be conflating some related properties:
> >> >
> >> > [a] The IRQ will be left unmasked.
> >> > [b] The IRQ will be handled immediately when taken.
> >> > [c] The IRQ will wake the system from suspend.

[...]

> > Considering that the use-case of a watchdog is to alert us to something
> > going hideously wrong in the kernel, we want to handle the IRQ after
> > executing the smallest amount of kernel code possible. For that, they
> > need to have their handlers to be called "immediately" outside of the
> > arch_suspend_disable_irqs() ... arch_suspend_enable_irqs() window, and
> > need to be enabled during suspend to attempt to catch bad wakeup device
> > configuration.
> >
> > I think it's possible (assuming the caveats on [b] above) to provide
> > [a,b,c] for this case.
> 
> OK
> 
> But in this case the request_irq() passing IRQF_NO_SUSPEND *and* requiring
> enable_irq_wake() in addition to that needs a big fat comment explaining the
> whole thing or we'll forget about the gory details at one point and no one will
> know what's going on in there.

Agreed.

I'd expect an IRQF_SW_WATCHDOG or something to that effect should also
be required for that case.

Thanks,
Mark.
