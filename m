Received: from smtp.smtpout.orange.fr (smtp-67.smtpout.orange.fr [80.12.242.67])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EC37A487
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283441; cv=none; b=LDeFfBBoW+x4AAzESJzD894mWxUQtHkgfeBJp+otftPmQPdbt0UqCbO6ZZnTfR5hcHiCB3UVC+/uCViz8EwJEuSdclJdOE3lLZUZT4AkhA63nvjt+Ck24VZRlOVC16eC1VS95ON/fR9YSUseIhf3YwAmQptgqOJYdvHovR4Wf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283441; c=relaxed/simple;
	bh=UN5qYfceQ3ckH2R4oH1JEa46tWKVcyoKp44kz6TD2nA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNWmivRF/dncRyWuOmGDNIClO/TeNtPy5BmRUUoibQVbYerc63HtIqchzcw8ppI0Nj8Iy+skER2opCIhbCgXGjpTmYR2XFTMxbFlQzBaVjkUnKg/hw7ugq6IsFts7hRRVCjfdj+mRejJRe5UHa7nTuyTtRZW9q4CV2nTB8ekl1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YC2cf7QG; arc=none smtp.client-ip=80.12.242.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YC2cf7QG"
Received: from device-101.home ([10.65.86.57])
	by smtp.orange.fr with ESMTP
	id t3u0wWOVbr6ujt3u0wcwoY; Sun, 09 Aug 2026 15:49:24 +0200
Received: from device-101.home ([IPv6:2a01:cb10:785:b00:6128:9b8c:c203:905])
	by smtp.orange.fr with ESMTPSA
	id t3tnw3cg2k6xLt3towWMXk; Sun, 09 Aug 2026 15:49:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1786283356;
	bh=Ti0lq77YCohFOsswk+8chbqQ3hHI0aVo1aBVQ+5rD4g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YC2cf7QGJq+3QVFiUplisQRBrKIdQqwENIlZon9xvxdAtupuci/Eo++/UnyNgETMk
	 WtnSRImatXz1TyNjUFVkmVZmGPAhZK5mZe/6BfX4iXWsj/q3Lbqo7GnjLKGGOGP6/l
	 DQBdWOiV8N+UVNzIDgvpiTMzj/Qau1lWDrauMlkq9iMw0oQYp12JetM9J3Mcw0Z9TE
	 UaZMQrK1Yd258CBFJB7QfhuWmcQAdIeUFUN0AIr0mO25116LNUZv3DvJpCArkMX6y+
	 61rAaYFD0FdssPss2AOBeK48AH20F5JTWBRq/RlEIoy5VZTukU0Mi5z+rKyW4YPR0y
	 R63hEvOJ2iLbg==
X-ME-Helo: device-101.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Aug 2026 15:49:16 +0200
X-ME-IP: 2a01:cb10:785:b00:6128:9b8c:c203:905
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: apple: Constify some structures
Date: Sun,  9 Aug 2026 15:49:10 +0200
Message-ID: <99019b7e560c2d9c087be340e68f9cce4db1988e.1786283336.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct watchdog_ops' and 'struct watchdog_info' are not modified in this
driver.

Constifying these structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   7319	   1768	      0	   9087	   237f	drivers/watchdog/apple_wdt.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   7543	   1544	      0	   9087	   237f	drivers/watchdog/apple_wdt.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/watchdog/apple_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
index 6b9b0f9b05ce..f533953294f6 100644
--- a/drivers/watchdog/apple_wdt.c
+++ b/drivers/watchdog/apple_wdt.c
@@ -139,7 +139,7 @@ static int apple_wdt_restart(struct watchdog_device *wdd, unsigned long mode,
 	return 0;
 }
 
-static struct watchdog_ops apple_wdt_ops = {
+static const struct watchdog_ops apple_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = apple_wdt_start,
 	.stop = apple_wdt_stop,
@@ -149,7 +149,7 @@ static struct watchdog_ops apple_wdt_ops = {
 	.restart = apple_wdt_restart,
 };
 
-static struct watchdog_info apple_wdt_info = {
+static const struct watchdog_info apple_wdt_info = {
 	.identity = "Apple SoC Watchdog",
 	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
 };
-- 
2.55.0

