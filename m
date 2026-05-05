Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77747327C18;
	Tue,  5 May 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973208; cv=none; b=nQXzXLKaxxKuIgZPoUeKRSZ96o9Kj/bfv6eyemaINMjlYflZ8LWWKJB3rzycl14KXxiJ06TJReUrn4fh6IZqwl1l5Ot4oC1nRO7xxf39p0jzwNIgZlGOtt/ZejEeG+tZPsT1MWgEs6pu4eX5Ql83PitbWlmJ0/S+zYVz/67QOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973208; c=relaxed/simple;
	bh=6JR1rI7E1CBXEUhksGIm+JDj7sfufWA39XmqmTsMT7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qplkfSU52aRi0j3LYD5WInvl5/ZpwpxF6aeFkelbzFU3YDK9gP2RMOFqtVDk7ynNe1bjusesgiF+m66HCN7/fvA1YYeqv+oZscO75BpITR6C+8MiP1E1I4iu6nChbqkT8j+94DO7N3EENyz1Smo6bCf11ooEauTBXV8FlomeLoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=vogu4m1m; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="vogu4m1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777973201; bh=6JR1rI7E1CBXEUhksGIm+JDj7sfufWA39XmqmTsMT7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vogu4m1mVl1rgDwJlaltvU0y6q3rWkzyPmkcYxHfrRvHl1UnXRBGH4ur03ysBtEbw
	 9ad2FuJx3+bXa3RySQHWgsIOyIqcrA1/8vSRaJPzCTdBXk6E8xz9PA9MYxVIxr4Epb
	 s8C8vrqTprAley2FDV0KPyGKftJzfOK14FkwNVBk=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f9b7d0-23fc-7f0000032729-7f000001b35e-1
	for <multiple-recipients>; Tue, 05 May 2026 11:26:40 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  5 May 2026 11:26:40 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] watchdog: Prefix WDT with ICS for clarity
Date: Tue,  5 May 2026 11:26:16 +0200
Message-ID: <5a71979d8e8ab8e0a30de33f6aa2540b3b5dc1ee.1777972790.git.phahn-oss@avm.de>
In-Reply-To: <cover.1777972790.git.phahn-oss@avm.de>
References: <cover.1777972790.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1777973200-BAC19EEC-24DBE6AA/0/0
X-purgate-type: clean
X-purgate-size: 3615
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

From: Philipp Hahn <phahn-oss@avm.de>

`wdt.rst` is only about the Watchdog from "Industrial Computer Source"
(ICS). Change the title and rename the file to better express this.

Add missing SPDX license identifier `GPL-2.0-or-later` same as code to
silence `checkpatch`.

Fix wrong link to sample driver in drivers/watchdog/smsc37b787_wdt.c.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 Documentation/watchdog/{wdt.rst => ics-wdt.rst} |  8 +++++---
 Documentation/watchdog/index.rst                |  2 +-
 drivers/watchdog/Kconfig                        | 10 ++++++----
 drivers/watchdog/smsc37b787_wdt.c               |  2 +-
 4 files changed, 13 insertions(+), 9 deletions(-)
 rename Documentation/watchdog/{wdt.rst => ics-wdt.rst} (91%)

diff --git a/Documentation/watchdog/wdt.rst b/Documentation/watchdog/ics-wdt.rst
similarity index 91%
rename from Documentation/watchdog/wdt.rst
rename to Documentation/watchdog/ics-wdt.rst
index d97b0361535b0..b0dc29e56358d 100644
--- a/Documentation/watchdog/wdt.rst
+++ b/Documentation/watchdog/ics-wdt.rst
@@ -1,6 +1,8 @@
-============================================================
-WDT Watchdog Timer Interfaces For The Linux Operating System
-============================================================
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================================
+Industrial Computer Source Watchdog Driver
+==========================================
 
 Last Reviewed: 10/05/2007
 
diff --git a/Documentation/watchdog/index.rst b/Documentation/watchdog/index.rst
index 293ed05ba6b87..dbc702b31a43e 100644
--- a/Documentation/watchdog/index.rst
+++ b/Documentation/watchdog/index.rst
@@ -23,6 +23,6 @@ Driver specific
 
     watchdog-parameters
     hpwdt
-    wdt
+    ics-wdt
     mlx-wdt
     pcwd-watchdog
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5d..43c2ee69caada 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2270,10 +2270,11 @@ config MIXCOMWD
 	  Most people will say N.
 
 config WDT
-	tristate "WDT Watchdog timer"
+	tristate "ICS WDT500P/501P Watchdog timer"
 	depends on ISA
 	help
-	  If you have a WDT500P or WDT501P watchdog board, say Y here,
+	  If you have an Industrial Computer Source (ICS) WDT500P or WDT501P
+	  watchdog board, say Y here,
 	  otherwise N. It is not possible to probe for this board, which means
 	  that you have to inform the kernel about the IO port and IRQ that
 	  is needed (you can do this via the io and irq parameters)
@@ -2304,10 +2305,11 @@ config PCIPCWATCHDOG
 	  Most people will say N.
 
 config WDTPCI
-	tristate "PCI-WDT500/501 Watchdog timer"
+	tristate "ICS PCI-WDT500/501 Watchdog timer"
 	depends on PCI && HAS_IOPORT
 	help
-	  If you have a PCI-WDT500/501 watchdog board, say Y here, otherwise N.
+	  If you have an Industrial Computer Source (ICS) PCI-WDT500/501 watchdog
+	  board, say Y here, otherwise N.
 
 	  If you have a PCI-WDT501 watchdog board then you can enable the
 	  temperature sensor by setting the type parameter to 501.
diff --git a/drivers/watchdog/smsc37b787_wdt.c b/drivers/watchdog/smsc37b787_wdt.c
index 3011e1af00f98..9f2c2ab4e2f15 100644
--- a/drivers/watchdog/smsc37b787_wdt.c
+++ b/drivers/watchdog/smsc37b787_wdt.c
@@ -36,7 +36,7 @@
  *  mknod /dev/watchdog c 10 130
  *
  * For an example userspace keep-alive daemon, see:
- *   Documentation/watchdog/wdt.rst
+ *   samples/watchdog/watchdog-simple.c
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.43.0

