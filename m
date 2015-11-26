Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbbKZMc2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Nov 2015 07:32:28 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/6] mei: drop nfc leftovers from the mei driver
Date: Thu, 26 Nov 2015 14:31:16 +0200
Message-Id: <1448541081-11299-2-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
References: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We left few function prototypes in the header file after
moving nfc logic to bus.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/mei_dev.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 4250555d5e72..b54d9d9cacea 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -649,17 +649,6 @@ int mei_amthif_irq_read_msg(struct mei_cl *cl,
 			    struct mei_cl_cb *complete_list);
 int mei_amthif_irq_read(struct mei_device *dev, s32 *slots);
 
-/*
- * NFC functions
- */
-int mei_nfc_host_init(struct mei_device *dev, struct mei_me_client *me_cl);
-void mei_nfc_host_exit(struct mei_device *dev);
-
-/*
- * NFC Client UUID
- */
-extern const uuid_le mei_nfc_guid;
-
 int mei_wd_send(struct mei_device *dev);
 int mei_wd_stop(struct mei_device *dev);
 int mei_wd_host_init(struct mei_device *dev, struct mei_me_client *me_cl);
-- 
2.4.3

