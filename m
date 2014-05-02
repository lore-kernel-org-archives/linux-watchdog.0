Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38654 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaEBEiX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 May 2014 00:38:23 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so4557766oag.22
        for <linux-watchdog@vger.kernel.org>; Thu, 01 May 2014 21:38:23 -0700 (PDT)
Message-ID: <5363213D.7060701@acm.org>
Date: Thu, 01 May 2014 23:38:21 -0500
From: Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Don Zickus <dzickus@redhat.com>
CC: openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
References: <20140501135832.GE61249@redhat.com> <5362E8FA.9050700@acm.org> <5362F0B0.4030405@roeck-us.net>
In-Reply-To: <5362F0B0.4030405@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/01/2014 08:11 PM, Guenter Roeck wrote:
> On 05/01/2014 05:38 PM, Corey Minyard wrote:
>> On 05/01/2014 08:58 AM, Don Zickus wrote:
>>> Hi Corey,
>>>
>>> I stumbled upon an issue with a partner of ours, where they booted
>>> their
>>> machine and tried to load the ipmi_watchdog module by hand and it
>>> failed.
>>>
>>> The reason it failed was that the iTCO watchdog driver was already
>>> loaded
>>> and it registered the misc device /dev/watchdog first.
>>>
>>> I looked at the ipmi watchdog driver and realized it was never
>>> converted
>>> to the new watchdog framework where the watchdog_core module manages
>>> the
>>> '/dev/watchdog' misc device.
>>>
>>> So being naive and not knowing much about IPMI, I decided to follow the
>>> helpful document
>>> Documentation/watchdog/convert_drivers_to_kernel_api.txt
>>> and convert the ipmi_watchdog to use the new watchdog framework.
>>>
>>> I ran into a few issues and then realized the driver itself never
>>> really
>>> binds to any hardware, so it makes the conversion process a little more
>>> challenging.
>>>
>>> So a few questions to you before I waste my time in this area:
>>>
>>> - Is there any prior history about why the ipmi_watchdog was never
>>>    converted to the new watchdog framework?  Lack of interest?
>>> Technical
>>> hurdles?
>>
>> Mostly lack of interest, but there are some technical hurdles.
>>
>> It would be hard to implement some things.  The watchdog framework has
>> no concept of pretimeouts.  And IPMI is message based, you send a
>
> Are you saying that WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT don't
> work
> for ipmi ? If so, can you explain ?
>

That isn't enough to be able to report the pretimeout to the user.  You
can set it and get it with those calls, but it also needs poll, fasync,
and read to be able to select on a pretimeout or block on a read.


>> message to a controller to do anything, and you have to wait for the
>> response.  That doesn't work very well with the watchdog interface,
>> which assumes you can do everything immediately.
>>
> Does it ? How so ? Please elaborate; I don't immediately see how the
> watchdog
> subsystem would prevent you from using, say, kernel threads or delayed
> workers
> to implement asynchronous access to or from any underlying hardware.
>
I was remembering you couldn't block in the various calls, but looking
at the code, I see that's not an issue.

-corey
