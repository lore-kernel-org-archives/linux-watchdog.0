Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34655 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437AbaBQTda (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Feb 2014 14:33:30 -0500
Date: Mon, 17 Feb 2014 14:33:25 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-watchdog@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [RESEND/PATCH v7 00/18] Armada 370/XP SoC watchdog support
Message-ID: <20140217193325.GX7862@titan.lakedaemon.net>
References: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140217192948.GK1484@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140217192948.GK1484@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 17, 2014 at 08:29:48PM +0100, Wim Van Sebroeck wrote:
> Hi All,
> 
> > Hi Jason, Andrew,
> > 
> > This patchset adds watchdog support for the Armada 370/XP ARM SoCs.
> > The series was sent seven times:
> > 
> > [v1] http://archive.arm.linux.org.uk/lurker/message/20130827.143424.4e961f2b.ca.html
> > [v2] http://www.spinics.net/lists/arm-kernel/msg302104.html
> > [v3] http://www.spinics.net/lists/arm-kernel/msg302245.html
> > [v4] http://www.spinics.net/lists/arm-kernel/msg302602.html
> > [v5] http://www.spinics.net/lists/arm-kernel/msg303349.html
> > [v6] http://www.spinics.net/lists/arm-kernel/msg305547.html
> > [v7] http://www.spinics.net/lists/arm-kernel/msg306534.html
> > 
> > As you can see, it received numerous feedback, testing and reviews;
> > we've finally reached agreement and so we'd like to merge this series for
> > v3.15, if at all possible.
> > 
> > However, the watchdog subsystem maintainer remained completely silent through
> > the *entire* life of this patchset, and so we've no idea what are his plans
> > about it.
> > 
> > Do you think this can be merged through Andrew's tree? Or maybe through
> > Jason Cooper's so the irqchip dependency is easily handled?
> > 
> > Thanks a lot!
> > 
> > Original cover letter
> > =====================
> > 
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
> 
> I reviewed all patches and you have an Acked-by from me on all of them.

Thanks, Wim!

thx,

Jason.
