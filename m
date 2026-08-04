Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8B42AF96
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827122; cv=none; b=b9sqvibBYZ2eV2RXbuM5khK+TZosZc4QJV6FSV7E1jfgSQIRZqB0Z+3m0axMW7UQDqrdcGKrNF16r8Akq7f2vyzdBKl+hbMbJg8Op/FMvpUgu0ZQJXD1GM8x/E8k4Q1UHO3jg8yVBHArVf6Sv58BFhaj8EXGFN0Zq12PwK9yrVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827122; c=relaxed/simple;
	bh=yKkOBIWDLVzZbrFG3yiQLyXNfyi/iupP2ISmcl3yvxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTfIyWFHSGyeyKRjv/cF8MusqpDc0IH7QcdKXN+kqj1FgBVCUIbKaaTftG0nnL2T5zkMxcQQybXPZZtnFxmmh+h/7nmu4g95vwSKqcFZuwJ0CQKQjeGl7JDsCUVd4Xgbbvnhu3lqVDjihUGHzvkZm96zKYWf2h2oy6Xf+Fu9fQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3j3+7q0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3j3+7q0"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e88b60121so3239326a91.3
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Aug 2026 00:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827120; x=1786431920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUz1mWBpB/XSD0ZgFsInGJUX8h9hfweN14oEZfYpX44=;
        b=j3j3+7q0fFi59wJIt2lJipImnOPmmhKt1LXwPGccfMMvwLiEvvz79ibCI9H00nOpHX
         QTTFhKDbWb7p/kTqzv8VeLTGZJI1EMJobsIL+o0j0r/vcqggKLsBHXr/9WLWpMwndnxI
         e3Sw76G+oiGDMBVvTKXmjUnI8NYgEKOwe/yl1/NN0ac/6ldakmWNOeSdrbeY/skobZA0
         ANNMF379tdzlmQyi5dtH6OzuOBwsbKjn8vBG7Mb3Yg/xa5nDwbYpx2S0lPaYs2VFhLuF
         i6tWVv5RQz5OlxBR1H5f3kTTFs0Uv2io1hXym63tsB4JTFt6/r3x7WejGBRINxfFwMjK
         8jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827120; x=1786431920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUz1mWBpB/XSD0ZgFsInGJUX8h9hfweN14oEZfYpX44=;
        b=MUsLR+9m1DHSk45wXEr9FxNQSgc6+F6CzRjBzM1F2K4Y+Kht/aCb7pHfyodibC4C89
         /4QRV7e3LR0R+KohTWlblfa2pNVS9jZh2+xKVhi2RTI6zayq+BQBfe6fBkeFFPARjQfN
         eVnqteCEBtGyGDzBPriME34KDcp+cg+3fPs4khw9aFEIuGnNwp93mYO/aIuKMBC5DYVH
         3HZGZ6PJaS491xFbQbqBdhvp9F4BJ2ZC56mdQPqZRLxqRSTief2YjcgHV6OKzXkLR5K7
         FuYyilQuObPr1d+ZqWYXfproaZac7nEIQf8GbgeGx5QdJkcyne9xNFgS5edJVLm9/IzM
         u4NQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOSBWnlq12p755jSYanx41g+d4q3O5fx2ccCu18MA2vfa2NSQruTHvnDacJqHUHhiqNb8VZDmNqqF+AgKJYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDgUhARbcEVpcLfb/Gxog4tassOO4oUf6/pfZcjy+SNGQHOCz
	HJxpukvH8U5nsiowiLmhYIfs4SJ2dFrLtLcSLeR00H47xgYrOnODR4Os
X-Gm-Gg: AR+sD10fqwq/NarexJAS3Nllo5ao+r+YiJ5G1moaq2ayRawPRoDm28cn5IQILZVcZry
	vlCNywfvwdBDNldZHAQirRuiAjRjZ+4T9sapKPCA1lb6r4mtllMy2TBUGB9YIEfeIejpsnJe1AQ
	IEjBur4xYzTKElrZac9c93wpcstVnYlrOsXWqSL+BTp/6ITFuA3s54oudze2iX8EqjEMhIV2L5r
	KvhhQCgvtZcJ802DCEPq0xq8p+m8Jb+2XtXwt/ihlKT1niwD4r8nAq2HsKmMM8POB6SO1mRpRWF
	bDL8SO0m8sO+6DTXtl6VS9mwh6I9eHeNK23YFnnNPyJ/tyTH4iQcbdVdTxjcJBbj7TMlYaEfClN
	xH/ZxBxfhuK0BynIZBI3mb8mEuy9c1nsJgX5iSPF64mCxEyiYX6tE4zflCrKe1lUc3ygHGQ5BS7
	CqW4sYY+SwyNcp8Kt78U5JLFWy1ecmfaWDrZRDBPxVecqRp+us5bKPWYp3QXcqxI93xG9YMpDn6
	oPq6GAlgRZI6/LdwZ4kUiPM2NVBobrQrwpN0BUjiNoAIxQ=
X-Received: by 2002:a17:90b:4a11:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-38fbc4055bdmr11835563a91.2.1785827120151;
        Tue, 04 Aug 2026 00:05:20 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febfd8ff8sm859815a91.4.2026.08.04.00.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:05:19 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v3 3/3] arm64: dts: nuvoton: Add WDT node for MA35D1 SoC
Date: Tue,  4 Aug 2026 15:03:51 +0800
Message-Id: <20260804070351.1846165-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804070351.1846165-1-zychennvt@gmail.com>
References: <20260804070351.1846165-1-zychennvt@gmail.com>
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

