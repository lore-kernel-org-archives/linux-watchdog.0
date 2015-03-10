Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:43720 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753237AbbCJVdT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 Mar 2015 17:33:19 -0400
Date: Tue, 10 Mar 2015 22:33:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>,
	Sylvain Rochet <gradator@gradator.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Mike Turquette <mturquette@linaro.org>,
	Jason Cooper <jason@lakedaemon.net>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Slaby <jslaby@suse.cz>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Message-ID: <20150310213317.GK9188@piout.net>
References: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <1615214.0rkGfM1gZL@vostro.rjw.lan>
 <20150309075546.GY3989@piout.net>
 <1592385.fqRVVyPSPE@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592385.fqRVVyPSPE@vostro.rjw.lan>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 09/03/2015 at 15:30:01 +0100, Rafael J. Wysocki wrote :
> > > > Actaully, your platform should just refuse to enter suspend-to-RAM
> > > > when hw watchdog is enabled.
> > > 
> > > Quite likely, depending on how exactly the suspend is implemented.
> > >
> > 
> > We've had absolutely zero complain on that. It is quite clear in the
> > datasheet that failing to refresh the watchdog once started will lead to
> > a reset and that it is impossible to stop.
> > It is actually quite convenient to also ensure that you can actually
> > wake up from suspend because that can obviously go wrong.
> 
> I gather then that the suspend implementation is such that touching the
> watchdog periodically while suspended is not a problem.
> 
> Again, can you please tell me how suspend is implemented on at91?
> 

It actually depends on the architecture (at91rm9200, at91sam9 or sama5)
but basically, the clocks are switched off in almost all the peripheral
drivers then the ram self refresh activated, the master clock is
switched off using code running from SRAM and the core is then waiting
for interrupt.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
