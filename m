Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56593 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066AbbCEK6A (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Mar 2015 05:58:00 -0500
Date: Thu, 5 Mar 2015 10:57:29 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
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
Message-ID: <20150305105729.GB13617@leverpostej>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <14143668.0aRkeVrc3Q@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14143668.0aRkeVrc3Q@vostro.rjw.lan>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

[...]

> > >  		err = request_irq(wdt->irq, wdt_interrupt,
> > > -				  IRQF_SHARED | IRQF_IRQPOLL,
> > > +				  IRQF_SHARED | IRQF_IRQPOLL |
> > > +				  IRQF_NO_SUSPEND,
> > 
> > I'm a little confused by this. What happens if the watchdog fires when
> > we're actually in the suspended state (when IRQF_NO_SUSPEND interrupts
> > aren't guaranteed to be delivered).
> 
> Why wouldn't they be delivered?
> 
> If that's suspend-to-idle, we'll handle them normally.  If that's full suspend,
> they may not be handled at the last stage (when we run on one CPU with interrupts
> off), but that was the case before the wakeup interrupts rework already and I'd
> expect it to be taken into account somehow in the existing code (or if it isn't
> taken into account, we have a bug, but it is not related to this series).

There's no enable_irq_wake(wdt->irq), and I was under the impression this
is for full suspend.

I agree that if problematic, it's an existing bug. Given Boris's
comments in the other thread this may just a minor semantic issue w.r.t.
IRQF_NO_SUSPEND vs IRQF_COND_SUSPEND.

Thanks,
Mark.
