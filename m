Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483722;
	b=P8bqnGz3NyIsq42zhrPpFhv/NE4fx5WTQ0svq185atKl1VWwoyzWUd7KM0lUZBeP4x91
	 TAMskqAXjh35SO6deGOxDv4dX2IKQx/oUhdlTQ+ekhinDf+hidYLZvTSCClgMQYes2nsl
	 FRpbrEl1TTyukmW4O1sZRQreihV0Wcs7iFMBsT2mKvdbGO3yMSfZkewQzXBg8kjaknkIp
	 1YFXc6QXM0AIVubjX6zqEahP68LUUjQ7VNeJdrOs/F89QcroyDejjgZfDvCG5zaBKCLKz
	 QvEAyqvz3qqYSIhpIwyOEYkkSdlG5TjJFA8gT7Lqs18OMTPGZvkU+fXdQYEN13wesVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uzgThVtz5FyRtzpWhXy/XQBj1yMgQbdQfAysHaetNR4=;
	b=x2Nvt4LFSM8KA6l8uceeulJAgkn1ymjZv8CfAl+viyFeu2e/0IEetMsCufEvJpLWfQCE
	 0mlEJf6K6qtUgr4uujs+cPlOEzTuk8+v+Owk25hhkDNl3QskkUGpol5wVw7IMpJgb2VMW
	 UBKB4ZfY7nm08+rKfQvSA8gp/Zf1N0rbL3vB4EWJLPBQVfA0VYV2vRLiJCCJD+4s9wQv8
	 XZrxK86DlbsY1//uG4kku3jTLkbe4IRUHmQsm+5/GdUl+YjAIwj/ojw+NlnGtd+5C80eY
	 TjsVvcug4YBdoiA+bKfmHChAi+u6dCGM8ge8xvX/qHhbkW2iiZFd+EXlTt/RGSjhuhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Tg/baRzb";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B9606A32A
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 01:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A83B9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tg/baRzb
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1729465b3a.3
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 17:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795483721; x=1796088521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzgThVtz5FyRtzpWhXy/XQBj1yMgQbdQfAysHaetNR4=;
        b=Tg/baRzbsZ4MOxkIjrZ/B5lU6Fg/bjyV/logqMV1Ui1y31rDJSBd9tR660cSMf2F++
         C12+iqoEf/yPkP9JuTucDcpS1R0J6l9bUYC27oXB4I72759oIrBEBlx2Dn2Eoa2pOC9Q
         Nj/x/6fCVuoUrS3+FYMUcxMX7jGfl8E0Fo8GBLQxh/yrgJX3SxEsZhsWxCxdjKp8ti4b
         QWg7SWwnG4Xr/JLzzZymTqF8Iul2/6Mb2ecmHBRH9d+Ya4iWf5LkSGdCUzM7ZUdcZur5
         3TA0usdlayEF04ePUUIlLrCZFy1fGrabGj+Ae9XiHvZPm8H91gmpmH8MHsmCoJz019k/
         6tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483721; x=1796088521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uzgThVtz5FyRtzpWhXy/XQBj1yMgQbdQfAysHaetNR4=;
        b=1DSw1MbdjLcwKTQff7TVGepwpK5AoN9rgFmZhhQnOZ2J7H5BsdKEaABC8cAM76oz7W
         ZNti4COVZ6ul2DKEHBZNpsDrf/Ubyr44yqTyeVbZxj0Naey8iWuJ7buSSRt9VJnDRcvj
         ulDKl02fpoRS0emUfMeQccnSZWhAQbZ8p09s3bJl2v9tNca6uP6fZZEI87gT7bUGqpUY
         qMwsN2pZ+kRWQ8vW5OooNoPVsiS1tNYAbfNsLR1wndW36dwe+RrRVfoJ8RaeTvQFJ3CI
         BuYGYCX7P7Xu9AdJ3v5Cx2p4rBYG+6mFsU12IvJiuRQgWsjVrKxFzJGfjod/57A4qVKT
         F9Rg==
X-Gm-Message-State: APuU4Z8OvjIV7msZZJzJGpz3PCW/YyyCrnoj5VyDCcjjV82OOJkqqCZn
	ivlkkq9dpsPYVX5mCvjFfNADW17ITzn0dzUMgRGmGOUd3CBB+AQFJ2X9V47DQ4PH
X-Gm-Gg: AZFdTZcq3MiUSMu+Y1ORE2TfPklUpeJsXq6eKOgSzG2Rbl5/4bwQLTjNaTLsp7Kk7qg
	JktxLFzFvjjQUCtgNOgkqSjDwpnAEZHBEqcMAoTkKgmt8APSdlPKVzmGeh3GaE3k469ER+FsHiC
	AWjWh18yMUneMd1e9Fv5cHO0IcGmKJGc0p7iriG0fx1/4ZOfJ9z/m4P4slLhK3x6pfLv/tcWFJC
	XlUBrgOPTHYY2pVsvHd9nbTZapHx+U252i73mtJWi/fF/bMIw2fJlRYX8DbR+SanwpxAbujY6fV
	hEJHS2PjiBqx4Hk9I9T4MuL1286brQqO8D9ZjF5712KNd3AX/XevzZEY4aeR7KCqpOch14w5tCC
	sZjxprkeJtO7LuLqzhUDOdt4s+OC3ng86iV3Z4YcT+lZ5M7w/FWMYOxcUMBrErctJJchVC5LUHE
	4GcIYNRvlXFpsgUkrt+tQGMN9n/jIMJgx0hEVvN623b+vyMc6WLyUWUg9GcudYImvPAHWh1Z2QX
	Zw1xecB6Zy1xwTWWSC3mujXqXf+p6ITVBuM1qsqAafXYWUB0GDo94DSESTmeWlMSlSc9DyYCUFi
	3Fo4ELj6x+P7hw+EC7vlDcmkOw2UOTrmf5MK6Rg5qOqfkQClzIBDz2U=
X-Received: by 2002:a05:6a20:3d1a:b0:3eb:37a7:12a2 with SMTP id adf61e73a8af0-4014cf57a08mr12321296637.33.1795483720826;
        Mon, 23 Nov 2026 17:28:40 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4d0:8e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e457d1sm6115243b3a.30.2026.11.23.17.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:28:40 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] arm64: dts: hisilicon: hi3798cv200: Add watchdog node
Date: Tue, 24 Nov 2026 09:27:37 +0800
Message-ID: <20261124012755.328774-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124012755.328774-1-mmyangfl@gmail.com>
References: <20261124012755.328774-1-mmyangfl@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the on-chip watchdog controller node to hi3798cv200.dtsi,
backed by the new hisilicon,histb-wdt platform driver.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index e5010c9d4c39..169a919bb282 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -254,6 +254,14 @@ range: gpio-range {
 			};
 		};
 
+		watchdog0: watchdog@8a2c000 {
+			compatible = "hisilicon,hi3798cv200-wdt", "hisilicon,histb-wdt";
+			reg = <0x8a2c000 0x1000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HISTB_OSC_CLK>;
+			status = "disabled";
+		};
+
 		uart0: serial@8b00000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x8b00000 0x1000>;
-- 
2.53.0

