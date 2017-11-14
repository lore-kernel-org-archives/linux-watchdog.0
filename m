Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v3 0/2] xen_wdt: use the watchdog subsystem
Date: Tue, 14 Nov 2017 16:23:48 +0000
Message-Id: <20171114162350.24283-1-rrendec@arista.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Attaching v3 of the xen_wdt patch, including the dev_info() fix. Please
note that I had to make some additional changes to make this work - as
described in my previous email (included below for your convenience).

8<----------------------------------------------------------------------

On Sat, 2017-11-11 at 08:40 -0800, Guenter Roeck wrote:
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

8<----------------------------------------------------------------------

Radu Rendec (2):
  watchdog: xen_wdt: use the watchdog subsystem
  watchdog: xen_wdt: remove info message and version number

 drivers/watchdog/xen_wdt.c | 258 +++++++++++----------------------------------
 1 file changed, 59 insertions(+), 199 deletions(-)

-- 
2.13.6
