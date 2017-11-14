Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
Message-ID: <1510682910.17297.21.camel@arista.com>
Subject: Re: [PATCH v3 0/2] xen_wdt: use the watchdog subsystem
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Date: Tue, 14 Nov 2017 18:08:30 +0000
In-Reply-To: <20171114173111.GA2237@roeck-us.net>
References: <20171114162350.24283-1-rrendec@arista.com>
	 <20171114173111.GA2237@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, 2017-11-14 at 09:31 -0800, Guenter Roeck wrote:
> On Tue, Nov 14, 2017 at 04:23:48PM +0000, Radu Rendec wrote:
> > Hi Guenter,
> > 
> > Attaching v3 of the xen_wdt patch, including the dev_info() fix. Please
> > note that I had to make some additional changes to make this work - as
> > described in my previous email (included below for your convenience).
> > 
> > 8<----------------------------------------------------------------------
> > 
> > On Sat, 2017-11-11 at 08:40 -0800, Guenter Roeck wrote:
> > > dev_info has that odd "wdt: " header because DRV_NAME is set to "wdt",
> > > which doesn't really make much sense. Please use something more sensible
> > > for DRV_NAME and use dev_info.
> > 
> > The trouble is (was) that the device is matched against the driver by
> > the name, so the device name has to be the same as the driver name.
> > Then, regardless of what the name is, __dev_printk() will print it
> > twice (once as the driver name and once as the device name).
> > 
> 
> Isn't that rather because MODULE_ALIAS is missing in the driver ?

No, I don't think so. I think MODULE_ALIAS is pretty much what it says,
so it just provides a way to "probe" the module by a different name.
For example, if I define MODULE_ALIAS("foobar"), then I can use
`modprobe foobar` and it will load the module. Special syntax within
the alias string exists to load the module automatically under certain
circumstances (e.g. modules with an alias starting with "platform:"
will be automatically loaded when platform devices are scanned).

On the other hand, the code in __dev_printk() (which is ultimately used
by all dev_... macros) is pretty straightforward:

if (dev)
	dev_printk_emit(level[1] - '0', dev, "%s %s: %pV",
			dev_driver_string(dev), dev_name(dev), vaf);

So it will always print both the driver name and the device name. If
they are the same (which is required in order to match the device with
the driver, in the absence of an id_table), it will print the same name
twice.

Radu
