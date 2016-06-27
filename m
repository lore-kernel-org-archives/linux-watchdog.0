Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49187 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbcF0X0w (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jun 2016 19:26:52 -0400
From: Thomas Pedersen <twp@codeaurora.org>
To: linux-watchdog@vger.kernel.org
Cc: Matthew McClintock <mmcclint@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/3] watchdog: qcom: update device tree bindings
Date: Mon, 27 Jun 2016 16:26:48 -0700
Message-Id: <1467070010-16965-2-git-send-email-twp@codeaurora.org>
In-Reply-To: <1467070010-16965-1-git-send-email-twp@codeaurora.org>
References: <1467070010-16965-1-git-send-email-twp@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Matthew McClintock <mmcclint@codeaurora.org>

Update the compatible string to align with driver

CC: linux-watchdog@vger.kernel.org
Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
index 4726924..60bb2f98 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
@@ -4,9 +4,8 @@ Qualcomm Krait Processor Sub-system (KPSS) Watchdog
 Required properties :
 - compatible : shall contain only one of the following:
 
-			"qcom,kpss-wdt-msm8960"
-			"qcom,kpss-wdt-apq8064"
-			"qcom,kpss-wdt-ipq8064"
+			"qcom,kpss-timer"
+			"qcom,scss-timer"
 
 - reg : shall contain base register location and length
 - clocks : shall contain the input clock
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

