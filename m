Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbbKZMc1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Nov 2015 07:32:27 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 0/6] mei: create proper iAMT watchdog driver
Date: Thu, 26 Nov 2015 14:31:15 +0200
Message-Id: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of integrating the iAMT watchdog within the mei core driver
we will create a watchdog device on the mei client bus and
create a proper watchdog driver for it.

The patches should apply and compile on both watchdog-next and char-misc-next
trees/branches.
I would prefer this will go via char-misc-next as this is the tree
we work against and conflicts should be trivial if at any.

Alexander Usyskin (4):
  mei: wd: drop the watchdog code from the core mei driver
  mei: wd: implement MEI iAMT watchdog driver
  mei: wd: register wd device only if required
  mei: wd: re-register device on event

Tomas Winkler (2):
  mei: drop nfc leftovers from the mei driver
  mei: bus: whitelist the watchdog client

 Documentation/misc-devices/mei/mei.txt |  12 +-
 MAINTAINERS                            |   1 +
 drivers/misc/mei/Kconfig               |   6 +-
 drivers/misc/mei/Makefile              |   1 -
 drivers/misc/mei/bus-fixup.c           |  29 ++
 drivers/misc/mei/client.c              |  12 +-
 drivers/misc/mei/client.h              |   4 -
 drivers/misc/mei/init.c                |  10 +-
 drivers/misc/mei/interrupt.c           |  15 -
 drivers/misc/mei/mei_dev.h             |  72 +----
 drivers/misc/mei/wd.c                  | 391 ----------------------
 drivers/watchdog/Kconfig               |  15 +
 drivers/watchdog/Makefile              |   1 +
 drivers/watchdog/mei_wdt.c             | 571 +++++++++++++++++++++++++++++++++
 14 files changed, 632 insertions(+), 508 deletions(-)
 delete mode 100644 drivers/misc/mei/wd.c
 create mode 100644 drivers/watchdog/mei_wdt.c

-- 
2.4.3

