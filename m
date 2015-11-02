Return-path: <pbrobinson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56369ED4.9070001@roeck-us.net>
References: <CALeDE9O3nU1j_eu4v7JbmKr1-+C1L-qBk3qu3XCcQcnGbbtssA@mail.gmail.com>
	<56369ED4.9070001@roeck-us.net>
Date: Mon, 2 Nov 2015 02:17:08 +0000
Message-ID: <CALeDE9OMJBKAcDK6Gr5ibwW+dY_AYWgwf+gWiEPWEhJrFr0=gA@mail.gmail.com>
Subject: Re: null pointer dereference in omap_wdt
From: Peter Robinson <pbrobinson@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: poeschel@lemonage.de, linux-watchdog@vger.kernel.org,
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Nov 1, 2015 at 11:23 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 11/01/2015 03:11 PM, Peter Robinson wrote:
>>
>> Hi Lars,
>>
>> I'm seeing the following crash in omap_wdt in omap_wdt_get_timeleft
>> when I just run wdctl on a couple of different TI devices, the
>> beaglebone black/green or panda ES. I'm seeing it on both 4.2.3 and
>> 4.3rc7, looking at git it looks like you added the fuction in June,
>> have you seen this on any of your platforms?
>>
>
> I think that
>         struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
> in omap_wdt_get_timeleft() needs to be
>         struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
>
> Looks like there was an overlap between commit d2f78268ba58 ("watchdog:
> omap: put struct watchdog_device into driver data") and commit 452fafed839e
> ("watchdog: omap_wdt: implement get_timeleft").
>
> Can someone test this and send a patch to fix the problem ?

Yes, that fixed it, tested on the panda-es. I'll send a patch through
in a moment.

Peter
