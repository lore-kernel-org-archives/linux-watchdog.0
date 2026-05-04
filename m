Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340CD3DA5C4;
	Mon,  4 May 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902754; cv=none; b=cbGlBRafgaQ8lk7jaujKv5tTe6kDZ81uRUQGw9gfHfOMP5V5Z8VTz+m2jg6vdqdG5Tai8ajhTg3kZuORDk3B0cul9XviaQOBX7zOEhuUeMaKBE5iIw3go2YiD7kI82rEn/KVmnRHAnSnnsGTqPs35CawvS/uozJptNcKWiwoO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902754; c=relaxed/simple;
	bh=X0jhz6d9YsnMWMf1sUvjNb50GBIT36snTSn8/utfE3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsnC5gHqyaDyGq38l/txKXGc3r3P9kgfmK945iwVrMiJK9YkKXmPrLG/0FQFd+r7WAr2XBPh7fvuqRg8Tt4G4vbHa+qcCUfmaNQ6XNZ564VKWbxums5Dqi0n3uMDkMVwNj3eknHoer/mmn7y3u4vpqzAtItXhDPb6EkyQRt2ibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=jmBeQg21; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="jmBeQg21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777902749; bh=X0jhz6d9YsnMWMf1sUvjNb50GBIT36snTSn8/utfE3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmBeQg21nqh75/+0bc+BnXQm5uJ8AHW6Pfnn2I84EYQUEAmVZ5uqHxt+DLrKc4Lle
	 lUKb305wjHBnlwgJJHFbyF8G6a2eiqBbram/zOSDqDdqz7XAd3uXhRhz1LDwNH6Z6j
	 o1HOJ5eA35zCgrQfNRjkDYBcOgUiWmlRVSQJmroA=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f8a49d-88c8-7f0000032729-7f000001e3a8-1
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
Subject: [PATCH v2 4/5] watchdog: Separate kind of documentation
Date: Mon,  4 May 2026 15:50:02 +0200
Message-ID: <8a4ccc42186d72cc172889411badc06ed68eacd5.1777902230.git.phahn-oss@avm.de>
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
X-purgate-ID: 149429::1777902749-51610582-609225D5/0/0
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
index 1cea24681e6bd..8886910550344 100644
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
+    wdt
+    hpwdt
+    mlx-wdt
+    pcwd-watchdog
-- 
2.43.0

