Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35398 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbdCAWjP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Mar 2017 17:39:15 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] watchdog updates for v4.11 - take 2
Date: Wed,  1 Mar 2017 14:38:59 -0800
Message-Id: <1488407939-23923-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Please pull additional watchdog updates for Linux v4.11 from
signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-linus-v4.11-2

Thanks,
Guenter
------

The following changes since commit 2d6be4abf514fc26c83d239c7f31da1f95e4a31d:

  Merge tag 'for-linus-4.11' of git://git.code.sf.net/p/openipmi/linux-ipmi (2017-02-28 21:06:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-linus-v4.11-2

for you to fetch changes up to 9ad82f117f057ed04643cc60ce16fbf59e1b167f:

  watchdog: retu: restore MFD dependency (2017-03-01 06:15:10 -0800)

----------------------------------------------------------------
watchdog updates for v4.11-rc1, take 2

Fix fallout from enabling COMPILE_TEST
Fix gcc-4.3 build of kempld watchdog driver
Use hrtimer in softdog

----------------------------------------------------------------
Arnd Bergmann (9):
      watchdog: wm831x watchdog really needs mfd
      watchdog: geode: restore hard CS5535_MFGPT dependency
      watchdog: menf21bmc: add I2C dependency
      watchdog: sp805: add back AMBA dependency
      watchdog: bcm2835: add CONFIG_OF dependency
      watchdog: kempld: revert to full dependency
      watchdog: kempld: fix gcc-4.3 build
      watchdog: db8500: add back prmcu dependency
      watchdog: retu: restore MFD dependency

Niklas Cassel (1):
      watchdog: softdog: fire watchdog even if softirqs do not get to run

 drivers/watchdog/Kconfig      | 15 ++++++++-------
 drivers/watchdog/kempld_wdt.c |  9 ++++++++-
 drivers/watchdog/softdog.c    | 44 ++++++++++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 25 deletions(-)
