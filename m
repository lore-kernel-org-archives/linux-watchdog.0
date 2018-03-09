Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932104AbeCIV61 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Mar 2018 16:58:27 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w29LuRKJ026757
        for <linux-watchdog@vger.kernel.org>; Fri, 9 Mar 2018 16:58:26 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gkw89mg2x-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Fri, 09 Mar 2018 16:58:26 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Fri, 9 Mar 2018 16:58:25 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joel@jms.id.au,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH 0/2] aspeed: watchdog: fix system reset and read alt-boot option
Date: Fri,  9 Mar 2018 15:58:18 -0600
Message-Id: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This series provides a fix to correctly set the reset mode of the control
register. Previously, configuring anything other than a full chip reset would
not reset anything when the watchdog timer expires. The series also provides a
patch to read in the existing aspeed,alt-boot boolean option from the
device-tree and set the appropriate bit in the control register.

Milton Miller (2):
  watchdog: aspeed: Fix translation of reset mode to ctrl register
  watchdog: aspeed: Allow configuring for alternate boot

 drivers/watchdog/aspeed_wdt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
1.8.3.1

