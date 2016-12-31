Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45770 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753481AbcLaToU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 31 Dec 2016 14:44:20 -0500
To: "wim@iguana.be" <wim@iguana.be>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mans Rullgard <mans@mansr.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Naidu Tellapati <naidu.tellapati@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Stopping watchdog in watchdog driver remove functions
Message-ID: <64c83c02-2c64-c536-3302-8079f438f0ab@roeck-us.net>
Date: Sat, 31 Dec 2016 11:44:15 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I noticed that several watchdog drivers stop the watchdog in trhe driver remove function.
A non-exhaustive list of drivers doing that is

	drivers/watchdog/bcm7038_wdt.c
	drivers/watchdog/cadence_wdt.c
	drivers/watchdog/imgpdc_wdt.c
	drivers/watchdog/jz4740_wdt.c
	drivers/watchdog/kempld_wdt.c
	drivers/watchdog/max77620_wdt.c
	drivers/watchdog/moxart_wdt.c
	drivers/watchdog/sama5d4_wdt.c
	drivers/watchdog/tangox_wdt.c
	drivers/watchdog/tegra_wdt.c

Since a watchdog has to be closed for its driver to be removable, one situation
where a watchdog is still running on unload is where the watchdog was opened but
not closed properly (eg by killing the watchdog application, or if the 'nowayout'
flag is set).

Given that, does it even make sense to stop the watchdog in the remove function ?
Should it even be permitted ?

Thanks,
Guenter
