Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2] MAINTAINERS: change my email address
Date: Thu,  7 May 2015 09:14:41 +0200
Message-Id: <1430982881-6965-1-git-send-email-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Change my email address to something that is not associated with my current
or future employer.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b399b34..288975e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3715,7 +3715,7 @@ S:	Maintained
 F:	drivers/edac/ie31200_edac.c
 
 EDAC-MPC85XX
-M:	Johannes Thumshirn <johannes.thumshirn@men.de>
+M:	Johannes Thumshirn <jthumshirn@suse.de>
 L:	linux-edac@vger.kernel.org
 W:	bluesmoke.sourceforge.net
 S:	Maintained
@@ -6396,14 +6396,14 @@ F:	include/linux/mtd/
 F:	include/uapi/mtd/
 
 MEN A21 WATCHDOG DRIVER
-M:	Johannes Thumshirn <johannes.thumshirn@men.de>
+M:	Johannes Thumshirn <jthumshirn@suse.de>
 L:	linux-watchdog@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/watchdog/mena21_wdt.c
 
 MEN CHAMELEON BUS (mcb)
-M:	Johannes Thumshirn <johannes.thumshirn@men.de>
-S:	Supported
+M:	Johannes Thumshirn <jthumshirn@suse.de>
+S:	Maintained
 F:	drivers/mcb/
 F:	include/linux/mcb.h
 
-- 
2.3.7
