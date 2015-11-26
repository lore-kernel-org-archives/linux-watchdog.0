Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbbKZMcf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Nov 2015 07:32:35 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 4/6] mei: bus: whitelist the watchdog client
Date: Thu, 26 Nov 2015 14:31:19 +0200
Message-Id: <1448541081-11299-5-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
References: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The iAMT WD client has to be whitelisted sice it has two connections
and is filtered out by number_of_connections fixup.
Also the API has changed for BDW and SKL but firmware haven't updated
the protocol version.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index b2d2a6ea576c..b87323f4bb14 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -35,6 +35,9 @@ static const uuid_le mei_nfc_info_guid = MEI_UUID_NFC_INFO;
 #define MEI_UUID_NFC_HCI UUID_LE(0x0bb17a78, 0x2a8e, 0x4c50, \
 			0x94, 0xd4, 0x50, 0x26, 0x67, 0x23, 0x77, 0x5c)
 
+#define MEI_UUID_WD UUID_LE(0x05B79A6F, 0x4628, 0x4D7F, \
+			    0x89, 0x9D, 0xA9, 0x15, 0x14, 0xCB, 0x32, 0xAB)
+
 #define MEI_UUID_ANY NULL_UUID_LE
 
 /**
@@ -66,6 +69,31 @@ static void blacklist(struct mei_cl_device *cldev)
 	cldev->do_match = 0;
 }
 
+/**
+ * mei_wd - wd client on the bus, change protocol version
+ *   as the API has changed.
+ *
+ * @cldev: me clients device
+ */
+#if IS_ENABLED(CONFIG_INTEL_MEI_ME)
+#include <linux/pci.h>
+#include "hw-me-regs.h"
+static void mei_wd(struct mei_cl_device *cldev)
+{
+	struct pci_dev *pdev = to_pci_dev(cldev->dev.parent);
+
+	dev_dbg(&cldev->dev, "running hook %s\n", __func__);
+	if (pdev->device == MEI_DEV_ID_WPT_LP ||
+	    pdev->device == MEI_DEV_ID_SPT ||
+	    pdev->device == MEI_DEV_ID_SPT_H)
+		cldev->me_cl->props.protocol_version = 0x2;
+
+	cldev->do_match = 1;
+}
+#else
+static inline void mei_wd(struct mei_cl_device *cldev) {}
+#endif /* CONFIG_INTEL_MEI_ME */
+
 struct mei_nfc_cmd {
 	u8 command;
 	u8 status;
@@ -280,6 +308,7 @@ static struct mei_fixup {
 	MEI_FIXUP(MEI_UUID_ANY, number_of_connections),
 	MEI_FIXUP(MEI_UUID_NFC_INFO, blacklist),
 	MEI_FIXUP(MEI_UUID_NFC_HCI, mei_nfc),
+	MEI_FIXUP(MEI_UUID_WD, mei_wd),
 };
 
 /**
-- 
2.4.3

