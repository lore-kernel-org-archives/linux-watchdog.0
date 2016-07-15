Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35165 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbcGOIxm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jul 2016 04:53:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id l89so6702894lfi.2
        for <linux-watchdog@vger.kernel.org>; Fri, 15 Jul 2016 01:53:41 -0700 (PDT)
Date: Fri, 15 Jul 2016 11:53:34 +0300
From: Alexey Kunitskiy <alexey.kv@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH 1/1] watchdog: add support for MCP78S chipset in nv_tco
Message-ID: <20160715115334.680ab21a@hades.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Add support for MCP78S chipset in nv_tco watchdog driver
Patch tested successfully on 4.1.27 kernel and ASUS M4N78-AM V2 motherboard

Signed-off-by: Aleksey Kunitskiy <alexey.kv@gmail.com>

--- drivers/watchdog/nv_tco.c.orig	2016-07-14 22:28:15.721583870 +0300
+++ drivers/watchdog/nv_tco.c	2016-07-14 22:28:48.838310400 +0300
@@ -294,6 +294,8 @@ static const struct pci_device_id tco_pc
 	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS,
 	  PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS,
+	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, tco_pci_tbl);

-----------------
Regards,
Aleksey Kunitskiy
