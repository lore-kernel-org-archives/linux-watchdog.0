Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46439 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeEPM4k (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 16 May 2018 08:56:40 -0400
Received: by mail-pg0-f65.google.com with SMTP id u8-v6so254231pgp.13
        for <linux-watchdog@vger.kernel.org>; Wed, 16 May 2018 05:56:40 -0700 (PDT)
Subject: Re: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
To: Marco Felsch <m.felsch@pengutronix.de>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "fzuuzf@googlemail.com" <fzuuzf@googlemail.com>,
        Guenter Roeck <groeck7@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <20180509123243.21170-1-m.felsch@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7019417EA41@SW-EX-MBX02.diasemi.com>
 <bec3deb4-6163-ff1c-d84c-47a413845445@pengutronix.de>
 <20180515184412.GC16006@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7019418108B@SW-EX-MBX02.diasemi.com>
 <20180516090129.qozynkc4cb523nru@pengutronix.de>
From: Guenter Roeck <guenter@roeck-us.net>
Message-ID: <607ce4db-891f-5eaf-3832-216bac7f94b2@roeck-us.net>
Date: Wed, 16 May 2018 05:56:36 -0700
MIME-Version: 1.0
In-Reply-To: <20180516090129.qozynkc4cb523nru@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/16/2018 02:01 AM, Marco Felsch wrote:
> Hi Steve and Guenter,
>
> On Wed, May 16, 2018 at 07:35:13AM +0000, Steve Twiss wrote:
>> On 15 May 2018 19:44, Guenter Roeck wrote,
>>
>>> Subject: Re: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
>>>
>>> On Wed, May 09, 2018 at 04:10:15PM +0200, Marco Felsch wrote:
>>>> Hi Steve,
>>>>
>>>>
>>>> That would be great looking forward to hear from you. I will prepare a v3 if it is.
>>>>
>>> Any updates ?
>>>
>>> Guenter
>> Hi Guenter and Marco,
>>
>> Thank you for your patience.
>> The best advice I can give at the moment is:
>>
>> Please follow what has been done in the DA9062 and DA9053 device drivers.
>> https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/da9062_wdt.c#L90
>> https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/da9052_wdt.c#L76
>>
>> In these cases:
>> "setting TWDSCALE to zero for at least 150 us before writing the new value"
> Okay. I tested it without a delay and saw no issues but I will add the
> delay to be on the safe side.
> Is that okay for you Guenter?

Yes. Better safe than sorry.

Thanks,
Guenter

>> There will be a longer answer, but that must wait until the formal datasheets have
>> been clarified by the hardware engineers.
>>
>> Regards,
>> Steve
>>
> Regards,
> Marco
>

