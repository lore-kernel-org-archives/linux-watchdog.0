Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62160 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbbD0JSj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 05:18:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
	Eric Anholt <eric@anholt.net>, linux-watchdog@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-rpi-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to the WDT driver.
Date: Mon, 27 Apr 2015 11:18:25 +0200
Message-ID: <2979294.WseZH0BUZW@wuerfel>
In-Reply-To: <553D05DD.8080300@roeck-us.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <12253069.Jm7LIDAreu@wuerfel> <553D05DD.8080300@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sunday 26 April 2015 08:35:57 Guenter Roeck wrote:
> On 04/25/2015 01:11 PM, Arnd Bergmann wrote:
> > On Friday 24 April 2015 12:08:54 Eric Anholt wrote:
> >> +/*
> >> + * We can't really power off, but if we do the normal reset scheme, and
> >> + * indicate to bootcode.bin not to reboot, then most of the chip will be
> >> + * powered off.
> >> + */
> >> +static void bcm2835_power_off(void)
> >> +{
> >> +       struct device_node *np =
> >> +               of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
> >> +       struct platform_device *pdev = of_find_device_by_node(np);
> >> +       struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
> >> +       u32 val;
> >> +
> >
> > Instead of doing the lookup again here, I'd suggest using a static variable
> > in the driver to store the device pointer for the device used on power_off.
> >
> > Make sure that the device remove callback assigns it back to NULL though
> > and that the function checks for NULL pointer.
> >
> 
> Why would that be needed ?

devices can be unbound from drivers through sysfs, or using dynamic DT
updates. If one does that, the watchdog driver will correctly destroy
all information it has about the device, so if the power_off function
still uses that pointer, it will crash.

	Arnd
