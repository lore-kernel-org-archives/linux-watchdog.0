Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:33557 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbaAVUb4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 15:31:56 -0500
Message-ID: <52E02AB6.7040104@gmail.com>
Date: Wed, 22 Jan 2014 21:31:50 +0100
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com> <20140121233537.GS18269@obsidianresearch.com> <20140122164904.GB27273@localhost> <20140122173417.GT18269@obsidianresearch.com>
In-Reply-To: <20140122173417.GT18269@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/22/2014 06:34 PM, Jason Gunthorpe wrote:
> On Wed, Jan 22, 2014 at 01:49:05PM -0300, Ezequiel Garcia wrote:
>>> Looking at this patch in isolation it looks to me like the clear
>>> bridge lines should be replaced with a request_irq (as that does the
>>> clear) - is the request_irq in the wrong spot?
>>
>> In that case, I thought that requesting the IRQ at probe time was enough
>> to ensure the BRIDGE_CAUSE would be cleared by the time the watchdog is
>> started. However, after reading through the irqchip code again, I'm no longer
>> sure this is the case.
>
> The watchdog should ideally be fully stopped before request_irq so
> there is no possible race.
>
>> It looks like the BRIDGE_CAUSE register is cleared when the interruption
>> is acked (which happens in the handler if I understood the code right).
>> So requesting the IRQ is useless...
>
> IMHO, the IRQ stuff should clear out pending edge triggered interrupts
> at request_irq time. It makes no sense to take an interrupt for a
> stale edge event.
>
> I had always assumed the core code did this via irq_gc_ack_clr_bit -
> but I don't see an obvious path..
>
>> Sebastian: If the above is correct, do you think we can add a cause clear to
>> the orion irqchip? (supposing it's harmful) Something like this:

Ezequiel,

irqchip/irq-orion.c does mask all interrupts but you are right, it 
should also clear pending interrupts right after that.

So
	/* mask all interrupts */
	writel(0, gc->reg_base + ORION_BRIDGE_IRQ_MASK);

should become

	/* mask and clear all interrupts */
	writel(0, gc->reg_base + ORION_BRIDGE_IRQ_MASK);
	writel(~0, gc->reg_base + ORION_BRIDGE_IRQ_CAUSE);

Could also be clear on write 0, I'll check that. I already had some
beer, so I'll postpone any patches till tomorrow.

Clearing BRIDGE_CAUSE will only clear all currently pending upstream
IRQs, of course. If WDT IRQ will be re-raised right after that in
BRIDGE_CAUSE depends on the actual HW implementation, i.e. we do no
clear the causing IRQ itself but just what it raised in BRIDGE_CAUSE.

So, you should also clear WDT's irq in the driver yourself to clear a
possible pending upstream BRIDGE_CAUSE.

Sebastian
