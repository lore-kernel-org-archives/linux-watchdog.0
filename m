Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39543 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbaITQaA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 20 Sep 2014 12:30:00 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XVNXs-003iKb-8G
	for linux-watchdog@vger.kernel.org; Sat, 20 Sep 2014 16:30:00 +0000
Message-ID: <541DAB63.4010108@roeck-us.net>
Date: Sat, 20 Sep 2014 09:29:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Carlo Caione <carlo@caione.org>
CC: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH v3 2/4] ARM: meson: add watchdog driver
References: <1411158989-8075-1-git-send-email-carlo@caione.org>	<1411158989-8075-3-git-send-email-carlo@caione.org>	<541D9D94.2010400@roeck-us.net> <CAOQ7t2a09zB2=qyDfsnJN94Wrj9Zu1c33R1bG5NC2QwzndtmcA@mail.gmail.com>
In-Reply-To: <CAOQ7t2a09zB2=qyDfsnJN94Wrj9Zu1c33R1bG5NC2QwzndtmcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/20/2014 09:15 AM, Carlo Caione wrote:
> On Sat, Sep 20, 2014 at 5:30 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 09/19/2014 01:36 PM, Carlo Caione wrote:
>>>
>>> This patch adds the watchdog driver for the Amlogic Meson SoCs used also
>>> to reboot the device.
>>>
>>> Signed-off-by: Carlo Caione <carlo@caione.org>
>>> ---
>>
>> [ ... ]
>>>
>>> +module_param(nowayout, bool, 0);
>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>>> +               "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>>> +
>>
>>
>> Checkpatch says:
>>
>> WARNING: quoted string split across lines
>> #295: FILE: drivers/watchdog/meson_wdt.c:231:
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>> +               "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>
> Thought that it was "somehow tolerated" :)

Not me, at least not in this case.

> But since I'm wrong I'll submit a v4.
>

MODULE_PARAM_DESC(nowayout,
                   "Watchdog cannot be stopped once started (default="
                   __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

is a really simple way of ensuring that you meet both the 80-column limit
and avoid the warning. The idea should not be to try to get away with
as many checkpatch warnings as possible ;-).

Guenter

