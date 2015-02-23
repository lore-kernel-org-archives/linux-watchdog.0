Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38361 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbBWQUE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 11:20:04 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YPvjn-001t7W-6R
	for linux-watchdog@vger.kernel.org; Mon, 23 Feb 2015 16:20:03 +0000
Date: Mon, 23 Feb 2015 08:19:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Timo Kokkonen <timo.kokkonen@offcode.fi>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Nicolas FERRE <nicolas.ferre@atmel.com>,
	alexandre.belloni@free-electrons.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at
 early boot
Message-ID: <20150223161948.GA2165@roeck-us.net>
References: <cover.1424262664.git.timo.kokkonen@offcode.fi>
 <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
 <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
 <20150220085151.3b599de8@bbrezillon>
 <E7DD67EB-CA34-48EA-838D-3EBBF74CAEBD@jcrosoft.com>
 <20150220181640.57b21432@bbrezillon>
 <20150220180646.GA26698@roeck-us.net>
 <54EAD6E5.8090104@offcode.fi>
 <20150223095154.63218331@bbrezillon>
 <54EAEECA.80803@offcode.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EAEECA.80803@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 23, 2015 at 11:11:38AM +0200, Timo Kokkonen wrote:
[ ... ]

> 
> After all, we do have already watchdog_init_timeout function that parses the
> watchdog timeout argument from either device tree or from command line. How
> about if we expanded that interface? Maybe have a more generic
> watchdog_init_parmas() or something that parses the generic watchdog
> arguments, either from command line, device tree or ACPI or something. The
> device driver could replace call from watchdog_init_timeout() to
> watchdog_init_params() once it is ready to support other generic parameters,
> such as early-timeout-sec. Then the watchdog driver could do the right thing
> about whether watchdog should be left running or stopped and how long time
> should be given.
> 
Good idea.

> Alternatively, we could also let the watchdog core know a little more about
> the actual watchdog hardware, such as whether the HW is stoppable, whether
> it needs manual pinging by the kernel until user space has taken over. Or

Yes, all that will be needed. But, still, the stop-gap is that we'll need to
get buyin from the DT folks for the necessary properties. I have had the
outline for the necessary watchdog core implementation in my mind for a long
time, but I just don't have the time (nor the patience, quite frankly)
to get DT buyin.

> maybe we can just extend the timeout values until the user space has first
> opened it and then shorten the timeout automatically so that it doesn't take
> that long for the device to reset after a crash. Or some other behaviour
> that is common to many users. Suggestions are welcome.
> 
> Anyway, that is something that needs to be done to make watchdog core take
> more control over more of the generic watchdog behaviour. It just needs to
> be done so that we don't need to convert all drivers at once.
> 
Correct. It should not be that difficult do do that if designed properly.

Guenter
