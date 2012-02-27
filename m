Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34651 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab2B0RYv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Feb 2012 12:24:51 -0500
Date: Mon, 27 Feb 2012 18:24:43 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>, kernel@pengutronix.de
Subject: Re: [PATCH 1/3] mfd: Add basic support for the Congatec CGEB BIOS
 interface
Message-ID: <20120227172443.GD3852@pengutronix.de>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
 <1328102793-4313-2-git-send-email-s.hauer@pengutronix.de>
 <20120220163927.GY5387@sortiz-mobl>
 <20120220180752.GV3852@pengutronix.de>
 <20120227135827.GM27687@sortiz-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120227135827.GM27687@sortiz-mobl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 27, 2012 at 02:58:27PM +0100, Samuel Ortiz wrote:
> Hi Sascha,
> 
> 
> On Mon, Feb 20, 2012 at 07:07:52PM +0100, Sascha Hauer wrote:
> > Hi Samuel,
> > 
> > On Mon, Feb 20, 2012 at 05:39:27PM +0100, Samuel Ortiz wrote:
> > > Hi Sascha,
> > > 
> > > On Wed, Feb 01, 2012 at 02:26:31PM +0100, Sascha Hauer wrote:
> > > > The Congatec CGEB is a BIOS interface found on some Congatec x86
> > > > modules. It provides access to on board peripherals like I2C busses
> > > > and watchdogs. This driver contains the basic support for accessing
> > > > the CGEB interface and registers the child devices.
> > > After looking at the code, I'm not entirely sure this one belongs to
> > > drivers/mfd/. Have you thought about putting it under arch/x86/platform/ ?
> > > There are similar examples there, like uv or olpc.
> > 
> > I don't mind putting it in arch/x86/platform instead. I'm an ARM guy and
> > on ARM there currently is a rush to move everything looking remotely
> > like a driver out of arch/arm/ to drivers/, so putting it under
> > drivers/mfd/ seemed logical to me.
> Yes, this seems to be the trend apparently. Could you try pushing that into
> the x86/platform, please ? If they put you under fire, I guess I could take
> this patchset. But they have several "BIOS interfaces" there already...

Ok, I'll put on my asbestos suit and give it a try.

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
