Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33754 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdCNMJS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Mar 2017 08:09:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170314111449.m4kejht32bdejxfk@dell>
References: <20170228210123.3404816-1-arnd@arndb.de> <20170228210123.3404816-3-arnd@arndb.de>
 <20170314111449.m4kejht32bdejxfk@dell>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Mar 2017 13:09:17 +0100
Message-ID: <CAK8P3a11maAoSYXPuTLwNsdc+aut4Lo71una7rZyMRdH23sFZw@mail.gmail.com>
Subject: Re: [PATCH 2/8] mfd: db8500-prcmu: fix stub helper interface
To: Lee Jones <lee.jones@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 14, 2017 at 12:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 28 Feb 2017, Arnd Bergmann wrote:
>
>> When the db8500 watchdog is enabled without the PRCMU, we get a lot of
>> warnings about duplicate or missing helper functions:
>>
>> In file included from drivers/watchdog/ux500_wdt.c:21:0:
>> include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prcmu_abb_read'
>>  static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
>>
>> This removes the duplicate function definitions and moves the helpers in
>> dbx500-prcmu outside of the #ifdef that hides them.
>>
>> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  include/linux/mfd/db8500-prcmu.h | 27 ----------------------
>>  include/linux/mfd/dbx500-prcmu.h | 49 ++++++++++++++++++++--------------------
>>  2 files changed, 25 insertions(+), 51 deletions(-)
>
> Is this patch still valid?

Yes. The build error was resolved with a different patch, but this is
still a useful cleanup.

    Arnd
