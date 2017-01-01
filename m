Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56254 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbdAAQwU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 1 Jan 2017 11:52:20 -0500
Subject: Re: Stopping watchdog in watchdog driver remove functions
To: Wim Van Sebroeck <wim@iguana.be>
References: <64c83c02-2c64-c536-3302-8079f438f0ab@roeck-us.net>
 <20170101111421.GA9695@spo001.leaseweb.nl>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mans Rullgard <mans@mansr.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Naidu Tellapati <naidu.tellapati@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a7f0a6b8-d572-99de-a5ba-0f448b82a1ab@roeck-us.net>
Date: Sun, 1 Jan 2017 08:52:09 -0800
MIME-Version: 1.0
In-Reply-To: <20170101111421.GA9695@spo001.leaseweb.nl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/01/2017 03:14 AM, Wim Van Sebroeck wrote:
> Hi Guenter,
>
>> I noticed that several watchdog drivers stop the watchdog in trhe driver
>> remove function.
>> A non-exhaustive list of drivers doing that is
>>
>> 	drivers/watchdog/bcm7038_wdt.c
>> 	drivers/watchdog/cadence_wdt.c
>> 	drivers/watchdog/imgpdc_wdt.c
>> 	drivers/watchdog/jz4740_wdt.c
>> 	drivers/watchdog/kempld_wdt.c
>> 	drivers/watchdog/max77620_wdt.c
>> 	drivers/watchdog/moxart_wdt.c
>> 	drivers/watchdog/sama5d4_wdt.c
>> 	drivers/watchdog/tangox_wdt.c
>> 	drivers/watchdog/tegra_wdt.c
>>
>> Since a watchdog has to be closed for its driver to be removable, one
>> situation
>> where a watchdog is still running on unload is where the watchdog was
>> opened but
>> not closed properly (eg by killing the watchdog application, or if the
>> 'nowayout'
>> flag is set).
>>
>> Given that, does it even make sense to stop the watchdog in the remove
>> function ?
>> Should it even be permitted ?
>
>>From an API point of view: if WDIOF_MAGICCLOSE is being used then the watchdog
> _SHOULD_ continue to run when the watchdog was not properly closed (which
> normally also results in a reboot of the system).
> if WDIOF_MAGICCLOSE is not being used then closing the watchdog device means
> that the driver needs to stop the watchdog.
>
All the above have WDIOF_MAGICCLOSE set. Does that mean they should not stop
the watchdog on remove ?

Happy new year everyone !

Guenter

