Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36179 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbcGaWR2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 31 Jul 2016 18:17:28 -0400
Subject: Re: [RFC 3/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_DEADLINE
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468487788-22457-4-git-send-email-rasmus.villemoes@prevas.dk>
 <5787A4E9.30905@roeck-us.net> <578891AB.3070501@prevas.dk>
 <5788F34E.8060905@roeck-us.net> <578FF674.2000704@prevas.dk>
 <20160721003110.GC23213@roeck-us.net> <579916E2.2070402@prevas.dk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <579E78F4.6050806@roeck-us.net>
Date: Sun, 31 Jul 2016 15:17:24 -0700
MIME-Version: 1.0
In-Reply-To: <579916E2.2070402@prevas.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/27/2016 01:17 PM, Rasmus Villemoes wrote:
> On 2016-07-21 02:31, Guenter Roeck wrote:
>> On Thu, Jul 21, 2016 at 12:08:52AM +0200, Rasmus Villemoes wrote:
>>
>> I hear you. "configure hardware" is a slippery term, though. After all,
>> one would typically configure the initial timeout in hardware, just as
>> any "normal" timeout. In many cases, this will actually already be the
>> case (and should be), since the watchdog should be enabled by the
>> ROMMON or BIOS before control is passed to the kernel. As such, the
>> initial timeout should already be set when the driver is loaded.
>
> So this suggests to me that you've misunderstood how I imagine the "open-deadline" (let me keep that name for now) to work. I do certainly expect the bootloader to have configured and started the watchdog device before control is handed to the kernel, preferably with a rather large timeout, so that the watchdog doesn't reset the board before the kernel gets around to loading the appropriate driver and detecting that there's a dog to be fed. In fact, if the watchdog isn't running when the kernel starts, my patch does nothing.
>

No, I did not misunderstand it. We just have a different perspective how to fix it.

>> Overall, my conclusion is that if a devicetree property is not acceptable
>> for some reason, we should drop the notion of supporting an initial or
>> "open" timeout entirely, and leave it up to the BIOS/ROMMON as well as the
>> respective watchdog driver to set an acceptable default or initial timeout.
>> This initial timeout can (and will) be overwritten with the desired runtime
>> timeout by the watchdog daemon after it opened the watchdog device.
>>
>>>> Devicetree could be handled in the core, with a function to set the
>>>> initial timeout,
>>>> or possibly even with the watchdog registration itself.
>>>
>>> But where in the device tree would you put this value? I'd really prefer not
>>> having to modify the node representing each individual watchdog device I
>>> might use.
>>>
>> The existing "timeout-sec" property is in the watchdog node as well.
>
> Yes, but my "timeout" is not used in any way for configuring the watchdog device nor the driver for it. Nor does an appropriate value depend on which watchdog hardware one has.
>
> I'm interested in, to borrow your words, "fixing the gap" between handing over control from the kernel to user-space, by making sure that the kernel only feeds the watchdog for a finite amount of time - if userspace hasn't come up and opened the watchdog device by then, the board reboots. I set a rather generous default of two minutes; it could be (and may in some cases need to be) more, but the important thing is that the kernel doesn't feed the watchdog indefinitely.
>

I don't think we are making progress. You are absolutely opposed to introducing a
devicetree property, and I am absolutely opposed to introducing a configuration option.
The only alternatives I can see would be the old fashioned way of introducing platform
data, and/or to live with a boot parameter. Or we can wait for Wim to chime in
and share his opinion.

Guenter

