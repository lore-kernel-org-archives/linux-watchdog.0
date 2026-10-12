Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A44766AB
	for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799797; cv=none; b=K/WP/1alYDsv+BvJYPQsJvl+Bu6a44odefKXxzjlf3kZ4lwj+AY+PY7dAF5KXqi10vpEG/jZ/xMhQ/h9KT0Fq6etadnMWV0CkEmhTBqfzijxbmPEhBns0CxzBBFBu76n0nW+yjqO6WEoZNF+JTqcZVtTcb6TLLgjmyxnNBlV0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799797; c=relaxed/simple;
	bh=GdBr63/reP3Wl9EB+qPXsBbASaozd7eVeU8Brd8bmQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMXhgesJUuJ/X28KIW/WuPIi/ylxaxVpaOUQEEhDPOZBnZvJDD0HqKd/lUR+9cUhNClxdE1YGiu22Q+BJH0GxrJ3hwvq83VIjO7whB7u72fY6VmS3+uS0lQXHkHzUUvUxFF6zzLutz7KaKGxPDVYC0LcG2Km+Y+r2QAq275qgzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q23PGFPP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q23PGFPP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49e73611928so23196495e9.1
        for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799784; x=1792404584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W68ZhWpdb/C/lOojsWavHUEouXSEUpAyq/d2Jk7bb08=;
        b=q23PGFPPozSr/KCXj3cm7fVXgqLqwXIcadbZmO20DR6tcdwCKBrYEv4U+PvELrr0cW
         5dScVZWjrmZv+DQabTlbLfA2RdRHwJIl+PE/kckGH6P9lJ84Gkq2ORKF8f/e8/3/Xdi5
         lsdStmU17MS5yk3XEtnb8OeQ6Ek5pt8FNsfMnqgZip9YrexwXivi5qsD6HP0uzTm1HcW
         lxtXgeqXAu30yO47GJXDNqafYSPjNEoe0ADRd2HGrbQUlSPA9sAkwxv3Zw/2aKEPBpRc
         2xTGtdL4DJO3CAAoP3lMBbcuGbBLM8aYZ1x+XQK/B659GvhZvsEM+42x2QuvRT7HtTAo
         PLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799784; x=1792404584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W68ZhWpdb/C/lOojsWavHUEouXSEUpAyq/d2Jk7bb08=;
        b=numoFcPSY33J+kUFitCRuzBXMsAp+W1xtsqFn8dC44VZgzIJ2zckfQlxvykiEkbXlD
         a7Cn3kBlQ2xI/UsSBwJhtwkDGmUkzttXC9gqqDhEa7P57f/FonPMtnekm1H5Wch81V3+
         psBKPb4I9AYlfX1PXTti0qRokLxcFiRg15giNxzoypO73EzDuCdtSvbBGnzCsJ/E4BDY
         X7ConTSjwa6NP25zPXf2jqkJJBcyUdS04441Dsi0tHkxpfnxjYRuZTarpebBKokJA95B
         F6GkwTatZv4CtlgT1AHWQTal4wWsi+dtCTSKkInG1t4rb2RtkxvXvOCnB3hN3kQMr7xa
         ic7A==
X-Forwarded-Encrypted: i=1; AKwUvBwF1uJJdcrGTFaGAliGuYQDQ7aqw7q9iVyo9wt3FpFFOnA5sdViF5/WaLQS3cVbiR+JSjmq+4MZgHZhbsq5xg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJwF6nGXoCyp+14RyR/KNXY8GTfkgLixvOEzCM9NozB/BqLv+AK
	ewYeKCFQyV+llCwZww8DF8XfXs8h9S2YkI0rvfdm4Wt9ILhUuCfjSVTH
X-Gm-Gg: AYBFou0g3iuCU+B36vAJn0O8NwssBkXbjnF8EwSp69GGPu5Po2h6ymBY1LU25rMIFSo
	493621UzTPPTdFlB9IjBi0IgvFil/UpfYFG6egvMntIfYKlSMk3kPfAr8VyY6MyjKM3eHFHXL9j
	XAIgAOD9R/HX1dFnY+EGI/gy9Cxx1pIINPfIAnLahB0jCrt1wjunO1jboFHzJblJKbysKKXrM5O
	H+r0CvTb6knd1lsrwx8FIJes91dnxKcAr2Eg6yLWPGNeq/ea+1Wk80n1xfrne5M4pQJEI4Kya26
	ZCFjDO3mmnXsFihWr1leMj00cL5x+pjcC+f6wxPk2Wbb38YKz3BjeL34KSf5BAnms2wrgfz572v
	pisL/QtW+c5ZdW0ssfrpGeKP0eP+Vr+zyu7nFfgMNQTsyWT8+K+k0pbE9iE0mFLu6x1O056U2YQ
	BEIEvISjPLJeJJNiZeFDWjtyzf8sYWyUuH3Cju+T5KExLhMmGkfldGR/ym9LcjL6QDALBLO0Mer
	C+rUw1CcgfCskb5Hl6D4YPPBysNAxVC
X-Received: by 2002:a05:600c:3e0b:b0:49f:fbad:29ae with SMTP id 5b1f17b1804b1-4a18e4b1311mr160592305e9.17.1791799783597;
        Mon, 12 Oct 2026 03:09:43 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a192d3efb6sm166229885e9.1.2026.10.12.03.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:09:43 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v4 09/11] dt-bindings: watchdog: sun4i-a10-wdt: add Allwinner B288
Date: Mon, 12 Oct 2026 11:08:14 +0100
Message-ID: <20261012100816.331033-10-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012100816.331033-1-pmazzini@gmail.com>
References: <20261012100816.331033-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same watchdog as the A31, which it falls back to.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
index b35ac03d5172..b70a6b45a33d 100644
--- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
@@ -20,6 +20,7 @@ properties:
       - const: allwinner,sun6i-a31-wdt
       - items:
           - enum:
+              - allwinner,sun8i-b288-wdt
               - allwinner,sun50i-a64-wdt
               - allwinner,sun50i-a100-wdt
               - allwinner,sun50i-h6-wdt
-- 
2.52.0

