Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753760AbdF0VRo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Jun 2017 17:17:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5RLE1xM073769
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Jun 2017 17:17:43 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bbsc9q3f8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Jun 2017 17:17:43 -0400
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <cbostic@linux.vnet.ibm.com>;
        Tue, 27 Jun 2017 15:17:42 -0600
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drivers/watchdog: Add optional ASPEED device tree properties
Date: Tue, 27 Jun 2017 16:17:33 -0500
In-Reply-To: <20170627211734.60477-1-cbostic@linux.vnet.ibm.com>
References: <20170627211734.60477-1-cbostic@linux.vnet.ibm.com>
Message-Id: <20170627211734.60477-2-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Describe device tree optional properties:

  * aspeed,arm-reet - ARM CPU reset on signal
  * aspeed,soc-reset - SOC reset on signal
  * aspeed,sys-reset - System reset on signal
          Disabling system reset may be required in situations where
          one of the other watchdog engines in the system is responsible
          for this.
  * aspeed,interrupt - Interrupt CPU on signal
  * aspeed,external-signal - Generate external signal (WDT1 and WDT2 only)
  * aspeed,alt-boot - Boot from alternate block on signal

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
v2 - Add 'aspeed,' prefix to all optional properties
   - Add arm-reset, soc-reset, interrupt, alt-boot properties
---
 .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
index c5e74d7..555b8b4 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -8,9 +8,34 @@ Required properties:
  - reg: physical base address of the controller and length of memory mapped
    region
 
+Optional properties:
+   Signal behavior - Whenever a timeout occurs, the watchdog can be programmed
+   to generate 6 types of signals:
+
+ - aspeed,arm-reset:  If property is present then reset ARM CPU only.
+
+ - aspeed,soc-reset:  If property is present then reset SOC.
+
+ - aspeed,sys-reset:  If property is present then reset the entire chip.
+                      In cases where one of the other watchdog engines
+                      in the system is responsible for system reset it
+                      may be required to not specify this property.
+
+ - aspeed,interrupt:  If property is present then interrupt CPU.
+
+ - aspeed,external-signal: If property is present then signal is sent to
+                           external reset counter (only WDT1 and WDT2).
+ - aspeed,alt-boot:    If property is present then boot from alternate block.
+
 Example:
 
 	wdt1: watchdog@1e785000 {
 		compatible = "aspeed,ast2400-wdt";
 		reg = <0x1e785000 0x1c>;
+		aspeed,arm-reset;
+		aspeed,soc-reset;
+		aspeed,sys-reset;
+		aspeed,interrupt;
+		aspeed,external-signal;
+		aspeed,alt-boot;
 	};
-- 
1.8.2.2

