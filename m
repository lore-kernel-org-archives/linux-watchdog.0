Return-path: <roy.qing.li@gmail.com>
MIME-Version: 1.0
In-Reply-To: <567296AC.4090607@roeck-us.net>
References: <1450342642-13429-1-git-send-email-roy.qing.li@gmail.com>
	<567296AC.4090607@roeck-us.net>
Date: Thu, 17 Dec 2015 19:54:06 +0800
Message-ID: <CAJFZqHz=nufRN_763M8sX_RBVeKW+N9pBp2bRhhAj0iLT1Ddog@mail.gmail.com>
Subject: Re: [PATCH] watchdog: force to stop the watchdog when unregister
From: Li RongQing <roy.qing.li@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Dec 17, 2015 at 7:04 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
>
>
> Real problem, wrong solution. We can not unconditionally stop all watchdogs
> in the watchdog core when unregistering a watchdog.
>
> Do you get an error message telling you that the watchdog isn't stopped
> after the echo command ? There should have been a "watchdog did not stop!"
> message on the console. This is per design.

Yes, I get  "watchdog did not stop!"

>
> The problem here is that the softdog has static variables which are accessed
> if its timer is still running after the driver is unloaded. This is a
> problem
> in the softdog driver, not in the watchdog core.
>
> The softdog driver should refuse to unload while still running. Anything
> else would defeat the purpose of MAGICCLOSE and the requirement to write
> the magic character before closing the watchdog.

Ok, I will resend a patch as you suggested

thanks

-Roy

>
> Thanks,
> Guenter
