Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63874 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818AbcFQAg5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Jun 2016 20:36:57 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: qipeng.zha@intel.com, linux@roeck-us.net, dvhart@infradead.org,
	linux-kernel@vger.kernel.org, jonathan.yong@intel.com
Subject: [PATCH v2 0/2] Correct iTCO Watchdog for Apollo Lake
Date: Fri, 17 Jun 2016 00:36:55 +0000
Message-Id: <1466123817-50679-1-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

These patches fix the iTCO watchdog for Apollo Lake.
I changed the watchdog memory io to only use 4 bytes rather
the whole region, I'm not sure if that is the correct way.

The previous 0x30h offset in intel_pmc_ipc.c was for based
on the earlier BXT-M platform. Apollo Lake has it at 0x40h.

Let me know if the patches need changes.
Please CC me as I am not subscribed, thanks.

* Resent, typo in linux-kernel email address

Changes since v1:
	* Watchdog NO_REBOOT bit off-by-one corrected.

Yong, Jonathan (2):
  watchdog: iTCO-wdt handle 5th variation for Apollo Lake
  x86: Fix Apollo Lake Watchdog address in PMC driver

 drivers/platform/x86/intel_pmc_ipc.c | 10 ++++++----
 drivers/watchdog/iTCO_wdt.c          |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.7.3

