Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51236 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754304AbbESI0r (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 04:26:47 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv8 05/10] Documentation/watchdog: Document watchdog core API changes
Date: Tue, 19 May 2015 11:26:04 +0300
Message-Id: <1432023969-20736-6-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Watchdog core API has changed somewhat and drivers are expected to
change. Document the new requirements so that driver writers know how
to do the change properly.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 .../watchdog/convert_drivers_to_kernel_api.txt     | 26 ++++++++
 Documentation/watchdog/watchdog-kernel-api.txt     | 71 +++++++++++++---------
 2 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.txt b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
index 271b885..c9ba973 100644
--- a/Documentation/watchdog/convert_drivers_to_kernel_api.txt
+++ b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
@@ -185,6 +185,32 @@ by adding a module parameter. The conversion for this would be something like:
 The module parameter itself needs to stay, everything else related to nowayout
 can go, though. This will likely be some code in open(), close() or write().
 
+Remove possible adhoc timer code
+--------------------------------
+
+The watchdog core is capable of handling various features many
+watchdog hardware are missing, such as emulating stopped watchdog with
+unstoppable hardware or extending the timeout when hardware only
+supports very short timeout values. Traditionally watchdog drivers
+needed to implement code of their own to work around the hardware
+limitations. Now it is enough to record the watchdog boot time status
+with watchdog_set_hw_active() function and the watchdog core takes
+care of starting or stopping the watchdog, depending on the used
+policy. If watchdog cannot be stopped, the stop() function should
+return -ENOTSUPP and let core emulate stopping the watchdog.
+
+Initialize parameters with watchdog_init_params()
+-------------------------------------------------
+
+There are parameters that the watchdog driver does not need to be
+aware of and there are parameters that are optional to the driver. The
+watchdog_init_params() function takes care of validating the mandatory
+parameters and filling in reasonable values for the optional ones.
+
+What the driver MUST do is to fill in hw_max_timeout value in
+milliseconds, record the current watchdog hardware active status with
+watchdog_set_hw_active() and then call watchdog_init_params() and
+check the return value to see that everything went right.
 
 Register the watchdog device
 ----------------------------
diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index a0438f3..265306c 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -11,12 +11,21 @@ It also does not describe the API which can be used by user space to communicate
 with a WatchDog Timer. If you want to know this then please read the following
 file: Documentation/watchdog/watchdog-api.txt .
 
-So what does this document describe? It describes the API that can be used by
-WatchDog Timer Drivers that want to use the WatchDog Timer Driver Core
-Framework. This framework provides all interfacing towards user space so that
-the same code does not have to be reproduced each time. This also means that
-a watchdog timer driver then only needs to provide the different routines
-(operations) that control the watchdog timer (WDT).
+So what does this document describe? It describes the API that can be
+used by WatchDog Timer Drivers that want to use the WatchDog Timer
+Driver Core Framework. This framework provides all interfacing towards
+user space so that the same code does not have to be reproduced each
+time. This also means that a watchdog timer driver then only needs to
+provide the different routines (operations) that control the watchdog
+timer (WDT).
+
+The Watchdog Timer Driver Core also intermediates between the user
+space and the driver and provides same user experience to the user
+space regardless of the hardware limitations. For example, some
+watchdog hardware can not be stopped or they have very short maximum
+keepalive timeout. In such case watchdog core can emulate a stopped
+watchdog device or extend watchdog timeout by pinging periodically the
+watchdog driver on behalf of the user space.
 
 The API
 -------
@@ -48,7 +57,8 @@ struct watchdog_device {
 	unsigned int bootstatus;
 	unsigned int timeout;
 	unsigned int min_timeout;
-	unsigned int max_timeout;
+	unsigned int hw_max_timeout;
+	unsigned int hw_keepalive;
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
@@ -69,7 +79,8 @@ It contains following fields:
 * ops: a pointer to the list of watchdog operations that the watchdog supports.
 * timeout: the watchdog timer's timeout value (in seconds).
 * min_timeout: the watchdog timer's minimum timeout value (in seconds).
-* max_timeout: the watchdog timer's maximum timeout value (in seconds).
+* hw_max_timeout: the watchdog timer's maximum timeout value supported
+  in hardware (in milliseconds).
 * bootstatus: status of the device after booting (reported with watchdog
   WDIOF_* status bits).
 * driver_data: a pointer to the drivers private data of a watchdog device.
@@ -124,12 +135,13 @@ are:
   The routine needs a pointer to the watchdog timer device structure as a
   parameter. It returns zero on success or a negative errno code for failure.
 * stop: with this routine the watchdog timer device is being stopped.
-  The routine needs a pointer to the watchdog timer device structure as a
-  parameter. It returns zero on success or a negative errno code for failure.
-  Some watchdog timer hardware can only be started and not be stopped. The
-  driver supporting this hardware needs to make sure that a start and stop
-  routine is being provided. This can be done by using a timer in the driver
-  that regularly sends a keepalive ping to the watchdog timer hardware.
+  The routine needs a pointer to the watchdog timer device structure
+  as a parameter. It returns zero on success or a negative errno code
+  for failure. Some watchdog timer hardware can only be started and
+  not be stopped. If the watchdog timer can not be stopped, the stop
+  routine must return -ENOTSUPP error code. The watchdog core can then
+  take care of pinging the watchdog hardware while user space expects
+  it to be stopped.
 
 Not all watchdog timer hardware supports the same functionality. That's why
 all other routines/operations are optional. They only need to be provided if
@@ -168,10 +180,11 @@ they are supported. These optional routines/operations are:
 
 The status bits should (preferably) be set with the set_bit and clear_bit alike
 bit-operations. The status bits that are defined are:
-* WDOG_ACTIVE: this status bit indicates whether or not a watchdog timer device
-  is active or not. When the watchdog is active after booting, then you should
-  set this status bit (Note: when you register the watchdog timer device with
-  this bit set, then opening /dev/watchdog will skip the start operation)
+* WDOG_ACTIVE: this status bit indicates whether or not a watchdog
+  timer hardware is active or not. When the watchdog is active after
+  booting, then you should set this status bit (Note: when you
+  register the watchdog timer device with this bit set, then opening
+  /dev/watchdog will skip the start operation)
 * WDOG_DEV_OPEN: this status bit shows whether or not the watchdog device
   was opened via /dev/watchdog.
   (This bit should only be used by the WatchDog Timer Driver Core).
@@ -213,14 +226,14 @@ The watchdog_get_drvdata function allows you to retrieve driver specific data.
 The argument of this function is the watchdog device where you want to retrieve
 data from. The function returns the pointer to the driver specific data.
 
-To initialize the timeout field, the following function can be used:
-
-extern int watchdog_init_timeout(struct watchdog_device *wdd,
-                                  unsigned int timeout_parm, struct device *dev);
-
-The watchdog_init_timeout function allows you to initialize the timeout field
-using the module timeout parameter or by retrieving the timeout-sec property from
-the device tree (if the module timeout parameter is invalid). Best practice is
-to set the default timeout value as timeout value in the watchdog_device and
-then use this function to set the user "preferred" timeout value.
-This routine returns zero on success and a negative errno code for failure.
+You can initialize timeout field in the watchdog_device structure
+eg. based from a module parameter in case user has a preference over
+the initial timeout when loading the module.
+
+Your driver also must fill in appropriate hw_max_timeout value in the
+watchdog_device structure and then call watchdog_init_params
+function. This function will initialize watchdog internal parameters
+and fill in missing values, such as timeout value. The function can
+use device tree to fill in the necessary values, but it does not
+override timeout value set by the driver. In case invalid values are
+given, watchdog_inint_params returns a negative error.
-- 
2.1.0

