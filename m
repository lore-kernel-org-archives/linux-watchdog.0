Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59822 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755061AbcAOKti (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jan 2016 05:49:38 -0500
Date: Fri, 15 Jan 2016 11:49:36 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: watchdog max63xx driver doesn't match datasheet?
Message-ID: <20160115104936.GA4778@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Marc,

when comparing the driver drivers/watchdog/max63xx_wdt.c (in Linux 4.4)
with the datasheet
https://datasheets.maximintegrated.com/en/ds/MAX6369-MAX6374.pdf I
wonder if I have a different documentation that you had back in 2009
when you wrote the driver. According to "my" datasheet these chips have
3 logic inputs SET1, SET2 and SET3 and depending on these the timeout is
configured. In your driver however you do:

	wdt->base = devm_ioremap_resource(&p->dev, mem);

and to select the timeout you write a byte to this address.

The driver seems to be used in arch/arm/mach-ixp4xx/vulcan-setup.c and
arch/arm/mach-pxa/zeus.c and I guess there the device sits behind some
hardware that sets an output for each bit set in the respective
register.

Did I get this right? If so, a patch to extend the driver to have a
binding like:

	{
		compatible = "maxim,max6371";
		set-gpios = <&gpio1 12 0>, ...;
		wdi-gpios = <&gpio3 ...>, ...;
	}

would be fine, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
