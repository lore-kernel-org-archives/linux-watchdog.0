Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:58388 "EHLO
	15.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbbBTUM5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 15:12:57 -0500
Received: from mail177.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 19140FFB57F
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Feb 2015 17:33:36 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at early boot
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
In-Reply-To: <20150220085151.3b599de8@bbrezillon>
Date: Sat, 21 Feb 2015 00:33:17 +0800
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Nicolas FERRE <nicolas.ferre@atmel.com>,
	alexandre.belloni@free-electrons.com,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E7DD67EB-CA34-48EA-838D-3EBBF74CAEBD@jcrosoft.com>
References: <54B53160.6060309@roeck-us.net> <cover.1424262664.git.timo.kokkonen@offcode.fi> <cover.1424262664.git.timo.kokkonen@offcode.fi> <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi> <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com> <20150220085151.3b599de8@bbrezillon>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


> On Feb 20, 2015, at 3:51 PM, Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> Hi Jean-Christophe,
> 
> On Fri, 20 Feb 2015 15:48:22 +0800
> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> 
>> 
>>> On Feb 18, 2015, at 8:57 PM, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
>>> 
>>> By default the driver will start a kernel timer which keeps on kicking
>>> the watchdog HW until user space has opened the watchdog
>>> device. Usually this is desirable as the watchdog HW is running by
>>> default and the user space may not have any watchdog daemon running at
>>> all.
>>> 
>>> However, on production systems it may be mandatory that also early
>>> crashes and lockups will lead to a watchdog reset, even if they happen
>>> before the user space has opened the watchdog device.
>>> 
>>> To resolve the issue, add a new device tree property
>>> "early-timeout-sec" which will let the kernel timer to ping the
>>> watchdog HW only as long as the specified timeout permits. The default
>>> is still to use kernel timer, but more strict behavior can be enabled
>>> via the device tree property.
>>> 
>>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>>> ---
>>> Documentation/devicetree/bindings/watchdog/watchdog.txt | 7 +++++++
>>> drivers/watchdog/at91sam9_wdt.c                         | 9 ++++++++-
>> 
>> This should not be handled by the driver but the kernel in a generic way
> 
> Could you detail a bit more what you have in mind ?

move this timeout on the linux thread that keep alive the watchdog not in the driver

Best Regards,
J.
> 
> Best Regards,
> 
> Boris
> 
> -- 
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

