Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50506 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdGSC5l (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 18 Jul 2017 22:57:41 -0400
Subject: Re: [PATCH 1/5] watchdog: renesas_wdt: avoid (theoretical) type
 overflow
To: Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
References: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
 <20170717151230.12680-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdV+yAy+QmDWFn8a7U8F1F5NcoV5C-1e8LeCV-jKcQHnMA@mail.gmail.com>
 <20170718072127.GA1627@katana>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4f512244-aeb7-2cde-d66c-79e1035e361e@roeck-us.net>
Date: Tue, 18 Jul 2017 19:57:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170718072127.GA1627@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/18/2017 12:21 AM, Wolfram Sang wrote:
>>> -       unsigned long rate;
>>> -       unsigned int clks_per_sec;
>>> +       unsigned long rate, clks_per_sec;
>>
>> If you make this change, you should also update rwdt_priv.clks_per_sec
>> (yes I know it's removed in a later patch in this series).
> 
> Right. I will change but also wait a bit for more comments.
> 

I for my part don't have any. Feel free to add

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

to the series when you resend.

Thanks,
Guenter
