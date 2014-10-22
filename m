Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47902 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932743AbaJVWzc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 18:55:32 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xh4oV-000MSd-KJ
	for linux-watchdog@vger.kernel.org; Wed, 22 Oct 2014 22:55:31 +0000
Date: Wed, 22 Oct 2014 15:54:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-watchdog@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] watchdog: orion: Use the reference clock on Armada
 375 SoC
Message-ID: <20141022225459.GB20733@roeck-us.net>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413984884-20273-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022140221.GP9845@lunn.ch>
 <54483297.90102@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54483297.90102@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 22, 2014 at 07:41:27PM -0300, Ezequiel Garcia wrote:
> On 10/22/2014 11:02 AM, Andrew Lunn wrote:
> > On Wed, Oct 22, 2014 at 10:34:42AM -0300, Ezequiel Garcia wrote:
> >> The 25 MHz reference clock has better stability so its use is preferred over the
> >> core clock. Changes the Armada 375 clock initialization to use this reference
> >> clock. To ensure the driver is compatible with an old devicetree, also provide
> >> a fallback path which will silently return to the previous behavior.
> > 
> > Hi Ezequiel
> > 
> > There is now quite a lot of code in orion_wdt.c which is not relevant
> > to Orion5x and Kirkwood. Would it be possible to put some of it inside
> > a #ifdef MACH_MVEBU_V7?
> > 
> 
> Hum.. I found ifdefs scary, so I tend to avoid them if at all possible.
> Just did a quick hack enclosing all the armada-xxx stuff around #if 0
> and here's the result:
> 
> $ ./scripts/bloat-o-meter ~/linux/.builds/mvebu_v7/drivers/watchdog/orion_wdt.o ~/linux/.builds/orion5x/drivers/watchdog/orion_wdt.o
> add/remove: 0/0 grow/shrink: 1/4 up/down: 12/-80 (-68)
> function                                     old     new   delta
> orion_wdt_probe                              732     744     +12
> orion_wdt_get_timeleft                        44      40      -4
> orion_enabled                                 68      60      -8
> orion_start                                  120      88     -32
> orion_wdt_ping                                80      44     -36
> 
> To be honest, I don't think it's worth the ugliness.

I agree, especially since each #ifdef means that some code may not be compiled
and errors are easier to creep into the code.

Guenter
