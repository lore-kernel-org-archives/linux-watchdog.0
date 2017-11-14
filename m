Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
Message-ID: <1510671931.17297.10.camel@arista.com>
Subject: Re: [v2,1/2] watchdog: xen_wdt: use the watchdog subsystem
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Date: Tue, 14 Nov 2017 15:05:31 +0000
In-Reply-To: <20171111164058.GA11701@roeck-us.net>
References: <20171106190412.10023-2-rrendec@arista.com>
	 <20171111164058.GA11701@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, 2017-11-11 at 08:40 -0800, Guenter Roeck wrote:
> On Mon, Nov 06, 2017 at 07:04:11PM +0000, Radu Rendec wrote:
> > Change the xen_wdt driver to use the watchdog subsystem instead of
> > registering and manipulating the char device directly through the misc
> > API. This is mainly getting rid of the "write" and "ioctl" methods and
> > part of the watchdog control logic (which are all implemented by the
> > watchdog subsystem).
> > 
> > Even though the watchdog subsystem supports registering and handling
> > multiple watchdog devices at the same time, the xen_wdt driver has an
> > inherent limitation of only one device due to the way the Xen hypervisor
> > exposes watchdog functionality. However, the driver can now coexist with
> > other watchdog devices (supported by different drivers).
> > 
> > Signed-off-by: Radu Rendec <rrendec@arista.com>
> 
> I just noticed this escaped my attention, possibly because it was sent
> as reply to v1. Doesn't it say samewhere that you should not do that ?

Sorry about that. In the future, I will make sure to start a new thread
for new patch versions.

> dev_info has that odd "wdt: " header because DRV_NAME is set to "wdt",
> which doesn't really make much sense. Please use something more sensible
> for DRV_NAME and use dev_info.

The trouble is (was) that the device is matched against the driver by
the name, so the device name has to be the same as the driver name.
Then, regardless of what the name is, __dev_printk() will print it
twice (once as the driver name and once as the device name).

As a workaround, after looking at platform_match(), I added an id_table
to the platform_driver struct and now the match is done by that. Then
the driver name can be different.

I set the driver name to "xen_wdt" and the device name to "watchdog".
Now the messages (using dev_info()) look like this:

xen_wdt watchdog: initialized (timeout=60s, nowayout=0)

At least this looks more meaningful; I hope it's ok.

I will submit v3 of the patch (with these changes) in a separate
thread.

Thanks,
Radu
