Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37102 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbbG2MKu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 08:10:50 -0400
Received: by wibud3 with SMTP id ud3so23210304wib.0
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2015 05:10:48 -0700 (PDT)
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
Subject: [PATCH v2 0/3] iTCO_wdt: Add support for Intel Sunrisepoint 
Date: Wed, 29 Jul 2015 13:10:41 +0100
Message-Id: <1438171844-24861-1-git-send-email-matt@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Matt Fleming <matt.fleming@intel.com>

Starting with Intel Sunrisepoint (Skylake PCH) the TCO watchdog device
is now on the SMBUS, whereas for previous ICH/PCH it was on the LPC bus.

Because iTCO_wdt devices may now appear on either the LPC bus or the
SMBUS we need to abstract the bus information into an agnostic structure
instead of the existing 'lpc_ich_info' which tightly integrates both the
lpc_ich and iTCO_wdt drivers.

The first patch introduces a platform data structure to handle this and
shuffles the existing code around. The other patches add the
device-specific information to the i2c-i801 and iTCO_wdt drivers.

Patches based against v4.2-rc4, if there's some other tree I should base
this on, please let me know.

Comments welcome!

Changes in v2:

 - Use lowercase for all new files and data structures
 - Allocate platform data with devm_kzalloc()
 - Move Kconfig changes to final patch and use 'select', not 'depends'
 - Swap strcpy() for strlcpy()
 - Fixup use of lpc_ich_info in intel_pmc_ipc which was missed in v1
 - Don't use bitops in i2c-i801
 - Remove superfluous NULL checks in i2c-i801
 - Explicitly list reboot bit versions in no_reboot_bit()
 - Use switch/case construst instead of crazy if else
 - Fold original fixups from PATCH 4 and 5 into PATCH 1 and 2


Matt Fleming (2):
  iTCO_wdt: Expose watchdog properties using platform data
  iTCO_wdt: Add support for TCO on Intel Sunrisepoint

Mika Westerberg (1):
  i2c: i801: Create iTCO device on newer Intel PCHs

 drivers/i2c/busses/i2c-i801.c          | 120 ++++++++++++++++++++++++++++++++-
 drivers/mfd/lpc_ich.c                  |  32 ++++++++-
 drivers/platform/x86/intel_pmc_ipc.c   |   9 ++-
 drivers/watchdog/Kconfig               |   3 +-
 drivers/watchdog/iTCO_wdt.c            |  77 ++++++++++++---------
 include/linux/mfd/lpc_ich.h            |   6 --
 include/linux/platform_data/itco_wdt.h |  19 ++++++
 7 files changed, 219 insertions(+), 47 deletions(-)
 create mode 100644 include/linux/platform_data/itco_wdt.h

-- 
2.1.0

