Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A583F99E1
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306526; cv=none; b=IYVhwgcykUs44FVgc+pMTYy6jv98daGHq/0cAdcxta8cBOrrFbfnw1I6Rl9jGr8+0L/rk8zGg6PA/4SoayJTaHj55vVPRcxU6BLBhgxPOj7WtLaDMa0lg2J0G7RgXz3gpuKCZDy865KazNH2TV8Uksed5X1YyjiyIg5qCyr9fN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306526; c=relaxed/simple;
	bh=Wl8PbtVcbqcYg36RIsWzXPaNK7DI0KcYAEDi+vEV6Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fh4yqsYCil/OfZwkIE2corLMOl6mxzGthq/FC8cEt+bnEs8J1LLd+3iPJ7yBcgRX6iyVw7kfBZPJ/at91qqBvebdbIhbgzyq6pCULQ/JdyoM1Y9INm4PUoEw5qIrnGg4eSIvNV4cG40XMbjZ0w4mA+go4JdAOxtiLIQbJL6BwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF/e3jB5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF/e3jB5"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15b1da6b82so514442466b.1
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306523; x=1784911323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5y+pF9Ye8xkl7BWvjPqf+44InrvFLLZAoR3RziMb21c=;
        b=cF/e3jB5vAx6v8rl54GIsfcxehnoEZbyCRB+R5U730GTZOnxpUtsBNyERAeCvb4JnF
         Kw+OSm5HmZOU+PaTeFAMWpWh+UGHOgrBECKcpeFYF0MJgNMLnovbjMuCfvdMFGIaIfSp
         s4t7S+Bxc/15ww4OyagJSNm03OJCvRPf72Y8KDLwuxxJiDt9kmG3WtUTpwIgLYMveEWZ
         Lm3/72r/f1JiEpBA7ahuTD5cU2ngGGkXvrmaFxWCYs9R752/epfJnCKXcaszLaY51pe8
         C6TM5Ur3GHwN04RYZsJDK9PfbxEEej3tIQ2hmXrup8ks06gxEyUtw/O0+x4010ljMamk
         0C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306523; x=1784911323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5y+pF9Ye8xkl7BWvjPqf+44InrvFLLZAoR3RziMb21c=;
        b=fUk2SnEvCxbSAj8OW4eYhCMcza+J5/WM1WXJsWVXg07SlL9K/jEdMqj1mqz+aWI+Au
         y2Gbi9xfpzxAbEdfG/KdAmNomQRoGbs086QYfOVDiZDWkk6/Xpt8dn5bCqJg9By56L1d
         /O8lHv3pK/5HtSmU2fx8orRcrhH0kK+ZZvIFfw19XY3D6wuu8u+y6wGZVCs1lFsxH3pO
         eV7UqxMyckrz0TMgrpfjym1bvryde8//kMl7uJHM99xqO7T185gamwcDT7Dz7KHoYjhZ
         i8Q4pvLaLDviLh0G8Qp3sUtX5yqkPasjVeXVgwCjmOuE1IERmT/4jri+13M2LZG327r7
         cjsg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3UE/coJmO7Hp9NYmpYMUIWXxGAnQvr5PCETqowhZLEbUXkvIlCCTmFfsfZfisJFfXpnWERbY9WB3hLZb9JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/xmWwW9cbLQDby9AOp7VjOyCAwkMifvJvYLERNr671DQ625K
	CwJfOvK4UtryxL3FpQ6TxJu56wOwY7iTM6dGQZaO3tMCFqfe5uzaoHki0ZAw8PQW
X-Gm-Gg: AfdE7cmF6q1WQ1acqNc5qvrr9MuREnztPis/erO1oERpwN/CVrLloYEkqJ1DQz9F1ze
	EfUzh6vJysM0CICGnBj2MC4fXMY1gKsVNCz35xXhWHUGs+9hyBpUS3jdJYylm46WzpYWjtd1/ty
	uHqtOM+bOgee8DFyplJuO4oZlQHQPIqonCySdzcgNGDHUrznau6m5vuf0N03OnSqs6YbIWQyXsX
	EAWu/nfZGSeg7GGArkBW9wXxKoMA7868O8XaYqYrgi/lDLeiILfCg57HVrWuk89hJgWsqujozdV
	8jFVttzKOAswNdze1qhqdO0NnFzpCbQ3TEs4MZUYAlE7n+RwOsHm1RFENZLgcV+BUOVq+oQfD9r
	BRim6p6I+rrzNl39N9AcVXqZ2UImCXojtgcA2SMM7Dj5Z9l+k2bRXtrtEzu+vpaivMvm1HxiVRw
	==
X-Received: by 2002:a17:907:707:b0:c16:5dbd:820c with SMTP id a640c23a62f3a-c16b47807e7mr158904666b.33.1784306522585;
        Fri, 17 Jul 2026 09:42:02 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm105880366b.14.2026.07.17.09.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:42:02 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/7] watchdog: mediatek: Add support for mt8167 TOPRGU/WDT
Date: Fri, 17 Jul 2026 18:39:16 +0200
Message-ID: <20260717163959.714561-6-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717163959.714561-1-l.scorcia@gmail.com>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Top Reset Generation Unit/Watchdog Timer found on
mt8167.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index e61f6ae74327..10a3d4b5ee30 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -13,6 +13,7 @@
 #include <dt-bindings/reset/mediatek,mt6589-resets.h>
 #include <dt-bindings/reset/mediatek,mt6735-wdt.h>
 #include <dt-bindings/reset/mediatek,mt6795-resets.h>
+#include <dt-bindings/reset/mediatek,mt8167-resets.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 #include <dt-bindings/reset/mt8183-resets.h>
 #include <dt-bindings/reset/mt8186-resets.h>
@@ -110,6 +111,10 @@ static const struct mtk_wdt_data mt7988_data = {
 	.has_swsysrst_en = true,
 };
 
+static const struct mtk_wdt_data mt8167_data = {
+	.toprgu_sw_rst_num = MT8167_TOPRGU_SW_RST_NUM,
+};
+
 static const struct mtk_wdt_data mt8183_data = {
 	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
 };
@@ -503,6 +508,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
+	{ .compatible = "mediatek,mt8167-wdt", .data = &mt8167_data },
 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
 	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
 	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },
-- 
2.43.0

