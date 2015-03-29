Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53655 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402AbbC2NnC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 29 Mar 2015 09:43:02 -0400
Date: Sun, 29 Mar 2015 15:42:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH 75/86] watchdog: use uapi/linux/pci_ids.h directly
Message-ID: <1427635734-24786-76-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ada3e44..c03b4cc 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -24,7 +24,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
-- 
MST

