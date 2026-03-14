Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA569258EE0;
	Sat, 14 Mar 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489187; cv=none; b=fuT1RXLzRMMAfAOzGJd4w4TgMNrwNM+AP+URvMGMJGGykjyIw59xne3BfCPJzoWnYKzN7MihpMP2D2lF2270iDSH9dy4FQNj1THZa1kn+x0bLTJcSrWFYIH9BQsmXhnWBFQyetvscT6nb0SnxIuhuHrAjEAjzKHK5WrLTd5GL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489187; c=relaxed/simple;
	bh=lyGbHpgdvoj/84R2wKCywhu1s+TBW0sYyEGzYTp4UV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OGfrVIPcMLvEQ14mXcO8jGOYzWHWK7m/o1qriMBurz6181/M+xgk8fUsWMMSXm0vQF7+Eunx/YM96uNf3QdCRVoBgLX8Rm6/3dt/h198fHjdD4HB+HmLRs/4Z3GOjUHRuU1DwGVZDGnTpDr8W/n5ABLgs4EDTtIJFwGdCXHVAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9GUOW7G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9GUOW7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47983C116C6;
	Sat, 14 Mar 2026 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773489187;
	bh=lyGbHpgdvoj/84R2wKCywhu1s+TBW0sYyEGzYTp4UV4=;
	h=From:To:Cc:Subject:Date:From;
	b=H9GUOW7GdncUZZx0oiTbOSdgixxTCNVK0JD3TrMw7mfNQAtpwnn7zvnQ+yyikdWLq
	 buDD4hUexRaFiWYoeimZve5TBk0bNdsMTGChqXxlMOpqV9brqnKlEjDEzgTHN2KhJ8
	 30kclckYfKEbYI09WTSk5u1gkudYkBe+2qJfTucVkYaNYBPYtg4hk+p1Ei842aFt9E
	 rJvrrkxLTUyTSsHfrc1KyE36Bnl3YsNvIaXb+V5taS9QtsDr1YttntA+VFbsuO24yn
	 LeoNcFKhA7w0ILStDlNOoDGqRf3nLocUHhfVDAH51mlMgxH6WoCQfvozhl1WaVAhwx
	 FuVk4Z7Dqu9+w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: linux-watchdog@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1] watchdog: ni903x_wdt: Convert to a platform driver
Date: Sat, 14 Mar 2026 12:53:01 +0100
Message-ID: <13996583.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

In particular, registering a watchdog device under a struct acpi_device
is questionable because it causes the watchdog to be hidden in the ACPI
bus sysfs hierarchy and it goes against the general rule that a struct
acpi_device can only be a parent of another struct acpi_device.

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ni903x_wdt watchdog ACPI driver to a
platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Note that after this change it actually makes sense to look for
the "timeout-sec" property via device_property_read_u32() under the
device passed to watchdog_init_timeout() because it has an fwnode
handle (unlike a struct acpi_device which is an fwnode itself).

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/watchdog/ni903x_wdt.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/ni903x_wdt.c b/drivers/watchdog/ni903x_wdt.c
index 045bb72d9a43..8b1b9baa914e 100644
--- a/drivers/watchdog/ni903x_wdt.c
+++ b/drivers/watchdog/ni903x_wdt.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
 #define NIWD_CONTROL	0x01
@@ -177,9 +178,9 @@ static const struct watchdog_ops ni903x_wdd_ops = {
 	.get_timeleft = ni903x_wdd_get_timeleft,
 };
 
-static int ni903x_acpi_add(struct acpi_device *device)
+static int ni903x_acpi_probe(struct platform_device *pdev)
 {
-	struct device *dev = &device->dev;
+	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct ni903x_wdt *wdt;
 	acpi_status status;
@@ -189,10 +190,10 @@ static int ni903x_acpi_add(struct acpi_device *device)
 	if (!wdt)
 		return -ENOMEM;
 
-	device->driver_data = wdt;
+	platform_set_drvdata(pdev, wdt);
 	wdt->dev = dev;
 
-	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+	status = acpi_walk_resources(ACPI_HANDLE(dev), METHOD_NAME__CRS,
 				     ni903x_resources, wdt);
 	if (ACPI_FAILURE(status) || wdt->io_base == 0) {
 		dev_err(dev, "failed to get resources\n");
@@ -224,9 +225,9 @@ static int ni903x_acpi_add(struct acpi_device *device)
 	return 0;
 }
 
-static void ni903x_acpi_remove(struct acpi_device *device)
+static void ni903x_acpi_remove(struct platform_device *pdev)
 {
-	struct ni903x_wdt *wdt = acpi_driver_data(device);
+	struct ni903x_wdt *wdt = platform_get_drvdata(pdev);
 
 	ni903x_wdd_stop(&wdt->wdd);
 	watchdog_unregister_device(&wdt->wdd);
@@ -238,16 +239,16 @@ static const struct acpi_device_id ni903x_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ni903x_device_ids);
 
-static struct acpi_driver ni903x_acpi_driver = {
-	.name = NIWD_NAME,
-	.ids = ni903x_device_ids,
-	.ops = {
-		.add = ni903x_acpi_add,
-		.remove = ni903x_acpi_remove,
+static struct platform_driver ni903x_acpi_driver = {
+	.probe = ni903x_acpi_probe,
+	.remove = ni903x_acpi_remove,
+	.driver = {
+		.name = NIWD_NAME,
+		.acpi_match_table = ni903x_device_ids,
 	},
 };
 
-module_acpi_driver(ni903x_acpi_driver);
+module_platform_driver(ni903x_acpi_driver);
 
 MODULE_DESCRIPTION("NI 903x Watchdog");
 MODULE_AUTHOR("Jeff Westfahl <jeff.westfahl@ni.com>");
-- 
2.51.0




