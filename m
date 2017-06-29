Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34387 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751786AbdF2A2j (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Jun 2017 20:28:39 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5T0ScGH014593
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Jun 2017 20:28:38 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bcj53ajm2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Jun 2017 20:28:38 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <cbostic@linux.vnet.ibm.com>;
        Wed, 28 Jun 2017 20:28:33 -0400
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v3 1/2] drivers/watchdog: Add optional ASPEED device tree properties
Date: Wed, 28 Jun 2017 19:28:10 -0500
In-Reply-To: <20170629002811.87199-1-cbostic@linux.vnet.ibm.com>
References: <20170629002811.87199-1-cbostic@linux.vnet.ibm.com>
Message-Id: <20170629002811.87199-2-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Describe device tree optional properties:

  * aspeed,arm-reet - ARM CPU reset on signal
  * aspeed,no-soc-reset - SOC reset on signal
  * aspeed,no-sys-reset - System reset on signal
  * aspeed,interrupt - Interrupt CPU on signal
  * aspeed,external-signal - Generate external signal (WDT1 and WDT2 only)
  * aspeed,alt-boot - Boot from alternate block on signal

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
v3 - Invert soc and sys reset to 'no' to preserve backwards
     compatibility.  SOC and SYS reset will be set by default
     without any optional parameters set
v2 - Add 'aspeed,' prefix to all optional properties
   - Add arm-reset, soc-reset, interrupt, alt-boot properties
---
 .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
index c5e74d7..6f18005 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -8,9 +8,33 @@ Required properties:
  - reg: physical base address of the controller and length of memory mapped
    region
 
+Optional properties:
+   Signal behavior - Whenever a timeout occurs the watchdog can be programmed
+   to generate/not generate 6 types of signals:
+
+ - aspeed,arm-reset:	If property is present then reset ARM CPU only.
+			If not specified no ARM CPU reset is done.
+
+ - aspeed,no-soc-reset: If property is present then do not reset SOC.
+			If not specified then SOC reset is done.
+
+ - aspeed,no-sys-reset: If property is present then do not reset system.
+			Typcally used in tandem with 'aspeed-external-signal'
+			If not specified then system reset is done.
+
+ - aspeed,interrupt:	If property is present then interrupt CPU.
+			If not specified then don't interrupt CPU.
+
+ - aspeed,external-signal: If property is present then signal is sent to
+			external reset counter (only WDT1 and WDT2). If not
+			specified no external signal is sent.
+ - aspeed,alt-boot:    If property is present then boot from alternate block.
+
 Example:
 
 	wdt1: watchdog@1e785000 {
 		compatible = "aspeed,ast2400-wdt";
 		reg = <0x1e785000 0x1c>;
+		aspeed,no-sys-reset;
+		aspeed,external-signal;
 	};
-- 
1.8.2.2

