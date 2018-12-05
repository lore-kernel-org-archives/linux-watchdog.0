Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42088 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeLEMVo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Dec 2018 07:21:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so14541197lfh.9
        for <linux-watchdog@vger.kernel.org>; Wed, 05 Dec 2018 04:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20181202110410.17562-1-linus.walleij@linaro.org> <5bc6b938-3cd0-73e5-f3c0-5ae2be2761f4@suse.de>
In-Reply-To: <5bc6b938-3cd0-73e5-f3c0-5ae2be2761f4@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Dec 2018 13:21:29 +0100
Message-ID: <CACRpkda7UdF_whmm_n7gTVsc-gJTPNFf_Qt5y2g5NTqN5LtUKg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: mena21_wdt: Convert to GPIO descriptors
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 3, 2018 at 9:12 AM Johannes Thumshirn <jthumshirn@suse.de> wrote:
> On 02/12/2018 12:04, Linus Walleij wrote:
> > This drops the old OF API use to look up global GPIO
> > numbers and replace it with the GPIO descriptor API.
> >
> > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> > Cc: Johannes Thumshirn <morbidrsa@gmail.com>
> > Cc: Johannes Thumshirn <jth@kernel.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
>
> I guess I have to many E-Mail addresses...

Haha :D

I just found several in the MAINTAINERS file so I got
confused and just added all of them.

Thanks!
Linus Walleij
