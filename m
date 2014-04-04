Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:37931 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753075AbaDDUHi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Apr 2014 16:07:38 -0400
Date: Fri, 4 Apr 2014 22:07:30 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Anatolij Gustschin <agust@denx.de>,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawn.guo@linaro.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: handle enabled watchdog properly
Message-ID: <20140404200730.GB1484@spo001.leaseweb.com>
References: <1396623242-15234-1-git-send-email-agust@denx.de> <20140404152011.GC5529@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140404152011.GC5529@katana>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

> On Fri, Apr 04, 2014 at 04:54:01PM +0200, Anatolij Gustschin wrote:
> > If the watchdog is already enabled (e.g. started by the boot loader),
> > we need to handle this case properly and start reloading the watchdog
> > time-out counter as frequently as needed.
> > 
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> 
> Uh, this driver has not been converted to use the watchdog framework
> yet? I'd suggest this should be the first step.
> 
> @Wim: Does the watchdog core already handle the case that the wdt might
> have been started by the bootloader?

There is nothing for that in the core. And I think that it makes no sense to put this in the core.
It's something you have to take care of during init/probe and that is driver specific.
See also this message: http://www.spinics.net/lists/linux-watchdog/msg04066.html .

Kind regards,
Wim.

