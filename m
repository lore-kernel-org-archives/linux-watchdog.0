Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52238 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbcAOLVU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jan 2016 06:21:20 -0500
Message-ID: <5698D62C.1020106@arm.com>
Date: Fri, 15 Jan 2016 11:21:16 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: watchdog max63xx driver doesn't match datasheet?
References: <20160115104936.GA4778@pengutronix.de>
In-Reply-To: <20160115104936.GA4778@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 15/01/16 10:49, Uwe Kleine-König wrote:
> Hello Marc,
> 
> when comparing the driver drivers/watchdog/max63xx_wdt.c (in Linux 4.4)
> with the datasheet
> https://datasheets.maximintegrated.com/en/ds/MAX6369-MAX6374.pdf I
> wonder if I have a different documentation that you had back in 2009
> when you wrote the driver. According to "my" datasheet these chips have
> 3 logic inputs SET1, SET2 and SET3 and depending on these the timeout is
> configured. In your driver however you do:
> 
> 	wdt->base = devm_ioremap_resource(&p->dev, mem);
> 
> and to select the timeout you write a byte to this address.
> 
> The driver seems to be used in arch/arm/mach-ixp4xx/vulcan-setup.c and
> arch/arm/mach-pxa/zeus.c and I guess there the device sits behind some
> hardware that sets an output for each bit set in the respective
> register.

Exactly. The driver states in the top comment section:

 * This driver assumes the watchdog pins are memory mapped (as it is
 * the case for the Arcom Zeus). Should it be connected over GPIOs or
 * another interface, some abstraction will have to be introduced.


> Did I get this right? If so, a patch to extend the driver to have a
> binding like:
> 
> 	{
> 		compatible = "maxim,max6371";
> 		set-gpios = <&gpio1 12 0>, ...;
> 		wdi-gpios = <&gpio3 ...>, ...;
> 	}
> 
> would be fine, right?

Perfectly fine by me. And if you want to make sure you didn't break the
existing setups, you are welcome to get my boards... ;-)

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
