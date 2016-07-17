Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sun, 17 Jul 2016 21:59:16 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: Implement status function in watchdog core
Message-ID: <20160717195916.GD32751@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

I didn't find the following patches that are in your tree in my e-mail:
watchdog: Improve description of min_hw_heartbeat_ms
watchdog: Implement status function in watchdog core
watchdog: sbsa: Drop status function
watchdog: tangox: Mark running watchdog correctly
watchdog: Eliminate status callback

I added "watchdog: Improve description of min_hw_heartbeat_ms" and "watchdog: tangox: Mark running watchdog correctly" to the linux-watchdog-next tree.

I didn't add the status function implementation. The reason is because there are cards that have means to read certain info life (like pcwd cards and the wdt cards). The implementation doesn't foresee this functionality and thus should be corrected first. (for these cards you want to call the status functions of these cards).

Kind regards,
Wim.
