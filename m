Return-path: <panand@redhat.com>
From: Pratyush Anand <panand@redhat.com>
To: wim@iguana.be
Cc: dyoung@redhat.com, dzickus@redhat.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, Pratyush Anand <panand@redhat.com>
Subject: [PATCH V5 0/2] watchdog: Sysfs status read support
Date: Thu, 17 Dec 2015 17:53:57 +0530
Message-Id: <cover.1450353452.git.panand@redhat.com>
List-ID: <linux-watchdog@vger.kernel.org>

These patches provide support to read different watchdog device status
through sysfs interface.
 
Changes since V4:
* All sysfs code has been protected under CONFIG_WATCHDOG_SYSFS

Changes since V3:                                                                                    
* Added Reviewed by tag
* Corrected a checkpatch warning             

Changes since V2: 
* Used static struct class watchdog_class in stead of pointer. It helped to 
keep using device_create(). 
* Above logic was moved to a separate patch.  Changed subject line of other
patch to look more relevant  

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
* removed watchdog_device_create and added functionality in
* watchdog_dev_register.
* optimized nowayout_show
* Now no -EOPNOTSUPP return for timeout read in case of
* wdd->timeout = 0.         

Pratyush Anand (2):
  watchdog: Use static struct class watchdog_class in stead of pointer
  watchdog: Read device status through sysfs attributes

 Documentation/ABI/testing/sysfs-class-watchdog |  51 +++++++++
 drivers/watchdog/Kconfig                       |   7 ++
 drivers/watchdog/watchdog_core.c               |  17 +--
 drivers/watchdog/watchdog_core.h               |   2 +-
 drivers/watchdog/watchdog_dev.c                | 140 ++++++++++++++++++++++++-
 5 files changed, 198 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-watchdog

-- 
2.5.0
