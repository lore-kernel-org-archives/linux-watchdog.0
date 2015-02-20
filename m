Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50520 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbbBTQKm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 11:10:42 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YOqA3-001e1b-CV
	for linux-watchdog@vger.kernel.org; Fri, 20 Feb 2015 16:10:39 +0000
Date: Fri, 20 Feb 2015 08:09:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	boris.brezillon@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Nicolas FERRE <nicolas.ferre@atmel.com>,
	alexandre.belloni@free-electrons.com
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at
 early boot
Message-ID: <20150220160953.GA22752@roeck-us.net>
References: <54B53160.6060309@roeck-us.net>
 <cover.1424262664.git.timo.kokkonen@offcode.fi>
 <cover.1424262664.git.timo.kokkonen@offcode.fi>
 <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
 <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 20, 2015 at 03:48:22PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
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
> 
Sure, and it has been in the back of my mind for a couple of years.
Care to submit a set of patches to implement it ?

Guenter
