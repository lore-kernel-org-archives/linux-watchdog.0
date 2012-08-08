Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:45528 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759161Ab2HHUWU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Aug 2012 16:22:20 -0400
Date: Wed, 8 Aug 2012 22:22:18 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: David Teigland <teigland@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: new option to skip ping in close
Message-ID: <20120808202218.GA27604@spo001.leaseweb.com>
References: <20120803174027.GB15192@redhat.com> <501CE688.8070509@redhat.com> <20120806162503.GA21740@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120806162503.GA21740@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Dave,

> On Sat, Aug 04, 2012 at 11:08:24AM +0200, Hans de Goede wrote:
> > Why on earth are you putting that if block there and not simply putting
> > the command in the switch-case where it belongs? If you were afraid watchdog_ioctl_op
> > could cause issues, then maybe you should have studied the code?
> > 
> > That would have thought you that it will always return -ENOIOCTLCMD for commands it
> > does not know how to handle, so it won't interfere with adding new standard commands.
> > 
> > Adding this if block there is completely unnecessary and quite ugly IMHO.
> 
> It is ugly, but it's also necessary for a couple reasons that you may have
> missed at first glance.  First, this ioctl is addressing behavior that
> exists in the common framework layer, not in individual drivers, so it
> doesn't make too much sense to pass down to the drivers.
> 
> That being said, we could do so if ENOIOCTLCMD worked as you suggest, but
> it doesn't quite.  Drivers with an ioctl op will return ENOTTY, in which
> case the switch statement would work, but drivers with no ioctl op (e.g.
> softdog) cause watchdog_ioctl_op to return ENOIOCTLCMD, causing the switch
> statement to be skipped.

at this moment all drivers that are allready converted to the general watchdog
infrastructure/API don't need and thus don't have an ioctl operation in place.
They all use the common code. Before we added the WDIOC_GETTIMELEFT to the
framework, I had the converted iTCO_wdt driver using an ioctl operations call
that used the ENOIOCTLCMD without any issue.

> In the end, we need WDIOC_NOCLOSEPING to be processed by the core,
> independent of what drivers do, since as I explained this is targeting the
> behavior of the core framework, not the drivers.
> 
> For those reasons, I placed the code where it is, but I would be satisfied
> with a different approach that also works.

I'm going to be honoust: I don't understand the use case. I have the impression
that you want to solve High Availability issues with watchdog resets...
And that's like replacing a car with a new car when you are out of gasoline...

So, I need to think more about this and I wonder if other people have the same
issue as you have with the extra ping.

Aside from that (and aside from the things that Hans allready suggested (thanks
Hans!)) we should look if disabling that ping is something that you want for the
complete system or for only one driver in the system.
The code for the complete system would be translated as a module or kernel parameter
and not as an extra ioctl.
If it would be needed for specific drivers then we need a more generic approach
that will also let us tweak other items in the future so that we don't need an ioctl
for every change of behaviour.

Kind regards,
Wim.

