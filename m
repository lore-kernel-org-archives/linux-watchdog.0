Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D63481FAF
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160076; cv=none; b=m50/yYxxTV+mH97vXsMUqnCmsPdtD5fOf8NxAoju7IBA95yvNcSnmSa0o3j2W/NLQvp91lAzRDd1MHCzgmGToL6MKVd7FlxVKaiYxVh9H3hIsS+PEoX9IRxmI9bvkeqjlLjGs7bL1aeP4esqPVXA8IAd4zAvtsKfMxdwNH2JPYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160076; c=relaxed/simple;
	bh=JPq1K/TtYhGpO+h9McDLSD5P9OgM/Hgg+AidAGB5kZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmLhRBz9LC3gjZh6VCt2uvCnj0Ua9RhTP/HE8KhVjWCtqv9EUy3atZj5VCPorA+PDWq91ryRrUnnG2orhaZ17J3eAYpf4PdKRqU6RINYHdpUXxNocz9FufmPP16hSq+CKGPnE5Db8Isol3io+wj11Mh44nV5hr6jW0f5gGAM7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYUL9gIP; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYUL9gIP"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so643510f8f.0
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160060; x=1790764860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hfcYaXdQ4JhprU1bLeofN4mzB3OfwntG7DvJN30DUis=;
        b=IYUL9gIPYJqMH6ta6UmGeCGhk8DIsHHAzbYofqCLJvUcJd1cGFPZ1pmRwg6BQ59q1W
         hE2e0h0expbETv8Dbh3Ykf6PjAp4Dh86GNT1GKS3AsHGBmp+VlW7r0N6o7+0+PvE9+P0
         AlYpOU3zgyCZlcNPLEThtBr5KSYBmvbf2IzoKvbY8leIFR5k+aQBfcdgd4E2QlSGOyX3
         esmrHSVIqwUliWW5BR0TacEIngcloE9S3B+LFoW+wtnGxr/0zoFnXeIEmSAuSyoqg/4V
         1gYc+O4fEdZExcqLBePgCguiixv2YpTL7FNOKXEL7M6GVQ/N8v/6Tridf2BtEPLjaa7O
         M3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160060; x=1790764860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hfcYaXdQ4JhprU1bLeofN4mzB3OfwntG7DvJN30DUis=;
        b=ujovI4uyFpe3G/P9nHiZnUCotDleaFmA+ZdTdIKwXYv+SngeCbQ/Ag/iTw6bNf8Ffy
         TrKHIBpZ7Tdhly95N7j2y1pdfJrrtqhbouE3YKKs4WUnxMmSIjOlJATiao/ygREKBb3W
         Ku9Sbfj/YVk+a7czNfvuRHsMjtqp3XPPyHk5Q/eOmtjM/pWFjRM4P6iZN8FV4P8q4Oln
         vEJMv3bh0Kh5fbt79BEdbHsmKrfSVxAK5BPVyF2VwatkZB/R7/Vqyb6A6NrVfaCcmwCK
         6jVNolrhclY7rZYf2m0kUqcITwelETRpGklS5XUoXTxlQcQ70RRJ8hNE72kA7SnCN8Fr
         p+vw==
X-Forwarded-Encrypted: i=1; AKwUvByt6J3eYMOrbbjbSLAxySxR0xLIVfuSky2Z+9LXu2zzp2iYs+ljZ4rc2tRN3aJhQ1t5VVKBUkK44GXZ1/+wog==@vger.kernel.org
X-Gm-Message-State: AFuF++lYr0pUBvSKRq++UzISxRGe7deocXf+4iUmiaBY8mwB9H2mGfmH
	8UGLejTjQQLh/nbko+6lpZJxVgCalvK2FDCAaGUSrWXlxMCPmFWyA+IK
X-Gm-Gg: AYBFou3nbUAjAYg5uTAmF/sxet5QVxvg5YKCEOW//EoMR04e6JGzJQjM3v14JGhqnuY
	Qx/Bkj+wcJy9dgfXTImjHrldqLtB1M++f80c3AcGnwuwF+/VvEyBTjlLOKgnexdjN1xPHwN81iU
	WS1MwqZLshVCJHxlckyK+eX4JcwHomTw0sOr4+Ii2is6ZsMu4ul6rcVSpFZM8ZupaLWqSe5TCzD
	ynJi9bKLtWWRwaryLmUOp7h4marDDTYmiGAZK8kebb5JUHjAJRxlq0T+21GlGumWGXlE2Q1d3TL
	EzpuIo+DdVCbbNSPXUQVe43Xx37kQdO8VRSLcI8wPOIBhqQ3W5CXdvPRbKaBHe8hgmlJ8KtNoRu
	RGD0JjjqGMLSLp/9TQhkNkd7w8Xg0CUFWD/nX6g2A/jeUk9GoNovg+lDKH2+wNTLzTi4MS8RBbJ
	CiV9YsSHZ6f7LOu6cvyOwSZy7DwiPpc77BG7MQw6qCfJgtBfSFSLZk8crQHXf800yAn/33HKCAo
	4kMUCIylavGH9hcRSD9HzSk3CAj4xPddq9rhqp69X4ql9foXrXTgX3U9OQNWyiWV5IJ6guyiUiq
	HZCFC2/aIwu4SghK5OE=
X-Received: by 2002:a05:600c:3b21:b0:49f:bd3c:bc25 with SMTP id 5b1f17b1804b1-49fdf25486bmr26346245e9.32.1790160059852;
        Wed, 23 Sep 2026 03:40:59 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:885e:6ade:cc5e:a35e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm65170415e9.15.2026.09.23.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:40:59 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 1/8] watchdog: rzv2h: Use pm_runtime_put_sync()
Date: Wed, 23 Sep 2026 11:40:47 +0100
Message-ID: <20260923104054.3324830-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v5->v6:
- Used pm_runtime_put_sync() in rzv2h_wdt_stop() function.

v4->v5:
- New patch
---
 drivers/watchdog/rzv2h_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 83540dd9a37b..057b890de0b0 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -174,7 +174,7 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (priv->of_data->wdtdcr)
 		rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put(wdev->parent);
+	pm_runtime_put_sync(wdev->parent);
 
 	return 0;
 }
@@ -268,7 +268,7 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 
 	return 0;
 }
-- 
2.55.0

