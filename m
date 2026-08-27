Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58D38F935;
	Thu, 27 Aug 2026 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806045; cv=none; b=nGl5k75hvORnsSpYRSnKCezNYXFFpQQh8EY+DyPsP/HAbhEu0w0AV4Q2AZZ6sL3SEBS8r2wI8MBR765HrCl2LNiYzGfu7HLKm9sCBP5pjjOra4B+3KBBObOVPTmN4eQauNE7TijBoAjXikpp/4YJ4SczIyRYoAKD2Qj/5a0UyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806045; c=relaxed/simple;
	bh=969dFVILLSzzi4FuhmedymopheD77PplXgAmpDKtUCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSij2Llkr/yMhFHSBmcvkMbORt9i+XZaSTmpk74IGusZeDcY3PuQvi5zw/w8/sIh4FpgGLRqERMXKrMluIxuua4CA61OUhYTOYjEm4x+h1GB957+6P/rLGb27f9K5fq81vL6fOpe2SC48PpGgxN6Faac12+avay8rYW7eoBjj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/PPzJQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/PPzJQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D612B1F00A3A;
	Thu, 27 Aug 2026 04:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787806044;
	bh=pOd+90b9USehEDU4bwY7Fb7vcrEXuHQKQ/sB1AFUld0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/PPzJQsfmyrsyjVac4ewq5iRdAGv2qQFAPjjfAufSR+a8eoYBC34VVd2FpDBPYcT
	 13DDON71xNmA/xRogKLJm7kSF8pULg47F26bIaX0AmJRwOd4B5HATwBejkj0AglykC
	 aQajSBBObgSaYCBdtExGCiNnsHrU8PmX6sIXamHmjtERMcPKHA2rURiqf80nCO7z5/
	 geOmFX8ol1QdRYlD5zHmb6TeWmWDeHUFEh4V3RF4ZntFzD3rn0ERTp6qN2bP+gDUe1
	 4FD403fN51nAlURPz3kzucpYogy3HZL//EWBEoHKS6kNM5YchfBWaPkRDJX8ot0MGa
	 MONTZi68vMglA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH 1/2] watchdog: msc313e: Fix NULL pointer dereference in PM callbacks
Date: Thu, 27 Aug 2026 04:46:59 +0000
Message-ID: <20260827044700.554333-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260827044700.554333-1-tzungbi@kernel.org>
References: <20260827044700.554333-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msc313e_wdt_probe() doesn't set the driver data for the platform device.
As a result, dev_get_drvdata() in msc313e_wdt_suspend() and
msc313e_wdt_resume() will return NULL, leading to a NULL pointer
dereference afterward.

Set the platform device driver data in msc313e_wdt_probe().

Fixes: e9800b799464 ("watchdog: Add Mstar MSC313e WDT driver")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/watchdog/msc313e_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
index d962589e2c55..f69d66971c41 100644
--- a/drivers/watchdog/msc313e_wdt.c
+++ b/drivers/watchdog/msc313e_wdt.c
@@ -124,6 +124,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
 
 	watchdog_set_drvdata(&priv->wdev, priv);
+	platform_set_drvdata(pdev, priv);
 
 	watchdog_init_timeout(&priv->wdev, timeout, dev);
 	watchdog_stop_on_reboot(&priv->wdev);
-- 
2.55.0.887.g758fc8c411-goog

