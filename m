Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55274 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758003AbdADCq3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 21:46:29 -0500
Subject: Re: [PATCH 2/4] watchdog: iTCO_wdt: Use device managed resources
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1483454364-28650-1-git-send-email-linux@roeck-us.net>
 <1483454364-28650-2-git-send-email-linux@roeck-us.net>
 <CAHp75VeUC+Nn4am-O2chdS-j953R1Bo-U9DFu4ViLTyjgM2qLA@mail.gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Fleming <matt.fleming@intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f12b4984-7a9d-9971-2bd2-a9ae0d252dbd@roeck-us.net>
Date: Tue, 3 Jan 2017 18:44:52 -0800
MIME-Version: 1.0
In-Reply-To: <CAHp75VeUC+Nn4am-O2chdS-j953R1Bo-U9DFu4ViLTyjgM2qLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/03/2017 02:41 PM, Andy Shevchenko wrote:
> On Tue, Jan 3, 2017 at 4:39 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> Using device managed resources simplifies error handling and cleanup,
>> and to reduce the likelyhood of errors.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Does it make sense to convert to dev_err() at some point?
>

I tried. It gives me

[59886.759774] iTCO_vendor_support: vendor-support=0
[59886.760452] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[59886.760540] iTCO_wdt iTCO_wdt.0.auto: Found a 9 Series TCO device (Version=2, TCOBASE=0x1860)
[59886.761849] iTCO_wdt iTCO_wdt.0.auto: initialized. heartbeat=30 sec (nowayout=0)

which I don't really like too much. Let's stick with pr_{info,err}.

Thanks,
Guenter

