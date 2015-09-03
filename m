Return-path: <panand@redhat.com>
From: Pratyush Anand <panand@redhat.com>
To: linux@roeck-us.net
Cc: dyoung@redhat.com, dzickus@redhat.com, linux-watchdog@vger.kernel.org,
        Pratyush Anand <panand@redhat.com>
Subject: [PATCH V3 0/2] watchdog: Sysfs status read support
Date: Thu,  3 Sep 2015 08:49:53 +0530
Message-Id: <cover.1441249584.git.panand@redhat.com>
List-ID: <linux-watchdog@vger.kernel.org>

These patches provide support to read different watchdog device status
through sysfs interface.

Changes since V2:
* Used static struct class watchdog_class in stead of pointer. It helped in
 keep using device_create().
* Above logic was moved to a separate patch.
* Changed subject line of other patch to look more relevant

Changes since V1(RFC):
* Removed keepalive and start ABI
* timeout is read only now
* state returns text
* only supported ABI visible
* ABI contact changed to MAINTAINER
* unnecessary mutex removed
* aligned continuation with '('
* unnecessary initialization of status (= 0) corrected
* unnecessary else removed
* used __ATTRIBUTE_GROUPS
* removed watchdog_device_create and added functionality in watchdog_dev_register.
* optimized nowayout_show
* Now no -EOPNOTSUPP return for timeout read in case of wdd->timeout = 0.

Pratyush Anand (2):
  watchdog: Use static struct class watchdog_class in stead of pointer
  watchdog: Read device status through sysfs attributes

 Documentation/ABI/testing/sysfs-class-watchdog |  51 ++++++++++
 drivers/watchdog/watchdog_core.c               |  17 +---
 drivers/watchdog/watchdog_core.h               |   2 +-
 drivers/watchdog/watchdog_dev.c                | 136 ++++++++++++++++++++++++-
 4 files changed, 187 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-watchdog

-- 
2.4.3
