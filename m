Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49958 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060AbbCGJk3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 7 Mar 2015 04:40:29 -0500
Date: Sat, 7 Mar 2015 10:18:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
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
Message-ID: <20150307091846.GN23367@worktop.ger.corp.intel.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150305115307.GA14093@leverpostej>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 05, 2015 at 11:53:08AM +0000, Mark Rutland wrote:
> If everyone else is happy with this using IRQF_NO_SUSPEND for now then
> don't let my comments above block this patch.

Yeah, I'm really not happy with NO_SUSPEND + enable_irq_wake().

I really want that combo to BUG/WARN -- esp. since there's so much cargo
culted crap out there.

We should make robust interfaces, not randomly toggle flags until it
mostly works by accident rather than by design -- which is what this
feels like.

And while I appreciate the watchdog use-case; I think the easiest
solution for now is to simply disable the wathdog over suspend until
we've come up with something that makes sense.

As it is, you need to 'suspend' the watchdog at some point anyhow; you
don't want that thing to wake you from whatever suspend state you're in.
