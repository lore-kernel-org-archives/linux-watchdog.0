Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E983A4F2F
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786911; cv=none; b=mgFTnepnisph3AlcdAeWpZPIra6MaJv+sMfkn6smqXrdeXtgu+wMu7S0h8i2qA/MQ0Tp2s+zyoDgjgtW+HVd9pBjQz9QBNbt9BWIXCXfYaUKP9QdoPMQKE5VOxZkRyfB4egnr6RRsrFiuHG9lfOyv7ZRuRIwrZGoloykN7+ZCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786911; c=relaxed/simple;
	bh=yKkOBIWDLVzZbrFG3yiQLyXNfyi/iupP2ISmcl3yvxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N0YaNaIlNkj9rXpwgLSW3TS9dfXlNOqYuuk0BIkIXYAjk8FgyLRa9YmqtVme2gC0GjqVFKGks8j1fH8Trq+upzrnSn+vAAV9A5yv5/mtKchTg/pdC8jOKIp9AT8OblVwyphTanH2T7JEfjo4m1DhMFr0QlD/CL5Rd5UXwKzuiE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIAeSBEy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIAeSBEy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cad4170e8eso4550525ad.3
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784786909; x=1785391709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUz1mWBpB/XSD0ZgFsInGJUX8h9hfweN14oEZfYpX44=;
        b=jIAeSBEyIv6zcH+gH+U6/tv0Dc1Hy4ZmiER8FjFdQR0OxPwF2HpGxiBKG1JYKS6o29
         J+EYFg+o24vlZdt40WFCfGrW2bc8btnREe1B66GqlH0dz/iGdwS73CUTbQvMib2C9Vo3
         uo3um9rfvtjh7pBZhu4HoAvLW7KBB2+JOrM23n98BPudzbNsOCxVdUnvSjGetbZI1kBi
         bPWtMu5KNCU6gILo4brGqfIxqkUkOLTcXyv9pQrVt6BEH7gqz0NSgqxQ6xTTiYkr4Bgn
         LMy2p/XIryx2Cs7aWmmvGxZUoK13vzScNtxqF2AX4GWDfYUTVEWnQZZ0WavOQsGFll/n
         i5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784786909; x=1785391709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUz1mWBpB/XSD0ZgFsInGJUX8h9hfweN14oEZfYpX44=;
        b=RNEeBCVv3znEUk/d+OCOIU6ICfTy+N2U43ZRic22FKLVmbbJeUBr3LVYjADEeAS5Z6
         uue8KWnM1oaXmr9O1VWSrvdcnPkKUCJVUtCJI0A9P5hEdjD28h7Y1am0D5TX/yjWIrxH
         MZMLZnPqERkUR79pf2vWACDiBQS/7UuMNyfSrjcyjEMd30axxKtZwhfrNY7h0KemHBIz
         gkt7b0DBg2a1HeJOFdIZ0XqoBN/3I8957qZn8b4nw1/KvuwL0iG5KFKveGGDDRqhIxFD
         xKyId1jnVEmp0y4UgDmqHASEbN/SsVDPgtGYcFQKmXU3XC821Cby0UCJdLctILaog0bU
         lREA==
X-Forwarded-Encrypted: i=1; AHgh+Rrgwy/8GXa+GqIPcKB57Ro13Vgsv7RJBR8iR9yi2GnkfLHaQBrUU8hpBOv1O7RFpvahEU692Iio/iwY7yElXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDAXqf+IncrUF3jAMSHDpLODiENoqoA7Vq3b2tQRs4G0w7HkpY
	j/lNq19OYr2P1NkOaJ7iMtGDJhc0D+rtq8gxDlz3T4vffrfo9+mwVuGD
X-Gm-Gg: AR+sD12xcEh1+H5Ut7hN094WUaS3s9X5mxYEmtEmPeIpYNzWVdp0831h8pV36DSYBjh
	9t35RpECN0jtjB8IG20pRFY92UoSuH9Mf+3HZJiOZEh7blxF/rVUaN7CZ5oDmafMJWgpzj5x6xH
	4emZXK/2XY//F3uXQ05h7DPnjXX94oXLshR+Xui2IC3VBwWM41gRWqrqPaVhP4sI83pQ9AoCITY
	lm8syMA7GTS00j8aU7UkFsT0LswMngF4PG8Q60EyM/0cL+reDkv+Nt4OPT612W2xgWUjQ3YVYG/
	sjDO4aZiGVLK/9O8VQlDrESSE9BbtKyRx40GCvGpWd16Et7ZkOZFye6GYty4dxhTIdG7U5geIdN
	PTnBtf7DoQ/d/IByPpVQizhHh6/oXP7D1ZSS/2KDjn3PqVbZFrBXpaUNg2ksexlSJtmWGaBptOM
	nWqMBDylenpq9LMzO+LP9CvphL94rc3Uo4GIbc6LXJNYOU017wRlmKif4Ihv9I
X-Received: by 2002:a17:903:2444:b0:2ca:1eef:5096 with SMTP id d9443c01a7336-2cfa6c7206emr21250435ad.36.1784786909424;
        Wed, 22 Jul 2026 23:08:29 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f390dd2sm26071285ad.79.2026.07.22.23.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:08:29 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH 3/3] arm64: dts: nuvoton: Add WDT node for MA35D1 SoC
Date: Thu, 23 Jul 2026 14:07:54 +0800
Message-Id: <20260723060755.1596858-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723060755.1596858-1-zychennvt@gmail.com>
References: <20260723060755.1596858-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Watchdog Timer (WDT) device node to ma35d1.dtsi.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 7228ad4735b5..14fd17cfdc5a 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -82,6 +82,13 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		wdt1: watchdog@40440000 {
+			compatible = "nuvoton,ma35d1-wdt";
+			reg = <0x0 0x40440000 0x0 0x100>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk WDT1_GATE>;
+		};
+
 		sys: system-management@40460000 {
 			compatible = "nuvoton,ma35d1-reset", "syscon";
 			reg = <0x0 0x40460000 0x0 0x200>;
-- 
2.34.1

