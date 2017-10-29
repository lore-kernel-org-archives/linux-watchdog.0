Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdJ2Juo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 29 Oct 2017 05:50:44 -0400
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, alexandre.belloni@free-electrons.com,
        qipeng.zha@intel.com, hpa@zytor.com, dvhart@infradead.org,
        tglx@linutronix.de, lee.jones@linaro.org, andy@infradead.org,
        souvik.k.chakravarty@intel.com
Cc: linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sathyaosid@gmail.com,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFC v8 1/7] platform/x86: intel_punit_ipc: Fix resource ioremap warning
Date: Sun, 29 Oct 2017 02:49:54 -0700
Message-Id: <0ed06c9aabd0f6d707f3ab8024282a764ffe0318.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

For PUNIT device, ISPDRIVER_IPC and GTDDRIVER_IPC resources are not
mandatory. So when PMC IPC driver creates a PUNIT device, if these
resources are not available then it creates dummy resource entries for
these missing resources. But during PUNIT device probe, doing ioremap on
these dummy resources generates following warning messages.

intel_punit_ipc: can't request region for resource [mem 0x00000000]
intel_punit_ipc: can't request region for resource [mem 0x00000000]
intel_punit_ipc: can't request region for resource [mem 0x00000000]
intel_punit_ipc: can't request region for resource [mem 0x00000000]

This patch fixes this issue by adding extra check for resource size
before performing ioremap operation.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_punit_ipc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Changes since v7:
 * None

Changes since v6:
 * None

Changes since v5:
 * None

Changes since v4:
 * None

diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
index a47a41f..b5b8901 100644
--- a/drivers/platform/x86/intel_punit_ipc.c
+++ b/drivers/platform/x86/intel_punit_ipc.c
@@ -252,28 +252,28 @@ static int intel_punit_get_bars(struct platform_device *pdev)
 	 * - GTDRIVER_IPC BASE_IFACE
 	 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	if (res) {
+	if (res && resource_size(res) > 1) {
 		addr = devm_ioremap_resource(&pdev->dev, res);
 		if (!IS_ERR(addr))
 			punit_ipcdev->base[ISPDRIVER_IPC][BASE_DATA] = addr;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	if (res) {
+	if (res && resource_size(res) > 1) {
 		addr = devm_ioremap_resource(&pdev->dev, res);
 		if (!IS_ERR(addr))
 			punit_ipcdev->base[ISPDRIVER_IPC][BASE_IFACE] = addr;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
-	if (res) {
+	if (res && resource_size(res) > 1) {
 		addr = devm_ioremap_resource(&pdev->dev, res);
 		if (!IS_ERR(addr))
 			punit_ipcdev->base[GTDRIVER_IPC][BASE_DATA] = addr;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 5);
-	if (res) {
+	if (res && resource_size(res) > 1) {
 		addr = devm_ioremap_resource(&pdev->dev, res);
 		if (!IS_ERR(addr))
 			punit_ipcdev->base[GTDRIVER_IPC][BASE_IFACE] = addr;
-- 
2.7.4

