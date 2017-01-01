Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35882 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755109AbdAAPY5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 1 Jan 2017 10:24:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170101111421.GA9695@spo001.leaseweb.nl>
References: <64c83c02-2c64-c536-3302-8079f438f0ab@roeck-us.net> <20170101111421.GA9695@spo001.leaseweb.nl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jan 2017 17:24:55 +0200
Message-ID: <CAHp75VeREcqh0YhQSe9w+y2XvG0mQBBEoSJXsaks_6K2isERgw@mail.gmail.com>
Subject: Re: Stopping watchdog in watchdog driver remove functions
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mans Rullgard <mans@mansr.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Naidu Tellapati <naidu.tellapati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Jan 1, 2017 at 1:14 PM, Wim Van Sebroeck <wim@iguana.be> wrote:

>> Given that, does it even make sense to stop the watchdog in the remove
>> function ?
>> Should it even be permitted ?
>
> From an API point of view: if WDIOF_MAGICCLOSE is being used then the watchdog
> _SHOULD_ continue to run when the watchdog was not properly closed (which
> normally also results in a reboot of the system).

Btw, some systems may require watchdog to be run in order to perform reboot.

-- 
With Best Regards,
Andy Shevchenko
