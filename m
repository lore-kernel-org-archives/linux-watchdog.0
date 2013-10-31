Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39723 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752334Ab3JaIIr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 04:08:47 -0400
Date: Thu, 31 Oct 2013 09:08:37 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: add module device table
Message-ID: <20131031080837.GE5261@spo001.leaseweb.com>
References: <E1VbfdE-0003gA-4q@rmk-PC.arm.linux.org.uk> <20131031004338.GA20335@roeck-us.net> <20131031004815.GT16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131031004815.GT16735@n2100.arm.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Russel,

> > > Add the module device table declaration so the module can be loaded
> > > automatically at boot time.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Hi Russell,
> > 
> > Wim should have this patch in his queue already, as 'watchdog: imx2_wdt:
> > expose module alias for loading from device-tree', submitted by Niels
> > de Vos back in July.
> 
> Any reason it hasn't made it in yet?  We had a merge window back in
> September where, if we're not happy to apply it as a fix during -rc,
> it could have gone in.  I see watchdog stuff did merge during the
> last merge window...

Lack of time due to an outsourcing project at a customer of mine.

But the patch is indeed in linux-watchdog-next now.

Kind regards,
Wim.

