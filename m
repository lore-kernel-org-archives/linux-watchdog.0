Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61122 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbaEBRSI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 May 2014 13:18:08 -0400
Message-ID: <5363D34B.9000006@roeck-us.net>
Date: Fri, 02 May 2014 10:18:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>
CC: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
References: <20140501135832.GE61249@redhat.com> <5362E8FA.9050700@acm.org> <5362F0B0.4030405@roeck-us.net> <5363213D.7060701@acm.org> <53639AFF.40206@roeck-us.net> <20140502164424.GH198341@redhat.com>
In-Reply-To: <20140502164424.GH198341@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/02/2014 09:44 AM, Don Zickus wrote:
> On Fri, May 02, 2014 at 06:17:51AM -0700, Guenter Roeck wrote:
>> On 05/01/2014 09:38 PM, Corey Minyard wrote:
>>> On 05/01/2014 08:11 PM, Guenter Roeck wrote:
>>>> On 05/01/2014 05:38 PM, Corey Minyard wrote:
>>>>> On 05/01/2014 08:58 AM, Don Zickus wrote:
>>>>>> Hi Corey,
>>>>>>
>>>>>> I stumbled upon an issue with a partner of ours, where they booted
>>>>>> their
>>>>>> machine and tried to load the ipmi_watchdog module by hand and it
>>>>>> failed.
>>>>>>
>>>>>> The reason it failed was that the iTCO watchdog driver was already
>>>>>> loaded
>>>>>> and it registered the misc device /dev/watchdog first.
>>>>>>
>>>>>> I looked at the ipmi watchdog driver and realized it was never
>>>>>> converted
>>>>>> to the new watchdog framework where the watchdog_core module manages
>>>>>> the
>>>>>> '/dev/watchdog' misc device.
>>>>>>
>>>>>> So being naive and not knowing much about IPMI, I decided to follow the
>>>>>> helpful document
>>>>>> Documentation/watchdog/convert_drivers_to_kernel_api.txt
>>>>>> and convert the ipmi_watchdog to use the new watchdog framework.
>>>>>>
>>>>>> I ran into a few issues and then realized the driver itself never
>>>>>> really
>>>>>> binds to any hardware, so it makes the conversion process a little more
>>>>>> challenging.
>>>>>>
>>>>>> So a few questions to you before I waste my time in this area:
>>>>>>
>>>>>> - Is there any prior history about why the ipmi_watchdog was never
>>>>>>     converted to the new watchdog framework?  Lack of interest?
>>>>>> Technical
>>>>>> hurdles?
>>>>>
>>>>> Mostly lack of interest, but there are some technical hurdles.
>>>>>
>>>>> It would be hard to implement some things.  The watchdog framework has
>>>>> no concept of pretimeouts.  And IPMI is message based, you send a
>>>>
>>>> Are you saying that WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT don't
>>>> work
>>>> for ipmi ? If so, can you explain ?
>>>>
>>>
>>> That isn't enough to be able to report the pretimeout to the user.  You
>>> can set it and get it with those calls, but it also needs poll, fasync,
>>> and read to be able to select on a pretimeout or block on a read.
>>>
>>
>> Ah, but now you are talking about a specific implementation, which is a bit
>> different. The question here is what you expect to occur when a pretimeout
>> happens, and you have a certain set of expectations. Personally I don't know
>> what the best solution is; maybe a sysfs attribute or, yes, some activity
>> on the watchdog device entry. Why don't you (or Don) suggest something
>> and come up with a patch set for review ?
>
> I look through the only other two watchdogs that I could find with
> pretimeouts (kempld and hpwdt).  hpwdt uses NMI as its pretimeout
> notification, while kempld uses a low level configured action (nmi, smi,
> sci, delay).  I think ipmi is the only one that chooses a user space
> implementation (which raises another question[1]).
>
> I can try to respectfully copy the ipmi implementation to watchdog_dev.c
> and set a wdd->option to indicate its use and in addition add the
> pretimeout ioctls to watchdog_dev.c (and struct watchdog_device).
>
> Otherwise I am not sure if adding read, fasync, and poll wrappers to
> watchdog_dev.c looks like a dirty hack.
>
> Cheers,
> Don
>
> [1] if the system is stuck such that the pretimeout goes off, is it even
> possible for userspace to run?  Or guaranteed that it could run reliably?
> Just curious behind the history for this addition.
>

I would guess it depends. In most cases, I would assume it reflects that the
watchdog daemon did not run. This in turn may suggest that userspace is,
for all practical purposes, unable to run. Given that, I would suspect that
a solution which depends on user space to act will in most cases not be able
to fulfil its purpose, and I would not want to depend on it.

Note that kempld in practice only implements NMI, though the HW can
do more. I can ask Kontron for feedback on their opinion for possible
actions (and why they didn't implement other actions in the driver).

Guenter

