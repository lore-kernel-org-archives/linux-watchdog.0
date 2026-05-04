Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CF3DB642;
	Mon,  4 May 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902754; cv=none; b=lqjW01gUs+jtcE1cWe2xXXqQ/0mZZSHGEHIsiGW8nxsngq1L0addKbcxSmId9DEVvZH1EN38xQZfRFLQB77CDgWz28VJnVx1LPw0CifCRIBHhbPBs2AxELHEynep9OA8n1cE0n1N6LisWIgTGEJe3FqXj6slyaXvmOAPZ3WSdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902754; c=relaxed/simple;
	bh=yfHhvGmjTMJPUcSrWCoGBx/HYBtZ7hrAGcW9br8CDbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+CuAMgJ623SoTTZa84VKT82dYPNAlD6nIVIbjE5I21MJQL4QBj2rD0tsXmTqh7bheyNarHOI5Axevv8ETFCb5+P1vX01yz89bXmlf+bh603TOKH6MMS6gxL9G7nQWbT5VNNhOcS9l/UdfokX0aRVF8HXJKIhnIq1MhGLRG+ReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=RitrhTI1; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="RitrhTI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777902749; bh=yfHhvGmjTMJPUcSrWCoGBx/HYBtZ7hrAGcW9br8CDbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RitrhTI1zgpi5hi758diD1Io3rQ9NBxPgedWS0qhWe+ycg/Fh9RF4eBxumQTrfJDN
	 hZeu6GQKD+aGG6FB2Dd3X2NgbXAgyGAv6AlKTq3VvT3TOoG9z3JJiBAbrg66uDOg5Y
	 J77TXTiUwHgZ72W20qVMN9tHcE/M7Et5ZAJBeWPQ=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f8a49d-88c8-7f0000032729-7f000001e3b2-1
	for <multiple-recipients>; Mon, 04 May 2026 15:52:29 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon,  4 May 2026 15:52:29 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] watchdog: Prefix WDT with ICS for clarity
Date: Mon,  4 May 2026 15:50:03 +0200
Message-ID: <25e65a138f70239b6263bdfbed801f1acbb06688.1777902230.git.phahn-oss@avm.de>
In-Reply-To: <cover.1777902230.git.phahn-oss@avm.de>
References: <cover.1777902230.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1777902749-4DE19582-8F7E9DBD/0/0
X-purgate-type: clean
X-purgate-size: 2165
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

From: Philipp Hahn <phahn-oss@avm.de>

`wdt.rst` is only about the Watchdog timer from "Industrial Computer
Source" (ICS). Change the title to better express this.

Add missing SPDX license identifier `GPL-2.0-or-later` same as code to
silence `checkpatch`.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 Documentation/watchdog/wdt.rst | 8 +++++---
 drivers/watchdog/Kconfig       | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/watchdog/wdt.rst b/Documentation/watchdog/wdt.rst
index d97b0361535b0..5be200e08d02c 100644
--- a/Documentation/watchdog/wdt.rst
+++ b/Documentation/watchdog/wdt.rst
@@ -1,6 +1,8 @@
-============================================================
-WDT Watchdog Timer Interfaces For The Linux Operating System
-============================================================
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+================================================================
+ICS WDT Watchdog Timer Interfaces For The Linux Operating System
+================================================================
 
 Last Reviewed: 10/05/2007
 
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5d..2cbf0391a065a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2270,10 +2270,10 @@ config MIXCOMWD
 	  Most people will say N.
 
 config WDT
-	tristate "WDT Watchdog timer"
+	tristate "ICS WDT Watchdog timer"
 	depends on ISA
 	help
-	  If you have a WDT500P or WDT501P watchdog board, say Y here,
+	  If you have an ICS WDT500P or WDT501P watchdog board, say Y here,
 	  otherwise N. It is not possible to probe for this board, which means
 	  that you have to inform the kernel about the IO port and IRQ that
 	  is needed (you can do this via the io and irq parameters)
@@ -2304,7 +2304,7 @@ config PCIPCWATCHDOG
 	  Most people will say N.
 
 config WDTPCI
-	tristate "PCI-WDT500/501 Watchdog timer"
+	tristate "ICS PCI-WDT500/501 Watchdog timer"
 	depends on PCI && HAS_IOPORT
 	help
 	  If you have a PCI-WDT500/501 watchdog board, say Y here, otherwise N.
-- 
2.43.0

