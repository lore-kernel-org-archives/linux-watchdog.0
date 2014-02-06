Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42358 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756849AbaBFRVu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 12:21:50 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v6 19/19] ARM: dove: Enable watchdog support in the defconfig
Date: Thu,  6 Feb 2014 14:20:26 -0300
Message-Id: <1391707226-18258-20-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Now that we have watchdog support, let's add it to the defconfig.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/dove_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 1101054..a330690 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -80,6 +80,8 @@ CONFIG_SPI_ORION=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_DOVE_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_ORION_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.8.1.5

