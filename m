Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36374 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbcEYNcv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 09:32:51 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Robin Gong <b38343@freescale.com>
Subject: [PATCH 4/7] watchdog: documentation: squash paragraphs about 'no set_timeout'
Date: Wed, 25 May 2016 15:32:28 +0200
Message-Id: <1464183151-4912-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
References: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Those paragraphs deal with the same topic, so tie them together for
easier reading.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 917eeeabfa5eae..a9a65f8c0de9f0 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -179,8 +179,8 @@ they are supported. These optional routines/operations are:
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
   If the watchdog driver does not have to perform any action but setting the
-  watchdog_device.timeout, this callback can be omitted.
-  If set_timeout is not provided but, WDIOF_SETTIMEOUT is set, the watchdog
+  watchdog_device.timeout, this callback can be omitted. That means if
+  set_timeout is not provided but WDIOF_SETTIMEOUT is set, the watchdog
   infrastructure updates the timeout value of the watchdog_device internally
   to the requested value.
 * get_timeleft: this routines returns the time that's left before a reset.
-- 
2.8.1

