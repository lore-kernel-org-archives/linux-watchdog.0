Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:52379 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaEBBLR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 May 2014 21:11:17 -0400
Message-ID: <5362F0B0.4030405@roeck-us.net>
Date: Thu, 01 May 2014 18:11:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: minyard@acm.org, Don Zickus <dzickus@redhat.com>
CC: openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
References: <20140501135832.GE61249@redhat.com> <5362E8FA.9050700@acm.org>
In-Reply-To: <5362E8FA.9050700@acm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/01/2014 05:38 PM, Corey Minyard wrote:
> On 05/01/2014 08:58 AM, Don Zickus wrote:
>> Hi Corey,
>>
>> I stumbled upon an issue with a partner of ours, where they booted their
>> machine and tried to load the ipmi_watchdog module by hand and it failed.
>>
>> The reason it failed was that the iTCO watchdog driver was already loaded
>> and it registered the misc device /dev/watchdog first.
>>
>> I looked at the ipmi watchdog driver and realized it was never converted
>> to the new watchdog framework where the watchdog_core module manages the
>> '/dev/watchdog' misc device.
>>
>> So being naive and not knowing much about IPMI, I decided to follow the
>> helpful document Documentation/watchdog/convert_drivers_to_kernel_api.txt
>> and convert the ipmi_watchdog to use the new watchdog framework.
>>
>> I ran into a few issues and then realized the driver itself never really
>> binds to any hardware, so it makes the conversion process a little more
>> challenging.
>>
>> So a few questions to you before I waste my time in this area:
>>
>> - Is there any prior history about why the ipmi_watchdog was never
>>    converted to the new watchdog framework?  Lack of interest? Technical
>> hurdles?
>
> Mostly lack of interest, but there are some technical hurdles.
>
> It would be hard to implement some things.  The watchdog framework has
> no concept of pretimeouts.  And IPMI is message based, you send a

Are you saying that WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT don't work
for ipmi ? If so, can you explain ?

> message to a controller to do anything, and you have to wait for the
> response.  That doesn't work very well with the watchdog interface,
> which assumes you can do everything immediately.
>
Does it ? How so ? Please elaborate; I don't immediately see how the watchdog
subsystem would prevent you from using, say, kernel threads or delayed workers
to implement asynchronous access to or from any underlying hardware.

Guenter

