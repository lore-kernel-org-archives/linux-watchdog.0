Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33866 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab3J1GZr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Oct 2013 02:25:47 -0400
Received: by mail-pd0-f176.google.com with SMTP id g10so6601317pdj.35
        for <linux-watchdog@vger.kernel.org>; Sun, 27 Oct 2013 23:25:46 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-doc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	wim@iguana.be, rob@landley.net, linux-samsung-soc@vger.kernel.org,
	kgene.kim@samsung.com, sachin.kamat@linaro.org
Subject: [PATCH] Documentation/watchdog: Update node name in samsung-wdt example
Date: Mon, 28 Oct 2013 11:54:17 +0530
Message-Id: <1382941457-2826-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Update the name as per DT naming convention.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
index 4c798e3..0642fb8 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
@@ -17,7 +17,7 @@ Optional properties:
 
 Example:
 
-watchdog {
+watchdog@101D0000 {
 	compatible = "samsung,s3c2410-wdt";
 	reg = <0x101D0000 0x100>, <0x10040408 0x4>, <0x1004040c 0x4>;
 	interrupts = <0 42 0>;
-- 
1.7.9.5

