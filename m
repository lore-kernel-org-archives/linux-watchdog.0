Return-Path: <jdelvare@suse.de>
Return-path: <jdelvare@suse.de>
Date: Thu, 27 Sep 2018 14:38:55 +0200
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org, Martin Wilck <mwilck@suse.com>, Wim Van
 Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Giel van Schijndel <me@mortis.eu>, "Steven J. Hill"
 <Steven.Hill@cavium.com>
Subject: Default behavior of watchdog drivers
Message-ID: <20180927143855.6f8cc48e@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

It seems that various watchdog drivers behave differently if the
watchdog timer is already enabled when the driver is loaded:

* iTCO_wdt will disable the timer. I think this is what most drivers
  do, but not all.
* w83627hf_wdt will let the timer run, unless option early_disable=1 is
  passed.

These are the 2 which bother me the most because they are among the
most popular watchdog drivers on x86 systems. Having a different
behavior depending on which driver is used is quite confusing.

Can we please settle on a default behavior (either all drivers reset
the timer a load time, or none do it) and have all watchdog drivers
stick to that?

If an option to get the opposite behavior is deemed useful, can we
settle on a standard name for it? Or even implement it at the
watchdog_core level, so that each driver doesn't need to implement it
separately?

While looking into this, I found a few other strange module parameters:

* f71808e_wdt has "start_withtimeout", which starts the timer even if
  nobody opens the watchdog device node. Giel, do we really need this?
* octeon-wdt has "disable", which completely disables the watchdog
  function. This "feature" was sneaked in via commit 381cec022e46
  ("watchdog: octeon-wdt: File cleaning.") which was supposed to be a
  cleanup-only patch, without any explanation nor even mention. I can't
  see how such an option can be useful. If you don't need the driver,
  just don't load it. Steven, can you explain?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
