Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:54084 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbcAVLOj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jan 2016 06:14:39 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mason <slash.tmp@free.fr>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
References: <56A0EABB.3090901@free.fr> <20160121204255.GA10214@roeck-us.net>
Date: Fri, 22 Jan 2016 11:14:38 +0000
In-Reply-To: <20160121204255.GA10214@roeck-us.net> (Guenter Roeck's message of
	"Thu, 21 Jan 2016 12:42:55 -0800")
Message-ID: <yw1xoacdn9wh.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On Thu, Jan 21, 2016 at 03:27:07PM +0100, Mason wrote:
>> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>=20
>> This change was requested by arm-soc maintainer Kevin Hilman
>> because the X in TANGOX is a wildcard.
>>=20
> Not what I was looking for, but not worth arguing about it, so

It would be better if the commit message simply mentioned the fact that
the platform support uses ARCH_TANGO and this has to match.  The detail=
s
of why it got named that way are less important.

>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
>> ---
>>  drivers/watchdog/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 4f0e7be0da34..e723e0169f88 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -145,7 +145,7 @@ config MENF21BMC_WATCHDOG
>>  config TANGOX_WATCHDOG
>>  	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
>>  	select WATCHDOG_CORE
>> -	depends on ARCH_TANGOX || COMPILE_TEST
>> +	depends on ARCH_TANGO || COMPILE_TEST
>>  	help
>>  	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
>>  	  and SMP87xx (tango4) family chips.
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-watc=
hdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
