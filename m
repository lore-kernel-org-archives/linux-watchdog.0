Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899A2D7DE2;
	Sat, 28 Feb 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240648; cv=none; b=IyJj1G9b35MzdgONhiTfCOOf11Cbd4eNRKFREcS0jjnbhKZwrGUMVW3DgsBllqoFudbuEcFELiDYgf/KU84cymVoEVVTXwDU1wMg17lyY7Wcvr90yROj5C6QXuSY+yLlws57Hj+MIG5I+mz9jtFgURXWdRC/AXYlkYMaXUlpCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240648; c=relaxed/simple;
	bh=pW7X3JCUSNB0uMRiqnXHeNK7AlBhL0qaQUSs2Be7/Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BETcEhJZ8B/+Kj/MxpgBXM1pleYVQkAgZhJld7Z69pJwzomoRU4jJ9XVamMIEU1QD68IqIanLkcvX6czzc4W9bzLdcXRVTndjw5Ry0DZXhesRmFDsYbn9NJGieRgGY2+Z25iWIWkqdpAAuvseyFxeWxtZiJQPc5PIqEuW7/u7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LGxMDNJD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LGxMDNJD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=op2TlNUursJCsJ2wf8GFZbci6I+s4vOSg2qO5Mu3PCg=; b=LGxMDNJDNUQhAwZ1DZPWz9m2To
	E819j6WU4byKUn/oGUSQQoyLjUfGegAK4RMlS6cTICinF9g1Cf9em8cjWMRjEp/IqwJpd69K5Tm3X
	5fHLuIEbn4o1QiTB0+zR2C51PFeIDSEupdm3zZnlTgmHwSSkJr2BN+9Xjjx/82GeFY+bKdeQ/ObL1
	NGh5JIB97dZKlwP8F7cZp+PT0evHH2J50Br+npgsWcQ0/k0zAr7GH8YyJEsuOjiV+bkis9EbnDxmU
	aJPinPFWMeyjDpIuSqnn/H7eF/Gak21d75WT9wZktQXcmd8kpm3KQHWbv5SIfB3597T/dyxWewg5t
	HBWDCOPQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw8kV-00000009Mfc-38J3;
	Sat, 28 Feb 2026 01:04:04 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/5] docs: watchdog: general cleaning and corrections
Date: Fri, 27 Feb 2026 17:03:57 -0800
Message-ID: <20260228010402.2389343-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some obvious issues in the watchdog documentation files.
I didn't try to fix every little niggling mistake.

 [PATCH 1/5] docs: watchdog: mlx-wdt: small fixes
 [PATCH 2/5] docs: watchdog: pcwd: fix typo and driver info.
 [PATCH 3/5] docs: watchdog-api: general cleaning
 [PATCH 4/5] docs: watchdog-kernel-api: general cleanups
 [PATCH 5/5] docs: watchdog-parameters: add missing watchdog_core parameters

 Documentation/watchdog/mlx-wdt.rst             |    4 -
 Documentation/watchdog/pcwd-watchdog.rst       |   19 +++++--
 Documentation/watchdog/watchdog-api.rst        |   38 +++++++--------
 Documentation/watchdog/watchdog-kernel-api.rst |   20 +++++--
 Documentation/watchdog/watchdog-parameters.rst |   11 +++-
 5 files changed, 58 insertions(+), 34 deletions(-)

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-doc@vger.kernel.org
