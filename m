Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB734F474;
	Fri, 29 May 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089629; cv=none; b=kOqibRh+OH4HPzTXZy4lDZMXDwkhKuxJWiRJxWGzfEU+hkdwaysZDtRCnAtYSgVjAzTB+OKI16cCwHk176m31Z/dawro5JQvxHfhWcCGuBHzY7d5nUw8K872U9e3g0R2DiQzaDXRfX+LXcoUZrh3Bq4mai6tkSMbX0MYtht6XuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089629; c=relaxed/simple;
	bh=oQ7x4NyHSPJnjBkGhNLc/QnP2bbrI9Ctr2l4qiKM6ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqEMXow/EE3bvdVRDfCu5rZxeNGtmdSeweb9UFR502ljrFq6De7DGINbcsTv1AmSURCRUdJijV+Atim9kwWY/Iuq6mFgM0I4qwKGC/CdNpSpNfF7vICpPHhqhpMwC2sOEU3dbbnlfO/cAsSg646N/1lTh08m0TXjnC9RdJiq2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ld0SYG+o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ld0SYG+o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XzNZ2l/2uZ2WpZM+YlAZx0tA9px8hPppIzSOcPIbcTs=; b=ld0SYG+oRntiKmikAa7hhVEPUl
	E/7P3ISfMsCUeRIcKX/3WANFEjo/Gl7gUkCfiHnSqCt3NQTP+S2QtL++QBQakhNHhORxGSealZFJo
	9FIZw0bU7X0Hw6CndCoATlpFByEfSrY2zchkteNNelek8sDaD0emGPSKSVUqy0Aj5uHpH/YoQO+zu
	3VMHX9klkDY6CQXM6VM89Atnv90M+gbrff5yUulXIldWXrDcxMfIe2f1znSMMhPJg6pnDySbw5JJC
	JlyDEiSjM9oiwJLSm9u0uDCuptbVKtax+J+TkvSjPryrA9lTyH014bvXa1qAE1OPqr+VERLd1JHHO
	aKJhq3Gw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT4d0-00000008F6L-3RCt;
	Fri, 29 May 2026 21:20:26 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 1/5] watchdog: add devm_watchdog_register_device() to watchdog-kernel-api
Date: Fri, 29 May 2026 14:20:20 -0700
Message-ID: <20260529212024.2119204-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529212024.2119204-1-rdunlap@infradead.org>
References: <20260529212024.2119204-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_watchdog_register_device() is not documented. Add it to the current
kernel API documentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: no changes

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/watchdog/watchdog-kernel-api.rst |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-next-20260525.orig/Documentation/watchdog/watchdog-kernel-api.rst
+++ linux-next-20260525/Documentation/watchdog/watchdog-kernel-api.rst
@@ -42,6 +42,14 @@ The watchdog subsystem includes a regist
 which allows you to register a watchdog as early as you wish during
 the boot process.
 
+There is also a resource-managed watchdog_register_device(),
+devm_watchdog_register_device(). If you use this to register a watchdog
+device, watchdog_unregister_device() is called automatically on driver
+detach::
+
+        int devm_watchdog_register_device(struct device *dev,
+				struct watchdog_device *wdd);
+
 The watchdog device structure looks like this::
 
   struct watchdog_device {
