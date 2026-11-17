Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881130;
	b=z3al85jhP6dZ5K9FsHM/kayxbuy/Wm3Qu/EYmFLbIz0S5gP+ihBnpu/meigiCjh6sTkW
	 d7SAMhgtLWqMwgC0Sy2z7+fHnjRQXQWRmO4LZHcpkLVGMaa4IXZ2DvPmEBCoQlyGBysdd
	 h8aDjimCFRUhDnBF7Q20K/pKif0GEnj9W3Ux2ckpjY2NFrzCZHP1s2KYhCAbDiDZCl5FX
	 ZvPUdyDooISJc4mvR83ChoM9Aq7BqNUTZkVKokEy63Gmliiov+IkO+laEWwYOujpLphT5
	 IenrPHPxbwkkN3o5DJz3azc/FeTlVduj/xawhNE9NyCmFOLGouNgzJ1QqrcqKspeN5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881130;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h32451cXeKQhEtLj9wsS/Ias7hb97pv09g1YdLOvxxE=;
	b=vnEqZvN7KlSlUIAV/gDokG3lcGF1KBrOAU3uvCFQu4+ebZBim/q5qVSgYdbMU4Gc/Adm
	 EBySquleWI+Y9gzB5G28ZBkauUfiXyHcd7MWK5Go62dLEQS1R8dpcV9sVuITZqWhYhNIz
	 WTCKJxAB3EDtZQQAbFI36SFVRRxqboJODhtzN0xIrpjI/5S71GPCAvzDU/NAEOMVLc7Ai
	 N/xC+vTkPiyv3cUflANTzaCjmExnmSd8BA8l6VtsAV0o/sJAh1BdjhrKm4ScCbshWNW/j
	 L97NnW6tBQEU6h1l2dsUX4dbS9oIs0T8MK4dZEnBL1wQS+2CHjwrZs0ZEIBEnEaIwxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=iwSulwvp;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E013606A31C;
	Tue, 17 Nov 2026 02:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E013606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=iwSulwvp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=iwSulwvptX/xFdfGJqoLXpt+Nq6GRObZTzEP89ur2R9ZF2WKcaQpTHSHE8UViGoapmE1dXQ+rUBAA
	 qED7ZZngjNZTNR/qlKqvJfJm1GPveKej4ZX9uqokpGQJ1QnejBjOc+KmpKqrTb8DkncRE+LnFieSgI
	 12bQ+kKUHGDmMJDk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16afbb66828d-dfb81;
	Tue, 17 Nov 2026 10:05:28 +0800 (CST)
X-RM-TRANSID:2ee16afbb66828d-dfb81
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16afbb666b0d-9edb7;
	Tue, 17 Nov 2026 10:05:27 +0800 (CST)
X-RM-TRANSID:2ee16afbb666b0d-9edb7
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: renesas_wdt: avoid sleeping clock calls in restart handler
Date: Tue, 17 Nov 2026 10:05:30 +0800
Message-Id: <20261117020530.19973-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.24.4
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rwdt_restart() runs in atomic context, as the comment above the function
points out, but it calls clk_prepare_enable().  clk_prepare() may sleep on
the clock mutex, which is not allowed from a restart handler.

Prepare the clock once in the probe function and only call clk_enable()
from the restart handler.  clk_enable() does not sleep, so the restart
path stays atomic.  Unprepare the clock in the probe error path and in
rwdt_remove().

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/watchdog/renesas_wdt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index d9760f2a3b..9630d05686 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -135,7 +135,7 @@ static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 	u8 val;
 
-	clk_prepare_enable(priv->clk);
+	clk_enable(priv->clk);
 
 	/* Stop the timer before we modify any register */
 	val = readb_relaxed(priv->base + RWTCSRA) & ~RWTCSRA_TME;
@@ -233,6 +233,14 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	/*
+	 * The restart handler runs in atomic context and can only enable the
+	 * clock, so prepare it here.
+	 */
+	ret = clk_prepare(priv->clk);
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 	priv->clk_rate = clk_get_rate(priv->clk);
@@ -290,6 +298,7 @@ static int rwdt_probe(struct platform_device *pdev)
 
  out_pm_disable:
 	pm_runtime_disable(dev);
+	clk_unprepare(priv->clk);
 	return ret;
 }
 
@@ -299,6 +308,7 @@ static void rwdt_remove(struct platform_device *pdev)
 
 	watchdog_unregister_device(&priv->wdev);
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(priv->clk);
 }
 
 static int rwdt_suspend(struct device *dev)
-- 
2.24.4



