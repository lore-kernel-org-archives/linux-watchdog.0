Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC54EA39C
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679056; cv=none; b=EErWBQn98n5gjFQQrCE4poTQA2w4v98VRAcgZ7F+BthCuioRnlGBuJrFtm544IUM2pdroUf5l0LIKlo42RgZk0Uho9nq2FJXkEQRivi8v2153Z5gc8yCXzMdZJbMjc9E4AuLWs7N38WW1hMLoZt2fa8fBSthH/wrVNmNTws48gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679056; c=relaxed/simple;
	bh=yEBiC89OR3qXvDQDCPsvt3vnd76aREcYsfSAe/oYJqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDoXC0mSmxNNDmUaqUcMBeOQJxFFFv4vm2k95WyasyyLw7B2nGyy/J32nKfXU7QJ99h9oh9OzCxZ8spKQSd2Ma6nMPeCt8ZzZCr4CigIAirQMxkqft6D4YeSRAaRuASgGPpLr38kj3H9ZzCaPJiVOUXBZW4n8myLmJezEzQe68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmBgauqP; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmBgauqP"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso21261465e9.3
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790679039; x=1791283839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9o2g8NAo8BLROcpDMeEoV80HGh5uA5p5XCke07A0uI=;
        b=MmBgauqPf5DoL3EuA5ugwMqKxCx9+fnMEX/8c11Dv8Q4OTrqhN7gn2Q5S0jVVn1KX1
         vYIJk8yTXv3WnHSprzu44vY4OgxL2d/aknXRa7wMXDGk3xCF022CYNGFW+C5OiIT3pmL
         VqHMLsUiwrcmkU6RvzYiyN3o36m6JLmDdbRKsfG3ewbZpve6+lTt22yhMbmVk1DIA0fw
         HJFs4UahZUbrzWkdZEyKW3jilheo13RfuD5dfC0eqIDTnLbLTU6eWRqFNf7LdeMMV9Cf
         qLxHzaL3aISxb8zhb8xDfESA90U0hQ/gYrXY9IaUXMN2xSWy9vpc9kj7Rill/IwTWxNZ
         hYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790679039; x=1791283839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I9o2g8NAo8BLROcpDMeEoV80HGh5uA5p5XCke07A0uI=;
        b=QpkwYkvQtL9mC70It4ZogVUHYxhXn32jPGq1/dI/I8bSxneFtzx9AAkqknZCxhfsc3
         lCwUz2QNr5jiYWZPk5Aav9pMR4uo2V7aP+efMKlFqTiRgD/5EiXHhfU4m5v8XbV7QpkB
         7B6m1+MLPQfGQys0y3IgW5v46cKyvXi9CIQzJsddVt7XljNp+aVzoBN+N0sypQvg7YvD
         JBHTJqj695MS34rBblbiKKH3sxGs5VnDg7XiTHixsQTeiANd8Xrj5VdOvctY3Souwj0h
         f5WEmbCOYT/AQw01af2Rd6QRIp0vIcoflJiKwgU1YmSvgyES8tGzlXQykVhG6bqEP/ZI
         EwPQ==
X-Forwarded-Encrypted: i=1; AKwUvByeulST+/5HL10fLmTdohHX1GJuEkHWMTfEsX/AJ8unSUivXdyRqT4Me9DwX8KMpAAPDeiehAMdtm2N1ZXm4w==@vger.kernel.org
X-Gm-Message-State: AFuF++ko/Ele+90KfOjYZIbxdASklvYI/tygAaX/POY+yBEyEzpVJmHg
	UV0s2GkLSXZUkPh0YWpDdTuQ1n9d+EXqNi30rUl8qnkn4l9TCrXGU5rZ
X-Gm-Gg: AYBFou0ob8dS+Pa7hcA4eRehw4r8qxyedhh6zXcEc9uyQwr2A7RAbh6+gh2Kud+/vab
	hA54hgdDJkYfFg7sThHg47auXPiUknVL/2ckSeyrgpel7egH4JJRsMo7as5iNVOHTpS6o1yUF/b
	N/dX3ZLHqgymjEM7c77GQessM7oFUGovgfd5/n2jf3s+UnGObBGviFUJM0qJy9Xp3Tp/Bf5q2n6
	I51zygY+t6Uv0Qbp2IUBUgCLTKd4XpPb/BfdgeiijbYZbjR+bbi6BeO9SttnSHeUQrE5TWnhqCu
	Rx0FGRLbglYZuKzCtwS3k8M8jZaINdi5xB/vCRUoEpIwscOQmLuHxKfJV2N6Pq880BQ9SZ+SjmK
	ZN2ZhJrZJzNow4QfYANDcbd5M93H+Sef5XZShBhUbOqedNAq4zvEp4DX2pf27CaatDcQVIwf1+M
	BQ4tyfP1zqpoVK2WtEVwH+rxZXlRMMKMLYQB1wDCpbG7hPMVPgcpThpBKn52TFoWSaH/AMJIcFn
	bE6dsz5EIz33i0YAtpIKn3Cc2KNLLo+kkzmnWxsMmZoXB9e68frLHCRdTlAWfMYN4j8LtLr1YyB
	cxIwX41YNd1Mtv2UqDXto/i+ZJhL
X-Received: by 2002:a05:600c:6291:b0:49f:ffed:2cb with SMTP id 5b1f17b1804b1-49fffed033bmr120811245e9.6.1790679039014;
        Tue, 29 Sep 2026 03:50:39 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:10d5:21e1:1aae:c9d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5058c52sm3516303f8f.19.2026.09.29.03.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:50:38 -0700 (PDT)
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
Subject: [PATCH v7 4/8] watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
Date: Tue, 29 Sep 2026 11:50:17 +0100
Message-ID: <20260929105021.542730-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDTRCR_RSTIRQS is unused, so drop it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v6->v7:
- No change

v5->v6:
- No change

v4->v5:
- No change

v2->v3:
- Updated commit message to reflect the change in v3.
---
 drivers/watchdog/rzv2h_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 55ac11fcfcab..17c9e9a24ce2 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -40,8 +40,6 @@
 #define WDTCR_RPSS_25		0x00
 #define WDTCR_RPSS_100		0x3000
 
-#define WDTRCR_RSTIRQS		BIT(7)
-
 #define WDTDCR_WDTSTOPCTRL	BIT(0)
 
 #define WDT_DEFAULT_TIMEOUT	60U
-- 
2.55.0

