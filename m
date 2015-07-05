Return-path: <ariel@vanguardiasur.com.ar>
Message-ID: <55989A9A.4090507@vanguardiasur.com.ar>
Date: Sat, 04 Jul 2015 23:46:50 -0300
From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
MIME-Version: 1.0
To: Joachim Eastwood <manabian@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
References: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>	<1435783930-20184-2-git-send-email-ariel@vanguardiasur.com.ar>	<CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>	<5594826F.6090203@roeck-us.net> <CAGhQ9VwXnc9+QfCWG785UCuKtdg9AJ_R24dVcUF17tkxXu0bpA@mail.gmail.com>
In-Reply-To: <CAGhQ9VwXnc9+QfCWG785UCuKtdg9AJ_R24dVcUF17tkxXu0bpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>


El 02/07/15 a las 06:03, Joachim Eastwood escibió:
> On 2 July 2015 at 02:14, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 07/01/2015 04:04 PM, Joachim Eastwood wrote:
>>>
>>> Hi Ariel,
>>>
>>
>>>> +/*
>>>> + * NXP LPC18xx Watchdog Timer (WDT)
>>>
>>>
>>> I think you should use "Windowed Watchdog Timer (WWDT)" here since
>>> that is name from the user manual, even though the driver doesn't have
>>> window functionality.
>>> At least use wwdt for the compatible string, ie: "nxp,lpc1850-wwdt".
>>>
>>> I don't think Guenter asked you to remove the "Windowed" part last
>>> time, but only asked what it meant.
>>
>>
>> I did, separately, but I don't want to start a war of words either.
>> No one will know what that term means, and I am personally not too hot
>> having to explain it to others.
> 
> Fine.
> 
> My only request then is to make the compatible string
> "nxp,lpc1850-wwdt", to leave the WWDT name somewhere. As this is the
> name you will find through out the user manual for this hw block.

Well, then I'll just change the compatible string to "nxp,lpc1850-wwdt".
