Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbbHRJOM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 05:14:12 -0400
Date: Tue, 18 Aug 2015 17:13:56 +0800
From: Dave Young <dyoung@redhat.com>
To: Pratyush Anand <panand@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Don Zickus <dzickus@redhat.com>
Subject: Re: Query: Best way to know if a watchdog is active (kicked)
Message-ID: <20150818091356.GA3768@dhcp-129-129.nay.redhat.com>
References: <20150818051532.GC27149@dhcppc13.redhat.com>
 <55D2C524.1060903@roeck-us.net>
 <20150818065743.GE27149@dhcppc13.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150818065743.GE27149@dhcppc13.redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi, Pratyush

A comment from my understanding about the background..

On 08/18/15 at 12:27pm, Pratyush Anand wrote:
> Hi Guenter,
> 
> Thanks a lot for your quick reply.
> 
> On 17/08/2015:10:39:48 PM, Guenter Roeck wrote:
> > On 08/17/2015 10:15 PM, Pratyush Anand wrote:
> > >Hi,
> > >
> > >I am looking for the best way to know if a watchdog has been kicked and active.
> > >
> > >I can see a way is to read timeout(WDIOC_GETTIMEOUT) and  timeleft(
> > >WDIOC_GETTIMELEFT). If they do not match, it means that wdt is active.
> > >
> > >But what if we tried to read timeleft just in time when watchdog daemon/or some
> > >other application had kicked it. May be we read timeleft twice at the interval
> > >of 1 sec.
> > >
> > >Please let me know if there is any other alternative which could be a better way
> > >to know if watchdog is active?  Or may be it would be good to implement an ioctl
> > >WDIOC_ACTIVE?
> > >
> > 
> > Normally the watchdog is active if the watchdog device is open, unless the
> > application controlling it explicitly disabled it with WDIOC_SETOPTIONS.
> > Therefore, the controlling application should always know the status.
> > A different application can not open the watchdog device, so it won't be
> > able to get its status using an ioctl anyway.
> 
> Yes, A different application can not open in parallel, but can open once the
> previous application has closed it. For example this is what I see:
> 
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
> > 
> > Why is that insufficient ?
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

Either stop it or continue kicking before timeout are fine.

> possible. Loading of driver/module itself stops a kicked device. So, if there
> could be a way to know active wdt from kernel, then the two daemon (one which
> manages watchdog and other which manages kdump) can play independently, and
> kdump daemon can correctly program a kdump file system to load relevant watchdog
> module as early as possible.

Some drivers like iTCO_wdt can stop it during module loading. But I'm not sure all
drivers work. At least under 'nowayout' mode.

So the better way (still is a best effort solution though) should be kicking it again
before timeout.

> -- Current distro implementations loads all the watchdog devices driver module
> in secondary kernel, which is not nice (secondary kdump kernel should be as
> minimal as possible).
> 
> ~Pratyush

Thanks
Dave
