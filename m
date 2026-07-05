Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5103815CC
	for <linux-watchdog@vger.kernel.org>; Sun,  5 Jul 2026 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260071; cv=none; b=bo24+V+aopI4m2/0cgUf/hySRIyzJqsSGUi2zwjFE25KAbbbx+8LPsCxe1i7eimrprQaHWdNCPPqMQBtrQ2Qc/ret35qN/4ztKU0LZCAsz8V8q0UOboCsr7msRqmW14wW/LAL7J7rjtmMr0oVJAFRDQY6HfNIKT+Jk4+BscJaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260071; c=relaxed/simple;
	bh=wtktcBb0elwPMxNsNeyK28wVa40Q4Q8PglfLTyE8noM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S38JpAPK+gqPRc+R3s0hOoBhA7E5BDenM4BfmncQMoIa309UwYbUCN3FWXjaX5SuNwimW3l7d8dJAyDjy/hU9EKo/kJmsBI/GBVsgXQmDKwWpVas12Tkhyw+/zquGD2e3d5bWD0fOaoq7YK9T7P4yX7lJZlVXDyWJqTGyqGA57o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS3dlMNg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS3dlMNg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so19023605e9.1
        for <linux-watchdog@vger.kernel.org>; Sun, 05 Jul 2026 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783260068; x=1783864868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcARrbs/xdLGk7+Pwn2pFBUUtRITiV3oWliffDjtOxk=;
        b=eS3dlMNg05RZEX+CzcpLOWHGw9AZ8538yUoRs5s7+owYCs3xLJP5CWySRZ2w9AYrlK
         gnZHN3UvTxdVPU8yTpfJYIEz8Lx1ug+nMXXoDrb3JrxB914PF4J06wPV1vmBeToBZIhc
         w7p3gS6ZsQzbFS3MzAED65pTx+5fANmnNKJzbL5NUrINlgpRZrpPAz48IrAmB6ZCMqmE
         yckGvYt/NfRXp0TkaFaqGIoyUky9qj3PlyuwEoIMeMWeNeLA+m9zq0HGTzpcCTjpz+GZ
         3Z34hD7lr/esmSwXPbkyRqKH1qjq2m1LXhc6ZwF+IO9Ecqu/OGJITXizSnvAjD6Ai1xm
         +RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783260068; x=1783864868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcARrbs/xdLGk7+Pwn2pFBUUtRITiV3oWliffDjtOxk=;
        b=oAZhwTJ06Mx3eLJ82LysI90qP+7tm92NeevlHtOP/kfjDFUAkRrnHsTccdXh2tKtkS
         x554Z/GaZc0GH1jRSQyfpsx3qXMMfhXRJiHC487XftFcTDx/cBp32DmadwkBGU1U8RGk
         XS3NiADPlJvn8+w8FRlAejdTO/EHAHxjPMVM9ci0T3tmXuhyKvZyukZ5GNFLVjTNTt21
         VZixILHzgMFKb80JT8zOb34SUtw1M5xUKhljteWDb/npPxpsSs/YRPHxe46fajFcm4Kg
         bQe/AOmzIusqvPAoyMsri7+UE9DxRQiZedZumL3vMStL/L2RTo6mOvuvBaTJdw5mRg8e
         237w==
X-Forwarded-Encrypted: i=1; AFNElJ9K0T9cEH4Rq2B2DghftWRAlH/VqCvWE62gvcR9ONsC5jregaElchPGf0ABhG+XiiVaUj79hXL44WoybjQ58Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJm8iAXTeosp11rF3qr9SniS9KT7hrPjgcqgBvXozUziY/RGd
	UscoUZtl4GooJh6S6YjtEDi6v4RjQnmJYGsXo6kPdKUzHS98esNUAPlN
X-Gm-Gg: AfdE7cnm+5fdWIa2BRHhH5viL2BhIxPYjhC+r235ewGi1Iwh36Qo1ja9cwYNBVm3SOE
	QpZXYTMjQxlmLQoFW8fwaKfWdMLhOCtk67oakigf6GeCd1zMRkLGSl2abYjMiZJMdMGEdVoQn+H
	6Pw6plgWerLywuTLM4//xZoKUgB9dhCU9h4uewE1fxRK6mLrQxh1CQKwfNuq+2mcTX80jMPA5AY
	5m8TlMllmnXOlqzgDl/LXZHs2qXSGZ6Q+qCBbl3sx63rfSk1ge0xnuN8+UttuW1/IREFwESsobW
	caEuGm8oilyTrriquSm2KcaGIgY0A3kChGzmJ4Fms+Z03PhSjGACr8aRrH3ixEJ27fnOTxNf86I
	Z9CbCvRfILLdyDHC92ytn+5WrZ/qZr2ynYWDzNF89rMnV3lOZ24+QVPKtNYNZS9SQi7aZOqOI9O
	A3ZtTnOZUk9+Isb2jTsonFSyo=
X-Received: by 2002:a05:600c:6792:b0:493:b4cf:d37f with SMTP id 5b1f17b1804b1-493d11d7dd2mr74212545e9.16.1783260068120;
        Sun, 05 Jul 2026 07:01:08 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm275911115e9.10.2026.07.05.07.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 07:01:07 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: watchdog: npcm: add GCR syscon property
Date: Sun,  5 Jul 2026 17:00:58 +0300
Message-Id: <20260705140100.1543486-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260705140100.1543486-1-tmaimon77@gmail.com>
References: <20260705140100.1543486-1-tmaimon77@gmail.com>
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
 .../devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
index 7aa30f5b5c49..99c225f166db 100644
--- a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
@@ -40,6 +40,12 @@ properties:
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

