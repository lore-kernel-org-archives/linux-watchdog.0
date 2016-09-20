Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:53192 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbcITGSK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Sep 2016 02:18:10 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
        <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
        <20160919200816.GC29242@roeck-us.net>
        <20160919223616.GN1041@n2100.armlinux.org.uk>
        <0909debb-f7df-648b-95d2-23b535e5b299@roeck-us.net>
Date: Tue, 20 Sep 2016 08:18:02 +0200
Message-ID: <87h99bdrhh.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 09/19/2016 03:36 PM, Russell King - ARM Linux wrote:
>> On Mon, Sep 19, 2016 at 01:08:16PM -0700, Guenter Roeck wrote:
>>> On Mon, Sep 19, 2016 at 09:12:14PM +0200, Robert Jarzmik wrote:
>>>> The OS timer rate used for the watchdog can now be fetched from the
>>>> standard clock API. This will remove the last user of
>>>> get_clock_tick_rate() in both pxa and sa11x0 architectures.
>>>>
>>>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>>
>>> Did you test this ? Potential problem, if built into the kernel, could be that
>>> the clocks might not be ready by the time the driver is instantiated. Unless
>>> this is converted to a platform driver, it won't be able to handle a
>>> -EPROBE_DEFER from the clock subsystem.
>>
>> Really not a problem at all.  The OSTIMER0 is required for the system
>> tick, and if that's not present, the kernel will be without any kind
>> of time keeping, so a missing watchdog driver is the least of the
>> problems.
>>
>> Therefore, both PXA and SA11x0 register their clocks really early to
>> ensure that OSTIMER0 is available by the time_init() stage, which is
>> way before driver probe time.
>>
>
> You are right. And, at least in qemu, it actually works.
Hi Guenter,

Yes, it was tested on pxa25x (lubbock) and pxa27x (mainstone).

Cheers.

-- 
Robert
