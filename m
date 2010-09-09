Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37568 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab0IIRGL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 9 Sep 2010 13:06:11 -0400
From: Seth Heasley <seth.heasley@intel.com>
To: wim@iguana.be
Subject: [PATCH 2.6.35.4] iTCO_wdt: TCO Watchdog patch for Intel Patsburg DeviceIDs
Date: Thu, 9 Sep 2010 09:58:03 -0700
Cc: linux-watchdog@vger.kernel.org, seth.heasley@intel.com
References: <201001121704.44010.seth.heasley@intel.com>
In-Reply-To: <201001121704.44010.seth.heasley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201009090958.03975.seth.heasley@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds the Intel Patsburg (PCH) DeviceIDs for iTCO Watchdog.
 
Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.35.4/drivers/watchdog/iTCO_wdt.c.orig	2010-08-26 16:47:12.000000000 -0700
+++ linux-2.6.35.4/drivers/watchdog/iTCO_wdt.c	2010-08-31 17:29:43.699146841 -0700
@@ -146,6 +146,7 @@
 	TCO_CPT29,	/* Cougar Point */
 	TCO_CPT30,	/* Cougar Point */
 	TCO_CPT31,	/* Cougar Point */
+	TCO_PBG,	/* Patsburg */
 };
 
 static struct {
@@ -233,6 +234,7 @@
 	{"Cougar Point", 2},
 	{"Cougar Point", 2},
 	{"Cougar Point", 2},
+	{"Patsburg", 2},
 	{NULL, 0}
 };
 
@@ -348,6 +350,7 @@
 	{ ITCO_PCI_DEVICE(0x1c5d,				TCO_CPT29)},
 	{ ITCO_PCI_DEVICE(0x1c5e,				TCO_CPT30)},
 	{ ITCO_PCI_DEVICE(0x1c5f,				TCO_CPT31)},
+	{ ITCO_PCI_DEVICE(0x1d40,				TCO_PBG)},
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, iTCO_wdt_pci_tbl);
