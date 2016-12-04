Return-path: <akkushwaha9896@gmail.com>
From: akkushwaha9896@gmail.com
To: wim@iguana.be
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	Amit Kushwaha <akkushwaha9896@gmail.com>
Subject: [PATCH] watchdog: cpwd: remove memory allocate failure message
Date: Sun,  4 Dec 2016 13:22:08 -0800
Message-Id: <1480886528-13702-1-git-send-email-akkushwaha9896@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Amit Kushwaha <akkushwaha9896@gmail.com>

This patch cleanup following warning reported by checkpatch.pl
WARNING: Possible unnecessary 'out of memory' message
With no available memory, a warn on message already gets printed
by page alloc functions

Signed-off-by: Amit Kushwaha <akkushwaha9896@gmail.com>
---
 drivers/watchdog/cpwd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 71ee079..baa2d0d 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -540,10 +540,8 @@ static int cpwd_probe(struct platform_device *op)
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	err = -ENOMEM;
-	if (!p) {
-		pr_err("Unable to allocate struct cpwd\n");
+	if (!p)
 		goto out;
-	}
 
 	p->irq = op->archdata.irqs[0];
 
-- 
1.7.1
