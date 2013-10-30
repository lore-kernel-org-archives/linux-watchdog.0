Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54757 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab3J3FMb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 01:12:31 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so399469pad.37
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Oct 2013 22:12:30 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	mark.rutland@arm.com, wim@iguana.be, linux@roeck-us.net,
	sachin.kamat@linaro.org
Subject: [PATCH 1/1] Documentation/watchdog: Add binding example in samsung-wdt
Date: Wed, 30 Oct 2013 10:41:10 +0530
Message-Id: <1383109870-30297-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Added an example for reference.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
index 2aa486c..7ddf461 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
@@ -12,3 +12,12 @@ Required properties:
 
 Optional properties:
 - timeout-sec : contains the watchdog timeout in seconds.
+
+Example:
+
+watchdog@101D0000 {
+ 	compatible = "samsung,s3c2410-wdt";
+ 	reg = <0x101D0000 0x100>;
+ 	interrupts = <0 42 0>;
+ 	status = "disabled";
+ };
-- 
1.7.9.5

