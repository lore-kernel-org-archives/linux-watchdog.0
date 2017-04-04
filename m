Return-path: <andy.shevchenko@gmail.com>
MIME-Version: 1.0
In-Reply-To: <d42ffbf3-d06f-a36a-f220-eba7b88a56a3@roeck-us.net>
References: <20170404141048.16828-1-andrew.smirnov@gmail.com>
 <CAHp75VfeNMQNwdW0VYmAYic6RgV3nUXO8r7URPxiqWW16HzS4w@mail.gmail.com> <d42ffbf3-d06f-a36a-f220-eba7b88a56a3@roeck-us.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Apr 2017 19:56:51 +0300
Message-ID: <CAHp75VeV9Ps11hOjyguSDudZTa3hQ5q3hk4Yg0fo1MZtiBWS9g@mail.gmail.com>
Subject: Re: [PATCH] watchdog: core: Make use of devm_register_reboot_notifier()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-watchdog@vger.kernel.org,
	Chris Healy <cphealy@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Apr 4, 2017 at 7:51 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 04/04/2017 08:47 AM, Andy Shevchenko wrote:
>> On Tue, Apr 4, 2017 at 5:10 PM, Andrey Smirnov <andrew.smirnov@gmail.com>
>> wrote:

>>> +               ret = devm_register_reboot_notifier(wdd->parent,
>>> +                                                   &wdd->reboot_nb);
>>
>>
>> I'm not sure it's logically correct. Perhaps binding to the actual
>> watchdog device would be better.
>> Though, Guenter can correct me.
>>
>
> As mentioned in my other reply, it doesn't work since wdd->parent can be
> NULL.
> It might be possible to move the code into watchdog_dev_register() and tie
> it
> to the watchdog device, but I have not explored what that would require.

I would rather add device pointer to watchdoig struct, though it's your call :-)
So, what you decide I'll agree with.

-- 
With Best Regards,
Andy Shevchenko
