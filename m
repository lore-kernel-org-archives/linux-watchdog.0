Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42652 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbbBROuv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 09:50:51 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YO5xj-001bMF-7Q
	for linux-watchdog@vger.kernel.org; Wed, 18 Feb 2015 14:50:51 +0000
Message-ID: <54E4A6C4.4070706@roeck-us.net>
Date: Wed, 18 Feb 2015 06:50:44 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Boris Brezillon <boris.brezillon@free-electrons.com>
CC: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at early
 boot
References: <54B53160.6060309@roeck-us.net>	<cover.1424262664.git.timo.kokkonen@offcode.fi>	<6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>	<54E49AA5.40008@roeck-us.net> <20150218151713.7a718311@bbrezillon>
In-Reply-To: <20150218151713.7a718311@bbrezillon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/18/2015 06:17 AM, Boris Brezillon wrote:
> Hi Guenter,
>
> On Wed, 18 Feb 2015 05:59:01 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> On 02/18/2015 04:57 AM, Timo Kokkonen wrote:
>>> By default the driver will start a kernel timer which keeps on kicking
>>> the watchdog HW until user space has opened the watchdog
>>> device. Usually this is desirable as the watchdog HW is running by
>>> default and the user space may not have any watchdog daemon running at
>>> all.
>>>
>>> However, on production systems it may be mandatory that also early
>>> crashes and lockups will lead to a watchdog reset, even if they happen
>>> before the user space has opened the watchdog device.
>>>
>>> To resolve the issue, add a new device tree property
>>> "early-timeout-sec" which will let the kernel timer to ping the
>>> watchdog HW only as long as the specified timeout permits. The default
>>> is still to use kernel timer, but more strict behavior can be enabled
>>> via the device tree property.
>>>
>>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>>> ---
>>>    Documentation/devicetree/bindings/watchdog/watchdog.txt | 7 +++++++
>>>    drivers/watchdog/at91sam9_wdt.c                         | 9 ++++++++-
>>>    2 files changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.txt b/Documentation/devicetree/bindings/watchdog/watchdog.txt
>>> index 7e3686c..32647cf 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/watchdog.txt
>>> +++ b/Documentation/devicetree/bindings/watchdog/watchdog.txt
>>> @@ -4,9 +4,16 @@ using these definitions.
>>>
>>>    Optional properties:
>>>    - timeout-sec: Contains the watchdog timeout in seconds.
>>> +- early-timeout-sec: If present, specifies a timeout value in seconds
>>> +  that the driver keeps on ticking the watchdog HW on behalf of user
>>> +  space. Once this timeout expires watchdog is left to expire in
>>> +  timeout-sec seconds. If this propery is set to zero, watchdog is
>>> +  started (or left running) so that a reset occurs in timeout-sec
>>> +  since the watchdog was started.
>>>
>>>    Example:
>>>
>>>    watchdog {
>>>    	 timeout-sec = <60>;
>>> +	 early-timeout-sec = <120>;
>>
>> That is not a generic property as you defined it; if so,
>> it would have to be implemented in the watchdog core code,
>> not in the at91 code. You'll have to document it in the bindings
>> description for at91sam9_wdt.
>
> Then, if this is a controller specific property, it should be defined
> with the 'atmel,' prefix.
> We're kind of looping here: the initial discussion was "is there a need
> for this property to be a generic one ?", and now you're saying no,
> while you previously left the door opened.
>
> Tomi is proposing a generic approach, as you asked him to. I agree that
> parsing the property in core code and making its value part of the
> generic watchdog struct makes sense (that's what I proposed to Tomi a
> few weeks ago).
>
Hmm ... the problem here is that the property description creates the
assumption or expectation that the property is used if defined,
which is not the case.

I am not sure how to best resolve this. Maybe a comment in the property
description stating that implementation of is device (driver) dependent ?
After all, that is true for the timeout-sec property as well.

Thanks,
Guenter

