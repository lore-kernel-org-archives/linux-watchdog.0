Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0077.outbound.protection.outlook.com ([65.55.169.77]:55360
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753329AbbKWKZF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 05:25:05 -0500
From: Huang Rui <ray.huang@amd.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Denis Turischev" <denis.turischev@compulab.co.il>,
	Borislav Petkov <bp@alien8.de>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	Huang Rui <ray.huang@amd.com>
Subject: [PATCH 2/2] sp5100_tco: Add AMD Carrizo platform support
Date: Mon, 23 Nov 2015 18:07:36 +0800
Message-ID: <1448273256-1793-2-git-send-email-ray.huang@amd.com>
In-Reply-To: <1448273256-1793-1-git-send-email-ray.huang@amd.com>
References: <1448273256-1793-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

sp5100_tco watchdog is also supported on AMD KernCZ chipset of Carrizo
platform.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Cc: Denis Turischev <denis.turischev@compulab.co.il>
---
 drivers/watchdog/sp5100_tco.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index c9dd419..6467b91 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -308,6 +308,8 @@ static const struct pci_device_id sp5100_tco_pci_tbl[] = {
 	  PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
 	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
-- 
1.9.1

