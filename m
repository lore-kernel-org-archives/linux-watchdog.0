Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40323 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbbIMTzH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 13 Sep 2015 15:55:07 -0400
Message-ID: <55F5D493.8090908@roeck-us.net>
Date: Sun, 13 Sep 2015 12:54:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>,
	linux-watchdog@vger.kernel.org, Eric Anholt <eric@anholt.net>
CC: linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: bcm2835: Fix poweroff behaviour
References: <1434549844-11704-1-git-send-email-noralf@tronnes.org> <558241F7.6070600@roeck-us.net> <55F5CDE2.5020703@tronnes.org>
In-Reply-To: <55F5CDE2.5020703@tronnes.org>
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/13/2015 12:26 PM, Noralf Tr=C3=B8nnes wrote:
>
> Den 18.06.2015 05:58, skrev Guenter Roeck:
>> On 06/17/2015 07:04 AM, Noralf Tr=C3=B8nnes wrote:
>>> Currently poweroff/halt results in a reboot on the Raspberry Pi.
>>> The firmware uses the RSTS register to know which partiton to
>>> boot from. The partiton value is spread into bits
>>> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
>>> the firmware to indicate halt.
>>>
>>> The firmware made this change in 19 Aug 2013 and was matched
>>> by the downstream commit:
>>> Changes for new NOOBS multi partition booting from gsh
>>>
>>> Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>
> It seems that this has slipped through the cracks, at least it didn't
> enter in the 4.3 merge window.
>

Yes, completely. It slipped through my cracks as well :-(.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
