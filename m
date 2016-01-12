Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:55980 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761277AbcALAXF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jan 2016 19:23:05 -0500
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH 2/2] niwatchdog: add support for custom ioctls
Date: Mon, 11 Jan 2016 18:23:01 -0600
Message-Id: <1452558181-19511-2-git-send-email-kyle.roeschley@ni.com>
In-Reply-To: <1452558181-19511-1-git-send-email-kyle.roeschley@ni.com>
References: <1452558181-19511-1-git-send-email-kyle.roeschley@ni.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add custom ioctls for features specific to the NI watchdog, including
disabling the watchdog, changing timeout behavior, and setting timeouts
with sub-second resolution.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
---
 drivers/watchdog/niwatchdog.c   | 115 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/niwatchdog.h |  10 ++++
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/niwatchdog.c b/drivers/watchdog/niwatchdog.c
index 3908846..fe637a3 100644
--- a/drivers/watchdog/niwatchdog.c
+++ b/drivers/watchdog/niwatchdog.c
@@ -131,6 +131,35 @@ out_unlock:
 	return ret;
 }
 
+static int niwatchdog_check_action(u32 action)
+{
+	int err = 0;
+
+	switch (action) {
+	case NIWD_CONTROL_PROC_INTERRUPT:
+	case NIWD_CONTROL_PROC_RESET:
+		break;
+	default:
+		err = -ENOTSUPP;
+	}
+
+	return err;
+}
+
+static void niwatchdog_get_actions(struct niwatchdog *niwatchdog, u8 *actions)
+{
+	u8 control;
+	unsigned long flags;
+
+	spin_lock_irqsave(&niwatchdog->lock, flags);
+
+	control = inb(niwatchdog->io_base + NIWD_CONTROL);
+	*actions = control & (NIWD_CONTROL_PROC_INTERRUPT +
+			      NIWD_CONTROL_PROC_RESET);
+
+	spin_unlock_irqrestore(&niwatchdog->lock, flags);
+}
+
 static int niwatchdog_add_action(struct niwatchdog *niwatchdog, u32 action)
 {
 	u8 action_mask;
@@ -233,12 +262,20 @@ static int niwatchdog_wdd_set_timeout(struct watchdog_device *wdd,
 {
 	struct niwatchdog *niwatchdog = to_niwatchdog(wdd);
 	u32 counter = timeout * (1000000000 / NIWD_PERIOD_NS);
+	u8 actions;
 
+	niwatchdog_get_actions(niwatchdog, &actions);
 	niwatchdog_reset(niwatchdog);
 	niwatchdog_counter_set(niwatchdog, counter);
-	niwatchdog_add_action(niwatchdog, NIWATCHDOG_ACTION_RESET);
 
-	return niwatchdog_start(niwatchdog);
+	if (actions & NIWD_CONTROL_PROC_RESET)
+		niwatchdog_add_action(niwatchdog, NIWATCHDOG_ACTION_RESET);
+	if (actions & NIWD_CONTROL_PROC_INTERRUPT)
+		niwatchdog_add_action(niwatchdog, NIWATCHDOG_ACTION_INTERRUPT);
+
+	niwatchdog_start(niwatchdog);
+
+	return 0;
 }
 
 static unsigned int niwatchdog_wdd_get_timeleft(struct watchdog_device *wdd)
@@ -319,6 +356,79 @@ static int niwatchdog_wdd_release(struct watchdog_device *wdd)
 	return 0;
 }
 
+static long niwatchdog_wdd_ioctl(struct watchdog_device *wdd, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct niwatchdog *niwatchdog = to_niwatchdog(wdd);
+	int err = 0;
+
+	switch (cmd) {
+	case NIWATCHDOG_IOCTL_PERIOD_NS: {
+		__u32 period = NIWD_PERIOD_NS;
+
+		err = copy_to_user((__u32 *)arg, &period, sizeof(__u32));
+		break;
+	}
+	case NIWATCHDOG_IOCTL_MAX_COUNTER: {
+		__u32 counter = NIWD_MAX_COUNTER;
+
+		err = copy_to_user((__u32 *)arg, &counter, sizeof(__u32));
+		break;
+	}
+	case NIWATCHDOG_IOCTL_COUNTER_SET: {
+		__u32 counter;
+
+		err = copy_from_user(&counter, (__u32 *)arg, sizeof(__u32));
+		if (!err)
+			err = niwatchdog_counter_set(niwatchdog, counter);
+		break;
+	}
+	case NIWATCHDOG_IOCTL_CHECK_ACTION: {
+		__u32 action;
+
+		err = copy_from_user(&action, (__u32 *)arg, sizeof(__u32));
+		if (!err)
+			err = niwatchdog_check_action(action);
+		break;
+	}
+	case NIWATCHDOG_IOCTL_ADD_ACTION: {
+		__u32 action;
+
+		err = copy_from_user(&action, (__u32 *)arg, sizeof(__u32));
+		if (!err)
+			err = niwatchdog_add_action(niwatchdog, action);
+		break;
+	}
+	case NIWATCHDOG_IOCTL_START: {
+		niwatchdog_start(niwatchdog);
+		break;
+	}
+	case NIWATCHDOG_IOCTL_PET: {
+		__u32 state;
+
+		niwatchdog_pet(niwatchdog, &state);
+		err = copy_to_user((__u32 *)arg, &state, sizeof(__u32));
+		break;
+	}
+	case NIWATCHDOG_IOCTL_RESET: {
+		niwatchdog_reset(niwatchdog);
+		break;
+	}
+	case NIWATCHDOG_IOCTL_COUNTER_GET: {
+		__u32 counter;
+
+		niwatchdog_counter_get(niwatchdog, &counter);
+		err = copy_to_user((__u32 *)arg, &counter, sizeof(__u32));
+		break;
+	}
+	default:
+		err = -ENOIOCTLCMD;
+		break;
+	};
+
+	return err;
+}
+
 static int niwatchdog_ping(struct watchdog_device *wdd)
 {
 	struct niwatchdog *niwatchdog = to_niwatchdog(wdd);
@@ -403,6 +513,7 @@ static const struct watchdog_ops niwatchdog_wdd_ops = {
 	.start		= niwatchdog_wdd_open,
 	.stop		= niwatchdog_wdd_release,
 	.ping		= niwatchdog_ping,
+	.ioctl		= niwatchdog_wdd_ioctl,
 	.set_timeout	= niwatchdog_wdd_set_timeout,
 	.get_timeleft	= niwatchdog_wdd_get_timeleft,
 };
diff --git a/include/uapi/linux/niwatchdog.h b/include/uapi/linux/niwatchdog.h
index 9d3613d..4fb8d47 100644
--- a/include/uapi/linux/niwatchdog.h
+++ b/include/uapi/linux/niwatchdog.h
@@ -25,6 +25,16 @@
 #define NIWATCHDOG_STATE_EXPIRED	1
 #define NIWATCHDOG_STATE_DISABLED	2
 
+#define NIWATCHDOG_IOCTL_PERIOD_NS	_IOR('W', 60, __u32)
+#define NIWATCHDOG_IOCTL_MAX_COUNTER	_IOR('W', 61, __u32)
+#define NIWATCHDOG_IOCTL_COUNTER_SET	_IOW('W', 62, __u32)
+#define NIWATCHDOG_IOCTL_CHECK_ACTION	_IOW('W', 63, __u32)
+#define NIWATCHDOG_IOCTL_ADD_ACTION	_IOW('W', 64, __u32)
+#define NIWATCHDOG_IOCTL_START		_IO('W', 65)
+#define NIWATCHDOG_IOCTL_PET		_IOR('W', 66, __u32)
+#define NIWATCHDOG_IOCTL_RESET		_IO('W', 67)
+#define NIWATCHDOG_IOCTL_COUNTER_GET	_IOR('W', 68, __u32)
+
 #define NIWATCHDOG_NAME			"niwatchdog"
 
 #endif /* _LINUX_NIWATCHDOG_H_ */
-- 
2.6.4

