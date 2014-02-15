Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:57706 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751174AbaBOI0r (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 03:26:47 -0500
Date: Sat, 15 Feb 2014 09:26:30 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v7 00/18] Armada 370/XP watchdog
Message-ID: <20140215082630.GJ1484@spo001.leaseweb.com>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com> <20140211083122.GB3687@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140211083122.GB3687@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Ezequiel,

> On Mon, Feb 10, 2014 at 08:00:19PM -0300, Ezequiel Garcia wrote:
> > Yet another round. This time, addressing Guenter's comment about the nowayout
> > parameter. So, to allow for proper nowayout behavior, we now restrict the
> > initial watchdog stop; which is only done if the watchdog is not properly
> > enabled.
> > 
> > I've dropped the clocksource patch which was previously part of the series.
> > The patch is independent and will be merged through the subsystem maintainer,
> > Daniel Lezcano.
> > 
> > Also, I've updated the multi_v7_defconfig, as per Jason Cooper request.
> > 
> > This series depends on Sebastian's irqchip fixes to clear the bridge irqs
> > cause, which Jason picked here:
> > 
> >   http://git.infradead.org/linux-mvebu.git mvebu-next/irqchip-fixes
> > 
> > Wim: Can we take all the watchdog changes through mvebu, with your Ack?
> > This way, we can sort out the irqchip dependency.
> > 
> 
> Wim: Do you have any comments about these patches?

Will review on monday. But agree that if patches are OK that they should go via mvebu.

Kind regards,
Wim.

