Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:1570 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbeBJV5q (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 10 Feb 2018 16:57:46 -0500
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-watchdog@vger.kernel.org
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Commit bc137dfdbec2 (watchdog: gpio_wdt: set WDOG_HW_RUNNING in
 gpio_wdt_stop)
Message-ID: <34efe5b3-954c-9c22-470f-9f9706a8a363@prevas.dk>
Date: Sat, 10 Feb 2018 22:56:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi stable maintainers

Can I get you to consider including

bc137dfdbec2 watchdog: gpio_wdt: set WDOG_HW_RUNNING in gpio_wdt_stop

in -stable? Without that, any (always-running) gpio watchdog effectively
fails to honour the magic close feature, causing an unexpected reset
shortly after userspace gracefully closes the device.

Anything containing 3c10bbde10 ("watchdog: core: Clear WDOG_HW_RUNNING
before calling the stop function") probably needs it (i.e. 4.8+), but at
the very least 4.14 and 4.15.

Rasmus
