Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2F34F259;
	Fri, 29 May 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089630; cv=none; b=qWOhj1ktk0/X7qcZ6fsqLLpvoLRrhXQQnhZ1lfYskfRbUj61r667SJ4vSIKsph2DnroDi1RjJgnR/801rX8VP75/c0tBILkVHjmhvEbZLC97kndxz2OhwDVwIW6BjuIV59QC3smbPnyLVcdupQ5RM5uNF0CUd8Oar9dVyzNCtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089630; c=relaxed/simple;
	bh=ud7k9akCgH8ruJf3ePGR/o3SXvZzR7s7syBnTrCItIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErSBNg2dn2CuImahLFB72cjyelSC8mpJ300iK4p1YWCkONvXpF2bwEyX0KbJCoqLJ3c8RjLy9J9AGkzNkuoZQ5Oh+rbTYIBRn7BEYxwyTe8q+72nGZNmlgZuTJKg6pC4avEgeaKh9j02Lyibh/No0hdqielKMEC6sCHQ65r802I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i3WiH8b3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3WiH8b3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=U8waAHuZn2ISPhRPhF26ORdCy+7ainxk2C8YJSzfwNo=; b=i3WiH8b3CwoSWvzGAlwQZLt0ty
	bqYhMx5pxNBWCr2xpWSHNXxYMDP/Z1UqrB7d7laV8JTuwM/bltDwt0mvay5MSNtRqR3UnPCCUddvT
	nkipix4b5UB5qpNUaK9LWKTCIKjRCDlHAdV5OywkLwfXFddsvnyFnlIBiKW31hGaD1SOdZJlRLtr7
	1WNE/sVg8cKfhMndWP6H07txoy7LbCKF6lqPkr7uQx7NBH/HRVKgAFbzCshL0YGPVfkiJonfr3qKP
	GBnRKteLd1Vxb2KBUn8W6To5h2ml1FbzmN+fc9goJ7s401YXsFI98xrUDf9nTgLr0/LBvURqknC4s
	2I7RSUQw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT4d0-00000008F6L-25ZB;
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
Subject: [PATCH v2 0/5] watchdog: improve comments & Documentation
Date: Fri, 29 May 2026 14:20:19 -0700
Message-ID: <20260529212024.2119204-1-rdunlap@infradead.org>
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

v2: modify comments in patch 3/5 per sashiko review

[PATCH v2 1/5] watchdog: add devm_watchdog_register_device() to watchdog-kernel-api
[PATCH v2 2/5] watchdog: linux/watchdog.h: repair kernel-doc comments
[PATCH v2 3/5] watchdog: uapi: add comments for what bit masks apply to
[PATCH v2 4/5] watchdog: core: clean up some comments
[PATCH v2 5/5] watchdog: dev: convert to kernel-doc comments

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
