Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2443 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab2HGHwm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Aug 2012 03:52:42 -0400
Message-ID: <5020C980.5050601@redhat.com>
Date: Tue, 07 Aug 2012 09:53:36 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: David Teigland <teigland@redhat.com>
CC: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: new option to skip ping in close
References: <20120803174027.GB15192@redhat.com> <501CE688.8070509@redhat.com> <20120806162503.GA21740@redhat.com>
In-Reply-To: <20120806162503.GA21740@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 08/06/2012 06:25 PM, David Teigland wrote:
> On Sat, Aug 04, 2012 at 11:08:24AM +0200, Hans de Goede wrote:
>> Why on earth are you putting that if block there and not simply putting
>> the command in the switch-case where it belongs? If you were afraid watchdog_ioctl_op
>> could cause issues, then maybe you should have studied the code?
>>
>> That would have thought you that it will always return -ENOIOCTLCMD for commands it
>> does not know how to handle, so it won't interfere with adding new standard commands.
>>
>> Adding this if block there is completely unnecessary and quite ugly IMHO.
>
> It is ugly, but it's also necessary for a couple reasons that you may have
> missed at first glance.  First, this ioctl is addressing behavior that
> exists in the common framework layer, not in individual drivers, so it
> doesn't make too much sense to pass down to the drivers.

All the ioctls handled by the switch-case are handled primarily by the
core layer (doing things like range checking for the timeout value, etc),
WDIOC_NOCLOSEPING is no different!

> That being said, we could do so if ENOIOCTLCMD worked as you suggest, but
> it doesn't quite.  Drivers with an ioctl op will return ENOTTY,

No they don't, if they would do that all the standard ioctls would not work,
since watchdog_dev.c: watchdog_ioctl() has:

         err = watchdog_ioctl_op(wdd, cmd, arg);
         if (err != -ENOIOCTLCMD)
                 return err;

So if they returned ENOTTY we would never get into the switch case.

 > in which
> case the switch statement would work, but drivers with no ioctl op (e.g.
> softdog) cause watchdog_ioctl_op to return ENOIOCTLCMD, causing the switch
> statement to be skipped.

<sigH> it is the other way around not returning ENOIOCTLCMD (ie returning ENOTTY)
causes the switch case to be skipped, not the other way around. The watchdog_ioctl_op
driver callback is there to add custom driver specific ioctls, for all other ioctls
the watchdog_ioctl_op function must return ENOIOCTLCMD, this get turned into a
ENOTTY by the switch case if the ioctl is not one of the standard ones either,
so with WDIOC_NOCLOSEPING being a new standard ioctl it should, it *must* go in
the switch case just like all the other ioctls.

> In the end, we need WDIOC_NOCLOSEPING to be processed by the core,
> independent of what drivers do, since as I explained this is targeting the
> behavior of the core framework, not the drivers.

Right, and it will be processed by the core if it is in the switch-case because:

watchdog_ioctl_op will return ENOIOCTLCMD for non driver specific custom ioctls,
causing watchdog_ioctl() to continue into the switch case for standard ioctls!

Regards,

Hans
