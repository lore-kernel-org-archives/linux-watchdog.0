Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F82459FE
	for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117075; cv=none; b=Z3e4rRjEXq49FF6BSSSCE2sIgUSe5E19KG6MNLeHd9tzoRXQn6jntFwiSZ8thSqpYIGhXUnB0cJqDUdOfrSsNb1R27ItpamnlSi5oJjmCX/RCKB3+h0R85VxAMG3kLKHZfUYvhhSgKTkvh8LRb8tcfkLj2/Mp9Lb3+FWlMVJ1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117075; c=relaxed/simple;
	bh=dp5DXrFD/VR2Pf30vi6TU4vpA2bUKis58HF5l5/23sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rz4+VHGZB5GgbR8ALpVynuieDl+Ttqx0mKbgL6GRJ9EOVUVMwok2EMG1MOdBCI8F3cmpa07WZHCmpxm9Bumk/jKDIf59toqWpjmhIBPb8PQKq1nIolw2SyMf1j56/3MBUueFI0fGr3fYitMNFNBXHoqnYZwpB1VPaSW54DDAKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtsOO3la; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtsOO3la"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so23735975e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Jun 2026 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117070; x=1782721870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTDgjvJHAETxnjltFNDifT9VJeCgqwN34Z2RGXGG7KE=;
        b=gtsOO3laBFWa7hQTUMYkOvrzhkoYZXn+VmP2rBo/+4Uh/aXkGXkU8tucRzrLcpiWvx
         E0isk6POZnFrNML12z8RURsSJlmKSAplQTQYTadOv+0ySbk2vwk9pbjE51IuvsWwGJcA
         bMrQo2RzeMqv7WDInMuJ63DvHsGasvs+y8kNHQP7pIOaVEhGDTNlUTVhyFGNtB9oSuht
         ++xO1efYEFtF0tUIaHDs3+pxBlvYe0HkttKEADIBryT0F27x6hv53PHTSAxnLItMiZ//
         3i4eufpySJ3HEob0Oi7balf9BHVLwgkfBEI/pXpsHyvIBetJ+ja+ugMfmuESV2idE3jr
         Rxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117070; x=1782721870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lTDgjvJHAETxnjltFNDifT9VJeCgqwN34Z2RGXGG7KE=;
        b=dZ3JtmwFEivcJXjfS1yKkUOvCCqu3yTAe2pEO3joEqGmfewBeeO2+JoscMrvPD0KeG
         aEFj/ioSAVYJogrtc+1zVHJt48Xfrm3OdAhZmYGxwnWRg/EvJAPPk/r4yL7QObjJy2Ll
         JLXekCNI4ZhlSv1nZLd214Y4Fo3dhTdiFPWerQ6OCVzjdSt1DOyh0SvsefpJNI6zym9n
         FOdTlouILrOCY9HBvQn+2CLAIjKFgdnuc5rif662InyJZ3mIYd9bZvDWyjsA5ZPdVSzP
         ylSEs4y04/dqlEdOfqPVbgrTpAga6PSG5ijP3DbqosyXTMjyhQf0C8oxgLWV1JwRQRot
         aTOg==
X-Forwarded-Encrypted: i=1; AFNElJ+t4cNa+4M4mrt6R4O6YPDAz3Z86LIVJ/QspwXPFUf0+ItMojLnQUwahyjCi/iISXkd9j3Q37N7ETGiARc3Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYKcnOmAAdukEQrtrGCWjdFxE11xEx2FXp3Xm3/5tSY2CIoaM
	Joa5xZPPKzoh9s5cjXZRPdMO4fw8JoSwJWI/IFlhJK8kAlB0ArB4qPjyia2ybQ==
X-Gm-Gg: AfdE7ckDUyok5BqaVIipgOCLTP7jFnfbsm2hiEMW22S1St11jAxy5YHcCv68bgv5z41
	hSBeb2P9rLF8wJvu7tQVX/ehd1Xlzju3ZGrCz/TY+IdZc3P2jemT8Bjc7vVfO/J4tBP3AzH8ZU+
	u14/MsKUuPzYGFN5yW61yB4LeLdK6a4C8VJZSiPflkGyjm9JHE8OWjaPTdUcZWFakBnbw29J9Lt
	jk7hkTGttKIuk5V2te6b5l0daDqcfHeHyjRm/kcvyfx9dA4Ip6uUtMf8/Q84Bhf6XnGt0Y4qdGM
	9XTzoYuxEUAYAL/9D6hrvr4P4Pk/wUDL86C/UoCuOgS7eGcIA8HaurcojYqxaRaodqMS3SGWaCF
	rA4nEDzVH3JDd3kppaHIb4tUcyuxtfZiJ9JXKpleH22S32CaKvLwHvh0DpuWcUAg+WiP9fpBa3P
	Bsz5/gejq/zAx/dmwgqofggnM=
X-Received: by 2002:a05:600c:5285:b0:492:4640:cf59 with SMTP id 5b1f17b1804b1-4924640cf67mr192104875e9.36.1782117069622;
        Mon, 22 Jun 2026 01:31:09 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm200809105e9.11.2026.06.22.01.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:31:09 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: watchdog: npcm: add GCR syscon property
Date: Mon, 22 Jun 2026 11:30:44 +0300
Message-Id: <20260622083046.3189603-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622083046.3189603-1-tmaimon77@gmail.com>
References: <20260622083046.3189603-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe syscon property that handles general control registers (GCR) in
Nuvoton BMC NPCM watchdog driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
index 7aa30f5b5c49..4f00f099b2d2 100644
--- a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
@@ -40,6 +40,12 @@ properties:
   clock-frequency:
     description: Frequency in Hz of the clock that drives the NPCM timer.
 
+  nuvoton,sysgcr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      a phandle to access GCR registers on NPCM750 and NPCM845 watchdog
+      instances.
+
 required:
   - compatible
   - reg
-- 
2.34.1

