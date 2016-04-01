Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58187 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043AbcDAL4g (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 Apr 2016 07:56:36 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: salvator-x: Enable watchdog timer
Date: Fri,  1 Apr 2016 13:56:25 +0200
Message-Id: <1459511786-4286-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This patch enables watchdog timer for Salvator-X board.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index c3c25409224a22..dbea5078fec367 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -507,6 +507,11 @@
 	shared-pin;
 };
 
+&wdt0 {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
 &audio_clk_a {
 	clock-frequency = <22579200>;
 };
-- 
2.7.0

