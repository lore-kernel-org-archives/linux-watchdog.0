Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720F30C147
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665127; cv=none; b=CUQOtxyyWpk+f14jDAVvE4e/oCp87RHZLQ21eNbNwnN75zxrFG+PUe4IRJw2EknNHcDVDQiZNICQXL/XuMq2kpFP2QeFXtYoLhKcoZ9de82IGVvL4lQWyjWF3v8FU/boNCL8rIJm+BuQOQHQh6wSHK1njFY7Gz2Bw8dCw+SdU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665127; c=relaxed/simple;
	bh=okmxrgBCvufTcX32FIBoSLwcDGUzqtcDdCzFnkaOA7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPncaGEOvH2nKe5DPBFjshZcWEg08+Jvxj2qnt+8i6pVwIZozN4C0UjC+GP2lB/hQB0PgVR6mcCl9tUiKrXufhhSRNPqAN+T+gIi5QpCsEDC8f1de9hBXUAhOsKuUcqHElH3i2bot0Xe+WzwI1gCYfJuqwMf+aJc8luRLi8w84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=bYCRFG/H reason="key not found in DNS"; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="bYCRFG/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780665122; x=1780924322;
	bh=s2Tq9L+mxJV1LF+CSfNq0nEeRrlDQozObfED+HQhBNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bYCRFG/HZfWvoIZNfUQTJoOV+UW28LEywD5mDdFTERrW811mG8Wq2eYo6+4R9dlvf
	 wvASNzsqKfPOvYu0jdPKnHJ2LQ9b5bJ/gZwThwzDM3DEX4ZeOYqulhpTuF9fcEfGMD
	 kk/eWaha1MgRiekGsZsMmtUXKDiK1Oq7T+1gl/3kjJWfnhQeUpEi7t/SOpfEs9Ks+7
	 NQqIZyR/ABA/72zQDUEVNrnXUhthISu55rsF4laFpQSHn97ERjjrwoN4jWaHyLnuNB
	 IGvtsbulZUvBSDmlBnhlCNrUB1IekgZ3J6oBc5ew0xczZUW40Sail1yjKYvGJ3dxzR
	 zdBcPzkb4F9dA==
X-Pm-Submission-Id: 4gX1zz1Gq6z1DFSh
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] watchdog: starfive: balance PM refcount when start operation fails
Date: Fri,  5 Jun 2026 09:11:50 -0400
Message-ID: <ea696db2019b0548b3956fbb84104b12eacc94eb.1780664848.git.william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780664848.git.william@theesfeld.net>
References: <20260605122336.159546-1-william@theesfeld.net> <cover.1780664848.git.william@theesfeld.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After pm_runtime_resume_and_get() succeeds in starfive_wdt_pm_start(),
the runtime PM usage counter is incremented.  If starfive_wdt_start()
subsequently fails, the function returns the error without releasing
that reference, leaking the usage counter.

Call pm_runtime_put_sync() on the start failure path so the counter
is balanced.

This also folds in the v1 conversion of pm_runtime_get_sync() to
pm_runtime_resume_and_get(), which was the original purpose of this
patch; both fixes together close the refcount-leak window in this
function as flagged by the maintainer on the v1 thread.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index af55adc4a..ed8c5711a 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -371,12 +371,16 @@ static void starfive_wdt_stop(struct starfive_wdt *wdt)
 static int starfive_wdt_pm_start(struct watchdog_device *wdd)
 {
 	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
-	int ret = pm_runtime_get_sync(wdd->parent);
+	int ret = pm_runtime_resume_and_get(wdd->parent);
 
 	if (ret < 0)
 		return ret;
 
-	return starfive_wdt_start(wdt);
+	ret = starfive_wdt_start(wdt);
+	if (ret)
+		pm_runtime_put_sync(wdd->parent);
+
+	return ret;
 }
 
 static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
-- 
2.54.0

