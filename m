Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f172.google.com ([209.85.214.172]:34885 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCEa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Dec 2018 21:04:30 -0500
From: Yangtao Li <tiny.windzz@gmail.com>
To: wim@linux-watchdog.org, linux@roeck-us.net, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/2] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat,  1 Dec 2018 09:51:38 -0500
Message-Id: <20181201145140.8088-1-tiny.windzz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Yangtao Li (2):
  watchdog: bcm281xx: convert to DEFINE_SHOW_ATTRIBUTE
  watchdog: convert to DEFINE_SHOW_ATTRIBUTE

 drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
 drivers/watchdog/ie6xx_wdt.c    | 16 +++-------------
 2 files changed, 6 insertions(+), 26 deletions(-)

-- 
2.17.0
