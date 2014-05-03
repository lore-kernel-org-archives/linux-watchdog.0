Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38497 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbaECCwA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 May 2014 22:52:00 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so1012799pad.4
        for <linux-watchdog@vger.kernel.org>; Fri, 02 May 2014 19:51:59 -0700 (PDT)
Message-ID: <536459CC.4090302@acm.org>
Date: Fri, 02 May 2014 21:51:56 -0500
From: Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>
CC: Guenter Roeck <linux@roeck-us.net>,
	openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
References: <20140501135832.GE61249@redhat.com> <5362E8FA.9050700@acm.org> <5362F0B0.4030405@roeck-us.net> <5363213D.7060701@acm.org> <53639AFF.40206@roeck-us.net> <20140502164424.GH198341@redhat.com> <5363D34B.9000006@roeck-us.net> <20140502174650.GI198341@redhat.com> <5364138C.1050208@acm.org> <20140503021002.GA20778@redhat.com>
In-Reply-To: <20140503021002.GA20778@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/02/2014 09:10 PM, Don Zickus wrote:
> framework. 
> Implementing read/poll should be easy in the framework.
>
> Don, are you interested in working on this?  i won't be able to get to
> it for a bit.
> I don't mind doing the work, as long as we agree on an implementation. :-)
>
> Just throwing an idea out there based on Guenter's reply, should I just
> create a new file ipmi_wdt in the drivers/watchdog area that is ported to
> the new watchdog framework?

Yes, that's what I would do.  I definitely belongs in the watchdog
directory.

>
> The idea is if a user pops up that wants the userspace solution that can
> fallback to the old ipmi_watchdog currently implemented.  Otherwise the
> new port would be the recommended way to go?  Seeing that the current
> driver is updated fairly infrequent, keeping both drivers in sync wouldn't
> be to hard.
>
> Just a random idea.

Yes, that's probably a good plan.

-corey
