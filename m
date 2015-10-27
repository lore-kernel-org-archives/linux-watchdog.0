Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41032 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbJ0VUU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Oct 2015 17:20:20 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] watchdog updates for Linux 4.4
Date: Tue, 27 Oct 2015 14:20:17 -0700
Message-Id: <1445980817-24937-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

This is my watchdog pull request for 4.4. The branch is currently based
on v4.3-rc7. It includes a merge with the immutable branch published by Lee
Jones.

Please consider pulling watchdog updates for Linux 4.4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim-4.4

The tag has been applied on top of the watchdog-next branch. The branch includes
a number of patches I collected over the last few months. It does not include
all submitted patches; only the ones I reviewed and felt comfortable with are
included. Some may already be in your -next branch.

I reviewed all patches and ran build tests as well as source verification tests
with both smatch and spatch. The branch has been on my Linux repository for a
while, so presumably Fenguang's robot will have built the code as well. The most
recent build results are available at http://server.roeck-us.net:8010/builders,
in the watchdog-next column.

If you don't want to apply the entire series, please consider applying whatever
subset you might feel comfortable with.

Thanks,
Guenter
------

The following changes since commit 32b88194f71d6ae7768a29f87fbba454728273ee:

  Linux 4.3-rc7 (2015-10-25 10:39:47 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-wim-4.4

for you to fetch changes up to b34bae0a422c71b9fda5b220b5861d6a156f9056:

  watchdog: core: propagate ping error code to the user space (2015-10-26 19:01:42 -0700)

----------------------------------------------------------------
Watchdog patches queued for v4.4

b34bae0a422c watchdog: core: propagate ping error code to the user space
3c4e349966e5 watchdog: watchdog_dev: Use single variable name for struct watchdog_device
b2604ea134d8 watchdog: Always evaluate new timeout against min_timeout
77751aa7027e wdt: intel-mid: add Magic Closure flag
a3f795e41cec watchdog: imx2_wdt: Use register definition in regmap_write()
977e2e2b09f1 watchdog: Read device status through sysfs attributes
ba38f75e28c1 watchdog: Use static struct class watchdog_class in stead of pointer
4193ae79561c watchdog_dev: Use device tree alias for naming watchdogs
28c2845d1de4 watchdog: Watchdog driver for Broadcom Set-Top Box
6e7a6a17b1e3 watchdog: bcm7038: add device tree binding documentation

----------------------------------------------------------------
Alexander Usyskin (1):
      watchdog: core: propagate ping error code to the user space

David Cohen (1):
      wdt: intel-mid: add Magic Closure flag

Fabio Estevam (1):
      watchdog: imx2_wdt: Use register definition in regmap_write()

Guenter Roeck (2):
      watchdog: Always evaluate new timeout against min_timeout
      watchdog: watchdog_dev: Use single variable name for struct watchdog_device

Justin Chen (3):
      watchdog: bcm7038: add device tree binding documentation
      watchdog: Watchdog driver for Broadcom Set-Top Box
      watchdog_dev: Use device tree alias for naming watchdogs

Pratyush Anand (2):
      watchdog: Use static struct class watchdog_class in stead of pointer
      watchdog: Read device status through sysfs attributes

 Documentation/ABI/testing/sysfs-class-watchdog     |  51 ++++
 .../bindings/watchdog/brcm,bcm7038-wdt.txt         |  19 ++
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bcm7038_wdt.c                     | 237 ++++++++++++++++
 drivers/watchdog/imx2_wdt.c                        |   6 +-
 drivers/watchdog/intel-mid_wdt.c                   |   2 +-
 drivers/watchdog/watchdog_core.c                   |  32 +--
 drivers/watchdog/watchdog_core.h                   |   2 +-
 drivers/watchdog/watchdog_dev.c                    | 299 +++++++++++++++------
 include/linux/watchdog.h                           |  11 +-
 11 files changed, 561 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-watchdog
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
 create mode 100644 drivers/watchdog/bcm7038_wdt.c
