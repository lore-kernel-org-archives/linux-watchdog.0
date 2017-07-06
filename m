Return-Path: <zboszor@pr.hu>
Return-path: <zboszor@pr.hu>
Subject: Re: [PATCH 0/5 v4] Fix sp5100_tco watchdog driver regression
To: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-i2c@vger.kernel.org, Paul Menzel <paulepanter@users.sourceforge.net>,
 Christian Fetzer <fetzer.ch@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Nehal Shah <nehal-bakulchandra.shah@amd.com>, Tim Small <tim@seoss.co.uk>,
 Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net, wim@iguana.be,
 jlayton@poochiereds.net, marc.2377@gmail.com, cshorler@googlemail.com,
 wsa@the-dreams.de, regressions@leemhuis.info,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu>
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <21338590-400b-e1b3-1787-bd275a30c17c@pr.hu>
Date: Thu, 6 Jul 2017 09:50:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170622132134.7200-1-zboszor@pr.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

ping for the series.

Adding Greg Kroah-Hartman to the cc: list, both for the USB core
and stable series maintainership.

2017-06-22 15:21 keltezéssel, Zoltán Böszörményi írta:
> This patch series fixes a regression introduced by:
> 
> commit 2fee61d22e606fc99ade9079fda15fdee83ec33e
> Author: Christian Fetzer <fetzer.ch@gmail.com>
> Date:   Thu Nov 19 20:13:48 2015 +0100
> 
>      i2c: piix4: Add support for multiplexed main adapter in SB800
> 
> The regression caused sp5100_tco fail to load:
> 
> sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42
> sp5100_tco: I/O address 0x0cd6 already in use
> 
> Notable bugzilla links about this issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=170741
> https://bugzilla.redhat.com/show_bug.cgi?id=1369269
> https://bugzilla.redhat.com/show_bug.cgi?id=1406844
> 
> The previous two versions of this patch series introduced
> a common mutex to synchronize access to the I/O port pair
> 0xcd6 / 0xcd7 used by the AMD SB800 USB PCI quirk code and
> the i2c-piix and sp5100_tco drivers. The common mutex was
> criticized because it introduces an inter-dependency between
> drivers.
> 
> This approach modifies the request_muxed_region() semantics and
> modifies the possible use cases.
> 
> The first patch in the series adds a new IORESOURCE_ALLOCATED
> flag that alloc_resource() sets and free_resource() considers.
> The core of __request_region() is factored out into a new function
> that doesn't allocate. With this change, drivers can use the
> pre-existing DEFINE_RES_IO_NAMED() static initialized macro
> to declare struct resource statically (e.g. on the stack)
> and pass the address of it to the new __request_declared_region()
> function. A new macro called request_declared_muxed_region()
> was added to exploit this functionality. Because of the new
> IORESOURCE_ALLOCATED resource flag, release_region() can still
> be called with the old interface (the port region start and
> end values) and it won't attempt to free a non-allocated resource.
> This eliminated one failure case that can come from allocation
> errors.
> 
> The second patch modifies the behaviour of IORESOURCE_MUXED,
> a.k.a. the request_*muxed_region() macros. When these macros
> are called, the caller goes to sleep when there is any conflicting
> regions, even if the conflicting region did not use the
> IORESOURCE_MUXED flag. The kernel logs this inconsistent
> flag usage with KERN_ERR. This change eliminates the second
> failure case for IORESOURCE_MUXED and request_muxed_region()
> can be used like mutex_lock(), i.e. it returns only in case it
> could successfully request the region.
> 
> The last three patches adds proper synchronization between the
> USB PCI quirks code and the i2c-piix and sp5100_tco drivers.
> 
> The result is that the sp5100_tco driver can load and works again:
> 
> sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42
> sp5100_tco: Using 0xfed80b00 for watchdog MMIO address
> sp5100_tco: Last reboot was not triggered by watchdog.
> sp5100_tco: initialized (0xffffba2f4192db00). heartbeat=60 sec (nowayout=0)
> 
> Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
> ---
>   drivers/i2c/busses/i2c-piix4.c | 41 ++++++++++++-------------------------
>   drivers/usb/host/pci-quirks.c  |  4 ++++
>   drivers/watchdog/sp5100_tco.c  | 28 +++++++++++++------------
>   include/linux/ioport.h         | 14 +++++++++++++
>   kernel/resource.c              | 46 ++++++++++++++++++++++++++++++++++++++----
>   5 files changed, 88 insertions(+), 45 deletions(-)
> 
> 

The synchronized access to the SB800 I/O ports seems to also have made a rare
"disabled by hub (EMI?), re-enabling..." report from the kernel disappear.

Can someone review the series?

Thanks in advance,
Zoltán Böszörményi
