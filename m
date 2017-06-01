Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41139 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751078AbdFAVf2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Jun 2017 17:35:28 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v51LYdKv133615
        for <linux-watchdog@vger.kernel.org>; Thu, 1 Jun 2017 17:35:28 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2atrp2wksg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Jun 2017 17:35:27 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <cbostic@linux.vnet.ibm.com>;
        Thu, 1 Jun 2017 17:35:27 -0400
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        andrew@aj.id.au
Subject: [PATCH] drivers/watchdog: Add sys files to modify watchdog behavior
Date: Thu,  1 Jun 2017 16:35:21 -0500
Message-Id: <20170601213521.58141-1-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add files to enable/disable Aspeed watchdog:
* External signal after timeout
* Reset system after timeout

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 .../ABI/testing/sysfs-platform-aspeed-wdt          | 40 +++++++++++
 drivers/watchdog/aspeed_wdt.c                      | 79 +++++++++++++++++++++-
 2 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-aspeed-wdt

diff --git a/Documentation/ABI/testing/sysfs-platform-aspeed-wdt b/Documentation/ABI/testing/sysfs-platform-aspeed-wdt
new file mode 100644
index 0000000..a582176
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-aspeed-wdt
@@ -0,0 +1,40 @@
+What:           /sys/bus/platform/devices/1e785000.wdt/watchdog/watchdog0/
+		reset_system
+Date:           May 2017
+KernelVersion:  4.12
+Contact:        Christopher Bostic <cbostic@linux.vnet.ibm.com>
+Description:
+                Value indicates if a watchdog time out results in a reset of
+		system.  'off': no system reset on timeout.  'on' there will
+		be a system reset on timeout.
+
+                Default: off
+
+                - Enable 'reset system' on watchdog timeout:
+                echo on > /sys/bus/platform/devices/1e785000.wdt/watchdog/
+			watchdog0/reset_system;
+
+                - Disable 'reset system' on watchdog timeout:
+                echo off > /sys/bus/platform/devices/1e785000.wdt/watchdog/
+			watchdog0/reset_system;
+
+What:           /sys/bus/platform/devices/1e785000.wdt/watchdog/watchdog0/
+		ext_signal
+Date:           May 2017
+KernelVersion:  4.12
+Contact:        Christopher Bostic <cbostic@linux.vnet.ibm.com>
+Description:
+                Value indicates if a watchdog time out results in an active
+		high pulse sent out an output pin.  'off': No output pulse
+		generated on watchdog time out.  'on': output pulse
+		generated on watchdog time out.
+
+                Default: off
+
+                - Enable 'external signal' on watchdog timeout:
+                echo on > /sys/bus/platform/devices/1e785000.wdt/watchdog/
+			watchdog0/ext_signal;
+
+                - Disable 'external signal' on watchdog timeout:
+                echo off > /sys/bus/platform/devices/1e785000.wdt/watchdog/
+			watchdog0/ext_signal;
diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 1c65258..66b27e8 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -136,6 +136,83 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
 	.identity	= KBUILD_MODNAME,
 };
 
+static ssize_t aspeed_wdt_cntl_get_state(struct device *dev, char *buf,
+					uint32_t mask)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct aspeed_wdt *wdt = platform_get_drvdata(pdev);
+	int ret;
+
+	if (readl(wdt->base + WDT_CTRL) & mask)
+		ret = sprintf(buf, "on\n");
+	else
+		ret = sprintf(buf, "off\n");
+
+	return ret;
+}
+
+static ssize_t aspeed_wdt_cntl_set_state(struct device *dev, const char *buf,
+					size_t count, uint32_t mask)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct aspeed_wdt *wdt = platform_get_drvdata(pdev);
+
+	if (!strncmp(buf, "on", strlen("on"))) {
+		wdt->ctrl |= mask;
+		writel(wdt->ctrl, wdt->base + WDT_CTRL);
+	} else if (!strncmp(buf, "off", strlen("off"))) {
+		wdt->ctrl &= ~mask;
+		writel(wdt->ctrl, wdt->base + WDT_CTRL);
+	} else {
+		dev_warn(dev, "Unknown reset system mode command: [%s]\n", buf);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t aspeed_wdt_reset_system_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	return aspeed_wdt_cntl_set_state(dev, buf, count,
+					WDT_CTRL_RESET_SYSTEM);
+}
+
+static ssize_t aspeed_wdt_reset_system_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return aspeed_wdt_cntl_get_state(dev, buf, WDT_CTRL_RESET_SYSTEM);
+}
+
+static DEVICE_ATTR(reset_system, 0644,
+		aspeed_wdt_reset_system_show, aspeed_wdt_reset_system_store);
+
+static ssize_t aspeed_wdt_ext_signal_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	return aspeed_wdt_cntl_set_state(dev, buf, count, WDT_CTRL_WDT_EXT);
+}
+
+static ssize_t aspeed_wdt_ext_signal_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return aspeed_wdt_cntl_get_state(dev, buf, WDT_CTRL_WDT_EXT);
+}
+
+static DEVICE_ATTR(ext_signal, 0644,
+		aspeed_wdt_ext_signal_show, aspeed_wdt_ext_signal_store);
+
+static struct attribute *aspeed_wdt_attrs[] = {
+	&dev_attr_reset_system.attr,
+	&dev_attr_ext_signal.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(aspeed_wdt);
+
 static int aspeed_wdt_probe(struct platform_device *pdev)
 {
 	struct aspeed_wdt *wdt;
@@ -160,7 +237,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.ops = &aspeed_wdt_ops;
 	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
 	wdt->wdd.parent = &pdev->dev;
-
+	wdt->wdd.groups = aspeed_wdt_groups;
 	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
 	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
 
-- 
1.8.2.2

