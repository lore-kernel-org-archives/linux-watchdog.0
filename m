Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53762 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbdKFTEX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 6 Nov 2017 14:04:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id r196so16397609wmf.2
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Nov 2017 11:04:23 -0800 (PST)
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 0/2] xen_wdt: use the watchdog subsystem
Date: Mon,  6 Nov 2017 19:04:10 +0000
Message-Id: <20171106190412.10023-1-rrendec@arista.com>
In-Reply-To: <20171106180416.GA12199@roeck-us.net>
References: <20171106180416.GA12199@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2017-11-06 at 10:04 -0800, Guenter Roeck wrote:
> On Mon, Nov 06, 2017 at 05:39:03PM +0000, Radu Rendec wrote:
> > I see your point, but I think module_platform_driver_probe() can't be
> > used here. The problem is that there's nothing else to create the
> > platform device, so if xen_wdt doesn't create it on its own, there will
> > be no (matching) platform device to be probed by the driver that
> > xen_wdt registers.
[snip]
> > I already fixed the other issues in the previous patch so, unless you
> > think init/exit can be simplified in a different way, I am ready to
> > resend the (updated) patches.
> >
>
> Ok; thanks for having a look.

You're welcome. Attaching the updated patches.

By the way, I tried to replace pr_* with dev_* but then the messages
look kind of funny, e.g.
wdt wdt: initialized (timeout=60s, nowayout=0)
instead of:
xen_wdt: initialized (timeout=60s, nowayout=0)

I thought this would be more confusing than useful to the user, so I
reverted back to pr_*.

Thanks,
Radu


Radu Rendec (2):
  watchdog: xen_wdt: use the watchdog subsystem
  watchdog: xen_wdt: remove info message and version number

 drivers/watchdog/xen_wdt.c | 243 +++++++++------------------------------------
 1 file changed, 49 insertions(+), 194 deletions(-)

-- 
2.13.6

