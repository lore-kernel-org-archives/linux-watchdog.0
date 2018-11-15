Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbeKPJzB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 16 Nov 2018 04:55:01 -0500
From: Tao Ren <taoren@fb.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
CC: Tao Ren <taoren@fb.com>
Subject: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Date: Thu, 15 Nov 2018 23:44:26 +0000
Message-ID: <20181115234413.27009-1-taoren@fb.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently "watchdog did not stop!" message is printed when the watchdog
timer is not stopped at close. For example, people may see the message
when rebooting the system, or the message will be logged to console
periodically if watchdog is kicked by a scirpt which runs "echo k >
/dev/watchdog" command.

Given a critical message usually indicates a serious hardware/software
failure, this message could easily lead to confusion, so it's better to
just delete the message.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 drivers/watchdog/watchdog_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index f6c24b22b37c..65e9ebbd8759 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -879,7 +879,6 @@ static int watchdog_release(struct inode *inode, struct=
 file *file)
=20
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
-		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
 		watchdog_ping(wdd);
 	}
=20
--=20
2.17.1
