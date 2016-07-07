Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52445 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbcGGTQD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Jul 2016 15:16:03 -0400
Date: Thu, 7 Jul 2016 12:16:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: ioanm@linux.com
Cc: Christian Fetzer <fetzer.ch@gmail.com>,
	linux-watchdog@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org
Subject: Re: I/O address 0x0cd6 already in use
Message-ID: <20160707191600.GA9431@roeck-us.net>
References: <CAH2idReJfXsd3QWvpRKnaLpw_isURt2p81VdGpPEU9dPnPHQpA@mail.gmail.com>
 <577E71D0.3030207@roeck-us.net>
 <CAH2idRciNOYZ9x8HC6oJM77pfJ2V93eamSxxpGMe_gtQOoyi2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2idRciNOYZ9x8HC6oJM77pfJ2V93eamSxxpGMe_gtQOoyi2Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jul 07, 2016 at 08:19:56PM +0300, Ioan Moldovan wrote:
> [ioan@ioanpc ~]$ sudo cat /proc/ioports | grep 0cd6
>   0cd6-0cd7 : pnp 00:07
>     0cd6-0cd7 : smba_idx
> 
> Look like pnp & smba_idx, no idea what those 2 are!
> 

Please don't drop the mailing list from your replies; others may be interested
in the problem as well. Also, please avoid top-posting.

The culprit is drivers/i2c/busses/i2c-piix4.c, which specifically requests
IO address 0xcd6-0cd7. In earlier kernels, that driver released the region
after it was done with its initialization. This is no longer the case;
instead, the region is only released when the driver is unloaded.

In other words, it is now either-or. You can load the watchdog driver
or the i2c driver, but not both. 

This was introduced with commit 2fee61d22e60 ("i2c: piix4: Add support
for multiplexed main adapter in SB800"). Copying the author and the i2c
mailing list for comments.

Guenter

> 2016-07-07 18:14 GMT+03:00 Guenter Roeck <linux@roeck-us.net>:
> > On 07/07/2016 06:12 AM, Ioan Moldovan wrote:
> >>
> >> At every boot of my PC I noticed the following error telling me the IO
> >> address 0x0cd6 is already in use:
> >>
> >> [    6.083233] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> >> [    6.083292] sp5100_tco: PCI Vendor ID: 0x1022, Device ID: 0x780b,
> >> Revision ID: 0x16
> >> [    6.083296] sp5100_tco: I/O address 0x0cd6 already in use
> >>
> >> Not being a kernel developer, I have no way to fix this.
> >>
> >
> > You probably won't be able to fix it. Try "sudo cat /proc/ioports";
> > it might tell you who is using that io address space.
> >
> > Guenter
> >
> >> CPU Details:
> >> vendor_id    : AuthenticAMD
> >> cpu family    : 21
> >> model        : 48
> >> model name    : AMD Athlon(tm) X4 860K Quad Core Processor
> >> stepping    : 1
> >> microcode    : 0x6003104
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-watchdog"
> >> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> 
> 
> 
> -- 
> Ioan Moldovan
> ioan.moldovan1999@gmail.com
