Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61581 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbaEBNR4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 May 2014 09:17:56 -0400
Message-ID: <53639AFF.40206@roeck-us.net>
Date: Fri, 02 May 2014 06:17:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: minyard@acm.org, Don Zickus <dzickus@redhat.com>
CC: openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
References: <20140501135832.GE61249@redhat.com> <5362E8FA.9050700@acm.org> <5362F0B0.4030405@roeck-us.net> <5363213D.7060701@acm.org>
In-Reply-To: <5363213D.7060701@acm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/01/2014 09:38 PM, Corey Minyard wrote:
> On 05/01/2014 08:11 PM, Guenter Roeck wrote:
>> On 05/01/2014 05:38 PM, Corey Minyard wrote:
>>> On 05/01/2014 08:58 AM, Don Zickus wrote:
>>>> Hi Corey,
>>>>
>>>> I stumbled upon an issue with a partner of ours, where they booted
>>>> their
>>>> machine and tried to load the ipmi_watchdog module by hand and it
>>>> failed.
>>>>
>>>> The reason it failed was that the iTCO watchdog driver was already
>>>> loaded
>>>> and it registered the misc device /dev/watchdog first.
>>>>
>>>> I looked at the ipmi watchdog driver and realized it was never
>>>> converted
>>>> to the new watchdog framework where the watchdog_core module manages
>>>> the
>>>> '/dev/watchdog' misc device.
>>>>
>>>> So being naive and not knowing much about IPMI, I decided to follow the
>>>> helpful document
>>>> Documentation/watchdog/convert_drivers_to_kernel_api.txt
>>>> and convert the ipmi_watchdog to use the new watchdog framework.
>>>>
>>>> I ran into a few issues and then realized the driver itself never
>>>> really
>>>> binds to any hardware, so it makes the conversion process a little more
>>>> challenging.
>>>>
>>>> So a few questions to you before I waste my time in this area:
>>>>
>>>> - Is there any prior history about why the ipmi_watchdog was never
>>>>     converted to the new watchdog framework?  Lack of interest?
>>>> Technical
>>>> hurdles?
>>>
>>> Mostly lack of interest, but there are some technical hurdles.
>>>
>>> It would be hard to implement some things.  The watchdog framework has
>>> no concept of pretimeouts.  And IPMI is message based, you send a
>>
>> Are you saying that WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT don't
>> work
>> for ipmi ? If so, can you explain ?
>>
>
> That isn't enough to be able to report the pretimeout to the user.  You
> can set it and get it with those calls, but it also needs poll, fasync,
> and read to be able to select on a pretimeout or block on a read.
>

Ah, but now you are talking about a specific implementation, which is a bit
different. The question here is what you expect to occur when a pretimeout
happens, and you have a certain set of expectations. Personally I don't know
what the best solution is; maybe a sysfs attribute or, yes, some activity
on the watchdog device entry. Why don't you (or Don) suggest something
and come up with a patch set for review ?

Thanks,
Guenter

