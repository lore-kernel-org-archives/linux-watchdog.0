Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:34417 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754588AbcGTWTc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 20 Jul 2016 18:19:32 -0400
Subject: Re: [RFC 3/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_DEADLINE
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1468487788-22457-4-git-send-email-rasmus.villemoes@prevas.dk>
 <5787A4E9.30905@roeck-us.net> <578891AB.3070501@prevas.dk>
 <5788F34E.8060905@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <578FF674.2000704@prevas.dk>
Date: Thu, 21 Jul 2016 00:08:52 +0200
MIME-Version: 1.0
In-Reply-To: <5788F34E.8060905@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2016-07-15 16:29, Guenter Roeck wrote:
> On 07/15/2016 12:32 AM, Rasmus Villemoes wrote:
>
>>> The initial timeout should be specified as module option or as
>>> devicetree parameter, and there should be no additional configuration
>>> option.
>>
>> I was under the impression that device tree was exclusively for
>> describing hardware, and this certainly is not that. I also wanted to
>> avoid having to modify each driver, which would seem to be necessary
>> if it was module parameter/DT - the only thing required of a driver
>> now is that it correctly reports WDOG_HW_RUNNING.
>
> What is "hardware" ? It is supposed to describe the system, isn't it ?
> Part of that system is its clock rate,
> and the means how the OS is loaded, and both have impact on the initial
> timeout (and the regular timeout).
>
> You might as well argue that clock rates should not be in devicetree
> either. Clock rates are, after all,
> just reflecting the _use_ of the hardware, not the hardware itself.

But they are used to configure hardware. The init timeout is not a 
property of any particular device - it configures how the kernel 
behaves, and as such I find it quite natural to have it in the kernel's 
.config (and overridable on command line and via sysfs).

> Devicetree could be handled in the core, with a function to set the
> initial timeout,
> or possibly even with the watchdog registration itself.

But where in the device tree would you put this value? I'd really prefer 
not having to modify the node representing each individual watchdog 
device I might use.

Rasmus
