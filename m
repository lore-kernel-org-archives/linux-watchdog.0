Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41488 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH1XHi (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 19:07:38 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 4/4] watchdog: i6300esb: avoid removing if NOWAYOUT
Date: Tue, 28 Aug 2018 21:14:16 +0200
Message-Id: <20180828191416.7781-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
References: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the new macro to prevent removing the driver if NOWAYOUT.

Note: This is only a build-tested proof-of-concept!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/i6300esb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 950c71a8bb22..939224789e2a 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -356,7 +356,7 @@ static struct pci_driver esb_driver = {
 	.remove         = esb_remove,
 };
 
-module_pci_driver(esb_driver);
+module_watchdog_pci_driver(esb_driver, nowayout);
 
 MODULE_AUTHOR("Ross Biro and David Härdeman");
 MODULE_DESCRIPTION("Watchdog driver for Intel 6300ESB chipsets");
-- 
2.11.0
