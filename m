Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32748 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756122AbdJLU0B (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Oct 2017 16:26:01 -0400
Date: Thu, 12 Oct 2017 15:24:10 -0500
From: Tom Saeger <tom.saeger@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Jimmy Vance <jimmy.vance@hpe.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Tom Saeger <tom.saeger@oracle.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] Documentation: fix selftests related file refs
Message-ID: <d4ae0439fc28ad274822f62f46b6230114e3e2da.1507838726.git.tom.saeger@oracle.com>
References: <cover.1507838726.git.tom.saeger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1507838726.git.tom.saeger@oracle.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Make refs to selftests files valid including:
  - watchdog-test.c
  - dnotify_test.c

Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---
 Documentation/filesystems/dnotify.txt    | 2 +-
 Documentation/watchdog/hpwdt.txt         | 2 +-
 Documentation/watchdog/pcwd-watchdog.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/dnotify.txt b/Documentation/filesystems/dnotify.txt
index 6baf88f46859..15156883d321 100644
--- a/Documentation/filesystems/dnotify.txt
+++ b/Documentation/filesystems/dnotify.txt
@@ -62,7 +62,7 @@ disabled, fcntl(fd, F_NOTIFY, ...) will return -EINVAL.
 
 Example
 -------
-See Documentation/filesystems/dnotify_test.c for an example.
+See tools/testing/selftests/filesystems/dnotify_test.c for an example.
 
 NOTE
 ----
diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
index 7a9f635d0258..6d866c537127 100644
--- a/Documentation/watchdog/hpwdt.txt
+++ b/Documentation/watchdog/hpwdt.txt
@@ -15,7 +15,7 @@ Last reviewed: 05/20/2016
 
  Watchdog functionality is enabled like any other common watchdog driver. That
  is, an application needs to be started that kicks off the watchdog timer. A
- basic application exists in the Documentation/watchdog/src directory called
+ basic application exists in tools/testing/selftests/watchdog/ named
  watchdog-test.c. Simply compile the C file and kick it off. If the system
  gets into a bad state and hangs, the HPE ProLiant iLO timer register will
  not be updated in a timely fashion and a hardware system reset (also known as
diff --git a/Documentation/watchdog/pcwd-watchdog.txt b/Documentation/watchdog/pcwd-watchdog.txt
index 4f68052395c0..b8e60a441a43 100644
--- a/Documentation/watchdog/pcwd-watchdog.txt
+++ b/Documentation/watchdog/pcwd-watchdog.txt
@@ -25,7 +25,7 @@ Last reviewed: 10/05/2007
 
  If you want to write a program to be compatible with the PC Watchdog
  driver, simply use of modify the watchdog test program:
- Documentation/watchdog/src/watchdog-test.c
+ tools/testing/selftests/watchdog/watchdog-test.c
 
 
  Other IOCTL functions include:
-- 
2.14.2

