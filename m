Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60256 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaG2IEc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Jul 2014 04:04:32 -0400
From: Sangjung Woo <sangjung.woo@samsung.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sangjung Woo <sangjung.woo@samsung.com>, again4you@gmail.com
Subject: [PATCH] Documentation: fix a typo in watchdog-api.txt
Date: Tue, 29 Jul 2014 17:04:24 +0900
Message-id: <1406621064-5466-1-git-send-email-sangjung.woo@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Sangjung Woo <sangjung.woo@samsung.com>
---
 Documentation/watchdog/watchdog-api.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
index eb7132e..53c49a4 100644
--- a/Documentation/watchdog/watchdog-api.txt
+++ b/Documentation/watchdog/watchdog-api.txt
@@ -118,7 +118,7 @@ resets.
 Note that the pretimeout is the number of seconds before the time
 when the timeout will go off.  It is not the number of seconds until
 the pretimeout.  So, for instance, if you set the timeout to 60 seconds
-and the pretimeout to 10 seconds, the pretimout will go of in 50
+and the pretimeout to 10 seconds, the pretimout will go off in 50
 seconds.  Setting a pretimeout to zero disables it.
 
 There is also a get function for getting the pretimeout:
-- 
1.7.9.5

