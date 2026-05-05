Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F350328610;
	Tue,  5 May 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973208; cv=none; b=W2u1xMg/ym2U+bChmv9t+4zvQya2dG8Klsa/P6TGtkkEJPT7pXK8TqIFeAhZfMNVpKN1hf1n/58yo0WJWMO4QT2003lusHisUX2/prBD/K0IAlw8wJgZYjiQfHe/2VhN+o2hQvnqf1bJDYZYSgWnPcLGttqhO8rKJrHnJRSdUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973208; c=relaxed/simple;
	bh=on5RSa3EvZp85/dED2BvXFuR/vPUMaxvQXxG7Jh74Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXK/TD2CFXOqq6Ss069bg2rlanCE1gwNMKipFBjSL6jE8bH3h8mddunk0+kkwPvIJSyyPz+OZddxM4XoY+Zl2m6PIAl+ZAvtui1ILm0XXTPmudIV8p9uzKu+t3f9sgJm5eAvuZ7u81bJz7907E96NFpNR7FpS9QS1Qr0kRAEqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=feKYQx0S; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="feKYQx0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777973200; bh=on5RSa3EvZp85/dED2BvXFuR/vPUMaxvQXxG7Jh74Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feKYQx0Sy5h5aBHTMg7p4yVIaOpblcsnF2SaQbKEpZnQb/vG/XtiUEdYxHHj/MUa0
	 0pDKJ9VTTe7OuvtkpwQjo0H9gkKcMaU4nK4hm3DplKyYUVpWzGP3chLv6+Hq723Bc1
	 NO/6aUCLGfRG3Clg1G4AHiC5XTL3u0T2HWLJUQLc=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f9b7d0-88c8-7f0000032729-7f0000019244-1
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
Subject: [PATCH v3 4/5] watchdog: Separate kind of documentation
Date: Tue,  5 May 2026 11:26:15 +0200
Message-ID: <7d1b722205bab83603832e66750f7b5f1f73eaa5.1777972790.git.phahn-oss@avm.de>
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
X-purgate-ID: 149429::1777973200-69640582-005E6247/0/0
X-purgate-type: clean
X-purgate-size: 1087
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

From: Philipp Hahn <phahn-oss@avm.de>

Currently there are several (sub-)documents for "Generic kernel
infrastructure API" and several "driver specific" documents. Put each
one into its own sub-section.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 Documentation/watchdog/index.rst | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/watchdog/index.rst b/Documentation/watchdog/index.rst
index 1cea24681e6bd..293ed05ba6b87 100644
--- a/Documentation/watchdog/index.rst
+++ b/Documentation/watchdog/index.rst
@@ -4,15 +4,25 @@
 Watchdog Support
 ================
 
+Kernel infrastructure
+=====================
+
 .. toctree::
     :maxdepth: 1
 
-    hpwdt
-    mlx-wdt
-    pcwd-watchdog
     watchdog-api
     watchdog-kernel-api
-    watchdog-parameters
     watchdog-pm
-    wdt
     convert_drivers_to_kernel_api
+
+Driver specific
+===============
+
+.. toctree::
+    :maxdepth: 1
+
+    watchdog-parameters
+    hpwdt
+    wdt
+    mlx-wdt
+    pcwd-watchdog
-- 
2.43.0

