Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59375 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752896AbaBNWZl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Feb 2014 17:25:41 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v7 18/18] ARM: dove: Enable watchdog support in the defconfig
Date: Fri, 14 Feb 2014 19:24:18 -0300
Message-Id: <1392416658-2780-19-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392416658-2780-1-git-send-email-ezequiel.garcia@free-electrons.com>
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

