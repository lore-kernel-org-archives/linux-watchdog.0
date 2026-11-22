Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330686;
	b=T9h5RSso269CsOaPDwBZ8N8IPHBALxyk3Zvij2G3bMWlMfqoYUCz62E3rcrLSt9oAy0s
	 +z1WvSKjHHHId5Cmknlemr0KD1b28cYqsHBoZDfTqfRvNXtP1nGsRtW3ApIelC6jHcP9p
	 LSP/4whHG2p2k6nFQjt3P46bIer72l7PoNt+ghkABCivJOqCj9Ze/mTGKt7GS0CCtKVVB
	 wnDhRpdwstNMsiWqsTBncn/GgMAfubgS6KNq9+8klwSfg6tnu7qCo2foeSNzfA+F1vgNb
	 lAGeGD78n4UpiBNFwzfzNcTaJuyI5RTjE/i3gPBrvDiJDewhLXVjaewLnMY+CMPpU6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uzgThVtz5FyRtzpWhXy/XQBj1yMgQbdQfAysHaetNR4=;
	b=clVZ9veP1q52MJa1rs4+UVVxsJzNvBZZkARDFgFdyiOojLmxdwQr3U+JXM2p43Un/9lU
	 PwGDk6ERFF1vW8WrBV8V002RWDxabD+2/OsexzYiFG2EKWMeHdStfV7KFtnjDG3Azqe6Z
	 yt81iul1rTPDAkS1Rp+gsLCppyYmfqXtT2YouPuCFKfDJETTvqMlUZUUvAaoBLJABSGM6
	 pnby9bX+xSdTHKaYzomQnL5XoyYjE9bdm57xhJzj4au4aSzwsUeJlyFCqG5dMgJNNBaXj
	 B/x/CAPp5dvdMEq/W3OQNxGQYJxc0HwfZXz1xYptLoubYZnly/e2p0NMZbFOMnZ3rFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGnsl5ob;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7FF606A330
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 06:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A7FF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGnsl5ob
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f06ff94acfso3075685ad.0
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 22:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795330685; x=1795935485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzgThVtz5FyRtzpWhXy/XQBj1yMgQbdQfAysHaetNR4=;
        b=GGnsl5obNSAzL9JzBsJqbnJfphbo/yKRmtuO93/mO2oOHN51qy2xcn3vCmoci4ikgX
         QzykZFk/BDowePozc8O/V1gurohLuy66GvPn2Yk/QgoJtNPCJ50QcWmW3hjyGTOccIcy
         lZxaYgseFAQEn2MUiZaBpiC4iGoMQSKj8hajJ1675YxvfZhAEO5PnPNe8KRBVdQ1FNhp
         Gsb5KoOy6WOR8aFDcQmO+BAS6Nu7z3kVwOJyqBkJvYQuJbZNamDrfH5BQy3v9x2sEZJk
         N03YDny6w56HsUoifAV8Pbsg5Y0bWn3SOhkZz/bRvYt6+XDnqCV3HUBf4NQlyR3SPq8/
         59Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795330685; x=1795935485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uzgThVtz5FyRtzpWhXy/XQBj1yMgQbdQfAysHaetNR4=;
        b=z8dNpHsy7AO5EveC1eDb9MNGOYLynwm/+MMU6U37K/akyQXHr64Wk/f4Yd/CNFNhLk
         ALa9tJB9cXDAJrP2Wfp4c2BxRnIf0KrYoiZlkhWKaaZGIxRfNR6t1BpUeOXQ5X2+L5Kx
         QX76j0h3+XkxbxzpqrL2ajoeOwgdCq4Col8m57oykMa3quk4nr4FFz7w/uLEE/W8wNuh
         u37EgVGWL1eCTVQaa+0la2GpYj8iLTpGWsPNty46CGFspjxCzILkbO6N/0ZFUcTdhfwe
         0OiMMSro+pc713Y74nACpBDRPpTEsoph2QyM+tDqgJa22x3LGjpRKuSnyqpoWOI/9Zdp
         Sy6A==
X-Gm-Message-State: APuU4Z9Ds1dxjuYOwyFJDfaT8Z2xh7ei3RjHaQYgqkqiJRnvBuFqiI3Q
	ypjk6SpKhUW7rR3qx5VnHymg+YDY8UFCMfal1oHn9oysKZZHkEbPyQ8ruWxVcOClTic=
X-Gm-Gg: AZFdTZfZVG1TUuPoAWMj4bGQH0O/6Vx2uNUH/L+JJpAEBK4kWVGPPOl/zEItoj/ZhvY
	WoHSF+MDMd90RbwV7iREJ/gIMmYZuhlxMhzUEsqkwpOqpnWdOTT5fFwtDs25H82KeZnUHwiOtK4
	EuoNEe1dhivYRcjv7aKVsrGLNzqIZWoN/dnrKoD4A4shYRBskjwT0YAC4EUy7TEcep1KZH9bqYr
	awfUEVppWVUsNwZ8K9L6cY9QjOYjUKDTu9Uw6GCNRpsQ40DKtcDVqyVHxIIOfgib3KW8xAlMQbI
	LBZZubUhLl2rRiTOqZqzKbK0i3E5vVDT3djLmAjtixAjwHCKXQKt+14+JeXXerZlOZM4sd9R0Ay
	qWmZTLjl7VjlN37vdcDilmSfo88pj390/NK47U0J4c0U5XhEQlH3M4Wf+fhx9Z1RBDGp4r4BPzP
	jlJzyiTSD/wUjafG0R38s6VE9riMVrG9ebzGOnTBWRFLspT2iEH4tS06lMzCLjINhz2cU5Dkrji
	PsosBu28dNcLOVi2eTJnePA1iRiYU/5N9LUP5BZvDJPkAgR3JIScgKiH2LNDXsbe8OD8o1+ayZw
	A67LzAi1Qzxvc2Jeuep5LlXI4ygkONHErxOZ9bLG8HTawZnjFP4mFqtjGaRQbMRvZsJ7AmofWw=
	=
X-Received: by 2002:a17:902:ce85:b0:2ed:1350:59ff with SMTP id d9443c01a7336-2f03ef594c0mr76278785ad.3.1795330685150;
        Sat, 21 Nov 2026 22:58:05 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6213:28::4:379])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120016sm34287345ad.58.2026.11.21.22.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:58:04 -0800 (PST)
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
Subject: [PATCH 3/4] arm64: dts: hisilicon: hi3798cv200: Add watchdog node
Date: Sun, 22 Nov 2026 14:55:22 +0800
Message-ID: <20261122065549.3265519-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122065549.3265519-1-mmyangfl@gmail.com>
References: <20261122065549.3265519-1-mmyangfl@gmail.com>
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

