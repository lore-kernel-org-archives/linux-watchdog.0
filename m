Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41039 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbbHRMuP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 08:50:15 -0400
Message-ID: <55D329FE.2050005@roeck-us.net>
Date: Tue, 18 Aug 2015 05:50:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Pratyush Anand <panand@redhat.com>
CC: linux-watchdog@vger.kernel.org, Dave Young <dyoung@redhat.com>,
	Don Zickus <dzickus@redhat.com>
Subject: Re: Query: Best way to know if a watchdog is active (kicked)
References: <20150818051532.GC27149@dhcppc13.redhat.com> <55D2C524.1060903@roeck-us.net> <20150818065743.GE27149@dhcppc13.redhat.com>
In-Reply-To: <20150818065743.GE27149@dhcppc13.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/17/2015 11:57 PM, Pratyush Anand wrote:
> Hi Guenter,
>
> Thanks a lot for your quick reply.
>
> On 17/08/2015:10:39:48 PM, Guenter Roeck wrote:
>> On 08/17/2015 10:15 PM, Pratyush Anand wrote:
>>> Hi,
>>>
>>> I am looking for the best way to know if a watchdog has been kicked and active.
>>>
>>> I can see a way is to read timeout(WDIOC_GETTIMEOUT) and  timeleft(
>>> WDIOC_GETTIMELEFT). If they do not match, it means that wdt is active.
>>>
>>> But what if we tried to read timeleft just in time when watchdog daemon/or some
>>> other application had kicked it. May be we read timeleft twice at the interval
>>> of 1 sec.
>>>
>>> Please let me know if there is any other alternative which could be a better way
>>> to know if watchdog is active?  Or may be it would be good to implement an ioctl
>>> WDIOC_ACTIVE?
>>>
>>
>> Normally the watchdog is active if the watchdog device is open, unless the
>> application controlling it explicitly disabled it with WDIOC_SETOPTIONS.
>> Therefore, the controlling application should always know the status.
>> A different application can not open the watchdog device, so it won't be
>> able to get its status using an ioctl anyway.
>
> Yes, A different application can not open in parallel, but can open once the
> previous application has closed it. For example this is what I see:
>

Just by opening the watchdog it is going to be activated. So all you end up
knowing is if the watchdog was active before, but in either case it will now
be active. That doesn't seem to be very helpful.

> --------------------------------------------------------------
> # cat /dev/watchdog1 ; sleep 5; wdctl /dev/watchdog1
> cat: /dev/watchdog1: Invalid argument
> wdctl: write failed: Invalid argument
> Device:        /dev/watchdog1
> Identity:      iTCO_wdt [version 0]
> Timeout:       30 seconds
> Timeleft:      24 seconds
> FLAG           DESCRIPTION               STATUS BOOT-STATUS
> KEEPALIVEPING  Keep alive ping reply          0           0
> MAGICCLOSE     Supports magic close char      0           0
> SETTIMEOUT     Set timeout (in seconds)       0           0
> --------------------------------------------------------------
> So, cat opened it and kicked it as well. But, it could not stop it as magic
> character "V" had not not received. Therefore, when wdctl opened and read
> Timeleft, it was different than Timeout.
>
>>
>> Why is that insufficient ?
>
> Well, let me explain the use case. Consider the situation when:
> -- A system has activated its watchdog to take care of software hang. So, when
> software has hanged, wdt causes to reboot, else it is kicked again before
> timeout.
> -- The same system has also activated kdump(kdump is a method to reboot to a
> minimal stable secondary kernel in case of kernel crash). Now when wdt was still
> active, there was a kernel crash and system booted to a secondary stable kernel
> which copies crash related data to a safe location. Since, wdt was active so
> before the desired process could complete in secondary kernel, hardware rebooted.
> -- So, the watchdog device need to be stoped in secondary kernel as early as
> possible. Loading of driver/module itself stops a kicked device. So, if there
> could be a way to know active wdt from kernel, then the two daemon (one which
> manages watchdog and other which manages kdump) can play independently, and
> kdump daemon can correctly program a kdump file system to load relevant watchdog
> module as early as possible.
> -- Current distro implementations loads all the watchdog devices driver module
> in secondary kernel, which is not nice (secondary kdump kernel should be as
> minimal as possible).

If the watchdog was active in the original kernel, it needs to be activated
in the crashdump kernel. I don't see a way around that. I can not comment on
"loads all the watchdog device driver module in the secondary kernel".
I would think it should be known which module to load.

One possible solution to your problem might be to have some sysfs attributes
associated with watchdog devices, one of which would be its state.
That has been on my mental task list for a while, but unfortunately
I never found the time to implement it.

Guenter

