Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822602;
	b=UTnliMa4N4KyRLdRGQRTqluMLIwcj+tFw0x3xVJ3G8NdLXX/VFolhcb3GhCzu/izV81v
	 nI0OxlMqeFHqFRmpMJ8twWQ/bILVVmEM0O/+1y2wQ+5uzvVla6QdtIAvm1VQsOZg0xGwL
	 uwfGh/BVSz6r0wUPxPvFU/svcadGWYYoIRdMMmT8TCBSLPAK1GFLGIwygyyhEZ7yPwsEi
	 2km7iUhhKeRDx/Mx6MFWd+f1gJ6Ev8ZhIHVYHxmvnKfN3FKQw+9k2pknEFsVI4tYCHboD
	 f3abO325Hip1G+29FXZQH774Xl3si94PgiTjAM1yQ1kxNqfBNPKCcNdZieRbMLdqZrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822602;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=nutLsIkA5U1mmOC4x0bj+AK0SbP4YnNIzYe51iNndR0=;
	b=4lqACphn4XEftv+DURHQ9v37xS9MOzKgwNZCoH9iOwxED3Y4167w2YomxUza8tS8RfdH
	 7YH4H5JRXpB0I/pETmNkF4vwpBxrWlGhMaPZHqpMMNgk+WXW2yScMkoUmu85qo6NNNbZL
	 QRB6UTa7w3m3v6L7fL40THF2aV/o6yaU+QkguzODXUlfkR3Hi5/mxBZsDtB7sqIH6bHXU
	 CAxwH9o1V0JWSzMKniQwy6DH5Ov6a+6RQO4DnGPwAKF0qcW+iTU7E75g8igz+/hjan8bl
	 Oyu8GoZT5vSTP38VRReT2ZBg06AMTMufqXwayIon/A69PPFkYtILmbTYhMxBsI4tZJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuIeV7IM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45CB606A31C;
	Mon, 16 Nov 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuIeV7IM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B0E1F000C4;
	Mon, 16 Nov 2026 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822602;
	bh=nutLsIkA5U1mmOC4x0bj+AK0SbP4YnNIzYe51iNndR0=;
	h=From:Date:Subject:To:Cc;
	b=GuIeV7IM+HGlt1Rr9ogolyxWR3STxnvhFA73A9T4j7VW2STl5N+8+/paAqcj2Qq+h
	 IxI+Fj5D+6hLsZ+ivrESmRf4pZtsyW5Tl2PaejKZTd6r36dexsv8F3YXbNB8ZlhHue
	 42U9Cn/ga+lsihQTpfj60gRag19aYQh84ee6oRoESTK054VhpN84WN389556qA7I+B
	 VU5THqIsKGwkKNgtbz+cEvzptZ4xQdF0zcy9Sif9kGRIVpr+gBSmtzI08pwwCdNZME
	 6zfca1OQPpYgYvZQmdLQ1TowYGRQoSh5xz8VPhS3RpAVqxOCsXh6QdJbsvrHWtdBeX
	 uXvCflislo5Pg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 10:49:58 +0100
Subject: [PATCH] dt-bindings: watchdog: arm,twd-wdt: Allow power domains
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
Message-Id: <20261116-ux500-watchdog-twd-binding-v1-1-a26adc9cea5e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MUQqDMAwA0KuEfBtoCnOjVxn7qEms+amjdVMQ7
 z7YO8A7sVtz65jgxGZf775WTMADoCy5FiNXTIAxxJGZR/octxBoz5ssuhbadqXJq3otpDGwPCT
 eZc44AL6bzX788+frun4dhmHwbAAAAA==
X-Change-ID: 20261116-ux500-watchdog-twd-binding-d201c8c27cfa
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
 linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Allow TWD watchdog nodes to reference their power domain.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Allow ARM TWD watchdog nodes to reference their power domain.

This binding-only change can be applied independently. The companion
Ux500 power-domain consumer DTS changes will be submitted separately.
---
 Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml b/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
index 9646ac72051e..5f6a9d6b9976 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
@@ -33,6 +33,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261116-ux500-watchdog-twd-binding-d201c8c27cfa

Best regards,
--  
Linus Walleij <linusw@kernel.org>

