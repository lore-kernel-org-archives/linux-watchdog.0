Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51683 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753490AbdFMUii (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Jun 2017 16:38:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5DKcWeW135594
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Jun 2017 16:38:37 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b2kym13tx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Jun 2017 16:38:37 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <cbostic@linux.vnet.ibm.com>;
        Tue, 13 Jun 2017 14:38:36 -0600
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        andrew@aj.id.au
Subject: [PATCH 1/2] drivers/watchdog: Document new aspeed optional dev tree properties.
Date: Tue, 13 Jun 2017 15:38:17 -0500
In-Reply-To: <20170613203818.17399-1-cbostic@linux.vnet.ibm.com>
References: <20170613203818.17399-1-cbostic@linux.vnet.ibm.com>
Message-Id: <20170613203818.17399-2-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Describe new optional property 'external-signal'.  When present in the
system device tree an exernal signal is generated on watchdog timeout.

Describe new optional property 'no-system-reset'.  When present in the
system device tree no system reset is to occur on watchdog timeout.
System reset in this case is managed by one of the other watchogs
available.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
index c5e74d7..4099ea5 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -8,9 +8,20 @@ Required properties:
  - reg: physical base address of the controller and length of memory mapped
    region
 
+Optional properties:
+ - external-signal: If the property is present then an external signal is to
+   be generated on watchdog timeout.  If absent, external signal is not
+   generated.
+
+ - no-system-reset: If the property is present then system will not be reset
+   on watchdog timeout. In this case one of the other watchdogs will handle
+   reset.  If absent then the watchdog resets the system on timeout.
+
 Example:
 
 	wdt1: watchdog@1e785000 {
 		compatible = "aspeed,ast2400-wdt";
 		reg = <0x1e785000 0x1c>;
+		external-signal;
+		no-system-reset;
 	};
-- 
1.8.2.2

