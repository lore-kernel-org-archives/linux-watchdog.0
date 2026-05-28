Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29C186284;
	Thu, 28 May 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928089; cv=none; b=X3wArFp2qlu/aVsF/0Z2u/Hf2nxLrHO9m4qx3sJ4rE5O2oF5rgmsfzeAGQFLvfQaecvME/xIdyw/8pbRGgwQwAsh8QMVN1qx9WJaKsJ5DV94knNG6hliAOIsH3jBORKyB/TqIwqHWUjOsItvAFgE5QDtYxE5Nn6ZvsQEQZy8z94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928089; c=relaxed/simple;
	bh=VzCCG2WY9lp/Ig+ftT7XCOYa3KAVTvV+8yWaQKuCg24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpT96OAYCYU3iX7IzyOoShVNW6UgStD4w8DNhAU+zYjeKFKjM8t7RK7HXmroBpBpRIjuG/h6lu36YK1iyzwauvixeoskdaIFEVW0GdanmWsov+EG2NvvlyWSLxgNhyvJyAl6y9Ml1jlWCttTwHkQurM0Kl+q74k5CXB4LP1YQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RhdOcE4H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RhdOcE4H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NpxOKjsfnDebULmYkiyGcMGkmFp7bR2xF1D+86616qg=; b=RhdOcE4HedAwdTo8jgjOUGNqod
	N/MfIwhs2SmXkFxo6tudlchN0aZl7TSiqbMid4OZRUndqaKLR5Av147tX8LoE2ykz/F2ML7X16vtW
	MK0d8wbLF8/YcgtoWk6hGZM6kDX79rNHoSjcTNJV3qFsRPvRkKcH5gaXEgx781a6oJ8DrEpGYvRKg
	dcT+GiUnBT09H02E+HCg7i02+5RwuGutrljvxrOM59eNf7DuM/EdAVRLFHi5Uejqjrf7Fkg7UhrKn
	U1k5Qyj6DCqf2yNDiLYx/UYlpyh9YJZDwWT5UGQyuHFEHyjIn/yIYGSG2uSrs76dQ30emdyjiPtBR
	q8rdpdzw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSObV-00000004rZ7-1qPG;
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
Subject: [PATCH 1/5] watchdog: add devm_watchdog_register_device() to watchdog-kernel-api
Date: Wed, 27 May 2026 17:27:59 -0700
Message-ID: <20260528002803.1260126-2-rdunlap@infradead.org>
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

devm_watchdog_register_device() is not documented. Add it to the current
kernel API documentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
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
