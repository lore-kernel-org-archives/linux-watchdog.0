Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>,
	robh+dt@kernel.org,
	shawnguo@kernel.org,
	kernel@pengutronix.de,
	wim@iguana.be,
	sameo@linux.intel.com,
	dinh.linux@gmail.com,
	linux@roeck-us.net,
	Arnd Bergmann <arnd@arndb.de>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v5 1/5] of: add vendor prefix for Technologic Systems
Date: Tue, 24 Nov 2015 13:00:49 -0500
Message-Id: <1448388053-30661-2-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1448388053-30661-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1448388053-30661-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 82d2ac9..0a70537 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -223,6 +223,7 @@ toshiba	Toshiba Corporation
 toumaz	Toumaz
 tplink	TP-LINK Technologies Co., Ltd.
 truly	Truly Semiconductors Limited
+technologic	Technologic Systems
 usi	Universal Scientific Industrial Co., Ltd.
 v3	V3 Semiconductor
 variscite	Variscite Ltd.
-- 
2.5.0
