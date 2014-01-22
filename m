Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:52018 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbaAVUwV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 15:52:21 -0500
Date: Wed, 22 Jan 2014 13:52:13 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
Message-ID: <20140122205213.GW18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <52E02AB6.7040104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52E02AB6.7040104@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Clearing BRIDGE_CAUSE will only clear all currently pending upstream
> IRQs, of course. If WDT IRQ will be re-raised right after that in
> BRIDGE_CAUSE depends on the actual HW implementation, i.e. we do no
> clear the causing IRQ itself but just what it raised in BRIDGE_CAUSE.

Which is why it makes no sense to clear it one time at kernel start.

Either you only get new edge triggered interrupts after request_irq
(sane behavior) or you might sometimes get an old pending edge
triggered interrupt after request_irq (crazy behavior).

Clearing BRIDGE_CAUSE at kernel start only shortens the racy window it
doesn't eliminate it.

In the more familiar level triggered world the driver would go to the
device and ensure it wasn't asserting an IRQ level and then do the
request_irq. This guarentees it won't get an interrupt callback.

In a edge triggered world the driver should go to the device an ensure
that it won't create a new IRQ, then do request_irq - confident that
there will NEVER be a call to the IRQ handler, under any
circumstances.

So I think edge triggered interrupts need to ack any possible old edge
trigger in the cause register before the first unmask - eg in the
setup callback.

> So, you should also clear WDT's irq in the driver yourself to clear a
> possible pending upstream BRIDGE_CAUSE.

Which isn't possible - the BRIDGE_CAUSE is owned by the irq driver and
it must be cleared there, and it must only be cleared after the wdt
has been stopped so it doesn't set it again.

Notice that Ezequiel has added an IRQ handler that just calls panic,
so a spurious interrupt call is VERY VERY BAD.

Jason
