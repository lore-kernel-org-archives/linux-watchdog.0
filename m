Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43043 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbbLUXSz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Dec 2015 18:18:55 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v3 0/8] mei: create proper iAMT watchdog driver
Date: Tue, 22 Dec 2015 01:17:53 +0200
Message-Id: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of integrating the iAMT watchdog within the mei core driver
we will create a watchdog device on the mei client bus and
create a proper watchdog driver for it.

V3:
1. Rrevert to dynamically alocated watchdog device wrapper
2. Export activation state to via debugfs
3. Move runtime unregistration to the BDW patch

V2: 
1. The watchdog device is no longer dynamically allocated in separate structure
2. Export device internal status via debugfs
3. Address few comments from Guenter
4. Reworked de/registration

The patches should apply and compile on both watchdog-next and char-misc-next
trees/branches.
I would prefer this will go via char-misc-next as this is the tree
we work against and conflicts should be trivial if at any.
Alexander Usyskin (3):
  mei: wd: drop the watchdog code from the core mei driver
  watchdog: mei_wdt: register wd device only if required
  watchdog: mei_wdt: re-register device on event

Tomas Winkler (5):
  mei: drop nfc leftovers from the mei driver
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
 drivers/misc/mei/mei_dev.h             |  72 +--
 drivers/misc/mei/wd.c                  | 391 -----------------
 drivers/watchdog/Kconfig               |  15 +
 drivers/watchdog/Makefile              |   1 +
 drivers/watchdog/mei_wdt.c             | 773 +++++++++++++++++++++++++++++++++
 14 files changed, 834 insertions(+), 508 deletions(-)
 delete mode 100644 drivers/misc/mei/wd.c
 create mode 100644 drivers/watchdog/mei_wdt.c

-- 
2.4.3

