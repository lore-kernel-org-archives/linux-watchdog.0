Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE537E5F5;
	Fri, 28 Aug 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933646; cv=none; b=CxBcIGvscAQFt6J++vxaKm+sthWjfhcHm+6vmYxuYM1uBg1u5b2vvZbdzBvuuXdKcoKAw90AUK21PuQ5tadTwg4ExfyE5DJoAE6rWl/4VrQA+kBWGiavilnh7cee7iMK5bJnrllGBzjzEV9X+yVwg6PX+zxJuO+D+I0Jew4qPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933646; c=relaxed/simple;
	bh=58gMZiQdo9xgQTc+9CgMaP90LgU1OrYjGTf28AJgEG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P51hnWqZIkmmVNYG8dX4cjzdxEYBHZ0E1AuMg5sL3sbYcYBqs+MztUxNIUFVwMQzZsAbagNJ5WQtkqbUZ7cb6bH2STJqDiAoSlMFYFtRH7qZ05SDzQVE1G+jIr5Fsg71rdOiKidljkaAYaO4dfh/c5gpHNGpeHirht7majGZGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJszZP+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJszZP+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613211F00A3D;
	Fri, 28 Aug 2026 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933645;
	bh=A+7kA2H8Mxmbnq2nhnANIpMB0DXOUGYwR1/+QLmtRcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DJszZP+5ghB40KPyQss0sib17WWFlB931rPFEmN7ZbJcLID1kXq/p8IXCdy7sudjl
	 X34mlP4JdqoBniLgfBu3XtBjtK0FBui7sf57yccMjbNIUiLhpn2yyQLebxHRfb6cOS
	 73G44TFD0R6cmeTBdyQNAqRkvYQPlM7tXb/I+lNObXx9Zjli4YwBbaZ6AkGIduGq72
	 wxFVO33pDdgC72OMP1O8Kp866UwqvK8wT0/rVrBlph1PfXQj63/i/KhCaUFypJ0KN1
	 GPFaX/jgWGR+H8uUToqzn04/TmO6ypXISf5HNkvHUEppkW2DxRwNpaE/93YIYwGFAh
	 BTydJfbpOARoQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 1/9] watchdog: msc313e: Fix NULL pointer dereference in PM callbacks
Date: Sat, 29 Aug 2026 00:13:40 +0800
Message-ID: <20260828161348.13212-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828161348.13212-1-tzungbi@kernel.org>
References: <20260828161348.13212-1-tzungbi@kernel.org>
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
v2:
- No changes.

v1: https://lore.kernel.org/all/20260827044700.554333-2-tzungbi@kernel.org
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
2.53.0

