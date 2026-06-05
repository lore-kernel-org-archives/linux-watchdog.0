Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E933F597
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679998; cv=none; b=VFfjMzxegRDVQJTKq/pPLwj1T+rgrSjs4SZSALaCvDjclJ6ilqXTpd6haWuYyLm4iQuOKGx4tEcmxEXoyg9p2joInblUZ6zZ7j55u4NbVPhSWIxu6NVb6cxog32s9/1vFJC5MShSOm8mKbKGihjvywMktHtI/B4Ry+fK4s+t0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679998; c=relaxed/simple;
	bh=okmxrgBCvufTcX32FIBoSLwcDGUzqtcDdCzFnkaOA7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv37oTlq5xeBRJX19oRt0fzynPMjpCYeflYEhS3PlxVdN70+s+sIBQPJv+g/a90lx6qn1gplkGsNLoLHjdVV3rdfZwbkbWxf9f87aUgNv8JcoxuIwvFrcpj/vvBw+79bW9p71MB+VZl2Y2O2O2FKwWPwalx4ka0iDFsyge/fbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=ui4XRlhA reason="key not found in DNS"; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="ui4XRlhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780679989; x=1780939189;
	bh=s2Tq9L+mxJV1LF+CSfNq0nEeRrlDQozObfED+HQhBNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ui4XRlhALxtb0GLmeJsQCT8vh2XKH7OwDJNvDI1E4KW0+vKaRzOyTA/Q9C16c+k+R
	 gj0WoSZ1eEbO2qx0fvzDyTtGCJQaSP4PMoLX0GsJnhNO8gnCsaIJBhq9cpHA117L0B
	 +6DGhSB/D1nEhomHNur2z0174icqn1IurMeV26RMRmv2/udjXt0yY29Qjj3wpBnk+b
	 YvoB45pI43v/tWcteMKyF1SU497D8u+CgMW6B/WHgjWjBwpvIOC1DPNdDg4hWDP80r
	 Ng/wh5daqb2nzFdnwgpAYonRAFAoX80+V8TEufA6hBGYfHaaof4QKAP3bPr95NUGNT
	 mx1HRWjgZMRBA==
X-Pm-Submission-Id: 4gX7Tt4DgYz1DDXm
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] watchdog: starfive: balance PM refcount when start operation fails
Date: Fri,  5 Jun 2026 13:19:37 -0400
Message-ID: <3a2ba59a0ed3e5ee121a49e04c5bed0c452af238.1780666366.git.william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780666366.git.william@theesfeld.net>
References: <cover.1780664848.git.william@theesfeld.net> <cover.1780666366.git.william@theesfeld.net>
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

