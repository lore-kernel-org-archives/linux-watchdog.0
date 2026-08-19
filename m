Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2344E040
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134759; cv=none; b=EqIf6ul40+LzYdj14HMLmyh+6S4LJ39RuTzN8pZtqDTWuYvGB5mDQ/A2V1J9PeZ9OtI5JZx6pJoqeizxYCeC6x5Qo1NxkCtT5ibFk5u/rav84uVnyvpjeAIZ0VNqB26Q0mGI01MhqZxjkJT6o2T0uBpUw3ZpB5MhH8VUkJeM3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134759; c=relaxed/simple;
	bh=0T5iL5WauiwX8hnXQYZB6/K7og5dPQJJwQvR8NpG2Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMgqnpXKkNYlRfBPUSsNzAOryg43quMwSqkXlhAATfAEcAF7sx/9nsEGHY7Bs2bxYVWj6W1SLucDkQE3UnQ/5LKfVuZcGl8mQfzgaOmDwjuhQJquIJ8HB0iRc10KaUlKXXSZjI+qN6giWnpSsS/KGQFyO41nBOHs2WYJPPWWn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoVM4+J4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoVM4+J4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so10056625e9.2
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134755; x=1787739555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4MVVnQZpsnH8AWbTGeS0HwvQAF/scb90pwaSD2kjboo=;
        b=MoVM4+J4umN2VeL6FQOKUiST5WOfCG0GCSBBoutv1C5oV6Wt4VhvKxly3ckuhFd4AR
         EpUc5JSXBO/6zXcR6xax83kWRSFmzFZ9A9Fmr5eOCNAOitoFEvzZ0ZP87Ck6pnNu3FeV
         y3F27iWf5PDjPq32GtNRL1VAjr5iXUGN/gAFupA9KqT3MLufoyXqGCMUqGUf9ryqyzjP
         +8Drlnonf08nhMIj8oQolzGx3k77fVJYChhDSHav/DDx83GPxazBf/6DPoqfmwXwrX6l
         PlItOUiGvoE7n1VYl++jTN/YceZs9IdauNeRGblmv9cnk3qYmsZS5UoQhzWjmatP3bDA
         qRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134755; x=1787739555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4MVVnQZpsnH8AWbTGeS0HwvQAF/scb90pwaSD2kjboo=;
        b=cn/dngf8GF2nwW5uJTLuaGewsOiqUWD/db6CmP9Dap1l6sQl3NgDjBljjtnKlpUf4r
         Wudvm2Tpuuj/4BdFagGvZcy5YiP0nHVq+WfdZQD2Ld81WzV06xW3CGoNCKRo0sFkMbLB
         ENZEXmooW5tKK9hdplQI9tFeV7r05qSAOOjwdtpAJInE58kuW2KAZ5aMQ04i334EeHyL
         tToeD2yLfj02FtcjS6uLFTa/30cDcfgALOORQy3a8SI1YYY+xPBDBtZu/RRH3UTmK9Yb
         kmaL61Sy1oJ+EMd0PHFU54ZT/pHrEF+0CEYWFWW4VoGeFXvtQTv9YxkojdDc9O/YJjbM
         4TNg==
X-Forwarded-Encrypted: i=1; AHgh+RraYhhoe8DvHmGCDF2uRYNtSxtZM/86npKSYSUhLSQDwiv8ytJplhhqaarsccy32MT24rPNO+b6/D/Wu7OXpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxtMvkaQXv1AFnRXJ/Ufl+BqjAyVl4fISh0Tdt683cd/lXtre
	6XUthXRTBjCMpl/REVYcXgabHxBxJ2+JlLpAPKOo/QnGsJVef4G8FmHr
X-Gm-Gg: AR+sD136B4rIBpUi5x1KY77u3gQqxbgXYYxi0JuAS2VpS4DzaUpQkZkw1BF40MmflbD
	doGP/R22CgSX6eZUYlL0/5HhfkxjKQT0xSR80EwZx+sebReKmbOk9cg4C0FqVRsbyL7ZLFJwBAy
	4gKWnmI2RxAe3fHeuodkJXC6G43RG0GpCBYoSYFBpQD/8M3/o3iE3gapBpektFXIeWMdtcwELDY
	RymSdWcsM2QeJu/kXAm2LGI+jCbbTDuudv/UPX3yGaqrilQPT0i+DY5jV90RsvhT+Hzz1p2c0q9
	whYjzBTNVtNj5eC75hUi/hsfKXOiOzLSi5JieoLBG4D1k4C6hIXPRWrXoKZti+IyPBpbXeL0spo
	IEzLQFi1N2wedUhj3mUkjitMpG8xR22v1Kg7j9f702DmtbXSIzDSRtkxvWVLtTJBvJg4LESsGBD
	wCTm35TJ/z9DeZ53i8VYLa7nPPvR69qpk+N/TFHuHBKhurmsRDq7Z1oQ==
X-Received: by 2002:a05:600c:4e15:b0:499:8a3a:fd3a with SMTP id 5b1f17b1804b1-499aa19a7c8mr69046125e9.5.1787134755440;
        Wed, 19 Aug 2026 03:19:15 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9b7c987sm27316965e9.1.2026.08.19.03.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:19:14 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
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
Subject: [PATCH v4 3/7] arm: dts: mediatek: mt6589: Enable toprgu reset controller
Date: Wed, 19 Aug 2026 12:16:24 +0200
Message-ID: <20260819101853.44681-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819101853.44681-1-l.scorcia@gmail.com>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the toprgu reset controller feature for the mt6589 SoC. This
allows generating reset signals for the 12 subsystems managed by its
top reset generation unit.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm/boot/dts/mediatek/mt6589.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6589.dtsi b/arch/arm/boot/dts/mediatek/mt6589.dtsi
index 46dea445742b..2ba912a356af 100644
--- a/arch/arm/boot/dts/mediatek/mt6589.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6589.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/mediatek,mt6589-wdt.h>
 
 / {
 	#address-cells = <1>;
@@ -147,6 +148,7 @@ uart3: serial@11009000 {
 		wdt: watchdog@10000000 {
 			compatible = "mediatek,mt6589-wdt";
 			reg = <0x10000000 0x44>;
+			#reset-cells = <1>;
 		};
 	};
 };
-- 
2.43.0

