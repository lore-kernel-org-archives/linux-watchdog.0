Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vpnchicago.adeneo-embedded.us ([65.182.180.190]:23421 "EHLO
	mxadeneo.adeneo-embedded.us" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752954AbbFFBrK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Jun 2015 21:47:10 -0400
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Guenter Roeck <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
Subject: [PATCH v2 2/3] watchdog-kernel-api: Add registration deferral mechanism
Date: Fri, 5 Jun 2015 18:46:51 -0700
Message-ID: <1433555212-4729-2-git-send-email-jtheou@adeneo-embedded.us>
In-Reply-To: <1433555212-4729-1-git-send-email-jtheou@adeneo-embedded.us>
References: <1433555212-4729-1-git-send-email-jtheou@adeneo-embedded.us>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add registration deferral mechanism capability information

Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index a0438f3..11c988b 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -36,6 +36,10 @@ The watchdog_unregister_device routine deregisters a registered watchdog timer
 device. The parameter of this routine is the pointer to the registered
 watchdog_device structure.
 
+The watchdog subsystem contain an registration deferral mechanism,
+which allow you to register an watchdog as early as you wish during
+the boot process, in the situation of a built-in module.
+
 The watchdog device structure looks like this:
 
 struct watchdog_device {
-- 
2.4.2

