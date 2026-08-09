Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863183D6476
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291633; cv=none; b=kb31l13aqa2Oz65GdT9oWdLyn4booR3L8zx01zxY8Yjn+ABd/J9ylyFcnKrduSd5mAuBcqP+YpClBxFFVB+Yc9wEqDgVKTZlHm6u4Qapa2+Hae7zmvgnt28yxF36iWDUbWCBMT0r/dG8YOvixduYS4dwGStpwDG1yPqej0F99EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291633; c=relaxed/simple;
	bh=jqcS/mUsknNkMF1lIxEjbIN2X/u7aP/HfgQXq54HGaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4gS4dLHU0vKEkLBo9mg3aSJahgcWmjy/M7YIIId7RGDPul6pWmBAUNj8WzjIvYgjt/KHy98vqgJn5xgO0Quf/rloGw/1AiO7a/gVmHrBEywrtsfrOFL5FNX3BNWlI2zGjeRLOP/MhYp86Kl54uerJJgqG0U8lARgDPhrqj++rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjnoN5+P; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjnoN5+P"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so13205765e9.2
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786291630; x=1786896430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2aw9hTPmVRYTxrK4RYL+auuCIDdNPlQ7RBPHnUIWSno=;
        b=JjnoN5+PvDDfZEd/pSvgNoBP0E3bak51lrcS67Jpf6iNaGQhmwO+9TWWSDgEedC3Tl
         kswnb9xWv/1+p8WcWOM16C4B4viS5VN1pyx6ZGCfRMIFtEn1XdBTwvkiv48dZLWGCvTx
         TryvStswAne0symLDCekLf3zJjzeyThcC0haciF7C7ilXfNbotkdByhtFK5p75DHPrw9
         2ohX4jOUXjHoBNV6D5kp2F0zlwy6GXsVfoPQ08/OPP2D3r/KGajoxBKc7l5FbvFnIAaO
         6FT+dD6Xy20PXf2/8gKVouJu+nXUDye3GC2bTe2fH7D5UwL7m+wJudz2ZFwnsP/PiOmr
         nmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786291630; x=1786896430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2aw9hTPmVRYTxrK4RYL+auuCIDdNPlQ7RBPHnUIWSno=;
        b=DHa7Ar/fF3Gpr28TnDFmki0VuM9WWZPSwPY2Jv9wdjCZmd1RKyxT3cGfGu9lD4A26e
         /sEVXlntuZgfBB/OW6kkkP7ZJquBhzI5IHrdRvZncoQs5/Z6VMSgBIkuzXEt9n+Z3rsy
         OZlQJrJHSMjGYahimkW3blvafVY1Vrb3fLSLHTgU7WJXV/7rBX/ySK3yzjEpp1cSqj+3
         8V+conw25vrwQxFmLnj0uTNpCnG1/RpgFw39bnY6Aodyj65b/F+K0U4S6yJT2tfAaJGu
         RsUgCMQLC/C2+5gZh5oIfy+thXP052sMHwel9EKv+hzNHcMiTdUWrmf5BrgoC/F/rCCW
         cByQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIBupYFjkGxm8bC58zkkUk9QOrY3Xlfac4oNixAE4WwYq+tHeFelme0CsPu0QWU8FZi9+aDaYe9aQDiUc7ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxsBCC6Symc4BwwhijeZMrartGxorCygNVtB4aQ1TjiT7uRxen
	bJRQ1uaAnM/ca0PMKusWcEnwQZ8/iU4SYA1if8E+TcOAsd8Vj0u4dKBn
X-Gm-Gg: AR+sD12rgV1CVCUx8Z+0oWzXq8i81FV9+4jbOb98inisogsXr2eWQefvw4qhRB3FFSs
	+pc9IeREbUgoiKFwtNefQk1MLRpTcusImrau7IIcedh/XxRzDae1m3+yNmZqH2jXoKgsHiDrsmD
	LS8P/o/bfGDnAmrqv05wkyFfOPXWl3YdTGxzqJkuyyeMdsPJq2+gloz/opWzJjA/NGwpLepPps0
	X+ceQCagSsgOmcjD9Tx7hE0e9s1W68P5CCmoW1p1LnYQhABq+RczUjln3bBrNElM8pL0tS1YV/m
	LHsCCMIwfT4WWnlK5Y+LkWJ5xWzmvymyhIDnQL86MbtA7ICB53XGocAKjvNlhjWgVQeVYCNc41U
	f/S2Cc/t1M7BcHAYthynwrZ2/dCCifg3A35rN1aDgCC8h+wXtVsHVsketUz2JcRynRMIiuV7zOS
	9YhWCfTDPXIZZv98p2g/d0jI+QYX8zIGABIE8mO7AVzba/wcqUrUUi5w==
X-Received: by 2002:a05:600c:3545:b0:499:52dd:c1f0 with SMTP id 5b1f17b1804b1-49952ddd05amr374922395e9.1.1786291629734;
        Sun, 09 Aug 2026 09:07:09 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm209832495e9.4.2026.08.09.09.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 09:07:09 -0700 (PDT)
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
Subject: [PATCH v3 3/8] arm: dts: mediatek: mt6589: Enable toprgu reset controller
Date: Sun,  9 Aug 2026 18:03:27 +0200
Message-ID: <20260809160643.33991-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809160643.33991-1-l.scorcia@gmail.com>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
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
index 46dea445742b..181d1b1ed9b3 100644
--- a/arch/arm/boot/dts/mediatek/mt6589.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6589.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/mediatek,mt6589-resets.h>
 
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

