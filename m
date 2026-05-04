Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0EC3A544B;
	Mon,  4 May 2026 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893005; cv=none; b=qS1Gfx3FOncDYLMmBdJHay4kHdCzaRpE0lQvkqr32qG7kt0/p5BLnj+H+XSc+iR6sbqwxn5K/C4sRHATVlkcmWo0e3WAAhwpv7m/u8427tzEn+Qemkp1wkZFlGYu2LG77o2mPk6pQOJr+9dKRyzMChHmKvcGOi+2pjQ5PU1CwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893005; c=relaxed/simple;
	bh=0+pnJbJtZojl0+g1hdLUgo7SUN68OmWxLYfO3SjEVfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0OVjlP6Z/Rp0seD+XAJhxNxtt76MRKfdtSomoEsKYWwNqzWpPN0OTzBQipMmBwwVrKqnym79JnWeOdis3X/ZKTH9di5Ir8JdPpwX46HRvMRwGH0C9gXQCy+miSz4KoP8fzhTlCVBkK4QdDEVzaeG2FIaJvC4B0b0fxfGtmt4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=ANZm3bag; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="ANZm3bag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777892587; bh=0+pnJbJtZojl0+g1hdLUgo7SUN68OmWxLYfO3SjEVfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANZm3bag0x8NEyFEgUytDBBvO3g4i0ua7ijLH6+q7/QC/qyhLHeGH6D28z8bT6sSt
	 /O9xtHZh0zuxSZAS5a9IK3k3T7SUiwHDGSPwK5ggN8rYwJgQjtV72UYveDdK2VABrc
	 5YPf//sWuGnL33hdQ/FGG23F8kZ3l/uqE+OXMJRw=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f87ceb-839b-7f0000032729-7f000001e27e-1
	for <multiple-recipients>; Mon, 04 May 2026 13:03:07 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon,  4 May 2026 13:03:07 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] watchdog: Separate kind of documentation
Date: Mon,  4 May 2026 13:02:40 +0200
Message-ID: <9fa905187a14c33246d30735cb8df23ca6a7e077.1777892508.git.phahn-oss@avm.de>
In-Reply-To: <cover.1777892508.git.phahn-oss@avm.de>
References: <cover.1777892508.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1777892587-93694EA9-0C938F5D/0/0
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
index 13e3d78254dd6..300ee142051dc 100644
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

