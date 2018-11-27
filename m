Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:3375 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeK0M12 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Nov 2018 07:27:28 -0500
Date: Mon, 26 Nov 2018 18:31:17 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Tao Ren <taoren@fb.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Message-ID: <20181127013117.GB11080@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <20181115234413.27009-1-taoren@fb.com>
 <20181116001938.GA16009@roeck-us.net>
 <9a43bb84-f476-d6c8-886a-2120312ee8e7@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a43bb84-f476-d6c8-886a-2120312ee8e7@fb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 16, 2018 at 12:37:28AM +0000, Tao Ren wrote:
> On 11/15/18 4:19 PM, Guenter Roeck wrote:
> > NACK. This message is displayed if/when the watchdog application
> > exits without stopping the watchdog and/or without closing properly.
> > This _is_ critical since it will reboot the system after the next
> > timeout period.
> > 
> > If userspace triggers this message on purpose (eg by the mentioned
> > script, which does not exit properly), userspace is at fault,
> > not the kernel.
> > 
> > Guenter
> 
> Thank you for the quick response, Guenter. I see the log each time when I reboot my system, and when I searched the message in google, I also found posts asking why the message is printed at reboot, and that's why I feel it's confusing.
> 
> Anyways, please ignore the patch since it's necessary.

Tao,

If you're on a system running systemd, the default behavior is to
enable the watchdog during shutdown.  This guards against shutdown hanging.
So this message will be routinely printed out during orderly shutdown.


See file: /etc/systemd/system.conf
----------------------------------
...
# Entries in this file show the compile time defaults.
...

#ShutdownWatchdogSec=10min




-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
