Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51947 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754565AbbBTRWj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 12:22:39 -0500
Date: Fri, 20 Feb 2015 18:16:40 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas FERRE <nicolas.ferre@atmel.com>,
	alexandre.belloni@free-electrons.com,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at
 early boot
Message-ID: <20150220181640.57b21432@bbrezillon>
In-Reply-To: <E7DD67EB-CA34-48EA-838D-3EBBF74CAEBD@jcrosoft.com>
References: <54B53160.6060309@roeck-us.net>
	<cover.1424262664.git.timo.kokkonen@offcode.fi>
	<cover.1424262664.git.timo.kokkonen@offcode.fi>
	<6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
	<00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
	<20150220085151.3b599de8@bbrezillon>
	<E7DD67EB-CA34-48EA-838D-3EBBF74CAEBD@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean-Christophe,

On Sat, 21 Feb 2015 00:33:17 +0800
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:

> 
> > On Feb 20, 2015, at 3:51 PM, Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> > 
> > Hi Jean-Christophe,
> > 
> > On Fri, 20 Feb 2015 15:48:22 +0800
> > Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > 
> >> 
> >>> On Feb 18, 2015, at 8:57 PM, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
> >>> 
> >>> By default the driver will start a kernel timer which keeps on kicking
> >>> the watchdog HW until user space has opened the watchdog
> >>> device. Usually this is desirable as the watchdog HW is running by
> >>> default and the user space may not have any watchdog daemon running at
> >>> all.
> >>> 
> >>> However, on production systems it may be mandatory that also early
> >>> crashes and lockups will lead to a watchdog reset, even if they happen
> >>> before the user space has opened the watchdog device.
> >>> 
> >>> To resolve the issue, add a new device tree property
> >>> "early-timeout-sec" which will let the kernel timer to ping the
> >>> watchdog HW only as long as the specified timeout permits. The default
> >>> is still to use kernel timer, but more strict behavior can be enabled
> >>> via the device tree property.
> >>> 
> >>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> >>> ---
> >>> Documentation/devicetree/bindings/watchdog/watchdog.txt | 7 +++++++
> >>> drivers/watchdog/at91sam9_wdt.c                         | 9 ++++++++-
> >> 
> >> This should not be handled by the driver but the kernel in a generic way
> > 
> > Could you detail a bit more what you have in mind ?
> 
> move this timeout on the linux thread that keep alive the watchdog not in the driver

AFAIK there's no such thing (if there is, could you point me to the
source file where this thread is defined ?), and each driver are
registering their own timer (if they need one).
If you're suggesting to add such common logic to watchdog core, why
don't you propose something ?

Timo's need is quite generic, but nobody seemed to bother with that
before.
Moreover, using an at91 specific implementation does not prevent
migrating to a more generic implementation when it's available.
Actually, it's rather difficult to design a generic infrastructure until
you have dealt with several devices requiring the same feature, and
that's obviously not the case here.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
