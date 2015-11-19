Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:47031 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756515AbbKSJ4H (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Nov 2015 04:56:07 -0500
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Denis Turischev <denis.turischev@compulab.co.il>
Subject: [PATCH] sp5100_tco: Add AMD Mullins platform support
Message-ID: <564D9CB0.1090209@compulab.co.il>
Date: Thu, 19 Nov 2015 11:56:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

AMD Mullins watchdog is fully compatible to the previous Hudson chipset,
reuse the existent sp5100_tco driver.

Signed-off-by: Denis Turischev <denis.turischev@compulab.co.il>

diff -Nru linux-4.3.orig/drivers/watchdog/sp5100_tco.c linux-4.3/drivers/watchdog/sp5100_tco.c
--- linux-4.3.orig/drivers/watchdog/sp5100_tco.c	2015-11-02 02:05:25.000000000 +0200
+++ linux-4.3/drivers/watchdog/sp5100_tco.c	2015-11-19 11:08:06.272777718 +0200
@@ -306,6 +306,8 @@
 static const struct pci_device_id sp5100_tco_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
 	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);	
