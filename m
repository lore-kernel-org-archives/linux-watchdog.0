Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:42852 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaEBAiU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 May 2014 20:38:20 -0400
Received: by mail-oa0-f45.google.com with SMTP id eb12so4366953oac.4
        for <linux-watchdog@vger.kernel.org>; Thu, 01 May 2014 17:38:20 -0700 (PDT)
Message-ID: <5362E8FA.9050700@acm.org>
Date: Thu, 01 May 2014 19:38:18 -0500
From: Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>
CC: openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
References: <20140501135832.GE61249@redhat.com>
In-Reply-To: <20140501135832.GE61249@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/01/2014 08:58 AM, Don Zickus wrote:
> Hi Corey,
>
> I stumbled upon an issue with a partner of ours, where they booted their
> machine and tried to load the ipmi_watchdog module by hand and it failed.
>
> The reason it failed was that the iTCO watchdog driver was already loaded
> and it registered the misc device /dev/watchdog first.
>
> I looked at the ipmi watchdog driver and realized it was never converted
> to the new watchdog framework where the watchdog_core module manages the
> '/dev/watchdog' misc device.
>
> So being naive and not knowing much about IPMI, I decided to follow the
> helpful document Documentation/watchdog/convert_drivers_to_kernel_api.txt
> and convert the ipmi_watchdog to use the new watchdog framework.
>
> I ran into a few issues and then realized the driver itself never really
> binds to any hardware, so it makes the conversion process a little more
> challenging.
>
> So a few questions to you before I waste my time in this area:
>
> - Is there any prior history about why the ipmi_watchdog was never
>   converted to the new watchdog framework?  Lack of interest? Technical
> hurdles?

Mostly lack of interest, but there are some technical hurdles.

It would be hard to implement some things.  The watchdog framework has
no concept of pretimeouts.  And IPMI is message based, you send a
message to a controller to do anything, and you have to wait for the
response.  That doesn't work very well with the watchdog interface,
which assumes you can do everything immediately.

>
> - Is there a reason why the ipmi_watchdog is a seperate module as opposed
>   to being called by ipmi_si?  It seems there shouldn't be an issue with
> the watchdog always loaded, it just won't do anything until someone opens
> it (from my understanding).  Also you would gain the ability to use the
> shutdown/remove routines properly instead of the reboot/panic notifiers.

I'm not sure I understand this.  Why would you want it as part of
ipmi_si?  ipmi_msghandler would be a little more logical, but IMHO still
doesn't make sense.  It uses the IPMI interface, and the interface is
designed to have multiple users.  Better to keep it separate because
it's a separate function.

I also don't understand the comment about shutdown/remove instead of
reboot/panic.  Can you elaborate on that?

>   In addition, passing the pointer to the 'struct watchdog_device' would be
> easier if some of those extra pieces were not there (as opposed to making
> it a global reference).
>
> - What does the fasync and poll calls do for a watchdog?

The IPMI watchdog has the ability to report a pretimeout at a specific
amount of time before the final timeout, presumably to take some action
before the system reboots.  the fasync and poll (and read) calls let
this be reported to the user.

>
> I'll start with that for now.
>
> I appreciate any feedback.  Currently we just implemented blacklisting the
> iTCO watchdog driver to workaround this problem.  I thought we could do
> better, hence my motivation to do work in this area.

It would be nice, yes.  I'm afraid to get all the functionality would be
a lot of hacking on the watchdog framework or removal of function from
the driver.

Thanks,

-corey

>
> Cheers,
> Don
>

