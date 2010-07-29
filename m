Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 29 Jul 2010 20:05:59 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: [WATCHDOG] Update Maintainers info
Message-ID: <20100729180559.GD30740@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

with these Changes:

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Thu Jul 29 18:02:51 2010 +0000

    watchdog: update MAINTAINERS entry
    
    Add Mailing-list and website to watchdog MAINTAINERS entry.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index db3d0f5..02f75fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6243,6 +6243,8 @@ F:	drivers/mmc/host/wbsd.*
 
 WATCHDOG DEVICE DRIVERS
 M:	Wim Van Sebroeck <wim@iguana.be>
+L:	linux-watchdog@vger.kernel.org
+W:	http://www.linux-watchdog.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
 S:	Maintained
 F:	Documentation/watchdog/
