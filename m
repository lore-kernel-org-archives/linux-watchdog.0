Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46751 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753377AbcAOOVp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jan 2016 09:21:45 -0500
Date: Fri, 15 Jan 2016 15:21:43 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: watchdog max63xx driver doesn't match datasheet?
Message-ID: <20160115142143.GL24441@pengutronix.de>
References: <20160115104936.GA4778@pengutronix.de>
 <5698D62C.1020106@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5698D62C.1020106@arm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Marc,

On Fri, Jan 15, 2016 at 11:21:16AM +0000, Marc Zyngier wrote:
> On 15/01/16 10:49, Uwe Kleine-König wrote:
> > Hello Marc,
> > 
> > when comparing the driver drivers/watchdog/max63xx_wdt.c (in Linux 4.4)
> > with the datasheet
> > https://datasheets.maximintegrated.com/en/ds/MAX6369-MAX6374.pdf I
> > wonder if I have a different documentation that you had back in 2009
> > when you wrote the driver. According to "my" datasheet these chips have
> > 3 logic inputs SET1, SET2 and SET3 and depending on these the timeout is
> > configured. In your driver however you do:
> > 
> > 	wdt->base = devm_ioremap_resource(&p->dev, mem);
> > 
> > and to select the timeout you write a byte to this address.
> > 
> > The driver seems to be used in arch/arm/mach-ixp4xx/vulcan-setup.c and
> > arch/arm/mach-pxa/zeus.c and I guess there the device sits behind some
> > hardware that sets an output for each bit set in the respective
> > register.
> 
> Exactly. The driver states in the top comment section:
> 
>  * This driver assumes the watchdog pins are memory mapped (as it is
>  * the case for the Arcom Zeus). Should it be connected over GPIOs or
>  * another interface, some abstraction will have to be introduced.

Ah, it seems I didn't look deep enough into this driver. So we agree
here.

> > Did I get this right? If so, a patch to extend the driver to have a
> > binding like:
> > 
> > 	{
> > 		compatible = "maxim,max6371";
> > 		set-gpios = <&gpio1 12 0>, ...;
> > 		wdi-gpios = <&gpio3 ...>, ...;
> > 	}
> > 
> > would be fine, right?
> 
> Perfectly fine by me. And if you want to make sure you didn't break the
> existing setups, you are welcome to get my boards... ;-)

Looking through the board files, I think I'm not interested in pre-dt
ARMv5, thanks. I think we can save the postage, thanks. When (and if) I
address the problem I think I can manage keeping them functional even
without the hardware. (But if you want to dust off your old boards
you're welcome to test the patches of course.)

If however you have a spare board with a fast processor, S-ATA, DVB-C,
much RAM and a big touch screen, then I would invest the postage :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
