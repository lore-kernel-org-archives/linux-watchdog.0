Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51541 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753873AbdFMUj2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Jun 2017 16:39:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5DKdLSR052070
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Jun 2017 16:39:23 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b2pdct53r-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Jun 2017 16:39:22 -0400
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <cbostic@linux.vnet.ibm.com>;
        Tue, 13 Jun 2017 14:38:33 -0600
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        andrew@aj.id.au
Subject: [PATCH 0/2] drivers/watchdog ASPEED: Add optional dev tree configs
Date: Tue, 13 Jun 2017 15:38:16 -0500
Message-Id: <20170613203818.17399-1-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add optional device tree attribute 'external-signal'.  Configure watchdog
to drive external signal on timeout if this attribute is present.

Add optional device tree attribute 'no-system-reset'.  Configure watchdog
to not reset system on timeout if this attribute is present.  This mode
is used when one of the other watchdogs in system is to be responsible for
managing system reset.

Christopher Bostic (2):
  drivers/watchdog: Document new aspeed optional dev tree properties.
  drivers/watchdog: ASPEED reference dev tree properties for config

 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 11 +++++++++++
 drivers/watchdog/aspeed_wdt.c                             | 13 +++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
1.8.2.2

