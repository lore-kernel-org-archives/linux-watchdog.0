Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12919 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754272Ab2HPQkS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Aug 2012 12:40:18 -0400
From: Tomas Winkler <tomas.winkler@intel.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, alan@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 0/4] mei: watchdog fixes and cleanups
Date: Thu, 16 Aug 2012 19:39:40 +0300
Message-Id: <1345135184-23915-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This series depends on regression fix for v3.6
http://marc.info/?l=linux-kernel&m=134512356218967&w=2

Tomas Winkler (4):
  mei: wd: add option WDIOF_SETTIMEOUT
  mei: wd: rename watchdog constants to be more descriptive
  mei: wd: decouple and revamp watchdog state machine
  mei: wd: use watchdog_set/get_drvdata for passing mei_device

 drivers/misc/mei/init.c      |    1 -
 drivers/misc/mei/interface.h |   10 +-----
 drivers/misc/mei/interrupt.c |   13 +++----
 drivers/misc/mei/main.c      |    9 ++++-
 drivers/misc/mei/mei_dev.h   |   27 ++++++++++----
 drivers/misc/mei/wd.c        |   83 ++++++++++++++++++++++--------------------
 6 files changed, 76 insertions(+), 67 deletions(-)

-- 
1.7.4.4

