Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BB556BB5;
	Tue, 22 Sep 2026 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088658; cv=none; b=lTUw8sPngH89H/5vHtZT+6mkBtMbYB4IpwKCCNU6Z+Uweh5Jsh1b0eLCbjfKlj+WfKRyaGWJcgBK2/KaqgamSNvxpngqhWmooa9XjR8YPxPi4HLWWECTm3XR7Himkv/EAiQqDHrTLK9Jg2EILj5YTBQtQGh7/uWm7StWTK1qNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088658; c=relaxed/simple;
	bh=s5oWfEXJoI5ocD6/Do0jTZxwmqVY7+FzjkxlVxVquuQ=;
	h=From:Date:Subject:Message-ID:To:Cc:In-Reply-To:References; b=GhqXLvXn1toBWJ7FjMRQwrAIa5SAoJF+lZkmmOm1nu32N8AkLfGhd0W2RikFEux4tG4UNL+KvEreQ50pQ9nqoWLIWSrePoK22nrtE3imW6oQFR7USGi4acSTwWPJzNBNpy0PaG9ioaskzFHy8BQyc7Km6Pu13W5/oDfdcF2OBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZwSx2H6i; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZwSx2H6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:Message-ID:To; bh=/MgaUyWfv67EFPk
	7+7tYexqejr06dCqnU5PjhwP2AXU=; b=ZwSx2H6ixQ/WgVxLICzXjcQcnHd0cg9
	NWhNt9nXl1wF23CEKuZe3rcl6Ge8tIBWRVAE1ilTQAlJe9yGqBbTXBfz9Dd9LaOv
	QQmwO4Lp5ImlNEAroCxJ45aMfZnlS0Mwftp3F7GUN97osPRhGSpXsH5ajlWUedWK
	lcDS9c3vKBBI=
From: =?UTF-8?q?=E6=9E=97=E6=BF=AC=E5=93=B2?= <m18667909625@163.com>
Date: Tue, 22 Sep 2026 22:49:52 +0800
Subject: [PATCH v3 2/2] watchdog: use kstrtouint to parse softlockup_panic=
Message-ID: <20260922153000.10086.2-m18667909625@163.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, m18667909625@163.com
In-Reply-To: <e5bc7dc4-3faa-491f-9c8d-62afe0be0bbd@roeck-us.net>
References: <20260921064143.81420-1-m18667909625@163.com>
 <7b91e8cb-d068-484c-9a9f-2c19cb37f5ba@roeck-us.net>
 <e5bc7dc4-3faa-491f-9c8d-62afe0be0bbd@roeck-us.net>
X-CM-TRANSID:_____wD3fwSqlbJqh3OTAA--.12933S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1kKrWUJr1Dtr1kGry3Arb_yoWDtrX_Zr
	WIqw1vgF1qyrZaqF42va17ZF9Fqay5GF4v9an5KFW7Aryku34UWrZaqFZ5GF9YqFZ5Crya
	kFnxCrWS9r1DtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR-YwUDUUUUU==
X-CM-SenderInfo: bpryllixzqmlisv6il2tof0z/xtbC-hHY3mqylbE7UgAA38
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>


simple_strtoul() is deprecated. Use kstrtouint() instead; on a parse
error the variable is now left unchanged instead of being silently
clamped.

__setup() handlers return whether they handled the option and cannot
propagate parse errors, so the handler simply returns 1.

v3: do not warn on parse errors (Guenter Roeck).

Signed-off-by: Lin Junzhe <m18667909625@163.com>
Assisted-by: AI coding assistant (per kernel AI guidelines)
---
 kernel/watchdog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 420f08140713..69cd5ebb4929 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -423,10 +423,11 @@ static unsigned long soft_lockup_nmi_warn;
 
 static int __init softlockup_panic_setup(char *str)
 {
-	int ret;
+	unsigned int val;
 
-	ret = kstrtouint(str, 0, &softlockup_panic);
-	return ret ? ret : 1;
+	if (!kstrtouint(str, 0, &val))
+		softlockup_panic = val;
+	return 1;
 }
 __setup("softlockup_panic=", softlockup_panic_setup);
 
-- 
2.54.0.windows.1


