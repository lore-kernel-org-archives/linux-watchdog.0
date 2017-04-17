Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50952 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbdDQR2d (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Apr 2017 13:28:33 -0400
Date: Mon, 17 Apr 2017 10:28:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: joel@jms.id.au, wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers:watchdog:aspeed_wdt: using msleep instead of mdelay
Message-ID: <20170417172829.GA12627@roeck-us.net>
References: <7ca24742-8a82-da21-7b4c-ca807f995844@roeck-us.net>
 <1492448730-5948-1-git-send-email-karim.eshapa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492448730-5948-1-git-send-email-karim.eshapa@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 17, 2017 at 07:05:30PM +0200, Karim Eshapa wrote:
> On Sun, 16 Apr 2017 12:53:28 -0700,Guenter Roeck wrote:
> > On 04/16/2017 09:33 AM, Karim Eshapa wrote:
> >>
> >> that's useful for the scheduler, power management unless
> >> the driver needs to delay in atomic context
> >> look at documentation/timers/timers-howto
> >
> > Possibly, but how can you guarantee that the restart function is called with
> > interrupts enabled ? Also, why would it be necessary or even useful for the 
> > scheduler to do anything while the system is in the process of restarting ?
> 
> From signaling or interruption point of view msleep() is uninterruptible. 
> your process will sleep and won't be waked up until finish the time.
> 
> From the cpu load and power point of view, mdelay() makes your code
> stucked doing nothing until the delay finishes so, it's still headache
> to the schedular from time slot perspective.
> Although it's restating but it's still a long process that takes time. 
> 
> In addittion to mdelay() isn't preferable in case of large delays +10 as it uses udelay()
>  
> But the question now what about ptotecting your HW while being accessed
> through manipulating the registers. and what about memory reordering may be generated
> by the compiler or the machine itself! while accessing a sequence of registers.
> 
We are in the process of _resetting the system_ in this function.
If the function works, it won't return from the call to mdelay().
If anything, I would argue that we don't want to use anything but mdelay()
in this situation.

Sorry, I don't see the point you are trying to make.

Guenter
