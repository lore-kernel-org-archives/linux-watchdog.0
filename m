Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:42528 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197Ab3FRSgb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 14:36:31 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so1913621bkc.4
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 11:36:29 -0700 (PDT)
Message-ID: <51C0A8A9.4070608@gmail.com>
Date: Tue, 18 Jun 2013 20:36:25 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>
CC: Russell King <rmk+kernel@arm.linux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] Watchdog: allow orion_wdt to be built for Dove
References: <E1Uoyd2-0001Cp-KL@rmk-PC.arm.linux.org.uk> <20130618163129.GY31667@titan.lakedaemon.net>
In-Reply-To: <20130618163129.GY31667@titan.lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/18/2013 06:31 PM, Jason Cooper wrote:
> On Tue, Jun 18, 2013 at 05:19:32PM +0100, Russell King wrote:
>> The watchdog infrastructure in Dove is no different from that in
>> Orion5x or Kirkwood, so let's enable it for Dove.  The only things
>> missing are a few register settings in Dove's bridge-regs.h.
>>
>> Rather than duplicating the same register bit masks for the RSTOUTn_MASK
>> and BRIDGE_CAUSE registers, move the definitions into the watchdog
>> driver itself.
>>
>> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
>> ---
>>   arch/arm/mach-dove/include/mach/bridge-regs.h     |    1 +
>>   arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    2 --
>>   arch/arm/mach-orion5x/include/mach/bridge-regs.h  |    3 ---
>>   drivers/watchdog/Kconfig                          |    2 +-
>>   drivers/watchdog/orion_wdt.c                      |    3 +++
>>   5 files changed, 5 insertions(+), 6 deletions(-)
>
> There shouldn't be any conflicts on the mvebu side.  Wim, feel free to
> take it:
>
> Acked-by: Jason Cooper<jason@lakedaemon.net>

FWIW, you also kind of get my Acked-by, although I was silently hoping
we can postpone orion wdt until we remove non-DT ;)

With irqchip queued for 3.11, we will ack the timer irqs by a
chained irq handler. But this will be DT-only and currently also only
for Kirkwood and Dove (Orion5x DT progress is slow).

With 3.11 out, I will see how to handle wdt. Either make it non-DT/DT
aware or also move non-DT to irqchip.

Sebastian
