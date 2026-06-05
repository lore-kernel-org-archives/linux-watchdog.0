Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ACE3264C1
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662225; cv=none; b=Jq6ZeX3Dva9NTu53MZGGOP1lU9TyDhu8P3kOfvSeuQo11+3fYvbHUYGtaTgb/4NGFj1qgasUlR0Q/JJr/WbW9+jVp5Yn69Ods4ePVyhHEpM6mWS3pAsMjFSo8QFHQrY1Hkn3KvNt2YICbFdojOINpIj2TDzBpPubHE8j55E6aK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662225; c=relaxed/simple;
	bh=lf8liRLXqerrcHOM1MpiG+E8k3mXlrEnpdPKvz1notw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUgZI7L3wI3NZSAGWDJ5v/h2kCxxGu1PcrSne5WdFQYAYxeVh492+8OAXcsydvcc/5kwXuwh2wWlg48mlB2QrZ+hZRYHXT+UA2QYsSyoIsr/iW1JtyjWhthKTozpgIvOrS22WhDfUEfZV5BgC0XbZ09Yl43Y8BKgkuGH7E1BhKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=vgW/GL10 reason="key not found in DNS"; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="vgW/GL10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780662221; x=1780921421;
	bh=CAg+JAjv99uS7QErzTZ9SCj+8OrbKRfqBPFomP201HI=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=vgW/GL10y0poYQkIyRHgqE/ilFkqx65pMmgQktapxx3H/kGmJPXd8eXlqS1CJ8i0T
	 WshZDsIjnBFEBjltz+2nDRIYXViUre6ptiA8H0a9e2WlelTtQ1y5TChdVEx8v6sSGR
	 GqY+otLh/dvBmg05cETJ/aJb+cSDVLrrzKyIbLL2NrkzYwDtlg0jtz0EDfSlMFVtRX
	 txLrGKtkanf7+LdzGG8it2a6jP1qs+m3Cc7MyC3lu2QuqfiEvq56mHh20OGinefYnY
	 UfXjrtTBLASM7qK+TZsNU4TMuSRlUDU2Gmg4J5No70eW1zT/RZL6dKSCIy0V2WULjW
	 jpwv9RSN9AN5g==
X-Pm-Submission-Id: 4gX0wB4n0qz2Scq9
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: starfive: use pm_runtime_resume_and_get() to fix refcount leak
Date: Fri,  5 Jun 2026 08:23:36 -0400
Message-ID: <20260605122336.159546-1-william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

starfive_wdt_pm_start() calls pm_runtime_get_sync(), but
pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error.  On the error path this function just
returns the error code without a matching pm_runtime_put_noidle(),
so the usage counter is leaked on every failed resume.

Switch to pm_runtime_resume_and_get(), which decrements the usage
counter automatically on failure, leaving the caller with the simple
"check return value and propagate" pattern that the existing code
was already trying to follow.

Signed-off-by: William Theesfeld <william@theesfeld.net>
---
 drivers/watchdog/starfive-wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index af55adc4a..5a3254c83 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -371,7 +371,7 @@ static void starfive_wdt_stop(struct starfive_wdt *wdt)
 static int starfive_wdt_pm_start(struct watchdog_device *wdd)
 {
 	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
-	int ret = pm_runtime_get_sync(wdd->parent);
+	int ret = pm_runtime_resume_and_get(wdd->parent);
 
 	if (ret < 0)
 		return ret;
-- 
2.54.0

