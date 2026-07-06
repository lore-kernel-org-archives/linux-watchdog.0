Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82AA3A7F41
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349320; cv=none; b=EvFRRb9nhLZXjUR/gfjXITiZ1/CZWaK0xI5q77bKgd4092biqgF3JPk+hjDCNuCQH/gL2eRX0Uldocd9Kw8o3a2iQg3tjRTptV95OBcqG21T4693LOqT91skW4xT5Lg5qYc5Zl13GyjlyLE9hAicS1muC/E0VYoNcthtvKCntec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349320; c=relaxed/simple;
	bh=JUJG5Grow4ynAAXlgwL43WqrOFCddT6+gQAxPmGjgds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVTmaLjnKEe+p/61arcOF4Dyv/Iz/ffYecZlULxsslN1SEZRnpZeKyh/hwU50+PjglSgskSj4U1/yCyM6wHVJZsMwhFEqKHfS6rCK2kbivZf4V0jnnE+q5/OtbmY2avV6WEcNTma96S/ToRAK8CeMVUhh+lj4oUyo3Uck9r92UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bENr7Prm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bENr7Prm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4720d22c94aso3087896f8f.1
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783349317; x=1783954117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqvnsBC1QnHy0BgYcjusDNjgJMCaD3QUZ4+Za8Z0104=;
        b=bENr7PrmgS7b57cOFH1CvyEzupl31QFfsdXmZNnifkjqtaKB0pkaIVrVhEzNK33CwO
         RBmNqjWHh/TTn4PojZ+AeavMTPQfzVR6tq8l2e17HuLvpa2K8PxRfOEHY6870GXQ+070
         9mNWbqRrGvYRLNd3/L6ua/CeEDXe8qeXuur4TjaBgH1+CzBrV/UU9aMkWZ/oMf+3uVfX
         VxZQtwEtKZJiaiP+Rh6M5Uw2gibdHdNbfYjzAG53j7+ZITgviZsOjarShD0iE9X1/hH3
         NqFbaokMZ1ckotDALUJ0CvCQe4g06Xqa+JfKJeyWe5fig3D29L6ASWWrqBknfVen5uQU
         gm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349317; x=1783954117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jqvnsBC1QnHy0BgYcjusDNjgJMCaD3QUZ4+Za8Z0104=;
        b=AdgtBtNeNds4DKf3dlq9dyR+4cZGEo+y/jyRoKLF+lAmHPW8EoMcOzLd4JyezQBAse
         sLcIB9UXeGqQgNBpagcTGj0zf2xvnUfkKZoj+mKO/OLlHfBXcywuBzdL2fdUKbq6gnKk
         re6Kg8Ly6SF/GF1Jyvfl8qx+fe20FmQ+LYLvHcb6ST66pUzYwY0AdhP24kbbJukRNrJo
         YK30h73ieg7gPgtRxlv5NicEKFEERhlj9Z+k3SVdjDJBaTreaYxQHXeqf+iSA30ieN9q
         UCHiCUy1y4MwN07t4OO8RGzTNtgoZHFiG9GnCnpatgXY16sidVxQR0W5La+9QYL3oZai
         znRg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0b7arP+DKDaDQtoqMEVf+hUUVWfma28ZGqJIF7T+93MiTXVYRNtqomGKUV6TJWMOZmL+YeKxxMnbjcyRTiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Px4TUpVk9lpPZawQl8yuVOgYjVgDoexh/9xwMXWFpmDgM+S+
	an18Gq8mYs/+IiMYTjyugCDkQThxfO4kec5T5xUt5FASY+RjLwi3l1xd
X-Gm-Gg: AfdE7ckOoz1gBXvJOF3k0QsKxaPmLAGLvaw3U1Zx0LZKy8JLIUw+/XXweTfS6TX9TYe
	8lTyaaTlAiyq39EvoKg6MMuw+LI++eNpvmFp9aV0NZBsw8quIx89XYNRFRSULcow1lSsaLBU1vP
	4eYTGb1jdZorcor0657JDzfGkKmlpUrcRafY0HkV/x/D4h/m79Hc43BxJCow/1URd2Dmj9e1Gf+
	9wW1XPG4uvm7bATUoIZktLz0GFOoCGfG6s7SgIMDMZqKkzmtA3rCMaimlcgJ/Z7DQVoRuD3w6hn
	odO7xaxY7LKFqmG2jCl+kCmIN4mzSYc14O6m2R+DercUUEyGxMLShrMrxvlGXynaWhK4VKqzEaU
	t/K8r2Wdq58a3vJGtO+2SnXF7tlmT15nCRii9zyXXCjkwnI2yBy68QbbnVfoGKYnyydUneC29/Y
	SwQgCIFei18In+i1peYqoaGgnyIDEKcvt0xg==
X-Received: by 2002:a05:6000:186e:b0:476:d52b:b85 with SMTP id ffacd0b85a97d-47de6695ff5mr680196f8f.16.1783349317101;
        Mon, 06 Jul 2026 07:48:37 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm26798473f8f.26.2026.07.06.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:48:36 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: andrew@codeconstruct.com.au,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	joel@jms.id.au
Subject: [PATCH v4 1/3] dt-bindings: watchdog: npcm: add GCR syscon property
Date: Mon,  6 Jul 2026 17:48:26 +0300
Message-Id: <20260706144828.3517631-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706144828.3517631-1-tmaimon77@gmail.com>
References: <20260706144828.3517631-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NPCM750 and NPCM845 latch watchdog reset indications in the SoC
GCR block rather than in the watchdog block itself.

Add the optional nuvoton,sysgcr phandle so watchdog nodes can
reference the shared GCR reset-status registers that hold those
latched watchdog reset indications.

This is needed by the following reset-status support, which reads
those latches and reports watchdog-caused resets through bootstatus.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/watchdog/nuvoton,npcm750-wdt.yaml     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
index 7aa30f5b5c49..81269fdc81a5 100644
--- a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
@@ -16,6 +16,14 @@ description:
 
 allOf:
   - $ref: watchdog.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nuvoton,wpcm450-wdt
+    then:
+      properties:
+        nuvoton,sysgcr: false
 
 properties:
   compatible:
@@ -40,6 +48,12 @@ properties:
   clock-frequency:
     description: Frequency in Hz of the clock that drives the NPCM timer.
 
+  nuvoton,sysgcr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      a phandle to access the GCR reset-status registers that latch
+      watchdog reset indications on NPCM750 and NPCM845.
+
 required:
   - compatible
   - reg
-- 
2.34.1

