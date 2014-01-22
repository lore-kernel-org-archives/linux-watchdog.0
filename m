Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:35275 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755818AbaAVSOQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 13:14:16 -0500
Date: Wed, 22 Jan 2014 11:14:09 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a
 separate resource
Message-ID: <20140122181409.GV18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233321.GR18269@obsidianresearch.com>
 <3176358.2QFcJHj0fv@wuerfel>
 <20140122162136.GA27273@localhost>
 <20140122180100.GE27273@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140122180100.GE27273@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 22, 2014 at 03:01:01PM -0300, Ezequiel Garcia wrote:
> On Wed, Jan 22, 2014 at 01:21:36PM -0300, Ezequiel Garcia wrote:
> > > I don't see a good way out that would preserve backwards compatibility,
> > > other than hardcoding the physical address in the driver, which seems
> > > just as bad as breaking compatibility. That said, it is always the
> > > same constant (0xf1000000 + 0x20000 + 0x0108) on Dove, Kirkwood and
> > > Orion5x (not on mv78xx0, but that doesn't use the wdt), so hardcoding
> > > a fallback would technically work, but we should print a fat warning at
> > > boot time if we actually fall back to that.
> > > 
> > 
> > Yes, I was thinking just about this. Namely:
> > 
> [..]
> 
> How about something like this?

I liked Arnd's idea to use an offset from the first register. With the
mbus driver we can now actually change the 0xF1.. prefix via the DT.

> +	dev_warn(&pdev->dev, "falling back to harcoded RSTOUT reg 0x%x\n",
> +		 ORION_RSTOUT_MASK);

Maybe:
dev_warn(&pdev->dev, FW_BUG "falling back to harcoded RSTOUT reg 0x%x\n",

?

> @@ -139,10 +166,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
>  	if (!wdt_reg)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!res)
> -		return -ENODEV;
> -	wdt_rstout = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	wdt_rstout = try_compat_rstout_ioremap(pdev);
>  	if (!wdt_rstout)
>  		return -ENOMEM;

ENOMEM is probably not the right errno? Is there a standard errno for
malformed DT?

Jason
