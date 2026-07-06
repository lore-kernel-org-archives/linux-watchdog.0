Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84C3DC4C8
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367978; cv=none; b=XBtLPZI/Urf6VeNofDuoCRDVSHjYzOqbbD+QgcojxbaoQNw/RoFIt4936mO0RMVE65M2wHqVM7lHFi9s5kzmLWrOixBW7SLUi5KNpgfJ1pb2aJooW2u8UfWL+uQf3koKs6uKlN3HHzOJdH18ZtRnduGgwBoWpOJWSYuX/r8TND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367978; c=relaxed/simple;
	bh=0lYRvkZXuSchRHY00awUjYx5PGi5688DqkEBenX/jOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y84E5+oEAqgJP8RFsq7vEvYuNq9K+ZOExfTIxEB41taTnUhBOiwm3ZSXPYuTgEd/HofatlHrn5jcbnqDNwzTLdWKFgoy940+s2qiPcm4tDnuLtSMQKs4Xg1korACrYJliv9tAC+RrJvmrZJPCrJY9r8AHyCeb15zbZulTfI4Xu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bdX/8yZ4; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bdX/8yZ4"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb5a9f02e8so1582200a34.0
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783367970; x=1783972770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8G6pGuOuOyYcWebHVgbsnO4yO7+jMa9pCvWAaZf6rmM=;
        b=bdX/8yZ4k7aUNHw9yIWVEZ3En+Sbno+64PmLSmC++7kGtvTlUwWYFyGpF4Y+rOA/YD
         Bb8UYmUAwErnUSlBokky5N5M64WXHo40U+m5w+rZNT2W/zY/pbMVZGwVsq+gi04yLTlY
         5ZHIju2FAhJjKeyAYGFpT2ZioevBXZXiEb4Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367970; x=1783972770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8G6pGuOuOyYcWebHVgbsnO4yO7+jMa9pCvWAaZf6rmM=;
        b=dJEAAPo6RjirooWOBRw99eae7a3tTygPrsZ0VQELc3eyPZC+lE9F/hJVXX71+s1514
         6y4IuYH9OWtaAsDbrKRKciCcZeV4BYhw5jKdDmlWFsk1toqrFlx+tBvbto0P+AoxWSrt
         0cLnFD0TSoL7P+dGv+LKrVqBWz4NMH2F02TqsxwOwdJzwl34eLFV82hlmy9FYdBotcyu
         wm60wp69cqR/1JfAy03gGDNrhwJ4zobpoolndHpGZ9arxLksKYC385FqyXF1/zCwyNbX
         zYwx8wrbDCIQb74v2wuZRfFwcYdGEjbQ13ZIM6LQ/M4LrV6sFlZLbt0TR88fuoGYr6Em
         kTwg==
X-Forwarded-Encrypted: i=1; AFNElJ/2toQUWzq+hOAyUARCpUnEWaaJ5jiK2VwbVXSniOG9XdhTfMrL+++oOeRgsBijNdWMUsywf8fEf/xAegLayg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEX1JAnNRamSbj0pKd+9Sx7AH0oJaBhA3xLWMDofilchcX70O
	NlLK7Fv449piwKjeOYFJ10WKjV+dpR7m0S7LEZ7Ry/0oZ46BPE59PTciordFHqMcOyUoX2XXeme
	s7bU1pg==
X-Gm-Gg: AfdE7clJmoQkUFk6fva4EVFg/NxtM/TDrRla4G7vzHwjWAGmYZ5N4Z8HI2+6V0F0Tcq
	+VVQk2/xtQ8fxklRo0NGwdLLxKGWvJXCsP1qC6rEAASYSOXPPF8OKt0Wpt7dd0SLX/9MgL+X/3l
	BaF6STASIaud5Tc77rPh6N763FQc8RMdQ3mB0BKS4MocRW2gYNBwHy2CfGr3GBC972SWZFE07YF
	hAQV6ByZtLsS7Gy3WeHPboyOpa7jGcjPoBgTOthyawdgUag6UTxYX02HpKmz7z1zJwI8pyDKzll
	OBsfTT5oe4o/Fu0uFHgNmlZe0W490/BMQ83MFdiOGc4gpsVUTSslSyZeYx1Q9aGE0DAUe/d+Gga
	XObzE/QgBdLkt7sx7IySNzewQrK91HrZ8LbuvJ818F1CZGthrBWpBCe++ZOvLVnQZLXESiQEaCP
	2IyubhoMA=
X-Received: by 2002:a05:6830:82fc:b0:7e9:dbbe:5af4 with SMTP id 46e09a7af769-7ebb23b0a45mr1303771a34.32.1783367970287;
        Mon, 06 Jul 2026 12:59:30 -0700 (PDT)
Received: from chromium.org ([174.51.25.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542d017csm12161834a34.8.2026.07.06.12.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:59:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@nabladev.com>,
	linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jamie Iles <jamie@jamieiles.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 08/12] dt-bindings: watchdog: snps,dw-wdt: Add RV1106 compatible
Date: Mon,  6 Jul 2026 13:58:04 -0600
Message-ID: <20260706195818.3906949-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706195818.3906949-1-sjg@chromium.org>
References: <20260706195818.3906949-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the watchdog of the Rockchip RV1106, which is
compatible with the Synopsys DesignWare watchdog.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
index 9d25f5e497e2..2b16b7c2787b 100644
--- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
@@ -35,6 +35,7 @@ properties:
               - rockchip,rk3576-wdt
               - rockchip,rk3588-wdt
               - rockchip,rv1103b-wdt
+              - rockchip,rv1106-wdt
               - rockchip,rv1108-wdt
               - rockchip,rv1126-wdt
           - const: snps,dw-wdt
-- 
2.43.0

