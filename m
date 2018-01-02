Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:37146 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeABJTh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 2 Jan 2018 04:19:37 -0500
Received: by mail-it0-f68.google.com with SMTP id d137so38807135itc.2
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Jan 2018 01:19:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACRpkdbYiG7TOOvBa3kWtocae8NikXCdDQkR6LyPd6Umt=DHTA@mail.gmail.com>
References: <cover.1514475654.git.vilhelm.gray@gmail.com> <ff1871fe837aa3a520fefe2602f8f1e13e1db244.1514475654.git.vilhelm.gray@gmail.com>
 <CACRpkdbYiG7TOOvBa3kWtocae8NikXCdDQkR6LyPd6Umt=DHTA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Jan 2018 10:19:36 +0100
Message-ID: <CACRpkdZ=kYMg==PEK3D==625+8zK_L+bM-WRSnJQDHVDkyQzsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: Change ISA_BUS_API dependency to selection
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 2, 2018 at 10:18 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Dec 28, 2017 at 5:02 PM, William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
>
>> The ISA_BUS_API Kconfig option enables the compilation of the ISA bus
>> driver. The ISA bus driver does not perform any hardware interaction,
>> and is instead just a thin layer of software abstraction to eliminate
>> boilerplate code common to ISA-style device drivers. Since ISA_BUS_API
>> has no dependencies and does not jeopardize the integrity of the system
>> when enabled, drivers should select it when the ISA bus driver
>> functionality is needed.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
> Patch applied.

Ooops there are newer patches, backed it out.

Yours,
Linus Walleij
