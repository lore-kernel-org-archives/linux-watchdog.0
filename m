Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:18405 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbcI0SqW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Sep 2016 14:46:22 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Russell King <linux@armlinux.org.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/4] kill get_clock_tick_rate()
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
        <87twd2bgtl.fsf@belgarion.home>
Date: Tue, 27 Sep 2016 20:46:12 +0200
In-Reply-To: <87twd2bgtl.fsf@belgarion.home> (Robert Jarzmik's message of
        "Mon, 26 Sep 2016 21:29:26 +0200")
Message-ID: <87wphx9o5n.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> Hi,
>>
>> This serie aims at killing get_clock_tick_rate() from pxa and sa1100 and replace
>> it by clock API calls.
>>
>> I'd like to have this reviewed and acked afterwards at least by :
>>  - Russell for the mach-sa1100 and sa1100_wdt.c
>>  - Stephen or Michael for the clk-pxa25x.c
>>  - Thomas or Daniel for the clocksource part
>>  - Wim for sa1100_wdt.c

Thanks to all for tests and acks, queued to pxa/for-next.

Cheers.

--
Robert
