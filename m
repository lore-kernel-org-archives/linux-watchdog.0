Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55176 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbcJQNd5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Oct 2016 09:33:57 -0400
Subject: Re: curious about a couple examples of drivers including
 <asm/watchdog.h>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Linux watchdog mailing list <linux-watchdog@vger.kernel.org>
References: <alpine.LFD.2.20.1610170536320.4439@ca624034.mitel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0c176d4e-eb52-7dcb-8a09-edf97f294711@roeck-us.net>
Date: Mon, 17 Oct 2016 06:33:55 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1610170536320.4439@ca624034.mitel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/17/2016 02:41 AM, Robert P. J. Day wrote:
>
>   more nitpicking pedantry ... reading watchdog-kernel-api.txt, which
> claims:
>
> "Each watchdog timer driver that wants to use the WatchDog Timer
> Driver Core must #include <linux/watchdog.h> (you would have to do
> this anyway when writing a watchdog device driver)."
>
>   except i just noticed the following -- kernel files that include
> <asm/watchdog.h>:
>
> $ grep -r "include.*asm/watchdog.h" *
> arch/sh/boards/mach-hp6xx/pm.c:#include <asm/watchdog.h>
> arch/sh/kernel/reboot.c:#include <asm/watchdog.h>

If you look more closely, you'll notice that yhe above two files may use
functionality associated with kernel/watchdog.c and/or use definitions
and/or functions defined in the asm include. They do not implement watchdog
drivers associated with drivers/watchdog.

> drivers/watchdog/shwdt.c:#include <asm/watchdog.h>
> drivers/watchdog/cpwd.c:#include <asm/watchdog.h>
> $
>
>   that last file, cpwd.c, includes just:
>
> #include <asm/watchdog.h>
>
>   while the file shwdt.c includes *both*:
>
> #include <linux/watchdog.h>
> ...
> #include <asm/watchdog.h>
>
>   i readily admit i have no idea why this is being done, or if there's
> a perfectly good reason that SH needs to be treated a bit differently;
> just pointing out that the claim in that Doc file is not entirely
> accurate for those cases.
>
Check the source. I would guess that those two drivers use definitions
and/or functions from the asm include files. The latter file hasn't been
converted to use the watchdog infrastructure.

Guenter

