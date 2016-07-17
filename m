Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36586 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbcGQQe3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 12:34:29 -0400
Received: by mail-lf0-f66.google.com with SMTP id 33so9845054lfw.3
        for <linux-watchdog@vger.kernel.org>; Sun, 17 Jul 2016 09:34:28 -0700 (PDT)
Date: Sun, 17 Jul 2016 19:34:24 +0300
From: Alexey Kunitskiy <alexey.kv@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/1] watchdog: add support for MCP78S chipset in
 nv_tco
Message-ID: <20160717193424.245516db@hades.home>
In-Reply-To: <578B972E.60209@roeck-us.net>
References: <20160715115334.680ab21a@hades.home>
	<20160716171540.GA29247@roeck-us.net>
	<20160717101453.4e3e8d2a@hades.home>
	<578B972E.60209@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add support for MCP78S chipset in nv_tco watchdog driver

Signed-off-by: Aleksey Kunitskiy <alexey.kv@gmail.com>

diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -294,6 +294,8 @@
 	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS,
 	  PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS,
+	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS,
 	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },			/* End of list */


-----------------
Regards,
Aleksey Kunitskiy
