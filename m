Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53863 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbaCGOhQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Mar 2014 09:37:16 -0500
Message-ID: <5319D99A.50003@roeck-us.net>
Date: Fri, 07 Mar 2014 06:37:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>, Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog <linux-watchdog@vger.kernel.org>
Subject: Re: Watchdog drivers and device driver model
References: <1394199268.4376.50.camel@chaos.site>
In-Reply-To: <1394199268.4376.50.camel@chaos.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/07/2014 05:34 AM, Jean Delvare wrote:
> Hi Wim and all,
>
> While investigating a customer case, it occurred to me that it is not
> always possible to figure out which driver is handling /dev/watchdog.
> For some drivers, /sys/dev/char/10:130 is a symbolic link
> to /sys/devices/virtual/misc/watchdog, and that virtual device says
> nothing about the physical device nor the device driver.
>
> As far as I can see, this happens whenever the dev.parent field of the
> watchdog_device structure isn't set before calling
> watchdog_register_device(). Couldn't we make setting this field
> mandatory, so that it is always possible to get to the physical device?
> It seems that only a minority of watchdog drivers are doing it properly
> at the moment.
>
> Also, it seems to me that at least in some cases, the parent device that
> is set isn't the right one. I am looking at the iTCO_wdt driver, it puts
> the PCI device as the parent, however the driver itself is a platform
> driver so it is attached to the iTCO_wdt platform device. That makes it
> impossible to find which driver is handling /dev/watchdog in an
> automated way: both /sys/dev/char/10:130
> and /sys/class/watchdog/watchdog0 point to the PCI device, which has
> driver "lpc_ich" attached, not "iTCO_wdt". One has to enter the iTCO_wdt
> directory there to find the proper driver. May I suggest that dev.parent
> should point to the iTCO_wdt platform device in that case?
>
Good idea. I've had trouble identifying watchdogs myself, and it would
be great to have a reliable means to do it.

> If you need some background: my customer needs to unload the native
> watchdog driver and use the IPMI watchdog instead. So they need a
> reliable way to figure out who is handling /dev/watchdog so that they
> can unload the right module. This is rather difficult, costly and
> fragile with the way things are currently implemented.
>

Another solution in that specific case would be to convert the ipmi
watchdog driver to the watchdog API. Then it could be loaded in parallel
with other watchdog drivers. Of course, the naming problem would still
exist.

Guenter

