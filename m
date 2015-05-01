Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35010 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbEAXQw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 19:16:52 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YoKAs-002mna-No
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 23:16:50 +0000
Message-ID: <55440955.6050204@roeck-us.net>
Date: Fri, 01 May 2015 16:16:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
	linaro-acpi@lists.linaro.org
CC: linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH] watchdog: introduce the ARM64 SBSA watchdog
 driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net> <5543A6E9.1090203@codeaurora.org> <2851853.hEtA2CtVGn@wuerfel> <5543DECA.10006@codeaurora.org>
In-Reply-To: <5543DECA.10006@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/01/2015 01:15 PM, Timur Tabi wrote:
> On 05/01/2015 02:19 PM, Arnd Bergmann wrote:
>> That should be fixed, we want normal drivers to be loadable modules.
>
> The driver references three functions that are not exported:
>
> ERROR: "acpi_parse_entries" [drivers/watchdog/arm_sbsa_wdt.ko] undefined!
> ERROR: "arch_timer_get_rate" [drivers/watchdog/arm_sbsa_wdt.ko] undefined!
> ERROR: "arch_timer_read_counter" [drivers/watchdog/arm_sbsa_wdt.ko] undefined!
>
> I know what you're going to say.  You want me to move the ACPI platform code into some ACPI platform file, maybe /arch/arm64/kernel/acpi.c.  My concern is that there is currently no code for ACPI timers, so I don't have much of a starting point.  I'd hate to have to define support for all of ACPI timers just to get my driver merged.
>

Not really, at least not me. However, there is no other caller of
arch_timer_get_rate, except for the call setting arch_timer_rate.
This suggests that it might not be such a good idea to call
arch_timer_get_rate() and arch_timer_read_counter() in the first place.

[ On a side note, arch_timer_get_rate() can return 0 if ARM_ARCH_TIMER
   is not configured. You'll need to check for that. ]

It is hard to imagine that the watchdog would be the only driver which
needs this clock. Isn't there some clock API call that can be used
instead ?

As for acpi_parse_entries, we will need some feedback from the acpi
maintainers. If the intent is that this function can be called from
drivers, it should be exported.

Guenter

