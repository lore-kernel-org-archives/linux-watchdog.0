Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbaEBRrG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 May 2014 13:47:06 -0400
Date: Fri, 2 May 2014 13:46:50 -0400
From: Don Zickus <dzickus@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
Message-ID: <20140502174650.GI198341@redhat.com>
References: <20140501135832.GE61249@redhat.com>
 <5362E8FA.9050700@acm.org>
 <5362F0B0.4030405@roeck-us.net>
 <5363213D.7060701@acm.org>
 <53639AFF.40206@roeck-us.net>
 <20140502164424.GH198341@redhat.com>
 <5363D34B.9000006@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5363D34B.9000006@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 02, 2014 at 10:18:03AM -0700, Guenter Roeck wrote:
> >>>That isn't enough to be able to report the pretimeout to the user.  You
> >>>can set it and get it with those calls, but it also needs poll, fasync,
> >>>and read to be able to select on a pretimeout or block on a read.
> >>>
> >>
> >>Ah, but now you are talking about a specific implementation, which is a bit
> >>different. The question here is what you expect to occur when a pretimeout
> >>happens, and you have a certain set of expectations. Personally I don't know
> >>what the best solution is; maybe a sysfs attribute or, yes, some activity
> >>on the watchdog device entry. Why don't you (or Don) suggest something
> >>and come up with a patch set for review ?
> >
> >I look through the only other two watchdogs that I could find with
> >pretimeouts (kempld and hpwdt).  hpwdt uses NMI as its pretimeout
> >notification, while kempld uses a low level configured action (nmi, smi,
> >sci, delay).  I think ipmi is the only one that chooses a user space
> >implementation (which raises another question[1]).
> >
> >I can try to respectfully copy the ipmi implementation to watchdog_dev.c
> >and set a wdd->option to indicate its use and in addition add the
> >pretimeout ioctls to watchdog_dev.c (and struct watchdog_device).
> >
> >Otherwise I am not sure if adding read, fasync, and poll wrappers to
> >watchdog_dev.c looks like a dirty hack.
> >
> >Cheers,
> >Don
> >
> >[1] if the system is stuck such that the pretimeout goes off, is it even
> >possible for userspace to run?  Or guaranteed that it could run reliably?
> >Just curious behind the history for this addition.
> >
> 
> I would guess it depends. In most cases, I would assume it reflects that the
> watchdog daemon did not run. This in turn may suggest that userspace is,
> for all practical purposes, unable to run. Given that, I would suspect that
> a solution which depends on user space to act will in most cases not be able
> to fulfil its purpose, and I would not want to depend on it.

I am sure Corey ran into one vendor who wanted it, hence why he
implemented it.  But yeah, I am not sure I would depend on it either.

> 
> Note that kempld in practice only implements NMI, though the HW can
> do more. I can ask Kontron for feedback on their opinion for possible
> actions (and why they didn't implement other actions in the driver).

I don't have much interest in it really.  I was just looking at what other
vendors did as reference.  NMI makes sense.  Though I don't see an NMI
handler, so I assume they just use the NMI to force a panic (like the
hpwdt does, sortof)?

Cheers,
Don
