Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:54170 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeBUSTb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Feb 2018 13:19:31 -0500
From: "Vance, Jimmy" <jimmy.vance@hpe.com>
To: "Hoemann, Jerry" <jerry.hoemann@hpe.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog/hpwdt: update maintainer information
Date: Wed, 21 Feb 2018 18:19:26 +0000
Message-ID: <DF4PR8401MB0521DAFE43B08D35982E3E98E3CE0@DF4PR8401MB0521.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180221092201.8031-1-jerry.hoemann@hpe.com>
In-Reply-To: <20180221092201.8031-1-jerry.hoemann@hpe.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Acked-by: Jimmy Vance <jimmy.vance@hpe.com>

-----Original Message-----
From: Hoemann, Jerry 
Sent: Wednesday, February 21, 2018 3:22 AM
To: linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: Vance, Jimmy <jimmy.vance@hpe.com>; Hoemann, Jerry <jerry.hoemann@hpe.com>
Subject: [PATCH] watchdog/hpwdt: update maintainer information

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..98b2ef91487d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6267,7 +6267,7 @@ S:	Odd Fixes
 F:	drivers/media/usb/hdpvr/
 
 HEWLETT PACKARD ENTERPRISE ILO NMI WATCHDOG DRIVER
-M:	Jimmy Vance <jimmy.vance@hpe.com>
+M:	Jerry Hoemann <jerry.hoemann@hpe.com>
 S:	Supported
 F:	Documentation/watchdog/hpwdt.txt
 F:	drivers/watchdog/hpwdt.c
-- 
2.13.6

