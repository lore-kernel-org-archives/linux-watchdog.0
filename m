Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:56884 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750910AbaK1GnE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Nov 2014 01:43:04 -0500
Message-ID: <54781971.4060600@offcode.fi>
Date: Fri, 28 Nov 2014 08:42:57 +0200
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Boris Brezillon <boris.brezillon@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com
Subject: Re: [PATCH] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <5465C00E.4030808@offcode.fi>	<1416572610-1770-1-git-send-email-timo.kokkonen@offcode.fi> <20141127200036.2c65df62@bbrezillon>
In-Reply-To: <20141127200036.2c65df62@bbrezillon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Boris,

Thanks for the comments.

On 27.11.2014 21:00, Boris Brezillon wrote:
> Hi Timo,
>
> Sorry for the late reply.
>
> On Fri, 21 Nov 2014 14:23:30 +0200
> Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
>
>> By default the driver will start a kernel timer which keeps on kicking
>> the watchdog HW until user space has opened the watchdog
>> device. Usually this is desirable as the watchdog HW is running by
>> default and the user space may not have any watchdog daemon running at
>> all.
>>
>> However, on production systems it may be mandatory that also early
>> crashes and lockups will lead to a watchdog reset, even if they happen
>> before the user space has opened the watchdog device.
>>
>> To resolve the issue, add a new device tree property
>> "enable-early-reset" which will prevent the kernel timer from pinging
>> the watchdog HW on behalf of user space. The default is still to use
>> kernel timer, but more strict behavior can be enabled via the device
>> tree property.
>>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>> ---
>>   Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 4 ++++
>>   drivers/watchdog/at91sam9_wdt.c                          | 6 +++++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> index f90e294..a0b7b75 100644
>> --- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> @@ -28,6 +28,10 @@ Optional properties:
>>   	entering idle state.
>>   - atmel,dbg-halt : Should be present if you want to stop the watchdog when
>>   	entering debug state.
>> +- enable-early-reset : Should be present if you want to let the
>> +	watchdog timer to expire even before user space has opened the
>> +	device. If not set, a kernel timer will keep on pinging the
>> +	watchdog until it is opened.
>
> If you want to make this property generic, maybe you should document it
> in a generic binding doc
> (Documentation/devicetree/bindings/watchdog/watchdog.txt ?).
> Once you're at it, maybe you could document the generic timeout-sec
> property in this file.
> Moreover, you might want to parse this property in watchdog_core.c and
> store the information in the watchdog_device struct.

Yeah, I can take a look at it.

Thanks,
-Timo

> Apart from that, I'm not opposed to the approach, and I'm fine with the
> current implementation.
>
> Regards,
>
> Boris
>

