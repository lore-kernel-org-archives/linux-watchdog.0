Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AC358363;
	Sat, 10 Oct 2026 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651593; cv=none; b=C1bWbnyC550su/aAUeRzdyFcx2YpTGqX3H2hwiOauk3PKMpt5WCbDtGlkYWTwIbnp/2/bO5YcngBImSSSvFFbuj1BTsH0nTXD+/LiBnbgZ+o0ln/5rCUAn6ADabcvr/Rb7xSlJZ5Ss1Oc7RiPY7Cc9BpC973ZL16l3KXpUM4RE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651593; c=relaxed/simple;
	bh=JIF3PfnEZtEAOC/gjKIJJfAtTAAX0Wcvin8jOshDjhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unM5QPEDtejSLwUzbdTj7CV7yOwKzPmNeMyDyKyYQdIpHbOuLoPzdOU5WDYNTC6OB50RsU/Wvv1ZhGiQ8P8id+/wmS/tXgt1Xi9rfpqA8VpInx+8Cvp9jIuORcDocDeTKPxHR73FTFpxPKe4s0WiGKfknv8skzGgDBZ8AfnxZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=OVClCkpm; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="OVClCkpm"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791651590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0e2xAGWSt5cTDmnhY/Kf0rqC98uB8drPok4JKg9Zrg=;
	b=OVClCkpmIy+dAT6t/siNfdGwoFHRjdt2prDg3YsAzD8m+4x3a5bYZJ0ifCbH/au+B7jsWj
	mUTraVuKSaY2evErcun5wXcRWF8lY7EckwesVBPa4SHjBfnb28dDvNYbvt8nvjgtj+DaA5
	XhZADQWbu0D+NkQAw0FW2x3o/hJvXDU=
Date: Sat, 10 Oct 2026 18:59:24 +0200
Subject: [PATCH 03/10] dt-bindings: arm: cpus: Add Apple M4 Pro/Max CPU
 core compatibles
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-apple-m4-pro-max-initial-devicetrees-v1-3-781fb3f2d9f6@cyberchaos.dev>
References: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
In-Reply-To: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hector Martin <marcan@marcan.st>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>

Add "apple,brava-e" and "apple,brava-p" compatibles for the M4 Pro/Max
efficiency and performance CPU cores respectively. As with the base M4
cores, there is no longer a generational codename, so we assign the core
compatible based on SoC codename ("Brava") plus core type (E-Core /
P-Core).

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5d79da63301b..aff78fc331c1 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -85,6 +85,8 @@ properties:
           - apm,strega
           - apple,avalanche
           - apple,blizzard
+          - apple,brava-e
+          - apple,brava-p
           - apple,cyclone
           - apple,donan-e
           - apple,donan-p

-- 
2.55.0

