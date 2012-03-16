Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:40163 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965440Ab2CPIOX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 16 Mar 2012 04:14:23 -0400
From: Linus Walleij <linus.walleij@stericsson.com>
To: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	Viresh Kumar <viresh.kumar@st.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] watchdog: Add support for WDIOC_GETTIMELEFT IOCTL in watchdog core
Date: Fri, 16 Mar 2012 09:14:00 +0100
Message-ID: <1331885640-21661-1-git-send-email-linus.walleij@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Viresh Kumar <viresh.kumar@st.com>

This patch adds support for WDIOC_GETTIMELEFT IOCTL in watchdog core. So, there
is another function pointer added to struct watchdog_ops, which can be passed by
drivers to support this IOCTL.

Related documentation is updated too.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../watchdog/convert_drivers_to_kernel_api.txt     |    4 ++++
 Documentation/watchdog/watchdog-kernel-api.txt     |    2 ++
 drivers/watchdog/watchdog_dev.c                    |    5 +++++
 include/linux/watchdog.h                           |    2 ++
 4 files changed, 13 insertions(+)

diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.txt b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
index be8119b..271b885 100644
--- a/Documentation/watchdog/convert_drivers_to_kernel_api.txt
+++ b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
@@ -59,6 +59,10 @@ Here is a overview of the functions and probably needed actions:
 	WDIOC_GETTIMEOUT:
 		No preparations needed
 
+	WDIOC_GETTIMELEFT:
+		It needs get_timeleft() callback to be defined. Otherwise it
+		will return EOPNOTSUPP
+
   Other IOCTLs can be served using the ioctl-callback. Note that this is mainly
   intended for porting old drivers; new drivers should not invent private IOCTLs.
   Private IOCTLs are processed first. When the callback returns with
diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 4b93c28..e4c4d1c 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -77,6 +77,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	unsigned int (*get_timeleft)(struct watchdog_device *);
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
@@ -122,6 +123,7 @@ they are supported. These optional routines/operations are:
   to re-program the watchdog timer device.
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
+* get_timeleft: this routines returns the time left for reset.
 * ioctl: if this routine is present then it will be called first before we do
   our own internal ioctl call handling. This routine should return -ENOIOCTLCMD
   if a command is not supported. The parameters that are passed to the ioctl
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 1199da0..fa64fb8 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -237,6 +237,11 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		if (wdd->timeout == 0)
 			return -EOPNOTSUPP;
 		return put_user(wdd->timeout, p);
+	case WDIOC_GETTIMELEFT:
+		if (!wdd->ops->get_timeleft)
+			return -EOPNOTSUPP;
+
+		return put_user(wdd->ops->get_timeleft(wdd), p);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 43ba5b3..58bc9a1 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -66,6 +66,7 @@ struct watchdog_device;
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
  * @set_timeout:The routine for setting the watchdog devices timeout value.
+ * @get_timeleft:The routine for getting the watchdog device's timeleft value.
  * @ioctl:	The routines that handles extra ioctl calls.
  *
  * The watchdog_ops structure contains a list of low-level operations
@@ -82,6 +83,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	unsigned int (*get_timeleft)(struct watchdog_device *);
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
-- 
1.7.9.2

