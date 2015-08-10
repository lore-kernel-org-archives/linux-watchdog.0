Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43503 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbbHJRdU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Aug 2015 13:33:20 -0400
Message-ID: <55C8E05A.8090902@roeck-us.net>
Date: Mon, 10 Aug 2015 10:33:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Wim Van Sebroeck <wim@iguana.be>, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 3/5] watchdog: mpc8xxx: make use of of_device_get_match_data
References: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de> <1438942067-1654-4-git-send-email-u.kleine-koenig@pengutronix.de> <55C4C733.7000802@roeck-us.net> <20150810072428.GP9999@pengutronix.de>
In-Reply-To: <20150810072428.GP9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 08/10/2015 12:24 AM, Uwe Kleine-K=F6nig wrote:
> Hello Guenter,
>
> On Fri, Aug 07, 2015 at 07:56:51AM -0700, Guenter Roeck wrote:
>>>   	enabled =3D in_be32(&wd_base->swcrr) & SWCRR_SWEN;
>>>   	if (!enabled && wdt_type->hw_enabled) {
>>>   		pr_info("could not be enabled in software\n");
>>> -		ret =3D -ENOSYS;
>>> -		goto err_unmap;
>>> +		return -ENOSYS;
>>>   	}
>>
>> checkpatch says:
>>
>> WARNING: ENOSYS means 'invalid syscall nr' and nothing else
>> #65: FILE: drivers/watchdog/mpc8xxx_wdt.c:166:
>> +		return -ENOSYS;
>>
>> Maybe just use -ENODEV.
> That would be a separate patch tough because I'm just changing the co=
de
> flow and ENOSYS was there already before.
>
Since you are at it, can you add a patch to do that ?

Thanks,
Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
