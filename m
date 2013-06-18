Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43447 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314Ab3FRSyX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 14:54:23 -0400
Date: Tue, 18 Jun 2013 19:54:09 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] Watchdog: allow orion_wdt to be built for Dove
Message-ID: <20130618185409.GE2718@n2100.arm.linux.org.uk>
References: <E1Uoyd2-0001Cp-KL@rmk-PC.arm.linux.org.uk> <20130618163129.GY31667@titan.lakedaemon.net> <51C0A8A9.4070608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51C0A8A9.4070608@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 18, 2013 at 08:36:25PM +0200, Sebastian Hesselbarth wrote:
> On 06/18/2013 06:31 PM, Jason Cooper wrote:
>> On Tue, Jun 18, 2013 at 05:19:32PM +0100, Russell King wrote:
>>> The watchdog infrastructure in Dove is no different from that in
>>> Orion5x or Kirkwood, so let's enable it for Dove.  The only things
>>> missing are a few register settings in Dove's bridge-regs.h.
>>>
>>> Rather than duplicating the same register bit masks for the RSTOUTn_MASK
>>> and BRIDGE_CAUSE registers, move the definitions into the watchdog
>>> driver itself.
>>>
>>> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
>>> ---
>>>   arch/arm/mach-dove/include/mach/bridge-regs.h     |    1 +
>>>   arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    2 --
>>>   arch/arm/mach-orion5x/include/mach/bridge-regs.h  |    3 ---
>>>   drivers/watchdog/Kconfig                          |    2 +-
>>>   drivers/watchdog/orion_wdt.c                      |    3 +++
>>>   5 files changed, 5 insertions(+), 6 deletions(-)
>>
>> There shouldn't be any conflicts on the mvebu side.  Wim, feel free to
>> take it:
>>
>> Acked-by: Jason Cooper<jason@lakedaemon.net>
>
> FWIW, you also kind of get my Acked-by, although I was silently hoping
> we can postpone orion wdt until we remove non-DT ;)
>
> With irqchip queued for 3.11, we will ack the timer irqs by a
> chained irq handler. But this will be DT-only and currently also only
> for Kirkwood and Dove (Orion5x DT progress is slow).
>
> With 3.11 out, I will see how to handle wdt. Either make it non-DT/DT
> aware or also move non-DT to irqchip.

Well, it doesn't actually use IRQs at all.  What it needs to do though
is ensure that the watchdog IRQ is cleared.  For the sake of speculation,
this may be because it needs to be cleared otherwise setting
WDT_RESET_OUT_EN might provoke an immediate reset...  Unfortunately
the Armada 510 manual seems to lack very many words about the Watchdog
behaviour.
