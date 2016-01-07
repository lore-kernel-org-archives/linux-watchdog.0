Return-path: <tomas.winkler@intel.com>
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v4 0/7] mei: create proper iAMT watchdog driver
Date: Fri,  8 Jan 2016 00:49:20 +0200
Message-Id: <1452206967-1144-1-git-send-email-tomas.winkler@intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

Instead of integrating the iAMT watchdog within the mei core driver
we will create a watchdog device on the mei client bus and
create a proper watchdog driver for it.

V4:
1. Rebase the code over patchset : "watchdog: Replace driver based refcounting"
2. Address comments from Guenter
3. Drop one unrelated patch from the series

V3:
1. Revert to dynamically allocated watchdog device wrapper
2. Export activation state to via debugfs
3. Move runtime unregistration to the BDW patch

V2: 
1. The watchdog device is no longer dynamically allocated in separate structure
2. Export device internal status via debugfs
3. Address few comments from Guenter
4. Reworked de/registration

The patches should apply and compile char-misc-next
trees/branches, though the new changes from whatchdog-next are required for proper
execution.
I would prefer this will go via char-misc-next as this is the tree
we work against.

Alexander Usyskin (3):
  mei: wd: drop the watchdog code from the core mei driver
  watchdog: mei_wdt: register wd device only if required
  watchdog: mei_wdt: re-register device on event

Tomas Winkler (4):
  watchdog: mei_wdt: implement MEI iAMT watchdog driver
  watchdog: mei_wdt: add status debugfs entry
  mei: bus: whitelist the watchdog client
  watchdog: mei_wdt: add activation debugfs entry

 Documentation/misc-devices/mei/mei.txt |  12 +-
 MAINTAINERS                            |   1 +
 drivers/misc/mei/Kconfig               |   6 +-
 drivers/misc/mei/Makefile              |   1 -
 drivers/misc/mei/bus-fixup.c           |  29 ++
 drivers/misc/mei/client.c              |  12 +-
 drivers/misc/mei/client.h              |   4 -
 drivers/misc/mei/init.c                |  10 +-
 drivers/misc/mei/interrupt.c           |  15 -
 drivers/misc/mei/mei_dev.h             |  61 +--
 drivers/misc/mei/wd.c                  | 391 ------------------
 drivers/watchdog/Kconfig               |  15 +
 drivers/watchdog/Makefile              |   1 +
 drivers/watchdog/mei_wdt.c             | 720 +++++++++++++++++++++++++++++++++
 14 files changed, 781 insertions(+), 497 deletions(-)
 delete mode 100644 drivers/misc/mei/wd.c
 create mode 100644 drivers/watchdog/mei_wdt.c

-- 
2.4.3
