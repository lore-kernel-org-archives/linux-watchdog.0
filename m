Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.nic.cz ([217.31.204.67]:55347 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeIXRLX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Sep 2018 13:11:23 -0400
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v4 0/4] Add support for Armada 37xx CPU watchdog
Date: Mon, 24 Sep 2018 13:06:50 +0200
Message-Id: <20180924110654.7329-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,
this is version 4 of Armada 37xx wdt patches.

Changes from previous version:
Patch 1: Added Reviewed-by and Tested-by
Patch 2: Changed device tree node name and compatible strings as suggested by
         Rob Herring
Patch 3: Added Reviewed-by
Patch 4: Same as patch 2

Marek
