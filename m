Return-path: <rdunlap@infradead.org>
Subject: Re: [PATCH 3/8] watchdog: wm831x watchdog really needs mfd
To: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-4-arnd@arndb.de> <20170228213614.GB6651@roeck-us.net>
 <CAK8P3a30JxYh6XkfFg4QcNe_79SErsyuDyviFQf1b6=4G2_uxw@mail.gmail.com>
 <CAK8P3a3-JwLcQCgfBse0qzHtJcwmOZ9DqLs4B0DjFM45HEYcgQ@mail.gmail.com>
 <20170228231606.GA9885@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
 Lee Jones <lee.jones@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f966d171-4d1e-fba9-fd5c-fac2b6ea5c0f@infradead.org>
Date: Tue, 28 Feb 2017 18:50:42 -0800
MIME-Version: 1.0
In-Reply-To: <20170228231606.GA9885@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 02/28/17 15:16, Guenter Roeck wrote:
> On Tue, Feb 28, 2017 at 10:48:27PM +0100, Arnd Bergmann wrote:
>> On Tue, Feb 28, 2017 at 10:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Tue, Feb 28, 2017 at 10:36 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>>>  config WM831X_WATCHDOG
>>>>>       tristate "WM831x watchdog"
>>>>> -     depends on MFD_WM831X || COMPILE_TEST
>>>>> +     depends on MFD_WM831X
>>>>
>>>> I prefer the fix proposed by Randy:
>>>>
>>>> -       depends on MFD_WM831X || COMPILE_TEST
>>>> +       depends on MFD_WM831X || (MFD_WM831X=y && COMPILE_TEST)
>>>>
>>>
>>> Agreed, that's better.
>>
>> Actually I misread. They should be completely equivalent, the part after
>> the || has no effect here.
>>
> Yes, I figured that out later as well.

Agreed.  Arnd's is simpler.  My patch might keep someone else from
making the same mistake.  ;)


-- 
~Randy
