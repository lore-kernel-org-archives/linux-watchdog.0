Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58053 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933006AbeCSNwC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Mar 2018 09:52:02 -0400
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] ACPI / watchdog: Fix off-by-one error at resource assignment
Date: Mon, 19 Mar 2018 14:51:49 +0100
Message-Id: <20180319135149.25215-1-tiwai@suse.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The resource allocation in WDAT watchdog has off-one-by error, it sets
one byte more than the actual end address.  This may eventually lead
to unexpected resource conflicts.

Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/acpi/acpi_watchdog.c | 4 ++--
 drivers/watchdog/wdat_wdt.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index 11b113f8e367..ebb626ffb5fa 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -74,10 +74,10 @@ void __init acpi_watchdog_init(void)
 		res.start = gas->address;
 		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 			res.flags = IORESOURCE_MEM;
-			res.end = res.start + ALIGN(gas->access_width, 4);
+			res.end = res.start + ALIGN(gas->access_width, 4) - 1;
 		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 			res.flags = IORESOURCE_IO;
-			res.end = res.start + gas->access_width;
+			res.end = res.start + gas->access_width - 1;
 		} else {
 			pr_warn("Unsupported address space: %u\n",
 				gas->space_id);
diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 6d1fbda0f461..0da9943d405f 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -392,7 +392,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 		memset(&r, 0, sizeof(r));
 		r.start = gas->address;
-		r.end = r.start + gas->access_width;
+		r.end = r.start + gas->access_width - 1;
 		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 			r.flags = IORESOURCE_MEM;
 		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-- 
2.16.2

