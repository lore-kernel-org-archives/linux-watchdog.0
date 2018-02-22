Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:40826 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753870AbeBVPSC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Feb 2018 10:18:02 -0500
Received: by mail-io0-f193.google.com with SMTP id v6so5234367iog.7
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Feb 2018 07:18:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bc33320887f448b772004e7c5d97322abb8cae0b.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com> <bc33320887f448b772004e7c5d97322abb8cae0b.1514578085.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:18:01 +0100
Message-ID: <CACRpkdZKxHRHvURL97iS__fvx_VMtg3ZohJKt4PfFQjZgnAuCA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] isa: Remove ISA_BUS_API selection for ISA_BUS
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 29, 2017 at 9:14 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> ISA_BUS_API is selected by drivers themselves when necessary. The
> ISA_BUS Kconfig option is now simply a mask for true ISA device drivers
> and relevant configuration. For now, the ISA_BUS Kconfig option is only
> available for X86, but may be added for other arch builds in the future
> if the need arises.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied to the GPIO tree for v4.17.

I'd like to have some ACK from some x86 maintainer for this
so it makes me a bit nervous.

Yet again the patch has been sitting since december with no
comments so...

Yours,
Linus Walleij
