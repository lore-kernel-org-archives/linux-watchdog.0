Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52043 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbHEHua (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Aug 2015 03:50:30 -0400
Message-ID: <55C1C041.3080504@roeck-us.net>
Date: Wed, 05 Aug 2015 00:50:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	=?windows-1252?Q?P=E1draig_Brady?= <P@draigBrady.com>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <55C14E2B.1080904@draigBrady.com> <20150805073605.GW9999@pengutronix.de>
In-Reply-To: <20150805073605.GW9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 08/05/2015 12:36 AM, Uwe Kleine-K=F6nig wrote:
> Hello P=E1draig,
>
> On Wed, Aug 05, 2015 at 12:43:39AM +0100, P=E1draig Brady wrote:
>> On 04/08/15 03:13, Guenter Roeck wrote:
>>> The watchdog infrastructure is currently purely passive, meaning
>>> it only passes information from user space to drivers and vice vers=
a.
>>>
>>> Since watchdog hardware tends to have its own quirks, this can resu=
lt
>>> in quite complex watchdog drivers. A number of scanarios are especi=
ally common.
>>>
>>> - A watchdog is always active and can not be disabled, or can not b=
e disabled
>>>    once enabled. To support such hardware, watchdog drivers have to=
 implement
>>>    their own timers and use those timers to trigger watchdog keepal=
ives while
>>>    the watchdog device is not or not yet opened.
>>> - A variant of this is the desire to enable a watchdog as soon as i=
ts driver
>>>    has been instantiated, to protect the system while it is still b=
ooting up,
>>>    but the watchdog daemon is not yet running.
>>
>> Just mentioning that patting the watchdog in the boot loader
>> (by patching grub etc.) can be a more general solution here as it
>> avoids hangs if the kernel crashes before it runs the watchdog drive=
r,
>> which is especially true if PXE loaded across the net for example.
>> Also this tends to be better spaced between boot start and user spac=
e loading.
>
> the watchdog I'm currently working with on a powerpc platform has a
> unchangable timeout of ~1 s. To make the machine boot I patched the
> bootloader and need some automatic pinging in the kernel before
> userspace takes over.
>

Does using arch_initcall in the watchdog driver help here, or is that
still too slow and you really need to hack the kernel ?

Thanks,
Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
