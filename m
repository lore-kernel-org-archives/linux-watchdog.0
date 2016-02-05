Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:35047 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751826AbcBEB2B (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Feb 2016 20:28:01 -0500
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, joshc@ni.com
Subject: [RFC 3/4] watchdog: ni9x3x_wdt: Add timeout_action sysfs attribute
Date: Thu, 4 Feb 2016 19:28:02 -0600
Message-Id: <1454635683-13668-3-git-send-email-kyle.roeschley@ni.com>
In-Reply-To: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The NI 903x/913x watchdog has the ability to either assert an interrupt
or reset the system on timeout, so expose this option via s sysfs
attribute.

RFC because we can't use the watchdog core lock inside the _show and
_store functions, so we're left without any protection on setting or
reading the control register. The options right now are either add our
own lock and double lock everything or force access to the watchdog core
lock. We don't want to do either, so for now we do nothing.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
 drivers/watchdog/ni9x3x_wdt.c | 106 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/ni9x3x_wdt.c b/drivers/watchdog/ni9x3x_wdt.c
index 13f5c10..1fce4d0 100644
--- a/drivers/watchdog/ni9x3x_wdt.c
+++ b/drivers/watchdog/ni9x3x_wdt.c
@@ -15,6 +15,7 @@
 #include <linux/acpi.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/sysfs.h>
 #include <linux/watchdog.h>
 
 #define NIWD_CONTROL	0x01
@@ -28,6 +29,7 @@
 #define NIWD_IO_SIZE	0x08
 
 #define NIWD_CONTROL_MODE		0x80
+#define NIWD_CONTROL_PROC_INTERRUPT	0x40
 #define NIWD_CONTROL_PROC_RESET		0x20
 #define NIWD_CONTROL_PET		0x10
 #define NIWD_CONTROL_RUNNING		0x08
@@ -48,6 +50,7 @@ struct ni9x3x_wdt {
 	struct acpi_device *acpi_device;
 	u16 io_base;
 	u16 io_size;
+	u32 irq;
 	spinlock_t lock;
 	struct watchdog_device wdog;
 };
@@ -101,6 +104,34 @@ static unsigned int ni9x3x_wdt_wdd_get_timeleft(struct watchdog_device *wdd)
 	return (unsigned int)((counter * (u64)NIWD_PERIOD_NS) / 1000000000);
 }
 
+static irqreturn_t ni9x3x_wdt_irq_handler(int irq, void *data)
+{
+	struct ni9x3x_wdt *wdt = data;
+	irqreturn_t ret = IRQ_NONE;
+	u8 control;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdt->lock, flags);
+
+	control = inb(wdt->io_base + NIWD_CONTROL);
+
+	if (!(NIWD_CONTROL_ALARM & control)) {
+		dev_err(&wdt->acpi_device->dev,
+			"Spurious watchdog interrupt, 0x%02X\n", control);
+		goto out_unlock;
+	}
+
+	/* Acknowledge the interrupt. */
+	outb(control | NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
+
+	ret = IRQ_HANDLED;
+
+out_unlock:
+	spin_unlock_irqrestore(&wdt->lock, flags);
+
+	return ret;
+}
+
 static int ni9x3x_wdt_wdd_start(struct watchdog_device *wdd)
 {
 	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
@@ -134,6 +165,55 @@ static int ni9x3x_wdt_wdd_ping(struct watchdog_device *wdd)
 	return 0;
 }
 
+static ssize_t timeout_action_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct ni9x3x_wdt *wdt = acpi_driver_data(acpi_dev);
+	u8 control;
+
+	control = inb(wdt->io_base + NIWD_CONTROL);
+
+	if (control & NIWD_CONTROL_PROC_RESET)
+		return sprintf(buf, "reset\n");
+	if (control & NIWD_CONTROL_PROC_INTERRUPT)
+		return sprintf(buf, "interrupt\n");
+	else
+		return sprintf(buf, "\n");
+}
+
+static ssize_t timeout_action_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct ni9x3x_wdt *wdt = acpi_driver_data(acpi_dev);
+	bool interrupt_not_reset;
+	u8 control;
+
+	if (!strcmp(buf, "interrupt"))
+		interrupt_not_reset = true;
+	else if (!strcmp(buf, "reset"))
+		interrupt_not_reset = false;
+	else
+		return -EINVAL;
+
+	control = inb(wdt->io_base + NIWD_CONTROL);
+	if (interrupt_not_reset) {
+		control |= NIWD_CONTROL_PROC_INTERRUPT;
+		control &= !NIWD_CONTROL_PROC_RESET;
+	} else {
+		control |= NIWD_CONTROL_PROC_RESET;
+		control &= !NIWD_CONTROL_PROC_INTERRUPT;
+	}
+
+	outb(control, wdt->io_base + NIWD_CONTROL);
+
+	return count;
+}
+static DEVICE_ATTR_RW(timeout_action);
+
 static ssize_t counter_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -163,6 +243,7 @@ static ssize_t counter_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RW(counter);
 
 static struct attribute *ni9x3x_wdt_attrs[] = {
+	&dev_attr_timeout_action.attr,
 	&dev_attr_counter.attr,
 	NULL
 };
@@ -185,6 +266,17 @@ static acpi_status ni9x3x_wdt_resources(struct acpi_resource *res, void *data)
 
 		return AE_OK;
 
+	case ACPI_RESOURCE_TYPE_IRQ:
+		if (wdt->irq != 0) {
+			dev_err(&wdt->acpi_device->dev,
+				"too many IRQ resources\n");
+			return AE_ERROR;
+		}
+
+		wdt->irq = res->data.irq.interrupts[0];
+
+		return AE_OK;
+
 	case ACPI_RESOURCE_TYPE_END_TAG:
 		return AE_OK;
 
@@ -237,7 +329,7 @@ static int ni9x3x_wdt_acpi_add(struct acpi_device *device)
 	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 				     ni9x3x_wdt_resources, wdt);
 	if (ACPI_FAILURE(status) || wdt->io_base == 0 ||
-	    wdt->io_size != NIWD_IO_SIZE) {
+	    wdt->io_size != NIWD_IO_SIZE || wdt->irq == 0) {
 		dev_err(&device->dev, "failed to get resources\n");
 		return -ENODEV;
 	}
@@ -250,6 +342,13 @@ static int ni9x3x_wdt_acpi_add(struct acpi_device *device)
 
 	spin_lock_init(&wdt->lock);
 
+	ret = devm_request_irq(&device->dev, wdt->irq, ni9x3x_wdt_irq_handler,
+			       0, NI9X3X_WDT_NAME, wdt);
+	if (ret) {
+		dev_err(&device->dev, "failed to register interrupt\n");
+		return ret;
+	}
+
 	wdt->wdog.info = &ni9x3x_wdt_wdd_info;
 	wdt->wdog.ops = &ni9x3x_wdt_wdd_ops;
 	wdt->wdog.min_timeout = NIWD_MIN_TIMEOUT;
@@ -268,8 +367,9 @@ static int ni9x3x_wdt_acpi_add(struct acpi_device *device)
 	outb(NIWD_CONTROL_RESET | NIWD_CONTROL_MODE,
 	     wdt->io_base + NIWD_CONTROL);
 
-	dev_info(&wdt->acpi_device->dev, "IO range 0x%04X-0x%04X\n",
-		 wdt->io_base, wdt->io_base + wdt->io_size - 1);
+	dev_info(&wdt->acpi_device->dev, "IO range 0x%04X-0x%04X\n, IRQ %d\n",
+		 wdt->io_base, wdt->io_base + wdt->io_size - 1, wdt->irq);
+
 	return 0;
 }
 
-- 
2.7.0

