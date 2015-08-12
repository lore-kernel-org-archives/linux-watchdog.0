Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37899 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933534AbbHLI0k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 04:26:40 -0400
Received: by wicja10 with SMTP id ja10so17340047wic.1
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Aug 2015 01:26:39 -0700 (PDT)
Date: Wed, 12 Aug 2015 09:26:35 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Darren Hart <dvhart@infradead.org>,
	Matt Fleming <matt.fleming@intel.com>
Subject: [GIT PULL] Immutable branch between MFD, I2C, X86 and Watchdog due
 for v4.3
Message-ID: <20150812082635.GA18282@x1>
References: <1438865186-25794-1-git-send-email-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438865186-25794-1-git-send-email-matt@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Enjoy!

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-i2c-x86-watchdog-v4.3

for you to fetch changes up to 2a7a0e9bf7b32e838d873226808ab8a6c00148f7:

  watchdog: iTCO_wdt: Add support for TCO on Intel Sunrisepoint (2015-08-11 15:03:52 +0100)

----------------------------------------------------------------
Immutable branch between MFD, I2C, X86 and Watchdog due for v4.3

----------------------------------------------------------------
Matt Fleming (2):
      mfd: watchdog: iTCO_wdt: Expose watchdog properties using platform data
      watchdog: iTCO_wdt: Add support for TCO on Intel Sunrisepoint

Mika Westerberg (1):
      i2c: i801: Create iTCO device on newer Intel PCHs

 drivers/i2c/busses/i2c-i801.c          | 120 ++++++++++++++++++++++++++++++++-
 drivers/mfd/lpc_ich.c                  |  32 ++++++++-
 drivers/platform/x86/intel_pmc_ipc.c   |   9 ++-
 drivers/watchdog/Kconfig               |   3 +-
 drivers/watchdog/iTCO_wdt.c            |  82 +++++++++++++---------
 include/linux/mfd/lpc_ich.h            |   6 --
 include/linux/platform_data/itco_wdt.h |  19 ++++++
 7 files changed, 222 insertions(+), 49 deletions(-)
 create mode 100644 include/linux/platform_data/itco_wdt.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
