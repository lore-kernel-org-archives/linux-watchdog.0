Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43043 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbbLUXS7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Dec 2015 18:18:59 -0500
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v3 1/8] mei: drop nfc leftovers from the mei driver
Date: Tue, 22 Dec 2015 01:17:54 +0200
Message-Id: <1450739881-3923-2-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
References: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We left few function prototypes in the header file after
moving nfc logic to bus.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2/V3: resend

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

