Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F494347BBD
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Feb 2026 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836794; cv=none; b=QT2NvyslM1kKEDy8uAzTDpCv8Tpszh2xcI8086aLvkLj67X66DiS6MX2pPEYJre8ZcTJwt2asMXBPcqlXmulVz9Za5iZ+HRPyo0kD7HRkLRyY26+JlDlj1Vga0P8z/g7tCt/Lr26T61KfmygKw/SSrLlD+4Yc3z9je0zmmg7l2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836794; c=relaxed/simple;
	bh=t9e5Q0EmJeb3lcaKTiFAO7Gmn2UWzlxx3/mNI4p+z8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZjd3B8oUigTUT5GbaTvKbuIJXf6Rfsz+DTCq09YUq/QCuJUEP77Ef7I5fg3TKFtdJ0ykHP4JDyLTC3E0H7DOOw+mOTS3TGHD5RP36Ul2Js/Nd6wYEMpwkr48p+WghPnsxRZuFpgy3WQV8kgFycvo2IZWkGyYtHfcjSCaVQ7d8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3ECsavL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ECsavL"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3734085f8f.2
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Feb 2026 11:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770836791; x=1771441591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMI81tlEGd5ZFeGN2V0v4Psax4OyjBHj6wkzJgwxN1c=;
        b=N3ECsavLXQ6Wh4lbAdwKVZvl/8pTOCtuD7uj1eN3axhEUgRafRESr1lB4ss9BxzUGR
         85dA0lIpMAHUelkNSgnxOgkhu9ovVmzIaS/QTlOJgpOEQp688AkWuHwctnJL2IQE/rjt
         gKi5d22Yon9zCQIxhhrgP2Sw2K0vdTrpu90kOBB4OB68pAazfU3PxaAnAYa93XY7YMpr
         lnovnZ2ruB8Bz5HwwI6Bf2pt1+BGcNrIF4E+9KjopHAxnnEFt2Gv/ENLEC6cDp0eNNe7
         t7CgyhZYqFM/1QUEyD7WTsSHQ1QYg2Ss6RlrtNsKQ5/HRJUEUAxmXqzdBULO24NUZt3M
         Biqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770836791; x=1771441591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMI81tlEGd5ZFeGN2V0v4Psax4OyjBHj6wkzJgwxN1c=;
        b=BJ7thlCKt5YvhG+TU3tfDMtQeeZ080xbaKuMf04wmMgkkmuUBll+tXm40UqZXjgjOt
         Owmrg3l86xDfS+HjDBAU8CwIUKILzVaMJtFY7E09U0Z3AzH+Ur5yncmPNixIg2yGVGMZ
         Ui5Jinef+d6R/RY7/HTHCP0ml51qyOUjXkxVjOQd34yZvcowekPCrZ27zIS9PCXzXMGS
         NR0lV6RzVCV/LhIZQE77nQRvqZtp5tBdNKGHrtqCJ+7oH7Y3ORi+sLHXeAeqFs68+sfO
         oZ9vxPHuI8RtTHQ9CYqyId22DJIpBo2cBb8qa4EQN5EZ9jzePWuc17baUgaKOiJc2gAu
         2XQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmS4COqN93Eb5ODGK0L2OKbfW8iWhd1+ZcGbL1nILS3hFO/I5zP2LRYrZAYE3CAJiC/zo7OsdykOt9kPtnyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VmFtZEuf0eVjP0ZhSH8AnvHqXF0rRLaMz6qF1NHJ8pABNNce
	VcZBfCjwddXAXoSuXibHypsiaWTNCiJJybZ/mOnT8CbdxSJRlCUgmfRx
X-Gm-Gg: AZuq6aL3EUvS2GQGKqVhXtOw5CQnrHZuYUbi2QkzHbcWf2HJjxbxX7jXCjDMCqrF7Ar
	J6HGKmCDHYDz8+5eeUWYpT9tiuV8cleoEmJtCv4oMUoEHFtF/OxEN/GtZVJ/xgNTPpvIU/mEt94
	cVHwnpCYt7PStaZ8T/8WPMilQ7v9/LCWVQYs9OpYG8Do8GHLV/LJv2sPWUkGAoaYv8XATslDGPy
	ToXPkqkrsJCzqnIvCRd0zAa31sRv8+7sa1YKoFJXQepoVPw7h+gGT7tG1fe7D2bWC2CZyxgubEO
	RBV6bIseEBORvS1FgFbD8YkgBGNt5y+tVxH0RtoVd+Fw+SDAopbCjNG+CYvs9eAFn0VOMJEaugH
	Tt1Mnv8YxKJuQj3IL09oq7JROsqd5LjbvOfrVvT2GtXJIQSYvxoxn4kcWITJpN+bo8MDsQUOlW+
	zn+F03FXNT3FGLYqPBboE=
X-Received: by 2002:a05:6000:2209:b0:436:3707:2be6 with SMTP id ffacd0b85a97d-4378ad60397mr789319f8f.53.1770836791489;
        Wed, 11 Feb 2026 11:06:31 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4378e122df9sm211223f8f.15.2026.02.11.11.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:06:31 -0800 (PST)
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
Subject: [PATCH 5/7] arm64: dts: mt8167: Add a specific watchdog dts node
Date: Wed, 11 Feb 2026 19:03:26 +0000
Message-ID: <228e74cc870ac01b223875e2a0dd7effa4137213.1770836190.git.l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770836189.git.l.scorcia@gmail.com>
References: <cover.1770836189.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog driver for mt8167 relies on DT data, so the fallback
compatible mt8516 won't work, need to update watchdog device node
to sync with watchdog dt-binding document.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index fd17daa13dba..caf51f203dd3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -48,6 +48,13 @@ apmixedsys: apmixedsys@10018000 {
 			#clock-cells = <1>;
 		};
 
+		watchdog@10007000 {
+			compatible = "mediatek,mt8167-wdt";
+			reg = <0 0x10007000 0 0x1000>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
+			#reset-cells = <1>;
+		};
+
 		scpsys: syscon@10006000 {
 			compatible = "mediatek,mt8167-scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-- 
2.43.0

