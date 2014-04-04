Return-Path: <emilio@elopez.com.ar>
Message-ID: <533EF270.9090308@elopez.com.ar>
Date: Fri, 04 Apr 2014 14:57:04 -0300
From: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 wim@iguana.be, carlo.caione@gmail.com
CC: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunxi: Fix compilation with C=2
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar> <533EED7A.20307@roeck-us.net>
In-Reply-To: <533EED7A.20307@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

El 04/04/14 14:35, Guenter Roeck escribió:
> On 04/04/2014 10:24 AM, Emilio López wrote:
>> When compiling sunxi_defconfig while using C=2, the following error
>> causes the compilation to fail:
>>
>>      drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not
>> a valid number
>>
>> Fix it by using hex notation instead of the non-standard binary one
>>
>
> What defines "non-standard" here ?

non-standard as not part of the C standard. Binary constant notation is 
a GCC extension as far as I'm aware:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=23479
http://gcc.gnu.org/onlinedocs/gcc/Binary-constants.html (Note the "C 
Extensions" section)

> Isn't this a sparse problem that
> should possibly
> be fixed in sparse instead ?

It could be fixed in sparse as well, I don't really mind either way. The 
binary notation doesn't seem to be used much, if at all, on the kernel 
though; most of the matches I saw when quickly grepping were comments.

Cheers,

Emilio
