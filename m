Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659645EF34
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188987; cv=none; b=gYKfCq8S8CFnKD6oIMQjjdMLc7hRr+2U+bp918j0cQmLNbv/e9V29cJicaXZvSTefu1WXx7K6Yf0O6lMPahHdAeN9xHsx+qT5v1XjlKlwD3DKhv4kp7b6RhW0v65SOB6T+el6+aKCGJlYbKWk7ERu0TBZ4hggOQnvLQI643SeOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188987; c=relaxed/simple;
	bh=USJi1mzL8+lPOcpSNRWr0Z3kEjLwRiOa7ngvLPjI/TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohyql7u11+1NwGrs7/AxbOJrjT9OCZH/M5BpAfMPay5066NerVM9+D7QgwStF/4bx78vzxO5YD4o8LXEEjzgoHQV34rcpz1SIwadv/EYynazukBSaHF34/zIW/pBZ8CL6qCav6pmYeLy50OtkyyyHgMAYxbpO/oA0sjEnBLeNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlvuCuPH; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlvuCuPH"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35f036b17easo1042471eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792188986; x=1792793786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7D3GGnuSg0CzAtbTEwk4pCTsYfF5JzaHvUW0xerr6zc=;
        b=nlvuCuPHnWXB84FmDro+crEVYnrpf8j5LWlh3WtRm6jV/xxRQXsGdxIhF5Anf1NYPH
         qh7nO0JCxykAKpYQKw3/0OvT+aAF5OgYpBIaY72mfyHP+vC5nL6xyfvbw7oy2xXaAOWm
         Gr/bp6/Vjd1qqlbCHWBZq7nHrmmZf5mCIPqeSEDyYVso5IuZ/85ZgntDnDRNkWH4o/Z/
         hIMI9jjd8ZeKOrY563XdIwufE8b9ckY5Dd/L4zyiRoFpz+MLtOfm/rZPy2mBNk0DIh60
         smqCCgxF160QxzJAAc/HOtFKATzVr7obBPNgIdTYaqGMQvrORrSpy+2an2vjDwfi01jQ
         cu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792188986; x=1792793786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7D3GGnuSg0CzAtbTEwk4pCTsYfF5JzaHvUW0xerr6zc=;
        b=LaDkG8206mz0MoBJrbgiFVM7n0D2DyXtDmV9AkU7hVBX7Wb/h9XCTaDmBJNDnp1sZG
         yjWlnuxgCMl4s+NeHPj3v6KV+FURkSkgJwvSwN/XhCuxw5cnjrI1IIeZ2spzYHi6PFgv
         m4vdthubzLnh2s6mOa2die1WuNyIxfx98EX8ZLCTePlQqplK9h9O/MlvIF2HBg8jS6kx
         kK+z8LHW46YAYeNln7bxZu9dBI8OLtCoENHxabo+Nig6KGzL01GzEKdSg4tv41o4PGC2
         8H5aCOObMh/MmZuhSgpVDJJUDblYH/f93IW47Vhnx6VjqDJIuLb+JhyI0k7hndN7u4Qt
         CKJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUSZRXMYPr9tUdRGbhrZaQFdrDNbITR95QEIvUQc7Ad5ICafOWGUgT5uFzALI2ty5/ENtuTWLZRIVsCY8tCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLJjrI3Vto3ekzcPwfjN+LxGwD4RssE3wW98J5dSLKEPDUST/lj
	vWu6FsuRMnMInRrvIcgU6TEyf1D1GN3/avnUcrvmq3F8GcREQPJWYlBo
X-Gm-Gg: AYBFou03zmqs4dmZboxHh3kSWDR2lfrT/wn9hmNBSpcrgYsQR4IUkrdgXCwK8UsjQKF
	BMe2K4pZlcAvJ9gyD/EonmOV7gsr3kMjmUYqqW4kmNVk2T6YFSrHkkZeQ8A1pGwa65vOuk53ogh
	HtpZg9hCIJf2AmmwhbqJIJo8cseoElM/HkV13adK92wqNcb5MqO5zvgcag52n8hOEQtzsSr03DR
	wfkS7eO7yvGrnnGNqL4qoQRIt1aHMlzL54iaYOusOWke1mbOZuq4rHU8XM/EGghLS2/QsDJtl5h
	saAKw5ylVKZIHMr+oMFPmTjCmK7PyWXr2N0g9+uj079JQFC/rUV0/DtSb50a+c7qYps7pIgb34U
	9LlUur17lNIcBjJvuujxspv2BtBHkyGwoNMha+XKFxziaVVZjy4qeFm6dtclgMUJoQZO8PWXery
	DYw6jznQNo1jnz8EcWN8nDlQuHCx39b2YsAFqoM/qRS6MqpXJMxp6xFwO5XW8bmLhdLpbuSA==
X-Received: by 2002:a05:7022:b057:10b0:163:8b44:902c with SMTP id a92af1059eb24-18512c37e50mr1582749c88.17.1792188985543;
        Fri, 16 Oct 2026 15:16:25 -0700 (PDT)
Received: from eldorado ([2600:8802:b00:1f84:d294:66ff:fe95:a98e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm10480863c88.6.2026.10.16.15.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:16:22 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	manuel.lauss@gmail.com
Subject: [PATCH 2/5] dt-bindings: watchdog: gpio: Describe minimum heartbeat intervals
Date: Fri, 16 Oct 2026 15:16:14 -0700
Message-ID: <20261016221617.2223004-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016221617.2223004-1-f.fainelli@gmail.com>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some GPIO-controlled watchdogs require a minimum interval between input
transitions. Add an optional hw-min-interval-ms property to describe this
constraint, allowing the watchdog core to defer early keepalives.

Also remove the 16-bit limit on hw_margin_ms. The generic GPIO driver has
no hardware register imposing this limit, and its heartbeat interval is
stored in an unsigned int. The MTX-1 watchdog has a nominal 100-second
hardware timeout and requires at least 1.6 seconds between transitions.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/watchdog/linux,wdt-gpio.yaml  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml b/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
index 499f1b7e03f9..1adbfe5e5461 100644
--- a/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
+++ b/Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
@@ -36,7 +36,12 @@ properties:
     description: Maximum time to reset watchdog circuit (milliseconds).
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 2
-    maximum: 65535
+
+  hw-min-interval-ms:
+    description:
+      Minimum time between watchdog resets in milliseconds. If omitted, the
+      watchdog can be reset at any time. Must be less than hw_margin_ms.
+    minimum: 1
 
   always-running:
     type: boolean
@@ -64,5 +69,7 @@ examples:
         compatible = "linux,wdt-gpio";
         gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
         hw_algo = "toggle";
-        hw_margin_ms = <1600>;
+        hw_margin_ms = <100000>;
+        hw-min-interval-ms = <1600>;
+        always-running;
     };
-- 
2.53.0

