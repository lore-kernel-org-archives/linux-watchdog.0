Return-path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAK8P3a30JxYh6XkfFg4QcNe_79SErsyuDyviFQf1b6=4G2_uxw@mail.gmail.com>
References: <20170228210123.3404816-1-arnd@arndb.de> <20170228210123.3404816-4-arnd@arndb.de>
 <20170228213614.GB6651@roeck-us.net> <CAK8P3a30JxYh6XkfFg4QcNe_79SErsyuDyviFQf1b6=4G2_uxw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 28 Feb 2017 22:48:27 +0100
Message-ID: <CAK8P3a3-JwLcQCgfBse0qzHtJcwmOZ9DqLs4B0DjFM45HEYcgQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] watchdog: wm831x watchdog really needs mfd
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Feb 28, 2017 at 10:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Feb 28, 2017 at 10:36 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
>>>  config WM831X_WATCHDOG
>>>       tristate "WM831x watchdog"
>>> -     depends on MFD_WM831X || COMPILE_TEST
>>> +     depends on MFD_WM831X
>>
>> I prefer the fix proposed by Randy:
>>
>> -       depends on MFD_WM831X || COMPILE_TEST
>> +       depends on MFD_WM831X || (MFD_WM831X=y && COMPILE_TEST)
>>
>
> Agreed, that's better.

Actually I misread. They should be completely equivalent, the part after
the || has no effect here.

     Arnd
