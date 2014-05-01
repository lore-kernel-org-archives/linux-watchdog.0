Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbaEAN6n (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 May 2014 09:58:43 -0400
Date: Thu, 1 May 2014 09:58:32 -0400
From: Don Zickus <dzickus@redhat.com>
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: ipmi watchdog questions
Message-ID: <20140501135832.GE61249@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Corey,

I stumbled upon an issue with a partner of ours, where they booted their
machine and tried to load the ipmi_watchdog module by hand and it failed.

The reason it failed was that the iTCO watchdog driver was already loaded
and it registered the misc device /dev/watchdog first.

I looked at the ipmi watchdog driver and realized it was never converted
to the new watchdog framework where the watchdog_core module manages the
'/dev/watchdog' misc device.

So being naive and not knowing much about IPMI, I decided to follow the
helpful document Documentation/watchdog/convert_drivers_to_kernel_api.txt
and convert the ipmi_watchdog to use the new watchdog framework.

I ran into a few issues and then realized the driver itself never really
binds to any hardware, so it makes the conversion process a little more
challenging.

So a few questions to you before I waste my time in this area:

- Is there any prior history about why the ipmi_watchdog was never
  converted to the new watchdog framework?  Lack of interest? Technical
hurdles?

- Is there a reason why the ipmi_watchdog is a seperate module as opposed
  to being called by ipmi_si?  It seems there shouldn't be an issue with
the watchdog always loaded, it just won't do anything until someone opens
it (from my understanding).  Also you would gain the ability to use the
shutdown/remove routines properly instead of the reboot/panic notifiers.

  In addition, passing the pointer to the 'struct watchdog_device' would be
easier if some of those extra pieces were not there (as opposed to making
it a global reference).

- What does the fasync and poll calls do for a watchdog?

I'll start with that for now.

I appreciate any feedback.  Currently we just implemented blacklisting the
iTCO watchdog driver to workaround this problem.  I thought we could do
better, hence my motivation to do work in this area.

Cheers,
Don

