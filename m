Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:3844 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403Ab0HFVfD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:35:03 -0400
Date: Fri, 6 Aug 2010 23:35:01 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (10/12): Construct status message w/ kasprintf and
	emit it with dev_info
Message-ID: <20100806213501.GI31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit b014df2245efe8abe6a9913dcd1ef2da683f67a0
Author: dann frazier <dannf@hp.com>
Date:   Wed Jul 28 12:38:43 2010 -0600

    watchdog: hpwdt (10/12): Construct status message w/ kasprintf and emit it with dev_info
    
    Constructing the string dynamically w/ kasprintf will make it easier to
    ifdef-out parts of it. Also, this is for a device, so let's use dev_info.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 7ce7317..5bade2d 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -659,6 +659,7 @@ static int __devinit hpwdt_init_one(struct pci_dev *dev,
 					const struct pci_device_id *ent)
 {
 	int retval;
+	char *buf;
 
 	/*
 	 * Check if we can do NMI sourcing or not
@@ -742,14 +743,17 @@ static int __devinit hpwdt_init_one(struct pci_dev *dev,
 		goto error_misc_register;
 	}
 
-	printk(KERN_INFO
-		"hp Watchdog Timer Driver: %s"
-		", timer margin: %d seconds (nowayout=%d)"
-		", allow kernel dump: %s (default = 0/OFF)"
-		", priority: %s (default = 0/LAST).\n",
-		HPWDT_VERSION, soft_margin, nowayout,
-		(allow_kdump == 0) ? "OFF" : "ON",
-		(priority == 0) ? "LAST" : "FIRST");
+	buf = kasprintf(GFP_KERNEL, "hp Watchdog Timer Driver: %s"
+			", timer margin: %d seconds (nowayout=%d)"
+			", allow kernel dump: %s (default = 0/OFF)"
+			", priority: %s (default = 0/LAST)",
+			HPWDT_VERSION, soft_margin, nowayout,
+			(allow_kdump == 0) ? "OFF" : "ON",
+			(priority == 0) ? "LAST" : "FIRST");
+	if (!buf)
+		goto error_nomem;
+	dev_info(&dev->dev, "%s.\n", buf);
+	kfree(buf);
 
 	return 0;
 
@@ -762,6 +766,7 @@ error_get_cru:
 	pci_iounmap(dev, pci_mem_addr);
 error_pci_iomap:
 	pci_disable_device(dev);
+error_nomem:
 	return retval;
 }
 
