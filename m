Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34074 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753584AbdCOLgW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 15 Mar 2017 07:36:22 -0400
MIME-Version: 1.0
In-Reply-To: <20170315102701.ugauplmckezcj7rc@dell>
References: <20170228210123.3404816-1-arnd@arndb.de> <20170228210123.3404816-3-arnd@arndb.de>
 <20170314111449.m4kejht32bdejxfk@dell> <CAK8P3a11maAoSYXPuTLwNsdc+aut4Lo71una7rZyMRdH23sFZw@mail.gmail.com>
 <20170315102701.ugauplmckezcj7rc@dell>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Mar 2017 12:36:20 +0100
Message-ID: <CAK8P3a2dD+jA3i_k7JZsxrweuK6n53UnfH-D3VpeX9Cd3tpUgg@mail.gmail.com>
Subject: Re: [PATCH 2/8] mfd: db8500-prcmu: fix stub helper interface
To: Lee Jones <lee.jones@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 15, 2017 at 11:27 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 14 Mar 2017, Arnd Bergmann wrote:
>> On Tue, Mar 14, 2017 at 12:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Tue, 28 Feb 2017, Arnd Bergmann wrote:

>> > Is this patch still valid?
>>
>> Yes. The build error was resolved with a different patch, but this is
>> still a useful cleanup.
>
> Okay, so at least it needs LinusW's Ack.
>
> Once obtained can I take this independently from the rest of the set?

Yes, the other patches are already merged, and independent of this one.

    Arnd
