Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46085 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbdKFRjG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 6 Nov 2017 12:39:06 -0500
Received: by mail-wm0-f47.google.com with SMTP id r68so15475259wmr.1
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Nov 2017 09:39:05 -0800 (PST)
Message-ID: <1509989943.7709.20.camel@arista.com>
Subject: Re: [2/2] watchdog: xen_wdt: remove info message and version number
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Date: Mon, 06 Nov 2017 17:39:03 +0000
In-Reply-To: <20171105153910.GA28756@roeck-us.net>
References: <20171103153153.9992-3-rrendec@arista.com>
         <20171105153910.GA28756@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, 2017-11-05 at 07:39 -0800, Guenter Roeck wrote:
> On Fri, Nov 03, 2017 at 03:31:53PM +0000, Radu Rendec wrote:
> > The initial info message (early in the xen_wdt_init_module() function)
> > is not very useful and we already have a message on successful probe. If
> > the probe fails, additional messages are printed anyway.
> > 
> > The version number serves no useful purpose and it ran out of favor
> > upstream anyway.
> > 
> 
> As I mentioned in the other patch, any chance to use
> module_platform_driver_probe() ? The
> 
> 	if (!xen_domain())
> 		return -ENODEV;
> 
> could be moved there.

I see your point, but I think module_platform_driver_probe() can't be
used here. The problem is that there's nothing else to create the
platform device, so if xen_wdt doesn't create it on its own, there will
be no (matching) platform device to be probed by the driver that
xen_wdt registers.

I looked at module_platform_driver_probe() and it's a convenience macro
that ultimately calls __platform_driver_probe(). The latter is just
__platform_driver_register() with some additional tricks around the
probe function.

The current version works because platform_device_register_simple()
(called by the module init function) conveniently allocates and
registers a matching platform device.

Looking at platform_device.h, I don't see any other macros that we
could use instead.

I already fixed the other issues in the previous patch so, unless you
think init/exit can be simplified in a different way, I am ready to
resend the (updated) patches.

Thanks,
Radu

