Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:54619 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbaCCOiK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Mar 2014 09:38:10 -0500
Message-ID: <531493D0.9000805@roeck-us.net>
Date: Mon, 03 Mar 2014 06:38:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: core: module param to activate watchdog
References: <1393604183-8755-1-git-send-email-mpa@pengutronix.de> <20140302094323.GS1484@spo001.leaseweb.com> <20140303092747.GB24953@pengutronix.de> <20140303101940.GX1484@spo001.leaseweb.com> <20140303110932.GD24953@pengutronix.de>
In-Reply-To: <20140303110932.GD24953@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

>> To achieve what you want you should make sure that your "BIOS" starts
>> with the watchdog enabled and with a very long watchdog heartbeat (so
>> that it doesn't need to get pinged). Then the kernel can boot and
>> userspace can start and then you can do the necessary with the
>> /dev/watchdog functionality. Only thing you need to take care of is
>> that you don't stop the watchdog (via a module param or something
>> similar) during the probe/init of the driver.
>> I believe we allready have a winbond driver doing that. Just checked:
>> it's w83697hf_wdt.c with the early_disable module parameter.
>>
>> So, this is something that needs to be taken into account during
>> probe/init of the driver and for each watchdog that needs it.
>> And thus not for the first watchdog that get's registered.
>> Furthermore: not all watchdog devices have a heartbeat that is long
>> enough to achieve this functionality.
>
> Okay, thanks for the clarification. So I will change the driver and add
> an appropriate paramter to it instead as the winbond driver does.
>

Other drivers do the same, but don't even have a module parameter to
disable it if it is already running. They just ping the watchdog during
initialization to delay the timeout. w83627hf_wdt.c is an example.

Guenter

