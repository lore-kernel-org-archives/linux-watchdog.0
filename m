Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@stlinux.com, patrice.chotard@st.com, devicetree@vger.kernel.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, <wim@iguana.be>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <linux-watchdog@vger.kernel.org>
Subject: [PATCH 10/19] watchdog: bindings: Remove obsolete platforms from dt doc.
Date: Wed, 14 Sep 2016 14:27:48 +0100
Message-Id: <1473859677-9231-11-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

STiH415/6 SoC support is being removed from the kernel
so update the dt bding document to reflect this.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <wim@iguana.be>
Cc: <linux@roeck-us.net>
Cc: <robh+dt@kernel.org>
Cc: <linux-watchdog@vger.kernel.org>
---
 Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
index 039c5ca..b949039 100644
--- a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
@@ -9,8 +9,7 @@ functionality.
 
 Required properties
 
-- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
-				  "st,stih415-lpc" "st,stid127-lpc"
+- compatible 	: Should be: "st,stih407-lpc"
 - reg		: LPC registers base address + size
 - interrupts    : LPC interrupt line number and associated flags
 - clocks	: Clock used by LPC device (See: ../clock/clock-bindings.txt)
-- 
1.9.1
