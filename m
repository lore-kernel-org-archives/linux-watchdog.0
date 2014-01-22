Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49658 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753049AbaAVXGk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 18:06:40 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v4 18/18] ARM: mvebu: Enable watchdog support in defconfig
Date: Wed, 22 Jan 2014 20:05:15 -0300
Message-Id: <1390431915-5115-19-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Now that we have proper support for Armada 370/XP watchdog
let's enable it in the defconfig.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 594d706..84ec924 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -60,6 +60,8 @@ CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_ORION_WATCHDOG=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.8.1.5

