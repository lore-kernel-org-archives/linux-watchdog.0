Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:53935 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753146Ab3GEVDW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Jul 2013 17:03:22 -0400
Date: Fri, 5 Jul 2013 23:03:21 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	guenter@roeck-us.net
Subject: Re: [PATCH RESEND v10 2/2] watchdog: Sysfs interface for MEN A21 watchdog
Message-ID: <20130705210321.GB10354@spo001.leaseweb.com>
References: <20130618151939.GA23296@jtlinux> <20130618152119.GA23399@jtlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130618152119.GA23399@jtlinux>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Johannes,

> This patch adds a sysfs interface for the watchdog
> device found on MEN A21 Boards.
> 
> The newly generated files are:
> * rebootcause:
> Can be one of:
> Power on Reset,
> CPU Reset Request,
> Push Button,
> FPGA Reset Request,
> Watchdog,
> Local Power Bad,
> Invalid or
> BDI
> and shows the reason of the boards last reboot.
> 
> * active:
> Shows if the watchdog CPLD is actually running
> 
> * allow_disable:
> Shows if the watchdog is allowed to be disabled (NOWAYOUT disabled)

allow_disable should be nowayout because that is the general watchdog
parameter we will have for all watchdog drivers.

> * fastmode:
> Shows if the CPLD is running in fast mode (1s timeout), once it is in
> fastmode it can't be switched back to slow mode (30s timeout) until the
> next reboot.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>

I will not add this patch and put it in my waiting queue.
Reason: we should first do the sysfs stuff for the wwatchdog_core (since
active and nowayout are parameters that will be in the sysfs watchdog core).

Kind regards,
Wim.

