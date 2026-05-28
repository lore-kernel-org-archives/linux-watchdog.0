Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34A1940B0;
	Thu, 28 May 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928089; cv=none; b=FQsD0FRhgxJBa+zzSEDWfm35DNI+GsvJt5AXfdCTINS6HZv7ZA5jSSeWDNHXwTYqaiGvtAv+8Y8gUaSjb13lQpOs/WEDIgnvahnzKIMKr2J+vBeGAyXq5AJyYqqNYrf7GenIHkZQM8TiB9LHgmKMuWLYzLnX0os26QlCvlM3lG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928089; c=relaxed/simple;
	bh=iqIw4BmPF+2dDsjia4xazKYD/RIRJRAVFefpSJScL9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfTtcBGSE7xTSbBMGSVebMXNxH7vtDZUWH3kKEg8VDClA8gchNSqZD2ryycHRDFCM7r0h/XKKHzX5FNOz/CUDcwY/ROPAx2U4pWH2XGFxkh3TJAMHRZfxzffJe7xgNNsiU8nz5wZ1dkWJP4eb5rupDqun0Tu1FdVTAIUY8xmfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cuQWPBa7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cuQWPBa7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=J22xHJRmlZv6cVds2IeEilTP32/Q2JkES+c6kVoqSYg=; b=cuQWPBa7rh60yPE2xFaxQrz2bw
	Uit4QtsmtVGbLx+FGUxUuAhu81QgBK4WOl3viDf0HSJkIJz3XoJmztvfClbPdSIY9q+O/aX52vd9+
	R18bf5KSk73aiehT4Etk53GXInA0OQx7P9ux5S3bVi2+4OvpJFuB/5tIwP8XhaoGGJPhLWobfOnGk
	YsXgIgjCu/2c6ZqENyaVk2nYTNK4N68A3m+0mRxI2iyNwJev5NI6A2ari8/gdN141qtffnW8xcPXv
	gYvZa6YqPWtG3OnE1Ag28KhPfEpI/UiZdWueRFROw70H/cc2n/qIFpRQKJFBBjamDM5Lc5EVUBBe7
	KpVN1Nbw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSObV-00000004rZ7-0SgW;
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
Subject: [PATCH 0/5] watchdog: improve comments & Documentation
Date: Wed, 27 May 2026 17:27:58 -0700
Message-ID: <20260528002803.1260126-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing devm_watchdog_register_device() to watchdog-kernel-api.rst.
Convert some struct and function comments to kernel-doc format.
Add some UAPI comments for quick reference.
Correct some grammar and bulleted list format.

[PATCH 1/5] watchdog: add devm_watchdog_register_device() to watchdog-kernel-api
[PATCH 2/5] watchdog: linux/watchdog.h: repair kernel-doc comments
[PATCH 3/5] watchdog: uapi: add comments for what bit masks apply to
[PATCH 4/5] watchdog: core: clean up some comments
[PATCH 5/5] watchdog: dev: convert to kernel-doc comments

 Documentation/watchdog/watchdog-kernel-api.rst |    8 ++++
 drivers/watchdog/watchdog_core.c               |   12 +++---
 drivers/watchdog/watchdog_dev.c                |   30 +++++++--------
 include/linux/watchdog.h                       |    8 +++-
 include/uapi/linux/watchdog.h                  |    2 +
 5 files changed, 37 insertions(+), 23 deletions(-)

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
