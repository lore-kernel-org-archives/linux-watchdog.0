Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53367 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbcCWWGF (ORCPT
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
Subject: [PATCH 09/17] watchdog: qcom: add kpss-standalone to device tree binding
Date: Wed, 23 Mar 2016 17:05:04 -0500
Message-Id: <1458770712-10880-10-git-send-email-mmcclint@codeaurora.org>
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Update the compatible string to add new device tree binding

CC: linux-watchdog@vger.kernel.org
Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
index 60bb2f98..45b37cf 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
@@ -6,6 +6,7 @@ Required properties :
 
 			"qcom,kpss-timer"
 			"qcom,scss-timer"
+			"qcom,kpss-standalone"
 
 - reg : shall contain base register location and length
 - clocks : shall contain the input clock
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

