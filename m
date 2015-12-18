Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33086 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbbLRBmZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 Dec 2015 20:42:25 -0500
Subject: Re: [PATCH] watchdog: refuse to unload softdog module when its timer
 is running
To: Li RongQing <roy.qing.li@gmail.com>
References: <1450359002-26577-1-git-send-email-roy.qing.li@gmail.com>
 <5672CB9D.7000709@roeck-us.net>
 <CAJFZqHxvRX8ZW--VCx+N7zA-kOTXVt1tsQ2Ob1otMNJP6BREJw@mail.gmail.com>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5673647F.5040707@roeck-us.net>
Date: Thu, 17 Dec 2015 17:42:23 -0800
MIME-Version: 1.0
In-Reply-To: <CAJFZqHxvRX8ZW--VCx+N7zA-kOTXVt1tsQ2Ob1otMNJP6BREJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/17/2015 04:55 PM, Li RongQing wrote:
> On Thu, Dec 17, 2015 at 10:50 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> Don't bother with module_put() here.
>
>
> I think this is needed;
>
> the softdog supported soft_noreboot "Softdog action, set to 1 to
> ignore reboots, 0 to reboot (default=0)"
> if soft_noreboot is 1, and not call module_put(THIS_MODULE) in watchdog_fire,
> softdog module ref count is leaked, and softdog will not be unload
>

Good point.

Guenter

> -Roy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

