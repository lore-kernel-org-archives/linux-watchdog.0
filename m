Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:49385 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbaITQPe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 20 Sep 2014 12:15:34 -0400
Received: by mail-oa0-f47.google.com with SMTP id g18so2739096oah.34
        for <linux-watchdog@vger.kernel.org>; Sat, 20 Sep 2014 09:15:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <541D9D94.2010400@roeck-us.net>
References: <1411158989-8075-1-git-send-email-carlo@caione.org>
	<1411158989-8075-3-git-send-email-carlo@caione.org>
	<541D9D94.2010400@roeck-us.net>
Date: Sat, 20 Sep 2014 18:15:34 +0200
Message-ID: <CAOQ7t2a09zB2=qyDfsnJN94Wrj9Zu1c33R1bG5NC2QwzndtmcA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ARM: meson: add watchdog driver
From: Carlo Caione <carlo@caione.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Carlo Caione <carlo@caione.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Sep 20, 2014 at 5:30 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 09/19/2014 01:36 PM, Carlo Caione wrote:
>>
>> This patch adds the watchdog driver for the Amlogic Meson SoCs used also
>> to reboot the device.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>
> [ ... ]
>>
>> +module_param(nowayout, bool, 0);
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>> +               "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>
>
> Checkpatch says:
>
> WARNING: quoted string split across lines
> #295: FILE: drivers/watchdog/meson_wdt.c:231:
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
> +               "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

Thought that it was "somehow tolerated" :)
But since I'm wrong I'll submit a v4.

Thanks,

-- 
Carlo Caione
