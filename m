Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48717 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751805AbbBTHvz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 02:51:55 -0500
Date: Fri, 20 Feb 2015 08:51:51 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Nicolas FERRE <nicolas.ferre@atmel.com>,
	alexandre.belloni@free-electrons.com
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at
 early boot
Message-ID: <20150220085151.3b599de8@bbrezillon>
In-Reply-To: <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
References: <54B53160.6060309@roeck-us.net>
	<cover.1424262664.git.timo.kokkonen@offcode.fi>
	<cover.1424262664.git.timo.kokkonen@offcode.fi>
	<6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
	<00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean-Christophe,

On Fri, 20 Feb 2015 15:48:22 +0800
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:

> 
> > On Feb 18, 2015, at 8:57 PM, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
> > 
> > By default the driver will start a kernel timer which keeps on kicking
> > the watchdog HW until user space has opened the watchdog
> > device. Usually this is desirable as the watchdog HW is running by
> > default and the user space may not have any watchdog daemon running at
> > all.
> > 
> > However, on production systems it may be mandatory that also early
> > crashes and lockups will lead to a watchdog reset, even if they happen
> > before the user space has opened the watchdog device.
> > 
> > To resolve the issue, add a new device tree property
> > "early-timeout-sec" which will let the kernel timer to ping the
> > watchdog HW only as long as the specified timeout permits. The default
> > is still to use kernel timer, but more strict behavior can be enabled
> > via the device tree property.
> > 
> > Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> > ---
> > Documentation/devicetree/bindings/watchdog/watchdog.txt | 7 +++++++
> > drivers/watchdog/at91sam9_wdt.c                         | 9 ++++++++-
> 
> This should not be handled by the driver but the kernel in a generic way

Could you detail a bit more what you have in mind ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
