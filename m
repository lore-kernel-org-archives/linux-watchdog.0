Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35798 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbcAVOQz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jan 2016 09:16:55 -0500
Subject: Re: [PATCH v2] watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
References: <56A0EABB.3090901@free.fr> <20160121204255.GA10214@roeck-us.net>
 <yw1xoacdn9wh.fsf@unicorn.mansr.com>
Cc: Mason <slash.tmp@free.fr>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A239D4.5050708@roeck-us.net>
Date: Fri, 22 Jan 2016 06:16:52 -0800
MIME-Version: 1.0
In-Reply-To: <yw1xoacdn9wh.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/22/2016 03:14 AM, M=E5ns Rullg=E5rd wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
>
>> On Thu, Jan 21, 2016 at 03:27:07PM +0100, Mason wrote:
>>> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>>
>>> This change was requested by arm-soc maintainer Kevin Hilman
>>> because the X in TANGOX is a wildcard.
>>>
>> Not what I was looking for, but not worth arguing about it, so
>
> It would be better if the commit message simply mentioned the fact th=
at
> the platform support uses ARCH_TANGO and this has to match.  The deta=
ils
> of why it got named that way are less important.
>
Agreed. That is why I had asked to move that information after the "---=
".
But as I said, this is not worth an endless argument.

Guenter

>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>>> ---
>>>   drivers/watchdog/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 4f0e7be0da34..e723e0169f88 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -145,7 +145,7 @@ config MENF21BMC_WATCHDOG
>>>   config TANGOX_WATCHDOG
>>>   	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
>>>   	select WATCHDOG_CORE
>>> -	depends on ARCH_TANGOX || COMPILE_TEST
>>> +	depends on ARCH_TANGO || COMPILE_TEST
>>>   	help
>>>   	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
>>>   	  and SMP87xx (tango4) family chips.
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-wat=
chdog" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
