Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795496484;
	b=d8Xp6gy6ZidtCGHX7AbHluGw8ywbaumu3A1shnbKS06RqTZtD9M/qN2R1rIfFrUIaGQS
	 NhFgyG8h+OD3z5vGb92SFRHptaFZY8K/KIbE2nlUFQ6iE4eb+GusYhqgAMTDUwYLkZuW3
	 /WPsw1dgbWGjwSxhB8+ZTkikJtsg6td+Lv6jr26C5CMUHPNYNVwIp4c1pIW67qo81IRBp
	 VXZIrpVfH4M5dRtjLMRkLXEROdAw7/SVawzsIhAl2nDnxQBhEb4WbcUDMtqyAwDmvMGwC
	 YNLXeN+3f9ZMdo4VAHoeVxbeWGexiaZIeevxdrg4rNyfWueT89thvXS3fIuAL7/ZSfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795496484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ktgJZX8JcFhhcfmNRdxV4CsSaV1czgWtlUVf7nzy85g=;
	b=fkfJR2M5qhKhrV9b6hiul0ZY2ydDD068xNADW6i5TNsxXSv3124wLM94EsU0hrBxi61H
	 UCOGJPgZE+1/M6fbqjgnGZfeSejW7g5QHmeU4elsTO1rGROySHpTYximLWmrt2gSJ923z
	 xPOUo2Q0AiZFj9ct7GwWGycr0BGUsJcX2C4sw3Q/4EzgLlb5/J6kgf5PWVyzmXdcIIa+a
	 w83AA6KYMjpVTWbELcX60RO+39VBgRJEu1M9FvWwlNWJNuLatmqGgkO9ob7+kKyV2UbBi
	 nXiGiuA+tu/Jm3Ovrq7DQncyGrYtK2hBZesVESkP3VnGw77jABAOy7UXvvs0eeFq7Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fFwW39wk;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FB606A331
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 05:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD1FB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fFwW39wk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso38870005e9.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 21:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795496482; x=1796101282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ktgJZX8JcFhhcfmNRdxV4CsSaV1czgWtlUVf7nzy85g=;
        b=fFwW39wke2UeMDCDyevcDa0QjkORf9/JkWrBApvM1whIeu/MT3idKy4WebrycEYBil
         tC+PUgojm8iYFB5tml3gP3Q5qoYXeQZLfjCRIcTphSyDUmzKxadrvPT3vj3QH3QQ/6f3
         DigN9ccmvY0F7qid5AISIGgJ6jCHfwK5u7s0G01YvulQAgnFvxZbnWptKFZbge5hkMy+
         30OCIlQMWrmeabbQ4o0X2dvLQ/rY7Ecz4yFfTIZPx1Z95fkIKxUY3cPHHJtjjpUwQWTH
         vGCluAYEbrh30LWxsvE4Jk1SBFOZFMa23dsMc4K+wj1Ixf9CaxWfROVbATpuhAxiwU6L
         ozdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795496482; x=1796101282;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ktgJZX8JcFhhcfmNRdxV4CsSaV1czgWtlUVf7nzy85g=;
        b=Tav03jkaPpBv2CHryNrxVAkervnSQasmbSbBlVY67xPechgcrdUSXh31295l1eTKQP
         ikVvgBXqIv9aZk3dk476rCdH+e2tJ2Oujebow6BcsDWyp1mCmL7AhNVbWiq23mZSH8Hi
         LOLR0yj0Wiu4W16bvC73/SS6AlX2+OXZp+CVq7DtQBntH28gacSbfEg7Yr3aYnEQgxNE
         +m3v6RyEtMpropBmFJ2VSGm1lR3oreDHlL01r9ZzuAsgjlFPWuAGZvlppzNbYW3tGt8r
         YVjtjSYvHaoCGAO6nKbxkg1T4LiPb87RRFbe95RVjYcW4aBIwoT6GmY/1hmBFZ2+HOWl
         fRzg==
X-Forwarded-Encrypted: i=1; AL+hErEnt0tITfUJ4A/z1Q0vQeWsuP2Tzy+KZxhQMKU/VhdUKj7cfs5mOA80QNe7yNd2VF6+ikK+zDoMFqQMgp4C0A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/kOUVJ/Cuaxp179J08He3j85/K7i+Ccj8UR4tdtFVeVbWuce+K
	xgyvfCDOQKMnw+qcUV7fYfdfzCkGpXpAL5EUBRtbIYLwbWX5ido3wuS5
X-Gm-Gg: AZFdTZc8fIqjS/9/hcBCAdQ8isFgShva/URi4BJ/oiKYtjyYjfSrVV526zB85sB4cK1
	m21UjT+Y7td93jEf6IXVPRA4UnK4YeZ5QL4szMpV1nAkTXkTIAQp8oUTBrPxWI5CdO7YoeYveKp
	3IjseHX1n/Up30Gcq9+9bDqcSSDboLaV7fZaHcfbvH01YUbnpgcbqyXjbW8mYEbUrIH9c0yLUSo
	qiTvijez79XE6MmanomT33BZKHLP7fM5Dw3OQtXsCmqTQ1c4jF28cSGDPsXbWGQV7BWX8D9zYit
	AoHSAk7IMzbwLY7fEhLlYxZ7jwKoE7gtXMOdGkzKwUbR3x1g0D+ClzatkD5EDLWLqoxwQBk8VTu
	ehd1iGGnErRws/Z5xrppgQdFe7rFZxMJ1DUgmIQOOXFTTikdS/4oxj45Rd/7KFr2ojQt3NTWJKy
	dHGOx1t1MhW0ZWmx+30k990zjiZ+QNUbt/0iWkW2d9+RuHTXT/k2qdDkGyre4BVgqSAT/agWzGy
	gxRy4v5gCJ0wNLPaMfU64UOY3JP3v+gG/hbakjoozuMfh/YhnR6u7upoWQa38leHcMBF3Yhnlw8
	xN6sx0DLxN2IOJDUOaxN/sLP2jNnP9038hBEJCyrjHHxayTgA/JDWc/T56c5t/IVKjmKWduwA94
	hm7bNG7prFiqu/rb0eA7mUVTWtzK4RXfe5rtT9GayZmq1EFnGFVhkIBq8WAu048uNdKLN+5F7nw
	Ycv98xwEoeJ0Jr60FILFiawVUV+O+ta2xtf6u/qyyMjfI2bENhqoKA
X-Received: by 2002:a05:600c:3b1d:b0:4bb:6991:2330 with SMTP id 5b1f17b1804b1-4bb8881a890mr272747495e9.22.1795496481860;
        Mon, 23 Nov 2026 21:01:21 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f512-85ee-fdbe-0621.ipv6.o2.cz. [2a00:1028:8388:a84e:f512:85ee:fdbe:621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm353489155e9.1.2026.11.23.21.01.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 21:01:21 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: watchdog: maxim,max63xx: Add wdi-gpios
Date: Tue, 24 Nov 2026 06:01:16 +0100
Message-ID: <20261124050118.87944-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
References: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pali Rohár <pali@kernel.org>

On some boards only the SET pins of the watchdog are mapped to the
register, and its WDI (watchdog input) pin is connected to a GPIO. The
CZ.NIC Turris 1.x routers are wired this way.

Add an optional wdi-gpios property for that GPIO.

Signed-off-by: Pali Rohár <pali@kernel.org>
[pepe.schlehofer@gmail.com: rename gpios to wdi-gpios, reword the description]
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---

Notes:
    Changes in v4:
    - rename the property to wdi-gpios (Rob)
    - wrap the description at 80 columns (Rob)
    
    Changes in v3:
    * Extend description

 .../devicetree/bindings/watchdog/maxim,max63xx.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
index defe0401ded0..72f16d9f4596 100644
--- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
+++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
@@ -28,6 +28,12 @@ properties:
     description: This is a 1-byte memory-mapped address
     maxItems: 1
 
+  wdi-gpios:
+    description:
+      GPIO connected to the WDI (watchdog input) pin, on boards where WDI is
+      not driven through the memory-mapped register.
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.54.0 (Apple Git-157)

