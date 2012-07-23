Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <500D8DE3.20104@xenotime.net>
Date: Mon, 23 Jul 2012 10:46:11 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -next] watchdog: fix watchdog-test.c build warning
References: <20120723164036.52bc93caafcd165fc16f0284@canb.auug.org.au>
In-Reply-To: <20120723164036.52bc93caafcd165fc16f0284@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix compiler warning by making the function static:

Documentation/watchdog/src/watchdog-test.c:34:6: warning: no previous prototype for 'term'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc:	Wim Van Sebroeck <wim@iguana.be>
Cc:	linux-watchdog@vger.kernel.org
---
 Documentation/watchdog/src/watchdog-test.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20120723.orig/Documentation/watchdog/src/watchdog-test.c
+++ linux-next-20120723/Documentation/watchdog/src/watchdog-test.c
@@ -31,7 +31,7 @@ static void keep_alive(void)
  * or "-e" to enable the card.
  */
 
-void term(int sig)
+static void term(int sig)
 {
     close(fd);
     fprintf(stderr, "Stopping watchdog ticks...\n");
