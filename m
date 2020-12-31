Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B1C43381
	for <linux-watchdog@archiver.kernel.org>; Thu, 31 Dec 2020 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B759223E0
	for <linux-watchdog@archiver.kernel.org>; Thu, 31 Dec 2020 12:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgLaMwL (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 31 Dec 2020 07:52:11 -0500
Received: from aclms1.advantech.com.tw ([61.58.41.199]:52393 "EHLO
        aclms1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgLaMwK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 31 Dec 2020 07:52:10 -0500
X-Greylist: delayed 686 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Dec 2020 07:52:09 EST
Received: from taipei09.ADVANTECH.CORP (unverified [172.20.0.236]) by ACLMS2.ADVANTECH.CORP
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te3c6efff9fac14014b2650@ACLMS2.ADVANTECH.CORP>;
 Thu, 31 Dec 2020 20:39:53 +0800
Received: from localhost (172.16.12.146) by taipei09.ADVANTECH.CORP
 (172.20.0.236) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Dec
 2020 20:40:03 +0800
From:   Campion Kang <campion.kang@advantech.com.tw>
To:     <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        <linux-watchdog@vger.kernel.org>,
        AceLan Kao <chia-lin.kao@canonical.com>,
        Campion Kang <campion.kang@advantech.com.tw>
Subject: [PATCH v5 1/6] MAINTAINERS: Add Advantech AHC1 embedded controller entry
Date:   Thu, 31 Dec 2020 20:39:43 +0800
Message-ID: <20201231123948.10473-1-campion.kang@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.12.146]
X-ClientProxiedBy: aclcas3.ADVANTECH.CORP (172.20.1.12) To
 taipei09.ADVANTECH.CORP (172.20.0.236)
X-TM-SNTS-SMTP: DC59C5B75EFFC2C1B12861D66EBDBD8A25B1FB9FCF13927189C1CD79B162027F2000:8
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add Advantech AHC1 embedded controller entry

Signed-off-by: Campion Kang <campion.kang@advantech.com.tw>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..20766da2e794 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -562,6 +562,16 @@ S:	Maintained
 F:	Documentation/scsi/advansys.rst
 F:	drivers/scsi/advansys.c
 
+ADVANTECH EMBEDDED CONTROLLER DRIVER
+M:	Campion Kang <campion.kang@advantech.com.tw>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
+F:	drivers/hwmon/ahc1ec0-hwmon.c
+F:	drivers/mfd/ahc1ec0.c
+F:	drivers/watchdog/ahc1ec0-wdt.c
+F:	include/dt-bindings/mfd/ahc1ec0-dt.h
+
 ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL345/ADXL346)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
-- 
2.17.1

