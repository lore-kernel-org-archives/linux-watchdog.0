Return-path: <j.uzycki@elproma.com.pl>
From: Janusz Uzycki <j.uzycki@elproma.com.pl>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
Date: Tue, 30 Sep 2014 14:46:29 +0200
Message-Id: <1412081190-30699-1-git-send-email-j.uzycki@elproma.com.pl>
In-Reply-To: <542A3392.8020903@roeck-us.net>
References: <542A3392.8020903@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

TODO: change WDOG_KEEP_ON to autostart module parameter

changelog:
[PATCH 1/6] watchdog: watchdog_dev: WATCHDOG_KEEP_ON feature
* clean up old comments
* watchdog_keepon_start() renamed to watchdog_timer_start()
* watchdog_keepon_stop() renamed to watchdog_timer_stop()
* watchdog_timer_register() added
* watchdog_timer_unregister() added
* watchdog_timer_register() is the last action
  in watchdog_dev_register().
  FIXME: Really should be in probe()?
* TODO: should watchdog_timer_start() call watchdog_start()?
* watchdog_release() uses watchdog_timer_restart() helper function
