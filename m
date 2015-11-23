Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:58605 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbbKWH7k (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 02:59:40 -0500
Subject: [PATCH v2] sp5100_tco: Add AMD Mullins platform support
To: Wim Van Sebroeck <wim@iguana.be>
References: <564D9CB0.1090209@compulab.co.il>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Denis Turischev <denis.turischev@compulab.co.il>
Message-ID: <5652C765.8030302@compulab.co.il>
Date: Mon, 23 Nov 2015 09:59:33 +0200
MIME-Version: 1.0
In-Reply-To: <564D9CB0.1090209@compulab.co.il>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

AMD Mullins watchdog is fully compatible to the previous Hudson chipset,
reuse the existent sp5100_tco driver.

v2: rebased to v4.4-rc2

Signed-off-by: Denis Turischev <denis.turischev@compulab.co.il>

diff -Nru linux-4.4-rc2.orig/drivers/watchdog/sp5100_tco.c linux-4.4-rc2/drivers/watchdog/sp5100_tco.c
--- linux-4.4-rc2.orig/drivers/watchdog/sp5100_tco.c	2015-11-23 02:45:59.000000000 +0200
+++ linux-4.4-rc2/drivers/watchdog/sp5100_tco.c	2015-11-23 09:51:48.701245853 +0200
@@ -306,6 +306,8 @@
 static const struct pci_device_id sp5100_tco_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
 	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, }, 
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
