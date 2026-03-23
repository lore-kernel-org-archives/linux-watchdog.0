Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2872D3C661C
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288836; cv=none; b=tkL/woGjMwLU+JSDCg3wvX9zyB8YGMy0HY1CGQjRFCFdzfiN31UTalnxpq8csbujvcLwJGVtWvVts1O/d2L08RyI2yrSB0ftqC2nNzv0ygsFO14zBE7E7Px94tx9pkIpI4Z9KbqbIVEDg5PFCkpWyXjsWgRXFNS3KkcMU7layaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288836; c=relaxed/simple;
	bh=LLPiwF7UGY6nyiXVOwJgMlw8Nb26M+J/LVNn0ejXn6I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgUC4kCXWRqMUf8LRctIw/QePpl32SkCyZ2Qbe6CltnilFqre+76MHhEhd6Mhzu3k9H87lfc3I3t/ggBnpqYQYtYETXqQpFuk/BKlaht/8AjfXrR/rAOqvQrmNmeYlB/E7v6OwvgGoYxYGmQ9WsaF4oCREW+m7VimTGX4ctODhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG/v+o/n; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG/v+o/n"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48538c5956bso41614885e9.0
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774288833; x=1774893633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vg+jkqcoVNFNI7ndmig89tjt/SoHh62XMKbUf5COJgE=;
        b=RG/v+o/n3QCZFPdwO3KEr67CEEdOanZH3dXPiz12s55L4fiUfO2MLjvY8x/fksE5yk
         D5se+E/sLBhwNCH83YUzTq276JqQSktU75IaPi2zplUbjbjJAJ4pboEnBJExizTAgw34
         Sw/eYKad9u32rKrhepNMD1gLMmh3UPD9sq6SvxhG21k0Fy0Oej+V0yS8Zb0QFxPkPMef
         g7JNwMOkbLv3OVqrPyBfb67f1/TvxHmimu/BthHUVaDuF0N53SEhcwC3w4YwY8DbQHby
         0B4jojNXLyobL648KRCvAylCl9t3Gg7/xpBndoCa80dZnXqZLlMry7tnvCDwQpEpJCCB
         N5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288833; x=1774893633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vg+jkqcoVNFNI7ndmig89tjt/SoHh62XMKbUf5COJgE=;
        b=KVtn6GeKazdawWR3PPB+8LNJbFIt1xGzv6mSo62Hs9ermCcGyasb1xLfwFWkuP2xj3
         zg5DusPZNo3z3l4J/n9vYLR3q9E44LTs3RjxR2V1s9hUyNoKYhFdQH0pmbb/6zGO5em0
         JaZxuOlTV+wsx6a17BZ3g43cvg/grDa4LxegqewsRWsmLxYoOT6ESYeX9c1ikvsIRtwf
         W5ztggEZ7lK8sCqCnTT1YIVnjEx6hZN6U/bJWFvPGrdR4dTFq7BNcrGk3VXZ0e5BkZlc
         2vTNQx2EajXJBnzi1j4m5v0Smi657QXF3kg6yuZI4RVDEjBWba4g5y7aHRYRRbPTP0b9
         cifw==
X-Forwarded-Encrypted: i=1; AJvYcCXkgVo+gqHtw+tppkAhEbfi7RUXFeZKvXDj+qk4SLlMPP5uuhDZp98wZ1OSLMPqGB8qDiOqrk6Ts7s2StqtZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2sZ+xSjsXg3eMqWaoQfxtRugv5obXQ2aN4m2H562kQE12Kt3Y
	0YFXzUpIaJikHhuXe1ce0RInyYDkrS1RCAdfvFXl4LwJSqqcXBk001Hb
X-Gm-Gg: ATEYQzxzEK2cyFMU+QggnS2B7/EqiYD7vqcsOtNjYaW1QcvjNW4Wy5A0dxsb935ClfC
	uXvuaEIaUqSqo8mkXVi8mVdtSOsLLYbpQ+rUcIw+qz3cTjsxSYNj46t+RHRt9aZcT3NCMuc5ip5
	DKMmzCYFWFaJIqrQhK0nnJWhJEhuX0KCgJdrbjf4p8FeOJHkb88NKFns5qTgIzUnlwLSkvtXTsy
	T+fzb7sArjjkuUwB75teMamXMeilh6aIOUDUa8F16gDguoF4hdPV5UHn6I29rq1XpnFhQwCzYWL
	3f5XZ+2rOv2JesRCYxgmIFfUBLIsuaHE/IFbX7niFfPqmuyhO0jXVsQTTuKG1lHnwGrm1HXBBT+
	tce7IdDPsV7tBiFtcX/k/pEIR4YHmXtm0PNcxFGWBKYZ7Fy1KfSedr+WId+LFv8DloPfvqWrfyj
	bgsG9l7TFgb5Ud
X-Received: by 2002:a05:600c:1d02:b0:487:12c:e7ea with SMTP id 5b1f17b1804b1-4870f1f40f8mr7506315e9.5.1774288833279;
        Mon, 23 Mar 2026 11:00:33 -0700 (PDT)
Received: from fedora ([82.77.79.23])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486ff1d3befsm84419925e9.32.2026.03.23.11.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:00:32 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	egbostina@gmail.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: watchdog: Convert TS-4800 to DT schema
Date: Mon, 23 Mar 2026 19:59:44 +0200
Message-ID: <20260323175948.302441-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323175948.302441-1-egbostina@gmail.com>
References: <20260323175948.302441-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Technologic Systems TS-4800 watchdog timer bindings
to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 .../watchdog/technologic,ts4800-wdt.yaml      | 40 +++++++++++++++++++
 .../bindings/watchdog/ts4800-wdt.txt          | 25 ------------
 2 files changed, 40 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml b/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
new file mode 100644
index 000000000..5c2541ac6
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/technologic,ts4800-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Technologic Systems TS-4800 Watchdog
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+properties:
+  compatible:
+    const: technologic,ts4800-wdt
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the FPGA's syscon
+          - description: Offset to the watchdog register
+    description: Phandle / integers array that points to the syscon node which
+      describes the FPGA's syscon registers.
+
+required:
+  - compatible
+  - syscon
+
+allOf:
+  - $ref: watchdog.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+      watchdog {
+        compatible = "technologic,ts4800-wdt";
+        syscon = <&syscon 0xe>;
+        timeout-sec = <10>;
+      };
diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
deleted file mode 100644
index 8f6caad42..000000000
--- a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Technologic Systems Watchdog
-
-Required properties:
-- compatible: must be "technologic,ts4800-wdt"
-- syscon: phandle / integer array that points to the syscon node which
-          describes the FPGA's syscon registers.
-          - phandle to FPGA's syscon
-          - offset to the watchdog register
-
-Optional property:
-- timeout-sec: contains the watchdog timeout in seconds.
-
-Example:
-
-syscon: syscon@b0010000 {
-	compatible = "syscon", "simple-mfd";
-	reg = <0xb0010000 0x3d>;
-	reg-io-width = <2>;
-
-	wdt@e {
-		compatible = "technologic,ts4800-wdt";
-		syscon = <&syscon 0xe>;
-		timeout-sec = <10>;
-	};
-}
-- 
2.53.0

