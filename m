Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:1245 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbcERD0K (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 May 2016 23:26:10 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: qipeng.zha@intel.com, jonathan.yong@intel.com
Subject: [PATCH 0/2] Correct iTCO Watchdog for Apollo Lake
Date: Wed, 18 May 2016 03:26:10 +0000
Message-Id: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

These patches fix the iTCO watchdog for Apollo Lake.
I changed the watchdog memory io to only use 4 bytes rather
the whole region, I'm not sure if that is the correct way.

Let me know if the patches need changes.
Please CC me as I am not subscribed, thanks.

Yong, Jonathan (2):
  watchdog: iTCO-wdt handle 5th variation for Apollo Lake
  x86: Fix Apollo Lake Watchdog address in PMC driver

 drivers/platform/x86/intel_pmc_ipc.c | 10 ++++++----
 drivers/watchdog/iTCO_wdt.c          |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.7.3

