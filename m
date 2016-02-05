Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:58380 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751828AbcBEB2B (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Feb 2016 20:28:01 -0500
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, joshc@ni.com
Subject: [RFC 4/4] watchdog: ni9x3x_wdt: Let user control watchdog mode
Date: Thu, 4 Feb 2016 19:28:03 -0600
Message-Id: <1454635683-13668-4-git-send-email-kyle.roeschley@ni.com>
In-Reply-To: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When first powering on, the NI 903x/913x watchdog starts in boot mode.
If not switched from boot mode to user mode within 30 seconds of power
on, the device status LED indicates an unrecoverable error. While before
this was handled automatically, now add a module parameter to disable
this behavior.

In order to still have a useful watchdog, also add a R/W sysfs attribute
`mode' which can be used to switch the watchdog mode from boot to user
mode (but not user to boot mode).

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
 drivers/watchdog/ni9x3x_wdt.c | 52 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/ni9x3x_wdt.c b/drivers/watchdog/ni9x3x_wdt.c
index 1fce4d0..ba660b0 100644
--- a/drivers/watchdog/ni9x3x_wdt.c
+++ b/drivers/watchdog/ni9x3x_wdt.c
@@ -46,6 +46,14 @@
 
 #define to_ni9x3x_wdt(_wdog)	container_of(_wdog, struct ni9x3x_wdt, wdog)
 
+static bool auto_mode_switch = true;
+module_param(auto_mode_switch, bool, 0);
+MODULE_PARM_DESC(auto_mode_switch,
+		 "Automatically switch to user mode on driver load. If not"
+		 "set, the user must manually switch the timer within 30"
+		 "seconds of power on or the system will reset."
+		 "(default=true)");
+
 struct ni9x3x_wdt {
 	struct acpi_device *acpi_device;
 	u16 io_base;
@@ -242,9 +250,48 @@ static ssize_t counter_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(counter);
 
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct ni9x3x_wdt *wdt = acpi_driver_data(acpi_dev);
+	u8 control;
+
+	control = inb(wdt->io_base + NIWD_CONTROL);
+
+	control &= NIWD_CONTROL_MODE;
+
+	return sprintf(buf, "%s\n", control ? "boot" : "user");
+}
+
+static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct ni9x3x_wdt *wdt = acpi_driver_data(acpi_dev);
+	u8 control;
+
+	/* You can only switch boot->user */
+	if (strcmp(buf, "user"))
+		return -EINVAL;
+
+	control = inb(wdt->io_base + NIWD_CONTROL);
+
+	/* Check if we're already in user mode */
+	if (!(control & NIWD_CONTROL_MODE))
+		return count;
+
+	control = NIWD_CONTROL_MODE | NIWD_CONTROL_RESET;
+	outb(control, wdt->io_base + NIWD_CONTROL);
+
+	return count;
+}
+static DEVICE_ATTR_RW(mode);
+
 static struct attribute *ni9x3x_wdt_attrs[] = {
 	&dev_attr_timeout_action.attr,
 	&dev_attr_counter.attr,
+	&dev_attr_mode.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(ni9x3x_wdt);
@@ -364,8 +411,9 @@ static int ni9x3x_wdt_acpi_add(struct acpi_device *device)
 	}
 
 	/* Switch from boot mode to user mode */
-	outb(NIWD_CONTROL_RESET | NIWD_CONTROL_MODE,
-	     wdt->io_base + NIWD_CONTROL);
+	if (auto_mode_switch)
+		outb(NIWD_CONTROL_RESET | NIWD_CONTROL_MODE,
+		     wdt->io_base + NIWD_CONTROL);
 
 	dev_info(&wdt->acpi_device->dev, "IO range 0x%04X-0x%04X\n, IRQ %d\n",
 		 wdt->io_base, wdt->io_base + wdt->io_size - 1, wdt->irq);
-- 
2.7.0

