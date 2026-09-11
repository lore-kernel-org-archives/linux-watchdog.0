Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A449EC7D;
	Fri, 11 Sep 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145959; cv=none; b=XWVpZ0sqNUZn482PNpQStT26G+gT2AmpbhplyreJ43AxB/djH9uiXFq3XlCIBIkB5SdBdhXcVjRmrx9EpW4ExQe7wRmJmr4jPoj7cnkoU+L0NcZ/3iAEZtEIZCJ9nz29TZzMcS2ymbyTdDxphtYekTH377A1IKTa+JGKfHn7jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145959; c=relaxed/simple;
	bh=tEPA6uRdYuQ6PY6zBqXkquvyO5/4DfLy75Cass7/Zyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZTzXnGjutgUEVqCwNXEF7zQ/d4PlJCWd/AeqOTN01A1EnEqtzg5wY04cIDtFKcoK5IplLuQigKegFm++OeAO9lu0pN7TEdeI8DCL50MM9QDtlOo5Q30nycWpIvM4q+Xs+/64ThhVouzhEtn4H+moi5yRFqyo6W7QlBQ4eNvnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=IT0nrZF7; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="IT0nrZF7"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1789145942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnQifhsyepgUfl4SRUFqkKt3aBBkCt2ItCLaLcqAOuc=;
	b=IT0nrZF7k0tEGme7tgwWM2SCxTJGZyHK5qH6adO8N1YSNJ/tpM16ssbJahST+5DJo9EicZ
	1muwf9ZIS5iTOUflgiXFyphPAVwnKEmd74dDo7vQLRrO4L4BqVjfSoMVuMn8YVXVTqd3Gh
	85zYOHu2sT0+yXZtGb5recRzU3jg9XY=
Date: Fri, 11 Sep 2026 18:58:40 +0200
Subject: [PATCH v2 3/7] dt-bindings: arm: power: apple,pmgr-pwrstate: Add
 t8140 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-apple-a18-pro-initial-devicetrees-v2-3-08d06cf011d4@cyberchaos.dev>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

The device power state management of the PMGR blocks on the Apple
silicon A18 Pro SoC (t8140) is compatible with the M1-M4 SoCs.
Add "apple,t8140-pmgr-pwrstate" as A18 Pro specific compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index b24ea8e54e11..dcffdd12c8c7 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -49,6 +49,7 @@ properties:
               - apple,t6031-pmgr-pwrstate
               - apple,t8122-pmgr-pwrstate
               - apple,t8132-pmgr-pwrstate
+              - apple,t8140-pmgr-pwrstate
           - const: apple,t8103-pmgr-pwrstate
 
   reg:

-- 
2.55.0

