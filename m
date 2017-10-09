Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:25537 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754373AbdJITFg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Oct 2017 15:05:36 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jimmy.vance@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] watchdog: hpwdt: change maintainer.
Date: Mon,  9 Oct 2017 12:56:56 -0600
Message-Id: <1507575416-80477-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d750..e7dc993 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6114,7 +6114,7 @@ S:	Odd Fixes
 F:	drivers/media/usb/hdpvr/
 
 HEWLETT PACKARD ENTERPRISE ILO NMI WATCHDOG DRIVER
-M:	Jimmy Vance <jimmy.vance@hpe.com>
+M:	Jerry Hoemann <jerry.hoemann@hpe.com>
 S:	Supported
 F:	Documentation/watchdog/hpwdt.txt
 F:	drivers/watchdog/hpwdt.c
-- 
1.8.3.1

