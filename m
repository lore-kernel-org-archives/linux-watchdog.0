Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:33851 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751966AbbDIIE7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 9 Apr 2015 04:04:59 -0400
Message-ID: <552630DD.5070509@offcode.fi>
Date: Thu, 09 Apr 2015 10:57:17 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: linux-watchdog@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Boris BREZILLON <boris.brezillon@free-electrons.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Early watchdog resets and watchdog kernel API changes
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

We had earlier discussion about the "early_timeout_sec" device tree 
property that we could use to ensure the watchdog HW resets the device 
after the given timeout at boot up. If user space does not open the 
watchdog device or if kernel crash prevents user space from opening the 
device, there would be a reset. The discussion stopped soon after we 
kind of agreed that a more generic approach should be used instead of 
implementing the behaviour to each driver. Unfortunately the watchdog 
core is too limited for that as of now.

I now had some spare time and started to look at whether I could come up 
with a patch. I browsed through several watchdog drivers and quite many 
of them have the same problem they are working around: The hardware 
watchdog timeout is way too short to be nice to the user space. That is, 
the hardware may need petting maybe every 250ms, while 1 second petting 
interval is quite common. This is worked around similar manned in many 
drivers. The min_timeout and max_timeout parameters in watchdog_device 
structure are the timeout limits exposed to the user space. The driver 
itself uses different timeout limits and kernel timers are used to fill 
in the gap between user space and what is limited by the hardware.

So, what we could be doing is to change the watchdog kernel API to be 
more aware of the actual hardware constraints and take over some of the 
driver functionality that has been implemented over and over again many 
places. This also makes it easier to implement new features, such as the 
early_timeout_sec parameter handling discussed earlier.

The way I though it could be done is this: We need to add new 
hw_timeout_min and hw_timeout_max parameters in watchdog_device 
structure. These describe the actual hardware limitations. The current 
min_timeout and max_timeout parameters would then continue serving the 
user space limits for the watchdog, as it works out right now with a lot 
of drivers. If user space is using longer watchdog timeouts, the 
watchdog core would just use generic timer code to ping the watchdog 
driver to prevent the watchdog from expiring before user space timeout 
has expired. One question here is that why do we need to limit the user 
space timeout values if kernel is working around the HW constraints 
anyway? The watchdog core could simply satisfy any (reasonable?) timeout 
parameter requested by the user.

For this we would need also a new set of flags that describe the 
hardware capabilities. We also would need a generic function for parsing 
the generic watchdog device tree properties so each driver don't need to 
implement their own parsing for the same stuff. On non-devicetree 
platforms this function could use some other means for parsing the 
parameters, such as kernel command line or ACPI.

For this I'm proposing watchdog_init_params() function that would 
replace watchdog_init_timeout() call from current drivers. This function 
could also be used for the core to know whether a driver is converted to 
supply the new information about its HW capabilities and whether core 
should take over some of the generic watchdog behaviour from the driver. 
If watchdog_init_params() is not called before 
watchdog_register_device(), the core knows to treat the driver as 
before. This way drivers can be converted and cleaned up one by one and 
not all once. I'd start with at91sam9_wdt as that's what I have the test 
environment available right now.

I don't have a patch for this yet, but I'm working on it. I just thought 
writing this email to you will help me clear my thoughts on what I am 
really doing here and give me some feedback to help ensure this gets 
generic.

Any thoughts?

-Timo
