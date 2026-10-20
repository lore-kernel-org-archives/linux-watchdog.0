Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792517409;
	b=fNvBdTy5IZStnLn7Plws+VaLaUanspqWiwm0NfBf4l2aqT5rwSRiweTz8dQFgOVSkD4Y
	 kMzW4SRgLBh76QmV5nc7fgiwVg5nGfpKc+U+GQX7dt7NoCr8fzfa5tPUUTRTZyEsmFsG6
	 /37GR2czKnD8tiLZBqu77p8Mh0nXBuEzVFkuu9487aUXN3sv+wSFYV0FYyV/lkShZSUwE
	 8NlCQZwmApOpPhIPP79opUtoaY1elHKv2RCEvdejpdS9XFAuaq8NzYott4qpOgn2uXOIk
	 sv5DixHOE243oV6b+EVT8QrVdvK5hY76cYo15BKivO63x4V4Bi5zAtxI5/AfjOLUYBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517409;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rqO/CKqWZdrB+rJyWI0tCLcDKt2oC8zbgVmrKbIOvd4=;
	b=kCP20awq1Hn0rnHJhJ9nE7GbqW446GHOox6bt8uwaLZ6zRhQWqZ4zBgpTM8jI4ts8IBL
	 hoaz2KvQrcTWaFNE3PgS+WNJTjbxupSgkwe7kFGf3ZKHsmxTGdv04RXz5RcoJgM3AHncg
	 ndUaqZ2Oi6LU+Tutbv8sX1VEq9Zek8jUFwAyDNLcwdyg/5KUdKUby/88JUkkKmFTW9f0U
	 MXZLvMRFTTybR1D1Jwt2u+2JRJAXHjIPS2kHe95uFDM4j+NTqBDvLy7X5R6jq8FJ8V6KK
	 so4LW5U6jei9/QS3192qc3mUsYQ1JVl3aQ2YqUDCQfZ5ing5TCg6juFYLZlxbQ/RgtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOrluGdR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C513606A31E;
	Tue, 20 Oct 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOrluGdR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792517408;
	b=oD5s2Dvb+icY3Zgha9l7m5o2iUonODX8UgGmzHx1iglBp0OhdJfG9PDqv66FbyL2g7Mr
	 WGkb1meOOYSQ9gyvrIEjMyglhtPGt4WiC+2uKCq3oCzeMkuOBDcqNI0J6TMJp/N7e7f8t
	 cOueVzOQzCUuL7mHwTHsr/P2q7DmUF3/lTHQqAbpFLhbB5fbnEe/MY7m8k7z6TJm8K7AM
	 r5yOkqM1uFn6t3Wj4TNMQXnzTWffgwtAifSINx+kjcVkWOVPuwhDjqO2F4nB9AxXlZ+P5
	 dExBvHpSkqtstewqZyLbfTk05OiZ52kEtjYyYhQMNFDw7tVo9A51nAla9lXrlUxs9TQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517408;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=rqO/CKqWZdrB+rJyWI0tCLcDKt2oC8zbgVmrKbIOvd4=;
	b=uIdYUBNni3nGm72thlnmwhL5fE3+q03yTG8YQHZebf0Bbaorv3zOefePghn/3e21ddSR
	 ABFFw+QOIjm0ZSgpvoQxE+dAXZJS9NRV62uOyUhN00447eOTeSEGA5064XpvhgpHwq9kM
	 /46jsFC7Am+N4Mq4iS9eOatnB2rQUmAMN0mOrCqKexyMFDba0QWVzhlgKarZ90+7aK15O
	 OyIcvxgUlCa1w2SUwEmXlvqQ/cr7CZewsrhVwK063jjdHwm7dzWvViHxaZyznvZSXTa6/
	 ee/6h3mN3eJGQi2bKLuWdl9dkjZRjqWaPiXipzYHyFm0SdFWk0lTtxtSZ6A2A9dVaSA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 350631F000C9;
	Tue, 20 Oct 2026 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792517408;
	bh=rqO/CKqWZdrB+rJyWI0tCLcDKt2oC8zbgVmrKbIOvd4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=EOrluGdR/v719VpZIfUV74WpULIASUIPdoXL/tHyymzHUgei6uJ2jEEUSrYgyicpP
	 dFjK2qAS0dEKXKEK2f3fa6o3dBygcZ16Mz2gghMBxgUKFU5K54IZEer0il37psDMqi
	 26Q8yHC/PO6oyDblOCTNVnTXex3ONmBU/4XpLY3Q24uC/7EeUfqhKAs2k14ZzZM6Ys
	 DJtlKsezM+zvfKwph6kxY1l/eXWAwrvl7VOPi8+U9AINEie1wz7VvrbVyU705GRVKA
	 VTCWuHhBHUrGMXdWOxDDZRsInybbdw21oVW9yB4qodHx2OCp5oF6cCgnJu3xeySC7a
	 Yml4KSVWqBAjg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A1E3943181;
	Tue, 20 Oct 2026 17:30:07 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Tue, 20 Oct 2026 20:28:37 +0300
Subject: [PATCH] watchdog: meson_gxbb_wdt: fix suspend/resume handling of
 HW_RUNNING watchdog
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-meson-gxbb-wdt-suspend-v1-1-d5abe4340008@iav.lv>
X-B4-Tracking: v=1; b=H4sIAMSk12oC/x3MPQ6AIAxA4auYzjZBBlCvYhxQqnYQDfWHxHh3i
 eM3vPeAUGQSaIsHIl0svIWMqixgXFyYCdlng1baVEorXEm2gHMaBrz9gXLKTsGj89ZOjTXKuBp
 yvEeaOP3jrn/fD3NgT0FoAAAA
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Philippe Boos <pboos@baylibre.com>, linux-watchdog@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=sRv9WsAiYhuKwPOnpeKTfGsN/HKl13MoG+1oyJNF3pA=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnXl8oFK5/3KmUNFvRYWPXuus1sB4G68vNb+rIWO/n82
 33zHldARykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZhIjS4jw/40D7UdWeeS+W5E
 vV3I/WNR9qIzLkabjQPjXi7ZnPHtszMjw75lBx9c6Li346oIh0Gi+p2SOFUOyR4Db82VksfSHHN
 /8gAA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

meson_gxbb_wdt_suspend() and meson_gxbb_wdt_resume() only check
watchdog_active(). Since commit 6adbfbab0f03 ("watchdog: meson: keep
running if already active"), probe keeps a watchdog left running by the
bootloader and sets WDOG_HW_RUNNING. If userspace never opens the
device, WDOG_ACTIVE stays clear and the timer is not stopped for system
suspend.

On an ODROID-HC4 (S905X3) whose U-Boot starts the watchdog, with no
userspace owner, the board does not wake from deep suspend
(rtcwake -m mem -s 60) in 2 of 2 attempts and needs a power cycle.

Stop the timer on suspend and restart it on resume also when it is only
running in hardware, as sp805_wdt does. With this change the board
wakes from deep suspend in 4 of 4 attempts, and the kernel pings the
watchdog again after resume.

Fixes: 6adbfbab0f03 ("watchdog: meson: keep running if already active")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
The same change as commit 1c81d4a5cda2 ("watchdog: sp805_wdt: fix
suspend/resume handling of HW_RUNNING watchdog") in watchdog-next.
---
 drivers/watchdog/meson_gxbb_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index fb276060e831..fa6953d106ac 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -124,7 +124,8 @@ static int __maybe_unused meson_gxbb_wdt_resume(struct device *dev)
 {
 	struct meson_gxbb_wdt *data = dev_get_drvdata(dev);
 
-	if (watchdog_active(&data->wdt_dev))
+	if (watchdog_active(&data->wdt_dev) ||
+	    watchdog_hw_running(&data->wdt_dev))
 		meson_gxbb_wdt_start(&data->wdt_dev);
 
 	return 0;
@@ -134,7 +135,8 @@ static int __maybe_unused meson_gxbb_wdt_suspend(struct device *dev)
 {
 	struct meson_gxbb_wdt *data = dev_get_drvdata(dev);
 
-	if (watchdog_active(&data->wdt_dev))
+	if (watchdog_active(&data->wdt_dev) ||
+	    watchdog_hw_running(&data->wdt_dev))
 		meson_gxbb_wdt_stop(&data->wdt_dev);
 
 	return 0;

---
base-commit: 6276c8195e598361942082423114877265c17692
change-id: 20261020-meson-gxbb-wdt-suspend-ad77f97606a8

Best regards,
-- 
Igor Velkov <iav@iav.lv>


