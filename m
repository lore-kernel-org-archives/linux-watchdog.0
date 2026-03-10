Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEFD3A8F7
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Mar 2026 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101589; cv=none; b=GQkbNSm2VSYzh4b1vRXkoVKvDjJvzYYbtVd8B7TbF3mcgOO/v06LouMrAtO7R4oGHsv0KUbzUTOd5+VFDZ+ZM2WKOQcD897u42qveDScU+zjRR89+Cvvx90fIY3pCfPEnRu4+ybE7Zou5CEkjxm0RPUjSkMhQAFhtplnnPSx1iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101589; c=relaxed/simple;
	bh=wsZSzrQsTg6gNw22k7eI/az6oMhAofnBMfuav3Dqimg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L2TjK+fPGXNsWoQEk/j9z2UW5Tg15QA1OMTRWwmGKpHsphk5FRbz16tQIYYY/eqFmVS34OA0HXAeAW78ce+M46PHGGkyXEDywpjri+jpZHj/GVfkLh/vGQGfhbe2ASKBwlNKqWo7loEgJHaRjlEeOFNgJMwvHjtSwX/s8jS65uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mle2u4Ix; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mle2u4Ix"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-128d2e3082eso721941c88.0
        for <linux-watchdog@vger.kernel.org>; Mon, 09 Mar 2026 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773101588; x=1773706388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5Vy8clHNk9eodJvWfCEzeyoFnVAVF8SVtk0IY4w/+U=;
        b=Mle2u4IxLq/Ax6wuNPEj/bLCMaVuyakZVCXA1p4Yjthp+nPM8S0E9sVkOrQN00OAMS
         B3y7zWpV2vF1HJkYxNeCvG0fxmyEI6pYlHiBjjvEz0HrqynCf3WgcMhy84VNxnKKhG1A
         4ozgw2kpge7tnP4n78iHIQuVw0rdUKV7xcZFs0OZuj6/fGt6ryDJoes5sosgta6SIMRM
         O+RKX2bbr+QPngLo5zAn11fncXJT7jG5MEtdKvvKGVZMgY74Uoe+hNmK3Z9herOz9OP2
         LR9sBFfUQwpA5zvchxIR+KVBzmUvr59vyk7N/OTTSw6BDgNw3F+Uy1fBIoLrnqFFexlY
         502w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101588; x=1773706388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5Vy8clHNk9eodJvWfCEzeyoFnVAVF8SVtk0IY4w/+U=;
        b=pKStuDgDv9pcVuEXENGYwSF1QMP+zNi4Tc9uXgcEEAxUfDUGabakxKRHdAWAo0j4zj
         AD7OKiyZMgcnRoN4/sJo1iJaAHtXqakKzTaEP9l0blpr3S3SA55l/3U+15bNV+hnlSBC
         P9kVgJHhsrPncAtuts+WzRnqY/0/ejNRuym7QxqUR/W3NNwhO8Iz0VBNZ1W+wOfbONXH
         pf5vODUywLVI6kngCEIKBjJW5xxeG1lroY34RqYb/cfMuJyXd4OOS450cUkR1I4Jwwhx
         MuYDaYqjAHRviagN11ukiqRDRzwHIUPCte34bIC6+fllFyXXB3DsZnyRn0CskarAY+ir
         u/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFjavQVo8pYthZ8M1pS43ACHCGqTAibZCzAUuF+DLJwSBonOeAzGgAdRu4qEcVdrvoHpP6MoM7APdAN5GEfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kU6v5tlGhVJBqI8dnxHtGkCpr/TkLIE22cDk+Qdjeemxi8SD
	GS6l2jbh/ZIMLT3ZF3GPuPH0cVEu5GR0+TWXSLFRkP/YQngNw3RAhs75BHEdoQ==
X-Gm-Gg: ATEYQzwaEKZAYSe3TMueOHbrvYCIR4/R8p8sTKnynktzUTAsNTBI7/cbtwc0sH/WTMj
	obZFq3EvWNp4IDmx4zkRmAUpHxLwthc1crZIjUbt2MY4vqunwqxTKLlIcMy9tuPR4x2HFXkkdT9
	h301dZsRZHj4vBNGY/9AA7xaUY4iHRgqIl/uwm96x1LB03QHFRFB/Tg8NrIoVfysaApNoR7JG4F
	GAhrsJlIzpVSj1cVwv+wmm6I5jCGlsqCY3dYv88A7w9pjt1Uup0Ch7S/XZdttb58uCmLW9yf6uP
	nOuuZ0JTA/KgYXBAXh6DU0szabicKevKvkOp9Axr7GVlrJkv8FRITZ01VpGLeqPQt4bGSV9SJdf
	/MFBfgB9PCHdHDW0YjehRwGL8mmE8AufEvSQv+3vFjnAc223GxdzZ/On4iZ0TJdj2/eSHsapFDX
	sWlHH672CJrxMouqol4KAuA9kznJTgAANm29Qorb/AolKJG1b8Slkfpf5E/+iAjLv884jfM0HdC
	FBAcns=
X-Received: by 2002:a05:7301:678b:b0:2b7:32a6:82d1 with SMTP id 5a478bee46e88-2be4deaee22mr5771338eec.13.1773101587651;
        Mon, 09 Mar 2026 17:13:07 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a802:e566:5060:45a8:d0c9:5e8d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm12668054eec.17.2026.03.09.17.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:13:07 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH] dt-bindings: watchdog: rockchip: Add RV1103B compatible
Date: Mon,  9 Mar 2026 21:12:59 -0300
Message-Id: <20260310001259.416264-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The RV1103B watchdog is compatible with the existing DesignWare Watchdog
binding. Add the rockchip,rv1103b-wdt compatible string.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
index 609e98cdaaff..141c72909b15 100644
--- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
@@ -33,6 +33,7 @@ properties:
               - rockchip,rk3568-wdt
               - rockchip,rk3576-wdt
               - rockchip,rk3588-wdt
+              - rockchip,rv1103b-wdt
               - rockchip,rv1108-wdt
               - rockchip,rv1126-wdt
           - const: snps,dw-wdt
-- 
2.34.1

