Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43785 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967AbcC3P3m (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Mar 2016 11:29:42 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: salvator-x: Enable watchdog timer
Date: Wed, 30 Mar 2016 17:28:44 +0200
Message-Id: <1459351725-14144-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
References: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This patch enables watchdog timer for Salvator-X board.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since last RFC (only on renesas-soc-list):

* add timeout-sec property for a visible default

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 3921bd02f4c152..26f140d7cb6d1e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -503,6 +503,11 @@
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

