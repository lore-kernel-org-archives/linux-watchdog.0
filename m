Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:59026 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaEBVwP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 May 2014 17:52:15 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so2993309pdj.24
        for <linux-watchdog@vger.kernel.org>; Fri, 02 May 2014 14:52:14 -0700 (PDT)
Message-ID: <5364138C.1050208@acm.org>
Date: Fri, 02 May 2014 16:52:12 -0500
From: Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>, Guenter Roeck <linux@roeck-us.net>
CC: openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
References: <20140501135832.GE61249@redhat.com> <5362E8FA.9050700@acm.org> <5362F0B0.4030405@roeck-us.net> <5363213D.7060701@acm.org> <53639AFF.40206@roeck-us.net> <20140502164424.GH198341@redhat.com> <5363D34B.9000006@roeck-us.net> <20140502174650.GI198341@redhat.com>
In-Reply-To: <20140502174650.GI198341@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/02/2014 12:46 PM, Don Zickus wrote:
> On Fri, May 02, 2014 at 10:18:03AM -0700, Guenter Roeck wrote:
>>>>> That isn't enough to be able to report the pretimeout to the user.  You
>>>>> can set it and get it with those calls, but it also needs poll, fasync,
>>>>> and read to be able to select on a pretimeout or block on a read.
>>>>>
>>>> Ah, but now you are talking about a specific implementation, which is a bit
>>>> different. The question here is what you expect to occur when a pretimeout
>>>> happens, and you have a certain set of expectations. Personally I don't know
>>>> what the best solution is; maybe a sysfs attribute or, yes, some activity
>>>> on the watchdog device entry. Why don't you (or Don) suggest something
>>>> and come up with a patch set for review ?
>>> I look through the only other two watchdogs that I could find with
>>> pretimeouts (kempld and hpwdt).  hpwdt uses NMI as its pretimeout
>>> notification, while kempld uses a low level configured action (nmi, smi,
>>> sci, delay).  I think ipmi is the only one that chooses a user space
>>> implementation (which raises another question[1]).
>>>
>>> I can try to respectfully copy the ipmi implementation to watchdog_dev.c
>>> and set a wdd->option to indicate its use and in addition add the
>>> pretimeout ioctls to watchdog_dev.c (and struct watchdog_device).
>>>
>>> Otherwise I am not sure if adding read, fasync, and poll wrappers to
>>> watchdog_dev.c looks like a dirty hack.
>>>
>>> Cheers,
>>> Don
>>>
>>> [1] if the system is stuck such that the pretimeout goes off, is it even
>>> possible for userspace to run?  Or guaranteed that it could run reliably?
>>> Just curious behind the history for this addition.
>>>
>> I would guess it depends. In most cases, I would assume it reflects that the
>> watchdog daemon did not run. This in turn may suggest that userspace is,
>> for all practical purposes, unable to run. Given that, I would suspect that
>> a solution which depends on user space to act will in most cases not be able
>> to fulfil its purpose, and I would not want to depend on it.
> I am sure Corey ran into one vendor who wanted it, hence why he
> implemented it.  But yeah, I am not sure I would depend on it either.

The driver hardware can do an NMI or an indication through an IPMI
interrupt/signal, and the driver can either panic or try to give
information to the user.

I don't exactly remember the reason for giving a pretimeout to the
user.  I think there were some older implementations that did this, so I
kept the function. You can't depend on it, of course, but if it can work
then debugging a problem with the watchdog daemon (or something else in
userland) would be a lot easier with an option like this.  I have no
idea if anyone uses it.

I do agree that the driver should be moved over to use the framework. 
Implementing read/poll should be easy in the framework.

Don, are you interested in working on this?  i won't be able to get to
it for a bit.

-corey

>
>> Note that kempld in practice only implements NMI, though the HW can
>> do more. I can ask Kontron for feedback on their opinion for possible
>> actions (and why they didn't implement other actions in the driver).
> I don't have much interest in it really.  I was just looking at what other
> vendors did as reference.  NMI makes sense.  Though I don't see an NMI
> handler, so I assume they just use the NMI to force a panic (like the
> hpwdt does, sortof)?
>
> Cheers,
> Don

