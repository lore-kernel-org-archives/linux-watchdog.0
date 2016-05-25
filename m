Return-path: <wsa@the-dreams.de>
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [RFC 0/2] watchdog: pretimeout: userspace governor
Date: Wed, 25 May 2016 15:47:40 +0200
Message-Id: <1464184062-5230-1-git-send-email-wsa@the-dreams.de>
List-ID: <linux-watchdog@vger.kernel.org>

So, here is the RFC series implementing the userspace governor. This is merely
meant as a proof-of-concept, so my patch series will have the same capabilities
as Vladimir's series. It does work (for me (tm)) and shows how the bottom half
handling can be better put to the watchdog device code, making the pretimeout
code a lot simpler.

However, I am not sure if a uevent on the watchdog device is a good userspace
notification. Setting the governor is done vis sysfs, okay. But setting the
pretimeout is done via the character device, so I wonder if the response
shouldn't go there as well? But do we want to introduce select/poll support
only for pretimeouts?

Other ideas?

Thanks,

   Wolfram

Vladimir Zapolskiy (1):
  watchdog: pretimeout: add userspace notifier pretimeout governor

Wolfram Sang (1):
  watchdog: dev: add helper for creating uevent on dev

 drivers/watchdog/Kconfig                | 16 +++++++++++
 drivers/watchdog/Makefile               |  1 +
 drivers/watchdog/pretimeout_userspace.c | 47 +++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_dev.c         | 20 ++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h  |  2 ++
 include/linux/watchdog.h                |  3 +++
 6 files changed, 89 insertions(+)
 create mode 100644 drivers/watchdog/pretimeout_userspace.c

-- 
2.8.1
