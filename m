Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:41229 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756841AbaCSWVb (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Mar 2014 18:21:31 -0400
Date: Wed, 19 Mar 2014 16:21:22 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v3 0/8] Watchdog support for Armada 375/38x SoC
Message-ID: <20140319222122.GB1154@obsidianresearch.com>
References: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140312214312.GA14357@obsidianresearch.com>
 <20140312215456.GA13340@arch.cereza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140312215456.GA13340@arch.cereza>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 12, 2014 at 06:54:56PM -0300, Ezequiel Garcia wrote:
> On Mar 12, Jason Gunthorpe wrote:
> > On Wed, Mar 12, 2014 at 06:11:47PM -0300, Ezequiel Garcia wrote:
> > 
> > > I've pushed a branch so people can test this easily, e.g. ensuring
> > > no regressions on Dove, Kirkwood and A370/XP:
> > > 
> > > https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_a385_a375_v3
> > 
> > This branch worked for me, the watchdog functioned as expected.
> > 
> 
> Good to hear. Is that a Tested-by on Kirkwood?

Yes, sorry for the delay

> > I got these two oddball messages during boot though:
> > 
> > irq: Cannot allocate irq_descs @ IRQ26, assuming pre-allocated
> > irq: Cannot allocate irq_descs @ IRQ61, assuming pre-allocated
> > 
> > Probably unrelated to the watchdog.. Unfortunately I've run out of
> > time right now to investigate.
> > 
> 
> Probably. That branch is based on some mvebu/for-next tip, which has all
> the watchdog and devicetree dependencies for this patchset to apply.
> 
> I can re-send a series based on v3.15-rc1 and we can check again; maybe
> we're just missing some irq patch.

I quickly re-checked and 3.14.0-rc7 doesn't print these messages..

I can review again when 3.15-rc1 comes out.

Jason
