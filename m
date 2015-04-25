Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62701 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbDYUL7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 Apr 2015 16:11:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Eric Anholt <eric@anholt.net>, linux-watchdog@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-rpi-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to the WDT driver.
Date: Sat, 25 Apr 2015 22:11:40 +0200
Message-ID: <12253069.Jm7LIDAreu@wuerfel>
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <1429902534-2348-2-git-send-email-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 24 April 2015 12:08:54 Eric Anholt wrote:
> +/*
> + * We can't really power off, but if we do the normal reset scheme, and
> + * indicate to bootcode.bin not to reboot, then most of the chip will be
> + * powered off.
> + */
> +static void bcm2835_power_off(void)
> +{
> +       struct device_node *np =
> +               of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
> +       struct platform_device *pdev = of_find_device_by_node(np);
> +       struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
> +       u32 val;
> +

Instead of doing the lookup again here, I'd suggest using a static variable
in the driver to store the device pointer for the device used on power_off.

Make sure that the device remove callback assigns it back to NULL though
and that the function checks for NULL pointer.

Aside from this, the patch looks great.

	Arnd
