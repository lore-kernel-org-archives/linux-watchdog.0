Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2EB18FC80;
	Thu, 28 May 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928090; cv=none; b=Oxu1l61dGRzY/RUAwt+bFl7bMcnASUPbWJ6lI3rmVqji/h9x6B7LNmfuQO824DGYHxp6nGxvaOfeM74heYpq6cRI15JwygUwmprbFahEiYcJjGdDeNaWOtKGQiafIwiQKa52silJ6SIoidUsVxJcVqVb0XtP6IN3p4GePI5VCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928090; c=relaxed/simple;
	bh=vwm3ZNRCzNEkNrji1GlfC6deS7Y4C3lKdD2jDFtC0Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrepWCsklbW4vFHf1mK8vzAaRxjrX6Q/U5pT8vfv4tJD3ZhrN2p6vuNfsIdx2hRPTuf+HL1CbAOKAdfSWlhvCX0KIZE+m1+/ugezCG+Nn15x22TRA6BR8k4ruFR8rbuxVhnAw0W/KrTptBMguvUter4NCmG+cQ2Bpe3ULnF7Hro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YbQPS73C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YbQPS73C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YUbwXC7zGeZUbyZDSGIHXcRoenrR+B/707Xvi52W8jE=; b=YbQPS73Cl9CIgvsr1bYeHF2AKW
	WzKJkEcC7LX8BOcNiZPVllLahAYKHql4mC17C9TWxHWj7MsIMI3XSS7MgWS/cuvamGJCPkuKdHy2e
	bhovLbmzpBfCwR8tpTVzb7UMGTc3aoRCvAPFXDw5Gdh9zERKNrbva7X+tBOUHxO9E63L6GaWnWz83
	MCrSDTQDwGNjBpBz618yF9Bm05uqmnX6CU8WsgS0TNukktwBj8huiBV6iD3ia9noJrva1cJ9bSAA2
	wi9fWk7Qi+WeGXdXc3GSZWPqJcQnI69SwAjLGJSi1TEPEWuFuz+6Sd9+bXEIRx0gQ2x4Ff1y9K4UU
	NUlyl4vQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSObV-00000004rZ7-3JS4;
	Thu, 28 May 2026 00:28:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/5] watchdog: linux/watchdog.h: repair kernel-doc comments
Date: Wed, 27 May 2026 17:28:00 -0700
Message-ID: <20260528002803.1260126-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528002803.1260126-1-rdunlap@infradead.org>
References: <20260528002803.1260126-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert struct comments to correct kernel-doc format and
add one missing struct member description.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org

 include/linux/watchdog.h |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-next-20260525.orig/include/linux/watchdog.h
+++ linux-next-20260525/include/linux/watchdog.h
@@ -26,7 +26,8 @@ struct watchdog_device;
 struct watchdog_core_data;
 struct watchdog_governor;
 
-/** struct watchdog_ops - The watchdog-devices operations
+/**
+ * struct watchdog_ops - The watchdog-devices operations
  *
  * @owner:	The module owner.
  * @start:	The routine for starting the watchdog device.
@@ -59,7 +60,8 @@ struct watchdog_ops {
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
-/** struct watchdog_device - The structure that defines a watchdog device
+/**
+ * struct watchdog_device - The structure that defines a watchdog device
  *
  * @id:		The watchdog's ID. (Allocated by watchdog_register_device)
  * @parent:	The parent bus device
@@ -83,6 +85,8 @@ struct watchdog_ops {
  *		Replaces max_timeout if specified.
  * @reboot_nb:	The notifier block to stop watchdog on reboot.
  * @restart_nb:	The notifier block to register a restart function.
+ * @pm_nb:	The notifier block to stop watchdog on suspend and restart it
+ *		on resume.
  * @driver_data:Pointer to the drivers private data.
  * @wd_data:	Pointer to watchdog core internal data.
  * @status:	Field that contains the devices internal status bits.
