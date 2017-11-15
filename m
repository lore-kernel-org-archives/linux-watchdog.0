Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44218 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757938AbdKOSV4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 15 Nov 2017 13:21:56 -0500
Received: by mail-pg0-f68.google.com with SMTP id 4so9693354pge.1
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Nov 2017 10:21:56 -0800 (PST)
Date: Wed, 15 Nov 2017 10:21:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 1/2] watchdog: xen_wdt: use the watchdog subsystem
Message-ID: <20171115182153.GA5138@roeck-us.net>
References: <20171114162350.24283-1-rrendec@arista.com>
 <20171114162350.24283-2-rrendec@arista.com>
 <20171115145829.GA18395@roeck-us.net>
 <1510760080.27053.9.camel@arista.com>
 <20171115162612.GB29282@roeck-us.net>
 <1510764388.27053.22.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510764388.27053.22.camel@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 15, 2017 at 04:46:28PM +0000, Radu Rendec wrote:
> On Wed, 2017-11-15 at 08:26 -0800, Guenter Roeck wrote:
> > On Wed, Nov 15, 2017 at 03:34:40PM +0000, Radu Rendec wrote:
> > > On Wed, 2017-11-15 at 06:58 -0800, Guenter Roeck wrote:
> > > > On Tue, Nov 14, 2017 at 04:23:49PM +0000, Radu Rendec wrote:
> > > > > diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
> > > > > index 5dd5c3494d55..4e00419bd47d 100644
> > > > > --- a/drivers/watchdog/xen_wdt.c
> > > > > +++ b/drivers/watchdog/xen_wdt.c
> > > > > @@ -9,9 +9,8 @@
> > > > >   *	2 of the License, or (at your option) any later version.
> > > > >   */
> > > > >  
> > > > > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > > -
> > > > > -#define DRV_NAME	"wdt"
> > > > > +#define DRV_NAME	"xen_wdt"
> > > > > +#define DEV_NAME	"watchdog"
> > > > 
> > > > [ ... ]
> > > > 
> > > > >  
> > > > > +static const struct platform_device_id xen_wdt_id_table[] = {
> > > > > +	{ .name	= DEV_NAME },
> > > > 
> > > > I understand we are way into bikeshedding territory, and I was inclined
> > > > to let this just go, but this is way too generic for a platform device
> > > > ID, sorry.
> > > 
> > > Yes, that's the part I don't like about it either. So I think we're on
> > > the same page here :)
> > > 
> > > FWIW, the old (current) version has the same problem, because in the
> > > absence of an id_table (or a matching entry), platform_match() matches
> > > against the driver name, which is just "wdt".
> > > 
> > > Anyway, how about using "xwdt0" for DEV_NAME? The driver supports only
> > > one device by design, so adding "0" should be fine.
> > > 
> > 
> > A numeric suffix to the device name suggests that there can be more than one,
> > which would be misleading.
> > 
> > And all that because you don't like the output of dev_info(). Hope you don't
> > start to mess with all the other drivers having the same "problem" of a less
> > than perfect output from dev_ functions.
> 
> I was merely trying to make the output look better than just a repeated
> string (which doesn't make much sense, IMHO).
> 
> At this point I see the following options:
> 
>    1. Revert to the previous patch version, but use dev_ instead of pr_ as
>       you suggested. Messages would look like "wdt wdt: ...". Note that
>       this still has the problem of registering a platform "id" of "wdt"
>       which *is* quite generic and may collide with other drivers.
>    2. Same as above, but change DRV_NAME to "xen_wdt", which is less
>       generic. Messages would look like "xen_wdt xen_wdt: ...".
>    3. Keep the id_table and change DEV_NAME to something without a numeric
>       suffix, e.g. "xwdt".
> 
> At the end of the day, what I really want is to port the xen_wdt driver
> to use the watchdog subsystem.
> 
> Please let me know which of the above options you prefer and I will
> send an updated v4.
> 
I would suggest the second option.

Guenter
