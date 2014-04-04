Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53818 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbaDDSBP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Apr 2014 14:01:15 -0400
Message-ID: <533EF367.9050208@roeck-us.net>
Date: Fri, 04 Apr 2014 11:01:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	wim@iguana.be, carlo.caione@gmail.com
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunxi: Fix compilation with C=2
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar> <533EED7A.20307@roeck-us.net> <533EF270.9090308@elopez.com.ar>
In-Reply-To: <533EF270.9090308@elopez.com.ar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 04/04/2014 10:57 AM, Emilio L=C3=B3pez wrote:
> Hi,
>
> El 04/04/14 14:35, Guenter Roeck escribi=C3=B3:
>> On 04/04/2014 10:24 AM, Emilio L=C3=B3pez wrote:
>>> When compiling sunxi_defconfig while using C=3D2, the following error
>>> causes the compilation to fail:
>>>
>>>      drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is no=
t
>>> a valid number
>>>
>>> Fix it by using hex notation instead of the non-standard binary one
>>>
>>
>> What defines "non-standard" here ?
>
> non-standard as not part of the C standard. Binary constant notation is=
 a GCC extension as far as I'm aware:
>
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D23479
> http://gcc.gnu.org/onlinedocs/gcc/Binary-constants.html (Note the "C Ex=
tensions" section)
>
Ok.

>> Isn't this a sparse problem that
>> should possibly
>> be fixed in sparse instead ?
>
> It could be fixed in sparse as well, I don't really mind either way. Th=
e binary notation doesn't seem to be used much, if at all, on the kernel =
though; most of the matches I saw when quickly grepping were comments.
>
Nah, if it is non-standard I don't think that would be a good idea.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
