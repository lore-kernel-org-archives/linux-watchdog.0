Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596870;
	b=ZgVgFwkwn5MkpwCsI6Ht4Vgr0m2cnjCIouA/CK5hldXIQQt1NiXTNgHlHRpz40EBa2iX
	 2SbLbVXml2nBBIR0RKM8G0Fp9fk7lj2hgbLm42pS90Ek1Eg+f3roTuSlZvnlv10a7yPeX
	 UxiqhLYNhJBRcl3ZoQnc5Glvd3Z1w+yxtt2xbiP7yZSNpdN9PBSdTV2KW+oKeUYw3S4GX
	 kN0K0HLN0TaISaZGgz/VnCyAp1/JmDMyr0MWHzGmDPqc7N6pYxpTy5YbzydcEQrfedU18
	 8XjT0Npye4q7WhYOMsRVH8tU1uKqcZ0yPHhN227s/awhgCghoPGqRJHAyfS3Ff6cBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
	b=2HdY7R+RRXGc6OjkadA43D1xjwTKEUkP2wGdYkiOjX0rY0t7OWtyixLiL2EBa/7p3hnR
	 e616+CDSC259RSpew1oJK1xJM2P9b6QUx0Y6gSG61rEZXMlcQPjUPTWCU7fRDlITSnbId
	 vjqOkaCJxhLjqiyfWECNiJTNM0oPWgyOJNNvcFcbHmQD55RlOEPzr8WA9K2a6ewjF71Nt
	 BFeh3kD1ImEBND0ymbGvGW5YM/7dlh8q69/VsIgNMTN/ErxH53J5mNCF+NXNOQrdr0bKD
	 OxASs5WsTCmWw6t2tXsfV5s4/BK2v0j330KZwxm6i4iH02BQvESLS/vFIfMbcGFC6Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rE2u3Ig9;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E663606A323
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 19:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E663606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rE2u3Ig9
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c506a231b88so233039866b.3
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596868; x=1795201668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=rE2u3Ig9QQmvYdO4meupm38R07509KcJIbOAEE8bkGwjMEOVzVv0JJLzRE37Peidsb
         smpNCeOpTI7ROICLLY5L90EV6xSGREQ/ui4lN8ruSeUYnNG4G3X9tiX6tmBDjD4S+rmA
         EJ+gM48JWQjmSoetmjwKebkBu1/6kW1rn3mdQb8JgRGM1t922TkimGEZMcSERFZuIPXi
         452eL4fN1PQASGBc2YGLxX4d6X09AtHZIOSnl2GtlrSWA8UO0+oSOyfyLdzIXzzzqMTS
         vEBgWlzFFtez3312Bw35huiUspC7CzTPnn3dJJdqQugkUMAD1AMnk+Aob0x4KYw0XNBZ
         gFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596868; x=1795201668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=bxXXR3Kaghjrk8nVTLy7K0dgMMrA0OOoGyx9mgryt5+UlzxfLtPV52o6CvXPCubQ26
         sX71n6FetM4WUpq0CBozqJ9teIVxPgbtpOOHSGppnY2yBxdMiXueXh7hoDqpDoX3sFHB
         kmVwEIuFU/mZG5G+wYH/a+4B/sjyMobqCGJMm5gXN/OscJlznLnORwmnEg05kdtjr+Ad
         Taxzi9x3a2QLbUJVdjPzjVIAucyWrgzS+iaC1jLXfUJ3TVNgVMVciFRTnAgZNOdUEIr3
         AXep4kvE9z2ypv/KJl7v9d6tTWjzNyn4oPAXFkwJMtnZBBLhun5YGEK5KuvzdNLvGUnZ
         3cSw==
X-Forwarded-Encrypted: i=1; AL+hErH+Mo2w/srpqYXTChlrQDZhlVkuAaL9mB5+XI7Y9yP+daPWVee+Mx8M7Q1myzzmiURPNMY/PPbpCexT95v/oA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+ZqqfLqsQwWyT6mayQnjJJau3sLFlhNvtcTa8KSZZqNkzYsGQ
	JYJAcAYOHUKfFtrbogErCvRCuIAxJm/s3P4YlKj0MzKNitc3lH0hv3wGiS9GtqP9yvak2A==
X-Gm-Gg: AYBFou3QMBj6QzW/DP9OhwmFnYE0ThOh0C/nythyKDIewUNfYmGxXJvlSCfyDPv3QEB
	0U9c3r+XbA1UnMMHJIf0W16yqdFNPu3pmMDXQ6PUJVbprNVgBBqJwHxCf29iDs96bYwVI6hUR0Z
	LaVJW2BinZuNbJ5NQm08bQ/ymEpA8WdEWoo1KXR8V+MlS/QuXiQ6G6yWV3whZP5huPlFfIgx7fQ
	ENMXn2yAm6Eb441hxGE+rKi12i/BOR5+BeVMF2oHgyUQQtkYmhKDYy2cM/ToPJmqUUfnJ9cjU41
	w/yMHKJudbeV4Q0w2QuhHdARCUprrgCDlWPQZc4jgkW8VX/gUbZhB3opr8v+tLEdkLk+CFzC6/R
	4UEyFanhbcYbtJF+if38bymKTQm35YzifVs9HbGFSUZ934xNqrs9VssdJxp6hRL/9xLi6wu6hB0
	d1gMnOHZNAuK1LbiZl23bpyyoOvN6sxXJSoT8tVlBWqKj9SkljdsYwonDs6wA22zEg8LHP2OpAg
	jRHG/k+5rCIuuY53PrEhC+DzgSHP8+sw/AVO3nl087efp1qiJVi+cqGKJhpxcK0+iALWJ8R7Qs4
	6XwqRFu/DOfiAfvBWCofnevRnLlU/hkzjGNXc4vI0zz8EPifsVXYMvOGR6NW/ksV
X-Received: by 2002:a17:907:2d8a:b0:c40:cee7:3918 with SMTP id a640c23a62f3a-c509683f389mr411823466b.44.1794596867571;
        Fri, 13 Nov 2026 11:07:47 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:46 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:04:58 +0300
Subject: [PATCH v2 2/9] dt-bindings: serial: mediatek,uart: Add compatible
 for MT6895
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-initial-mt6895-v2-2-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the UART of the MediaTek MT6895 (Dimensity
8000/8100) SoC. It works with the existing driver through the
mediatek,mt6577-uart fallback.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0..a3969cfdea7e 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -35,6 +35,7 @@ properties:
               - mediatek,mt6795-uart
               - mediatek,mt6797-uart
               - mediatek,mt6893-uart
+              - mediatek,mt6895-uart
               - mediatek,mt7622-uart
               - mediatek,mt7623-uart
               - mediatek,mt7629-uart

-- 
2.56.0

