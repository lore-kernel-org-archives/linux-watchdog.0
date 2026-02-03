Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16D3D1CAB;
	Tue,  3 Feb 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135699; cv=none; b=DrHS/E7Oda0FDDDIy66xK53jvMV6+qY4y32VfDd1eqwEnsyKZ8ifhmaianEBo7LLPpWxa2TBw1r5XbDjHhtxkx5E9wmfTmUN7JZIIMcTKQHu0h43FFPtCDqTH7XqkYRr3gJuQIRuA1WinmU/X/wjcTKLtpBDLhCfLSrs65HnZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135699; c=relaxed/simple;
	bh=FXR1urZyHxRMQhEV+YAE1Dupsb+CKUg3wI8EMI1En5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O1xXaOjC6Lc8sUyhm9vEgk3hNaftmCMZFHfdMLQqPrdkC0cW6xBW38vKDWUqvUrEsRVvxWAESA4728WYrQsxPjVi0Y4McffUKmS9Mh6wbe1JnPGhn8V6CxRc/SYdBQ3mRBlzRo+1ees1Vg9IIxb63JXjzqPZfAIwdgv8vWM5UNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IhJaT0Ou; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IhJaT0Ou"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F19E44E423E2;
	Tue,  3 Feb 2026 16:21:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE8CC60728;
	Tue,  3 Feb 2026 16:21:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EDB15119A8888;
	Tue,  3 Feb 2026 17:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770135695; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Iv2/16VnKv0xj7dzCIsq/6ykvwxz9Vm1Oxs1q8ZKaVA=;
	b=IhJaT0Ou/kPgEgJQh5skMhWgrBzndqcfICme9vUHZfia6yIm3tp6/EDpLEYNlMh4eoJaB1
	+5drPdkwQT+eUDHXCS6R05Nz4zvUu+GZAPQpEGG3ivAKv/eSmbMSspsScE+MYjrqdtadAB
	8RpcIglgtj9Ls+5+Slm46o7CoxwpaGbjwa3BtiT3FMeJgsa7Muty/Xa3M21tXiSeYB+xaX
	ETmMNTkDig4Mx1Yq7Va9LABP76/OeVuYhthcHpBQvwqUr63b1JeiBxcUwLFX6LPgAoWScE
	tVlti3rn0Q8Ihcxwhj901ddDkWJFPgTC/v2JHo9zxW/MD4NVN5dOUHcWERYC5g==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Date: Tue, 03 Feb 2026 17:21:10 +0100
Subject: [PATCH v3 1/5] dt-bindings: vendor-prefixes: Add AAEON vendor
 prefix
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-dev-b4-aaeon-mcu-driver-v3-1-0a19432076ac@bootlin.com>
References: <20260203-dev-b4-aaeon-mcu-driver-v3-0-0a19432076ac@bootlin.com>
In-Reply-To: <20260203-dev-b4-aaeon-mcu-driver-v3-0-0a19432076ac@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=thomas.perrot@bootlin.com; h=from:subject:message-id;
 bh=FXR1urZyHxRMQhEV+YAE1Dupsb+CKUg3wI8EMI1En5g=;
 b=owEB7QES/pANAwAKAZ/ACwVx/grtAcsmYgBpgiCHHJdMGQyfnwVKTPYFRXLxHw0FYtCoHkC2W
 uj9FJzILRCJAbMEAAEKAB0WIQSHQHfGpqMKIwOoEiGfwAsFcf4K7QUCaYIghwAKCRCfwAsFcf4K
 7WvJC/9SpUNhoDdX7+9IAoTUB/v+MkNNL5RbRfufer1AeRcJ5JWN159wm3yunjcDD1XzO2ogmDE
 8vwMKJ3nJOEuXYo70lspF9dT6azJ/a+P3cySfcc37Q2LTAIf3Vi471TXXt8x80UtFDr6GhSqDZG
 p4gfDXuv7+Ab/RMpBC8bw4ENMl6UPLy7st0WiSAJmIeUjCuDOpfGFTSPQ4aSADIH6I9VlQVqNom
 QSCkggI9xPez4xclj6m08AyYvDobRP6fpKia9qScRGuSpnGlhQP6+z9qt2OQb4SuHYdLhYcp0mx
 Iz3WR/WVriZS0Abmlq7FgxPJlt8eJSvZ/P+aKFzxvUSwTtTNeru0aDMeEoKW9drMKwAsOYTVIfg
 fSEMkz7qa0BIlxM1KPrURwtlq/MJEZdmMIUclF9Q5e/0tTS5HH5sLTxS5ECBmTGV8bfWIEUs5Eu
 0ofRm9KHlhsAvTLvbDuzKPCy89NatJI11YlgT0zg6vE+VlbPN18BjnX3nEFgmHnA05gK4=
X-Developer-Key: i=thomas.perrot@bootlin.com; a=openpgp;
 fpr=874077C6A6A30A2303A812219FC00B0571FE0AED
X-Last-TLS-Session-Version: TLSv1.3

Add the AAEON vendor prefix to support the AAEON SRG-IMX8P MCU driver
devicetree bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c7591b2aec2a74560a4f687fe7a2070ca21b0752..0f84ee93b3a8473719ee92f8c046e350c4a20825 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -32,6 +32,8 @@ patternProperties:
     description: 8devices, UAB
   "^9tripod,.*":
     description: Shenzhen 9Tripod Innovation and Development CO., LTD.
+  "^aaeon,.*":
+    description: AAEON
   "^abb,.*":
     description: ABB
   "^abilis,.*":

-- 
2.52.0

