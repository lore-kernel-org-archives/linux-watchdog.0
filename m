Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35783 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754717AbdKOPeo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 15 Nov 2017 10:34:44 -0500
Received: by mail-wm0-f66.google.com with SMTP id y80so3790255wmd.0
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Nov 2017 07:34:43 -0800 (PST)
Message-ID: <1510760080.27053.9.camel@arista.com>
Subject: Re: [PATCH v3 1/2] watchdog: xen_wdt: use the watchdog subsystem
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Date: Wed, 15 Nov 2017 15:34:40 +0000
In-Reply-To: <20171115145829.GA18395@roeck-us.net>
References: <20171114162350.24283-1-rrendec@arista.com>
         <20171114162350.24283-2-rrendec@arista.com>
         <20171115145829.GA18395@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 2017-11-15 at 06:58 -0800, Guenter Roeck wrote:
> On Tue, Nov 14, 2017 at 04:23:49PM +0000, Radu Rendec wrote:
> > diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
> > index 5dd5c3494d55..4e00419bd47d 100644
> > --- a/drivers/watchdog/xen_wdt.c
> > +++ b/drivers/watchdog/xen_wdt.c
> > @@ -9,9 +9,8 @@
> >   *	2 of the License, or (at your option) any later version.
> >   */
> >  
> > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > -
> > -#define DRV_NAME	"wdt"
> > +#define DRV_NAME	"xen_wdt"
> > +#define DEV_NAME	"watchdog"
> 
> [ ... ]
> 
> >  
> > +static const struct platform_device_id xen_wdt_id_table[] = {
> > +	{ .name	= DEV_NAME },
> 
> I understand we are way into bikeshedding territory, and I was inclined
> to let this just go, but this is way too generic for a platform device
> ID, sorry.

Yes, that's the part I don't like about it either. So I think we're on
the same page here :)

FWIW, the old (current) version has the same problem, because in the
absence of an id_table (or a matching entry), platform_match() matches
against the driver name, which is just "wdt".

Anyway, how about using "xwdt0" for DEV_NAME? The driver supports only
one device by design, so adding "0" should be fine.

Thanks,
Radu

