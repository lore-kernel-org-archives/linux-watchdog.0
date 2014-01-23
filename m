Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:43221 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaAWVQA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jan 2014 16:16:00 -0500
Message-ID: <52E1868A.8020208@gmail.com>
Date: Thu, 23 Jan 2014 22:15:54 +0100
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com> <20140121233537.GS18269@obsidianresearch.com> <20140122164904.GB27273@localhost> <20140122173417.GT18269@obsidianresearch.com> <52E02AB6.7040104@gmail.com> <20140122205213.GW18269@obsidianresearch.com> <52E0591E.6030009@gmail.com> <20140123111049.GB6065@localhost> <20140123115432.GC6065@localhost>
In-Reply-To: <20140123115432.GC6065@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Jason, Ezequiel,

On 01/23/2014 12:54 PM, Ezequiel Garcia wrote:
> Sebastian,
>
> On Thu, Jan 23, 2014 at 08:10:49AM -0300, Ezequiel Garcia wrote:
>> On Thu, Jan 23, 2014 at 12:49:50AM +0100, Sebastian Hesselbarth wrote:
>> [..]
>>>> Notice that Ezequiel has added an IRQ handler that just calls panic,
>>>> so a spurious interrupt call is VERY VERY BAD.
>>>
>>> And I understand that he now clears watchdog's register before
>>> requesting an irq. All that is missing is bridge_irq driver clearing
>>> CAUSE register after masking all irqs, right?
>>>
>>
>> Are you sure clearing the CAUSE register after masking the IRQs will be enough?
>>
>> AFAICS, until now nobody unmasks the watchdog IRQ (at least the orion_wdt
>> driver didn't request the interruption) but *still* the CAUSE register is set
>> upon watchdog expiration. So I would guessed a masked interrupt still raises a
>> bit in the CAUSE register.
>>
>
> Let me add some real information instead of my speculations. Taken from
> the Kirkwood specification:
>
> Table 136: Mbus-L to Mbus Bridge Interrupt Mask Register
> Offset:		0x00020114
> Field: 		Mask
> Type/InitVal: 	RW 0x0
> Description:	There is a mask bit per each cause bit. Mask only affects the
> 		assertion of interrupt pins. It does not affect the setting of
> 		bits in the Cause register.
>
> So I guess this is why Jason has been insisting with the introduction of
> the irq_startup.
>
> (Just for reference, the little patch I attached yesterday proved to work here.)

You guys were so right ;)

I just tested your v4 of the watchdog patches and forced a stale
watchdog irq. It will cause a watchdog reset as you predicted.

I have some fixes for irq-orion.c's bridge irq that take care of:
- handle_edge_irq
- mask _and_ clear irqs on init
- use irq_enable to ensure stale irqs are acked before unmask

With the last one, the stale watchdog irq will not raise watchdog's
irq handler anymore.

BTW, during my test, it looks like RSTOUT wasn't set, so I'll add
my Tested-by on v4 when I have investigated that.

Sebastian

