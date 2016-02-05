Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:58381 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751784AbcBEB2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Feb 2016 20:28:01 -0500
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, joshc@ni.com
Subject: [RFC 2/4] watchdog: ni9x3x_wdt: Add counter sysfs attribute
Date: Thu, 4 Feb 2016 19:28:01 -0600
Message-Id: <1454635683-13668-2-git-send-email-kyle.roeschley@ni.com>
In-Reply-To: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The NI 9x3x watchdog timer has 30.72 µs resolution, so expose this
by allowing the user to set the timeout counter directly via a sysfs
attribute.

RFC because we can't use the watchdog core lock inside the _show and
_store functions, so we're left without any protection on setting or
reading the control register. The options right now are either add our
own lock and double lock everything or force access to the watchdog core
lock. We don't want to do either, so for now we do nothing.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
 drivers/watchdog/ni9x3x_wdt.c | 73 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/ni9x3x_wdt.c b/drivers/watchdog/ni9x3x_wdt.c
index 2cb5627..13f5c10 100644
--- a/drivers/watchdog/ni9x3x_wdt.c
+++ b/drivers/watchdog/ni9x3x_wdt.c
@@ -60,37 +60,45 @@ static void ni9x3x_wdt_start(struct ni9x3x_wdt *wdt)
 	outb(control | NIWD_CONTROL_PET, wdt->io_base + NIWD_CONTROL);
 }
 
-static int ni9x3x_wdt_wdd_set_timeout(struct watchdog_device *wdd,
-				      unsigned int timeout)
+static void ni9x3x_wdt_counter_set(struct ni9x3x_wdt *wdt, u32 counter)
 {
-	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
-	u32 counter = timeout * (1000000000 / NIWD_PERIOD_NS);
-
 	outb(((0x00FF0000 & counter) >> 16), wdt->io_base + NIWD_SEED2);
 	outb(((0x0000FF00 & counter) >> 8), wdt->io_base + NIWD_SEED1);
 	outb((0x000000FF & counter), wdt->io_base + NIWD_SEED0);
-
-	return 0;
 }
 
-static unsigned int ni9x3x_wdt_wdd_get_timeleft(struct watchdog_device *wdd)
+static unsigned int ni9x3x_wdt_counter_get(struct ni9x3x_wdt *wdt)
 {
-	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
 	u8 control, counter0, counter1, counter2;
-	u32 counter;
 
 	control = inb(wdt->io_base + NIWD_CONTROL);
-	control |= NIWD_CONTROL_CAPTURECOUNTER;
-	outb(control, wdt->io_base + NIWD_CONTROL);
+	outb(control | NIWD_CONTROL_CAPTURECOUNTER,
+	     wdt->io_base + NIWD_CONTROL);
 
 	counter2 = inb(wdt->io_base + NIWD_COUNTER2);
 	counter1 = inb(wdt->io_base + NIWD_COUNTER1);
 	counter0 = inb(wdt->io_base + NIWD_COUNTER0);
 
-	counter = (counter2 << 16) | (counter1 << 8) | counter0;
-	counter = (counter * (u64)NIWD_PERIOD_NS) / 1000000000;
+	return (counter2 << 16) | (counter1 << 8) | counter0;
+}
+
+static int ni9x3x_wdt_wdd_set_timeout(struct watchdog_device *wdd,
+				      unsigned int timeout)
+{
+	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
+	u32 counter = timeout * (1000000000 / NIWD_PERIOD_NS);
+
+	ni9x3x_wdt_counter_set(wdt, counter);
+
+	return 0;
+}
+
+static unsigned int ni9x3x_wdt_wdd_get_timeleft(struct watchdog_device *wdd)
+{
+	struct ni9x3x_wdt *wdt = to_ni9x3x_wdt(wdd);
+	u32 counter = ni9x3x_wdt_counter_get(wdt);
 
-	return (unsigned int)counter;
+	return (unsigned int)((counter * (u64)NIWD_PERIOD_NS) / 1000000000);
 }
 
 static int ni9x3x_wdt_wdd_start(struct watchdog_device *wdd)
@@ -126,6 +134,40 @@ static int ni9x3x_wdt_wdd_ping(struct watchdog_device *wdd)
 	return 0;
 }
 
+static ssize_t counter_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct ni9x3x_wdt *wdt = acpi_driver_data(acpi_dev);
+	u32 counter;
+
+	counter = ni9x3x_wdt_counter_get(wdt);
+
+	return sprintf(buf, "%u\n", counter);
+}
+
+static ssize_t counter_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct ni9x3x_wdt *wdt = acpi_driver_data(acpi_dev);
+	u32 val;
+
+	if (kstrtouint(buf, 10, &val) || val > 0xFFFFFF)
+		return -EINVAL;
+
+	ni9x3x_wdt_counter_set(wdt, val);
+
+	return count;
+}
+static DEVICE_ATTR_RW(counter);
+
+static struct attribute *ni9x3x_wdt_attrs[] = {
+	&dev_attr_counter.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(ni9x3x_wdt);
+
 static acpi_status ni9x3x_wdt_resources(struct acpi_resource *res, void *data)
 {
 	struct ni9x3x_wdt *wdt = data;
@@ -214,6 +256,7 @@ static int ni9x3x_wdt_acpi_add(struct acpi_device *device)
 	wdt->wdog.max_timeout = NIWD_MAX_TIMEOUT;
 	wdt->wdog.timeout = NIWD_DEFAULT_TIMEOUT;
 	wdt->wdog.parent = &device->dev;
+	wdt->wdog.groups = ni9x3x_wdt_groups;
 
 	ret = watchdog_register_device(&wdt->wdog);
 	if (ret) {
-- 
2.7.0

