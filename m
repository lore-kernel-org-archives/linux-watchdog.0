Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:49660 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbaCGR34 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Mar 2014 12:29:56 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so4438431pbb.14
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Mar 2014 09:29:56 -0800 (PST)
Date: Fri, 7 Mar 2014 09:29:39 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog <linux-watchdog@vger.kernel.org>
Subject: Re: Watchdog drivers and device driver model
Message-ID: <20140307172939.GA32353@roeck-us.net>
References: <1394199268.4376.50.camel@chaos.site>
 <5319D99A.50003@roeck-us.net>
 <1394206246.4376.53.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1394206246.4376.53.camel@chaos.site>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean,

On Fri, Mar 07, 2014 at 04:30:46PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> Le Friday 07 March 2014 à 06:37 -0800, Guenter Roeck a écrit :
> > On 03/07/2014 05:34 AM, Jean Delvare wrote:
> > > If you need some background: my customer needs to unload the native
> > > watchdog driver and use the IPMI watchdog instead. So they need a
> > > reliable way to figure out who is handling /dev/watchdog so that they
> > > can unload the right module. This is rather difficult, costly and
> > > fragile with the way things are currently implemented.
> >
> > Another solution in that specific case would be to convert the ipmi
> > watchdog driver to the watchdog API. Then it could be loaded in parallel
> > with other watchdog drivers. Of course, the naming problem would still
> > exist.
> 
> Not sure if it would help. If both the native watchdog driver and the
> IPMI watchdog driver get loaded automatically via module aliases, it
> will be racy. Only one driver can own /dev/watchdog at any given time,
> and the use has to decide which one.
> 
At work we are using /dev/watchdog0 and /dev/watchdog1 directly,
and don't depend on /dev/watchdog (which maps to /dev/watchdog0).
This is actually quite convenient, as it lets us use the two watchdogs
to watch each other (I've seen hard system lockups with the mei
watchdog and the iTCO watchdog on a couple of systems, so I like to
have a backup).

Sure, if you insist that the ipmi watchdog is tied to /dev/watchdog,
no matter what, that is a different issue.

Anyway, in our case it doesn't matter much which watchdog is on
which device, because we just use both. But I agree that it would
be nice to have an easy way to determine the underlying device
from user space (without having to go through the ioctl to get
the name).

Guenter
