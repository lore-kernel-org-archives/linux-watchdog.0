Return-path: <kyle.roeschley@ni.com>
Date: Fri, 19 Feb 2016 11:12:24 -0600
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: <david.madden@ni.com>, <joshc@ni.com>, <linux-watchdog@vger.kernel.org>,
	<wim@iguana.be>
Subject: Re: [PATCH v2] watchdog: ni9x3x_wdt: Add NI 903x/913x watchdog driver
Message-ID: <20160219171222.GA2072@senary>
References: <1455837991-9704-1-git-send-email-kyle.roeschley@ni.com>
 <56C6A7A9.7090105@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56C6A7A9.7090105@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Feb 18, 2016 at 09:27:05PM -0800, Guenter Roeck wrote:
> On 02/18/2016 03:26 PM, Kyle Roeschley wrote:
> >Add support for the watchdog timer on NI cRIO-903x and cDAQ-913x real-
> >time controllers.
> >
> >Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
> >Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> >---
> 
> This would be an optimal place for a change log.
> 
> [ if any of my comments are duplicates, sorry, but a change log
>   would help avoiding that ]
> 

Sorry about that, I'll make sure to do so in the future.

> >  Documentation/watchdog/watchdog-parameters.txt |   5 +
> >  drivers/watchdog/Kconfig                       |  11 +
> >  drivers/watchdog/Makefile                      |   1 +
> >  drivers/watchdog/ni9x3x_wdt.c                  | 274 +++++++++++++++++++++++++
> 
> The name and context make me wonder: Is this driver going to support
> all watchdog devices for NI9[0-9]3[0-9] ?
> 
> If not, it may be better to select one supported device,
> whatever that may be, for the name, and describe in Kconfig
> and the documentation which devices the driver is known to support.
> 

All of the 9[2-9]3[0-9] devices but the 963x do not and cannot run Linux,
so they won't be a problem. There is already a driver for the 963x watchdog in
our tree which is currently third in line for upstreaming, so that should be
fine as well. That would lead me to think 9x3x is fine, but if not then 903x is
fine.

> >  4 files changed, 291 insertions(+)
> >  create mode 100644 drivers/watchdog/ni9x3x_wdt.c
[...]
> >+
> >+static int ni9x3x_wdd_set_timeout(struct watchdog_device *wdd,
> >+				  unsigned int timeout)
> >+{
> >+	struct ni9x3x_wdt *wdt = watchdog_get_drvdata(wdd);
> >+	u32 counter = timeout * (1000000000 / NIWD_PERIOD_NS);
> >+
> >+	outb(((0x00FF0000 & counter) >> 16), wdt->io_base + NIWD_SEED2);
> >+	outb(((0x0000FF00 & counter) >> 8), wdt->io_base + NIWD_SEED1);
> >+	outb((0x000000FF & counter), wdt->io_base + NIWD_SEED0);
> >+
> >+	wdd->timeout = (counter * (u64)NIWD_PERIOD_NS) / 1000000000;
> 
> Unless I am missing something, this should result in a link time failure
> when building for 32 bit. Either use div_u64(), or something like
> 
> 	wdd->timeout = counter / (1000000000 / NIWD_PERIOD_NS)
> 
> Though wouldn't that be the same as 'timeout' ? Are you trying to work around
> some rounding error here ?
> 

I was, but for no reason apparently. Just tested and I think our resolution is
high enough that you never end up with a shorter timeout than you requested.

> >+
> >+	return 0;
> >+}
> >+
[...]
> >+
> >+		wdt->io_base = res->data.io.minimum;
> >+		io_size = res->data.io.address_length;
> >+
> 
> What if io_size is less than NIWD_IO_SIZE ?
> 

Meant to yoink this check from its previous home in acpi_add when the io_size
element was removed from ni9x3x_wdt, but somehow I lost the snippet entirely.
I'll re-add.

> >+		if (!devm_request_region(wdt->dev, wdt->io_base, io_size,
[...]
> >+	wdd = &wdt->wdd;
> >+	wdd->info = &ni9x3x_wdd_info;
> >+	wdd->ops = &ni9x3x_wdd_ops;
> >+	wdd->min_timeout = NIWD_MIN_TIMEOUT;
> >+	wdd->max_timeout = NIWD_MAX_TIMEOUT;
> >+	wdd->timeout = NIWD_DEFAULT_TIMEOUT;
> >+	wdd->parent = dev;
> >+	watchdog_set_drvdata(wdd, wdt);
> >+	watchdog_set_nowayout(wdd, nowayout);
> >+	ret = watchdog_init_timeout(wdd, timeout, dev);
> >+	if (ret) {
> >+		dev_err(dev, "unable to set timeout value\n");
> 
> Sure you want to abort here, instead of using the default ?
> 

Not at all, that makes more sense.

> >+		return ret;
> >+	}
> >+

Regards,

Kyle
