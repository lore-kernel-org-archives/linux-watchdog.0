Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49014C954D
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525471; cv=none; b=Ct7fBftPdppiaoCERNBqmyY6kF84PZD2i9xcFNl2bTANmsHSECwOZlUFv3OC4NFFsulAFhFNgtijH8Alo9c/Z7sxELVXRkl5IEV+Qj5DMYmdhoWmaQYNHTmz8WG2wHnJB4XoltkXyfq6q57+034vmMIiEu+KlGiJ8/8A2XIWD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525471; c=relaxed/simple;
	bh=JZCBeGLfMB8LJuneUZA+6+fLkw1BbiXPSFoC/zVqo5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8oVb8d1sKHEB0FSFOMbwuVjwRxFYpndT8WVTv+3B1Xm1z1qHDvo0nMtcRefaZkfdcJ9A0c3oY2z+CIgqxqDh+BIzG26+vK7lMeRe7sLC5Ce0WkKBF3uHVk5zO8fQ/Pw7RGZW2o5+lxRuugSs1emwmojz7NCRJaCBurGEPZ3Aqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPbrN+ed; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPbrN+ed"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0046078so39268405e9.1
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525468; x=1779130268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKbDKt2WJzz1x2UtlmgWA9cf8CPcU+RwykUyEU48Pcs=;
        b=OPbrN+ed5o2+JLtioT9q4xmPZ9u5CgKNeytf2RwllnHQkZSJ0GxppGA/ll8iOymOxw
         EtPp/mOZkxDegFMY4WqpB920b0JqDNewRtAQxQ1nCohE/cqZgaBg/ususHEctMzA2ayX
         Vi/t2nAUlH3N/uCpnQRRsEXmjid+xgI2vtbK71HuITUTBDTW6+VQPNaI4DjTr4e4k9rI
         bv9KXeAzTEEzcpSoYNJ8seeIupjmCGov0nc80kaCCKjopQDEunZBMUS+uYIDyMP+LJFE
         w/lXxpwXcEkABHJBdvQNj3iB6l8UeER0pfILFKRXPOxXCTGZuJP6NJK0QPbxu1M/byUM
         RHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525468; x=1779130268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKbDKt2WJzz1x2UtlmgWA9cf8CPcU+RwykUyEU48Pcs=;
        b=VnroMLYJCh7B12ZA23z0edkTQL/bfa7EKHb/ss60Ze20EWgIvSCPX1h3XVHj75PTus
         jgOphWId0wuVG4/TdnNerGPXcW0X/EUi5zL8OoI1G1yMzpwRY6ebEkuekV5WfQbFjtsJ
         39PITymtVeu3rcy/x8bVEWmfrRxYZHdRco4pZ0kvieqnG0hOpO1JmA1pTK1bCafrDhAP
         Putzop1aIWjrp4/l/SFZ+g86MgUDbfmxdyN5j+B8dPwubSkW0VHjAXapzWQq/0F9WsCv
         nBVIrN7Os9KeF/a471Ee8k3nQ25xVtQB60HlwNj2yBExnuCDNpltkRqpecOHzgfAaXol
         4eTw==
X-Forwarded-Encrypted: i=1; AFNElJ8Nu1ePKw/ikc/WYgfDvvTESA0o0+mYTRsSveZHRrDHXEvG8CehYMsbD1N7CZg2oD3UlK4eYvOpfGYBRQLCng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7qqqfAh0m9Iyt4Hf/meftRsqokprxNmuOuamtJZlhuUFC1Lk6
	6hlSSas+ddh7aaHxtxrMVh8Asq4V2QRZi3MBfU4etzBZGlznAFuxi377
X-Gm-Gg: Acq92OH7VelDZDfGIFOKKIgvzHtLaYDxq2lpdS5T0Y1PQ3xNPbqGcYLqMGGn3ocZFgB
	kx+yd9qAttnFsEqiIs2cgbzcko9y5P+8UzpcvmtOba9et24iIMgj+ZHXRZSYK2NB8jOHkg/c5UL
	HDotMj+Nv9nA467qUFDYQ6TnCjZnxDVXQMaht5nh1Z0lE3SI0YajLMGCfowClJzUCaTuTkgy+kH
	UeJh7qwH0QoLTCYW51nyvoQbOK6Cnmt4piA28+7esZu9QPcgoq/WglGjkA9vQQxjRKU6jrHAw/2
	YzvOWOdxtVM3hquETRH+XtL6et0Q+mTMyhltSBInoh7vmKoNx7DaEY9O60rgrdC3pQZeKgfOHjf
	97wsZvpZgy/Is7na3eYHaFw05ejXihqXeCNBwKRo1w4j4x1aU9drT4CwVe8VRGiU1enppoF+Pwu
	AT/ne3nyVK+ytfHKkltUdGibaTrw5VKitbYWjqCQPdeh5lVKQ7FjAO1hltPrLIDJmYi8Y6YCZLB
	AXSmcZhkMrJiCT/knhGg1EiX89gpdKwQEFU2w==
X-Received: by 2002:a05:600c:5296:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48e706932d5mr166018355e9.11.1778525467756;
        Mon, 11 May 2026 11:51:07 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e687:6094:b849:9886])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm854775e9.2.2026.05.11.11.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:51:07 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 3/9] arm64: dts: renesas: r9a09g077: Add system controller child nodes
Date: Mon, 11 May 2026 19:50:52 +0100
Message-ID: <20260511185058.1926869-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/T2H SoC contains system controller (SYSC) blocks for low-power
management and access control within the CPG/MSSR address space.

Represent these SYSC blocks as child nodes of the CPG/MSSR controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 3761551c9647..59e5de743826 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1015,6 +1015,20 @@ cpg: clock-controller@80280000 {
 			#clock-cells = <2>;
 			#reset-cells = <1>;
 			#power-domain-cells = <0>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			sys0: system-controller@80290000 {
+				reg = <0 0x80290000 0 0x10000>;
+				renesas,sys-block = <0>;
+			};
+
+			sys1: system-controller@81290000 {
+				reg = <0 0x81290000 0 0x10000>;
+				renesas,sys-block = <1>;
+			};
 		};
 
 		icu: interrupt-controller@802a0000 {
-- 
2.54.0

