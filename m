Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420724A3F3B
	for <linux-watchdog@vger.kernel.org>; Thu,  1 Oct 2026 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873541; cv=none; b=iamBGKkhVhloU7HPvBJDJWbys3pGxarWTSM/NXoOdqI6q9Avp07dWkrZdE+tw0lXLu7CcUR9rLDHwjI5drTbjZWOal6GOD8+3KGWA+1DezUdZmbYb2oFQS0XlZ6r8QQlmWr9q0hmbTLEIJBf7WnSGdz1u/BtpeVHQ/soZ0Ojbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873541; c=relaxed/simple;
	bh=/4c6htHbY/+pTDzTjgO76aMfdQ2UmFpC3eU2LEDgX34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz5+63dCmeLvEFB/0laQ3LfPyEgUl+NKzfQT53Ls0jLvGPQ70qz3H1ljq3pTqx1pvYQJDZequtnmpw/pD9omxXqxMbWv+QMqY3Ec2MGn35V++TVpa2mN23Xt1GP06wbnSDcmQp8E4+7Hb3AwvclcXlgDCdjvvSTvrpwD8x5mfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzMnP34f; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzMnP34f"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffa15f67fso35487565e9.2
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Oct 2026 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790873533; x=1791478333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XLK7hUg8XDSDCbDtdKxO+z/jFp8LEc8rnhxAY0EynGc=;
        b=IzMnP34f6Ei8y7ngpA7BAVCYcTb3gBGSlJ3Byb5HRla+bSIHNqqtClj6gIrw7oJSjU
         wfqdywjlQ1xuy4g2f/jxSFWfrbNlGiVxFb4VzrM4oL8UNHbX1QgIbXaJVSdPBvL7jnSW
         E4VFZRUJS8LsFxeQfgFKOSpcZuE5hKrKPufMGjD8Rwcpl7rzIAA1qMGQq4kPX45tO4ok
         K84ZlfmLF+qYQ8YDDkcb/3GjxaKVHQ3o3ZDi2KZE4jnu7ptO5S/sm7XYE52xDTPIN2j/
         gnHHSnXUpkmZGkOlPI9ugQxEG11MyfIarNG8Xkng1z/posf+7KFFn/C9KDiHuHyg5f92
         LTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873533; x=1791478333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XLK7hUg8XDSDCbDtdKxO+z/jFp8LEc8rnhxAY0EynGc=;
        b=YEekbX/R0Brynv8DxLX60/dIbSbMl6S/l1/Xl6FcdEEiNXu6hwog2YHEI60f8W23aG
         hrvM+Qj5viyvS7N0DF3ILy1OcV2320N2MrZ23WpV9fXKr1rqiuHWRJSyGwD4htlhS+lc
         /7N3F7iOptF38CIUuQeyuG8Vcl6ddUbfX727MI90xFSZdKjBO77KzwB07bDmNTcQP/Ok
         i0+nCkRKtERf0gzZwBlZKBeeK5UQorMUZVMJqgjZ0V3bdKZ3OyYrf7O2bWncp7Ayog4+
         aCH7B0pnpi9J8eJxzVHSP6tLlB3DVNO4sYWFjP0doWC86H9f7lHNW4ZRmPnAZcxcDhqZ
         qYbA==
X-Forwarded-Encrypted: i=1; AKwUvBw6O8GwJS5ZET6dzSgnu3de/Yf9QqaYdt8g5Mf0XP0q/mEsdvmgZE9iFt5q1dvXeTdSWO8apKKx0JAGgPW/XA==@vger.kernel.org
X-Gm-Message-State: AFuF++lkPWuktN4m0DcO5fbEPuHSL+EIw3LUlYg+VPNPA1ALOOx0PDlI
	eMpfoHY2ahnqQmUSEmiwnOcOdau4qdjdI2Ha/4fmWT/2zANTzX1M5z1Q
X-Gm-Gg: AYBFou3Y2jwbs73dQc3xN+8oY1jM2hS4icMoMOVnWIEWrXKxOi19smmJRB+zzSLEOu+
	Ks3BCbYjNGWULuIwz+y+WME927BcJCi/D8xqHicAVMYcjUpTIxYHOICqZxRUM6In8dWdqIaRSMl
	DWBvgRA9hVaCrzBO0wpjdXQPUSiyPqnCfEt7ujJC7JtKF9ZwP6KpGMay4HkfWbDg6EOjEMDePKv
	orUAin0VuTl+nk3949hYk5iBsD7hMlUVPldPZUbxsqxjVYzhj0zkydAVskKYC2wuN75DOAGGviw
	V7NZl55w4b/UIG9Vn49vmIVUl6rxtwcOFCnyV6o2oJtWpAXm2EkN+DrIlZKDQOjbf+pw9TMUcZj
	1uqaPaWPP9RT5hPv/ubvPFQ/hPLGFhOm0dB6N8CIhyp2y0l1ATSbGLO+abStY85Njid4Xb8mNtv
	r4H1YGMfZi0iHRyiNL6+WCnrxn3f95X5rmRnJ1ddHQAoQDr8OkFri23EpoTupyx2BiQWQLGAS0p
	h+n2OFLODTZYlb5DN4xiwVOvmCTC0xagqCi0BmUk31yz822mMPQTduw0xLyHtp/9dm1CUAvIp5V
	pYG+5qQu
X-Received: by 2002:a05:600c:4592:b0:49f:ffc7:2099 with SMTP id 5b1f17b1804b1-4a0276ab7bbmr3757495e9.26.1790873532595;
        Thu, 01 Oct 2026 09:52:12 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027ae146csm480985e9.11.2026.10.01.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:52:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v8 7/7] arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access
Date: Thu,  1 Oct 2026 17:52:01 +0100
Message-ID: <20261001165201.763882-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The WDTDCR registers for wdt0-wdt5 reside in the second register region of
the CPG/MSSR block. This multi-function block is now exposed via a unified
syscon regmap interface.

Replace the direct mapping of the individual WDTDCR registers with the
new "renesas,sysc" phandle property pointing to the CPG/MSSR block syscon
node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v7->v8:
- No change

v6->v7:
- No change

v5->v6:
- No change

v4->v5:
- Added review-by tag.

v3->v4:
- No change

v2->v3:
- Renamed the "renesas,sys" property to "renesas,sysc"
- Updated commit message

v1->v2:
- No change.
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 68c8daed557b..abca7aa89458 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -327,61 +327,61 @@ channel1 {
 
 		wdt0: watchdog@80082000 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082000 0 0x400>,
-			      <0 0x81295100 0 0x04>;
+			reg = <0 0x80082000 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 0>;
 			status = "disabled";
 		};
 
 		wdt1: watchdog@80082400 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082400 0 0x400>,
-			      <0 0x81295104 0 0x04>;
+			reg = <0 0x80082400 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 1>;
 			status = "disabled";
 		};
 
 		wdt2: watchdog@80082800 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082800 0 0x400>,
-			      <0 0x81295108 0 0x04>;
+			reg = <0 0x80082800 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 2>;
 			status = "disabled";
 		};
 
 		wdt3: watchdog@80082c00 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082c00 0 0x400>,
-			      <0 0x8129510c 0 0x04>;
+			reg = <0 0x80082c00 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 3>;
 			status = "disabled";
 		};
 
 		wdt4: watchdog@80083000 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80083000 0 0x400>,
-			      <0 0x81295110 0 0x04>;
+			reg = <0 0x80083000 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 4>;
 			status = "disabled";
 		};
 
 		wdt5: watchdog@80083400 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80083400 0 0x400>,
-			      <0 0x81295114 0 0x04>;
+			reg = <0 0x80083400 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 5>;
 			status = "disabled";
 		};
 
-- 
2.55.0

