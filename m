Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:46172 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbdFVNWF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Jun 2017 09:22:05 -0400
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
To: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>,
        Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net,
        wim@iguana.be, jlayton@poochiereds.net, marc.2377@gmail.com,
        cshorler@googlemail.com, wsa@the-dreams.de,
        regressions@leemhuis.info,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
Subject: [PATCH 2/5 v2] Modify behaviour of request_*muxed_region()
Date: Thu, 22 Jun 2017 15:21:31 +0200
Message-Id: <20170622132134.7200-3-zboszor@pr.hu>
In-Reply-To: <20170622132134.7200-1-zboszor@pr.hu>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In order to make request_*muxed_region() behave more like
mutex_lock(), a possible failure case needs to be eliminated.
When drivers do not properly share the same I/O region, e.g.
one is using request_region() and the other is using
request_muxed_region(), the kernel didn't warn the user about it.
This change modifies IORESOURCE_MUXED behaviour so it always
goes to sleep waiting for the resuorce to be freed and the
inconsistent resource flag usage is logged with KERN_ERR.

v2: Fixed checkpatch.pl warnings and extended the comment
    about request_declared_muxed_region.

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 kernel/resource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 2be7029..5df2731 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1125,6 +1125,7 @@ resource_size_t resource_alignment(struct resource *res)
  *
  * request_declared_muxed_region creates a new shared busy region
  * described in an existing resource descriptor.
+ * It only returns if it succeeded.
  *
  * release_region releases a matching busy region.
  * The region is only freed if it was allocated.
@@ -1191,7 +1192,10 @@ struct resource *__request_declared_region(struct resource *parent,
 				continue;
 			}
 		}
-		if (conflict->flags & flags & IORESOURCE_MUXED) {
+		if (flags & IORESOURCE_MUXED) {
+			if (!(conflict->flags & IORESOURCE_MUXED))
+				pr_err("Resource conflict between muxed \"%s\" and non-muxed \"%s\" I/O regions!\n",
+					res->name, conflict->name);
 			add_wait_queue(&muxed_resource_wait, &wait);
 			write_unlock(&resource_lock);
 			set_current_state(TASK_UNINTERRUPTIBLE);
-- 
2.9.4

