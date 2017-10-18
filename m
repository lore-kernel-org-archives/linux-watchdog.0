Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:53150 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdJRPu0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Oct 2017 11:50:26 -0400
MIME-Version: 1.0
In-Reply-To: <20171017150812.187a6816af791519294897b6@linux-foundation.org>
References: <20170411160615.9784-1-andrew.smirnov@gmail.com>
 <01843f95-c62f-7844-70ee-eed3dc7d3c23@roeck-us.net> <CAHQ1cqFqupqUyVUrHcD6AcdyMBS_2f=0AZ-Og1pvQApjWozB_A@mail.gmail.com>
 <20171017150812.187a6816af791519294897b6@linux-foundation.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 18 Oct 2017 08:50:24 -0700
Message-ID: <CAHQ1cqEVY1_1L8ijbhcTvjGPuFCkytpN25qoUEUcgWFK88y9Fw@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: core: Make use of devm_register_reboot_notifier()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-watchdog@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 17, 2017 at 3:08 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 17 Oct 2017 08:50:12 -0700 Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
>> On Sat, Apr 15, 2017 at 11:11 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On 04/11/2017 09:06 AM, Andrey Smirnov wrote:
>> >>
>> >> Save a bit of cleanup code by leveraging newly added
>> >> devm_register_reboot_notifier().
>> >>
>> >> Cc: cphealy@gmail.com
>> >> Cc: linux-kernel@vger.kernel.org
>> >> Cc: Wim Van Sebroeck <wim@iguana.be>
>> >> Cc: Guenter Roeck <linux@roeck-us.net>
>> >> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> >> Cc: Andrew Morton <akpm@linux-foundation.org>
>> >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> >
>> >
>> > Acked-by: Guenter Roeck <linux@roeck-us.net>
>> >
>>
>> Andrew,
>>
>> This patch can't go in via watchdog tree because it depends on
>> devm_register_reboot_notifier() which is still present only in
>> linux-next, any change you can pull this into linux-next as well?
>
> That's because I've been sitting on
> kernel-reboot-add-devm_register_reboot_notifier.patch since March
> because it has no users.
>

Ah! I suspected that was the case.

> This patch adds a user.  Have you identified other sites which
> can/should use devm_register_reboot_notifier()?  I guess quite a lot,
> so it's a matter of alerting developers to the new interface.  I
> wonder how.  A checkpatch rule would do it, but that's new ground for
> checkpatch.
>

I can't say I looked for it in every nook and cranny, but I did look
at ~80% of the results that grepping for "register_reboot_notifier("
produces and it looked like lion's share of the code calling the
function didn't have a device to tie the registration lifespan to. For
dozen or so cases where there was a device to use, majority had the
call being done in the middle of probe/removal sequence, so it was
hard to tell if using devm_ version would be possible and if it would
give any significant benefits code reduction wise. However, there were
three places that looked like they had a pretty clear case for
conversion:

- drivers/input/misc/pm8941-pwrkey.c looked like a poster child for
the conversion, since the only thing it does in .remov is call
unregister_reboot_notifier()
- drivers/soc/lantiq/gphy.c and drivers/rtc/rtc-m41t80.c both looked
like they can be converted as well

Hope this is helpful.

Please, let me know if there's more action I should take about it.

Thanks,
Andrey Smirnov
