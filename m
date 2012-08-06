Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58000 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170Ab2HFQZK (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Aug 2012 12:25:10 -0400
Date: Mon, 6 Aug 2012 12:25:03 -0400
From: David Teigland <teigland@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: new option to skip ping in close
Message-ID: <20120806162503.GA21740@redhat.com>
References: <20120803174027.GB15192@redhat.com>
 <501CE688.8070509@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <501CE688.8070509@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 04, 2012 at 11:08:24AM +0200, Hans de Goede wrote:
> Why on earth are you putting that if block there and not simply putting
> the command in the switch-case where it belongs? If you were afraid watchdog_ioctl_op
> could cause issues, then maybe you should have studied the code?
> 
> That would have thought you that it will always return -ENOIOCTLCMD for commands it
> does not know how to handle, so it won't interfere with adding new standard commands.
> 
> Adding this if block there is completely unnecessary and quite ugly IMHO.

It is ugly, but it's also necessary for a couple reasons that you may have
missed at first glance.  First, this ioctl is addressing behavior that
exists in the common framework layer, not in individual drivers, so it
doesn't make too much sense to pass down to the drivers.

That being said, we could do so if ENOIOCTLCMD worked as you suggest, but
it doesn't quite.  Drivers with an ioctl op will return ENOTTY, in which
case the switch statement would work, but drivers with no ioctl op (e.g.
softdog) cause watchdog_ioctl_op to return ENOIOCTLCMD, causing the switch
statement to be skipped.

In the end, we need WDIOC_NOCLOSEPING to be processed by the core,
independent of what drivers do, since as I explained this is targeting the
behavior of the core framework, not the drivers.

For those reasons, I placed the code where it is, but I would be satisfied
with a different approach that also works.

Dave

