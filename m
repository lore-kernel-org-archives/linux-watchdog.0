Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:40359 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbJ2U1p (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 29 Oct 2015 16:27:45 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Cc: shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org,
	dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 1/5] of: add vendor prefix for Technologic Systems
Date: Thu, 29 Oct 2015 16:27:26 -0400
Message-Id: <1446150450-22093-2-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d444757..68aad78a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -211,6 +211,7 @@ toshiba	Toshiba Corporation
 toumaz	Toumaz
 tplink	TP-LINK Technologies Co., Ltd.
 truly	Truly Semiconductors Limited
+ts	Technologic Systems
 usi	Universal Scientific Industrial Co., Ltd.
 v3	V3 Semiconductor
 variscite	Variscite Ltd.
-- 
2.5.0

