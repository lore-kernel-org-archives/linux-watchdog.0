Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:49051 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbaAVRe0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 12:34:26 -0500
Date: Wed, 22 Jan 2014 10:34:17 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
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
Message-ID: <20140122173417.GT18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140122164904.GB27273@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 22, 2014 at 01:49:05PM -0300, Ezequiel Garcia wrote:
> > Looking at this patch in isolation it looks to me like the clear
> > bridge lines should be replaced with a request_irq (as that does the
> > clear) - is the request_irq in the wrong spot?
> 
> First of all, it seems to me that the first item "Disable WDT" is not
> currently true on this driver. orion_wdt_start() seem to reset the
> counter, but doesn't clear the WDT_EN bit. Do you think we should
> enforce a "true" disable?

I think so.

> Regarding the sequence. Let me see if I got this problem right. The
> concern here is about the bootloader leaving the registers in a
> weird-state, right?

It isn't just bootloaders to worry about, but also things like kexec..

> In that case, I thought that requesting the IRQ at probe time was enough
> to ensure the BRIDGE_CAUSE would be cleared by the time the watchdog is
> started. However, after reading through the irqchip code again, I'm no longer
> sure this is the case.

The watchdog should ideally be fully stopped before request_irq so
there is no possible race.

> It looks like the BRIDGE_CAUSE register is cleared when the interruption
> is acked (which happens in the handler if I understood the code right).
> So requesting the IRQ is useless...

IMHO, the IRQ stuff should clear out pending edge triggered interrupts
at request_irq time. It makes no sense to take an interrupt for a
stale edge event.

I had always assumed the core code did this via irq_gc_ack_clr_bit -
but I don't see an obvious path..

> Sebastian: If the above is correct, do you think we can add a cause clear to
> the orion irqchip? (supposing it's harmful) Something like this:

Hrm, irq_startup looks like the right hook to put something like this
in.

Jason
