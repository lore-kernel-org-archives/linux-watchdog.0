Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47147 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965286AbdAILE2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jan 2017 06:04:28 -0500
Date: Mon, 9 Jan 2017 12:04:20 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] watchdog: imx2: handle WMCR only being available on
 i.MX35 and later
Message-ID: <20170109110420.atgdqwin77iheb5g@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <19492fdf-a0f7-8525-f955-8c9136575659@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19492fdf-a0f7-8525-f955-8c9136575659@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Vladimir,

On Mon, Jan 09, 2017 at 12:55:28PM +0200, Vladimir Zapolskiy wrote:
> On 01/09/2017 11:50 AM, Uwe Kleine-König wrote:
> > Hello,
> > 
> > this is my approach to fix the issue reported by Vladimir Zapolskiy.
> > 
> > IMHO we don't need the third commit because I'm convinced most machines
> > just don't do anything when the WDOG signal becomes active. An affected
> > machine powers off 16 seconds after startup. This would be noticed
> > during development of the bootloader and so I assume all affected
> > machines having bootloaders that make the compat code unimportant.
> > 
> > If you want to know if your machine is affected, do:
> > 
> > 	mw -w $(watchdog_base_addr) 0x10
> 
> is it a command in barebox shell?

barebox cannot do $(watchdog_base_addr), but (on i.MX25) I can do:

	mw -w 0x53fdc000 0x10

. I think the corresponding U-Boot command is:

	mw.w 0x53fdc000 0x10

> > The machines I tested this on (among a few customer boards a
> > Phycore i.MX35 and a Freescale i.MX53 Quick Start Board) don't power off.
> > 
> > I don't have manuals handy for ls1021a, ls1043a and ls1046a but assume
> > they use the i.MX35 type, too. This needs to be fixed before this series
> > is applied.
> > 
> > Compared to Vladimir's patch machines still using board files are fixed,
> > too.
> > 
> 
> This addition can be done on top of my changes, in my version the driver
> ignores WMCR on all machines with board files.
> 
> So now we have two competing series unfortunately...

With mine being the better one, right? :-) 

You didn't update your series for my concerns, so I did it myself
instead of retrying to iterate about the changes I'd like to see on your
version. Feel free to criticise my variant.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
