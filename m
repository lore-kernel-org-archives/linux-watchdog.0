Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53275 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932277AbcCWWGF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Mar 2016 18:06:05 -0400
From: Matthew McClintock <mmcclint@codeaurora.org>
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
Cc: qca-upstream.external@qca.qualcomm.com,
	Matthew McClintock <mmcclint@codeaurora.org>,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
	DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/17] watchdog: qcom: update device tree bindings
Date: Wed, 23 Mar 2016 17:05:01 -0500
Message-Id: <1458770712-10880-7-git-send-email-mmcclint@codeaurora.org>
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

