Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:54853 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663AbbA2RWa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 29 Jan 2015 12:22:30 -0500
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: [PATCH 1/4] watchdog: MAX63XX_WATCHDOG does not depend on ARM
Date: Thu, 29 Jan 2015 12:15:42 -0500
Message-Id: <1422551745-29101-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1422551745-29101-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1422551745-29101-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Remove the ARM Kconfig dependency since the Maxim MAX63xx devices are
architecture independent.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08f41ad..40ea835 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -409,7 +409,7 @@ config TS72XX_WATCHDOG
 
 config MAX63XX_WATCHDOG
 	tristate "Max63xx watchdog"
-	depends on ARM && HAS_IOMEM
+	depends on HAS_IOMEM
 	select WATCHDOG_CORE
 	help
 	  Support for memory mapped max63{69,70,71,72,73,74} watchdog timer.
-- 
2.2.2

