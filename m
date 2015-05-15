Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:47572 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753269AbbEOG1B (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 02:27:01 -0400
Message-ID: <555591B0.2050500@offcode.fi>
Date: Fri, 15 May 2015 09:26:56 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Andreas Werner <andy@wernerandy.de>,
	Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Window watchdog driver design
References: <20150514115626.GA13621@wernerandy.de> <5554A35D.5040702@roeck-us.net> <20150514140908.GA21645@wernerandy.de> <55554356.3070700@roeck-us.net> <20150515054341.GA26468@wernerandy.de>
In-Reply-To: <20150515054341.GA26468@wernerandy.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Andy,

On 15.05.2015 08:43, Andreas Werner wrote:
> On Thu, May 14, 2015 at 05:52:38PM -0700, Guenter Roeck wrote:
>> On 05/14/2015 07:09 AM, Andreas Werner wrote:
>>> On Thu, May 14, 2015 at 06:30:05AM -0700, Guenter Roeck wrote:
>>>> On 05/14/2015 04:56 AM, Andreas Werner wrote:
>>>>> Hi,
>>>>> in the next few weeks I need to write a driver for a window wachtdog
>>>>> implemented in a CPLD. I have some questions about the design
>>>>> of the driver and the best way to write this driver to also be able
>>>>> to submit it.
>>>>>
>>>>> The triggering and configuration of the Watchdog is done by several GPIOs which
>>>>> are connected to the CPLD watchdog device. The correct GPIOs are configurable
>>>>> using the Device Tree.
>>>>>
>>>>> 1. Timeout
>>>>> 	The timeout values are defined in ms and start from 20ms to 2560ms.
>>>>> 	The timout is set by 3 GPIOs this means we have only 8 different
>>>>> 	timout values. It is also possible that a future Watchdog CPLD device
>>>>> 	does have different timeout values.
>>>>>
>>>>> 	Is it possible to set ms timeouts? It seems that the WDT API does
>>>>> 	only support a resolution of 1sec.
>>>>>
>>>>> 	One idea would be to use the API timeout as something like a timeout
>>>>> 	index to set the different values. Of course this needs to be documented.
>>>>>
>>>>> 	e.g.
>>>>> 	timeout	(API)	timeout in device
>>>>> 	1 		20ms
>>>>> 	2		100ms
>>>>> 	3		500ms
>>>>> 	...		...		
>>>>>
>>>>> 2. Upper/Lower Window
>>>>> 	There is currently no support for a windowed watchdog in the wdt core.
>>>>> 	The lower window can be activated by a gpio and its timeout is defined
>>>>> 	as "upper windows timeout/4"	
>>>>>
>>>>> 	What is the best way to implement those additional settings? Adding additional
>>>>> 	ioctl or export these in sysfs?
>>>>> --
>>>>
>>>> Sorry for the maybe dumb question, but what is a window watchdog,
>>>> and what is the lower window timeout for (assuming the upper window
>>>> timeout causes the watchdog to expire) ?
>>>>
>>>> Guenter
>>>>
>>>
>>> Oh sorry forgot to describe it in more detail.
>>>
>>> If you have a watchdog window you do not have just one timeout where the watchdog can expire.
>>> You have a so called "window" to trigger it within.
>>>
>>> 		|<----trig---->|
>>> ---lower timeout----------------upper timeout
>>>
>>> This means you have to trigger the watchdog not to late and not to early.
>>> This kind of watchdog is often used in embedded applications or more often
>>> in safety cases to fullfil requirements given e.g. by SIL1-SIL4 certifications.
>>>
>>> The lower timeout is set by a dedicated GPIO and the value will then "Upper timeout / 4". The
>>> upper timeout is set by 3 GPIOs to get different timeout values.
>>>
>>
>> Thanks a lot for the explanation.
>>
>> I would suggest to use a module parameter to enable the "lower timeout" functionality.
>>
>> Timeouts have to be specified in seconds.
>>
>> Hope this helps,
>> Guenter
>>
>
> Thanks for the answer.
>
> The module parameter would be ok for me, but it would be better if i can enable/disable
> the lower window by the application.
>
> I know that the API defines the timout in seconds but what about ms? Is there no
> watchdog out there which has timout values < seconds?.

There are a few. But the user space api specifies the timeout in seconds 
so you can't really do anything about it as long as you wish to remain 
compatible with the current watchdog API.

I am working on extending the kernel watchdog core api so that the 
driver would fill in hw_max_timeout parameter that tells the core the 
maximum supported timeout in HW. I was thinking that millisecond 
resolution would be good for this.

Also there are already at least one watchdog driver (Atmel's 
at91sam9_wdt.c) that has already concept of "minimum watchdog timeout" 
in a sense that pinging the watchdog too often is considered to be a 
failure. This is also something that is not handled with the current 
watchdog api at all.

As I am working on changing the core so that it takes over more of the 
generic watchdog behaviour and work around watchdog hardware constraints 
so that user space does not need to know about them, I am interested in 
hearing opinions about how I should care this kind of constraints. Right 
now I am not trying to "fix" an user space daemon behaviour where the 
daemon is pinging more often than what is allowed by the hardware. I 
don't know if that is something what the watchdog core should be doing 
or not. I can't think why it would be bad if watchdog daemon pings the 
hardware too often and why it should be considered as a failure. 
Therefore I can't think where one should think the failure to be in such 
case.

Right now I am assuming that kernel should not try to be clever about 
minimum ping interval at all. But as there clearly are hardware that has 
this kind of window definition, I'm sure there should be some kind of 
software support for it too. I'm open to hear more about it.

-Timo

> In my case I can only set 2 timouts (1sec and 2sec) but I need to support all 8 timeout
> values.
>
> The other thing is that my Watchdog can have differen timeout values depending
> on the CPLD and the customer requirements. I can not read out this values, they are
> only defined in the specification.
>
> This is why i had the idea with the table to only set some "indexes" for the timout
> to handle all the cases.
>
> Regards
> Andy
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

