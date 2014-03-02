Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:60309 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751622AbaCBJnZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 2 Mar 2014 04:43:25 -0500
Date: Sun, 2 Mar 2014 10:43:23 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: core: module param to activate watchdog
Message-ID: <20140302094323.GS1484@spo001.leaseweb.com>
References: <1393604183-8755-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393604183-8755-1-git-send-email-mpa@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Markus,

> Many watchdog driver reset the watchdog device on initialization. This
> is a problem if the watchdog is activated by the bootloader and should
> be active the whole time until the userspace can write to it.
> 
> This patch adds a module parameter (watchdog.activate_first) that
> activates the first registered watchdog. Using this parameter it is
> possible to have an active watchdog during the whole boot process.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

NAK. It is the responsibility of the watchdog device driver to do this
and not that of the core. The core can't know which device(s) are 
running and can't be turned off. So you can have more then 1 device 
that needs to keep going...

The normal way do this is by using a timer. Take a look at 
at91sam9_wdt.c . We have a timer there that pings the watchdog if
1) the watchdog device is not active for userspace (so before opening
/dev/watchdog and after clossing /dev/watchdog correctly)
2) pings 1/2 or 1/4 of the watchdog heartbeat time as long as the
userspace ping keeps going. (Else it will expire and you trigger a 
reboot).
(Note: the heartbeat is the period after which a watchdog hardware
device will trigger a reboot, timeout is the period for userspace.
So for most devices heartbeat and timeout are the same, but for 
devices where a timer is used (we also use it if the heartbeat value
is too small (i.e. 1 second)) the values have a different meaning.)

So the logic for a watchdog device driver is:
at startup the watchdog device driver should make sure that a reboot
can only occur when /dev/watchdog is open. This means that if a
watchdog device is active at boot it should either be stopped (that's
why most drivers have a stop in their init/probe function) or have a 
timer that pings the watchdog as long as it is not active for 
userspace (like at91sam9_wdt.c, via_wdt.c, pika_wdt.c, ...)

Kind regards,
Wim.

