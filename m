Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:43765 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966404AbcKOKVG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Nov 2016 05:21:06 -0500
Reply-To: hs@denx.de
To: linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
From: Heiko Schocher <hs@denx.de>
Subject: wdt, gpio: move arch_initcall into subsys_initcall ?
Message-ID: <582AE18A.2060405@denx.de>
Date: Tue, 15 Nov 2016 11:20:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

commit e188cbf7564f: "gpio: mxc: shift gpio_mxc_init() to subsys_initcall level"
moves the gpio initialization of the mxc gpio driver
from the arch_initcall level into subsys_initcall level.

This leads now on mxc boards, which use a gpio wdt driver
and the CONFIG_GPIO_WATCHDOG_ARCH_INITCALL option enabled,
to unwanted driver probe deferrals during kernel boot.

I see this currently on an imx6 based board (which has unfortunately
3 WDT: imx6 internal (disabled), gpio wdt and da9063 WDT ...).

Also a side effect from above commit is, that the da9063 WDT driver
is now probed before the gpio WDT driver ... so /dev/watchdog now
does not point to the gpio_wdt, instead it points to the da9063 WDT.

So there are 2 solutions possible:

- add a CONFIG_GPIO_MCX_ARCH_INITCALL option
   in drivers/gpio/gpio-mxc.c like for the gpio_wdt.c driver?

   But how can we guarantee, that first the gpio driver and then
   the gpio_wdt driver gets probed?

- move the arch_initcall in gpio_wdt.c into a subsys_initcall
   (Tested this, and the probe dereferral messages are gone ...)

   But this may results in problems on boards, which needs an early
   trigger on an gpio wdt ...

Other ideas?

Thanks for all suggestions!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
