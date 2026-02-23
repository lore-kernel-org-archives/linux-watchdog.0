Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBC1624D5;
	Mon, 23 Feb 2026 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841130; cv=none; b=URcSdBMvYZwMf4MKLsPSDngchPAH2MbRvQJ01P4Giu9redzSnlEueQQ82pcNwdOZXqrSNOTRpkxTwtPkUzbNFWy9A81EO+hbQ9KatvvnWhhe2VizZVs3V6KWIIw8hZWhj9hAt+LuxazxJtvBGuoSkiJGzRtKA+Kb7Nu45Cyg/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841130; c=relaxed/simple;
	bh=3ie0ZA5pNHuuMYiqJBlO4R/ou5Qo8K0jXmdQW6jxKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juT3fyHhUnog6e51KZEb3QMXSKdlbKL0q33Ex8f3RixmKhsWJrv+vvGL4ktxzloFtJ0i6ST9MJBN+XpJnwKUI94DwVtotZC9CL5CQr921gjv1dGztysLvNPGYbIpHXFzxgj/iOOgaYWCc/aqdx5pMNJ/9P5Uouihw/U2WDSciFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLVNTJz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLVNTJz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2942C116C6;
	Mon, 23 Feb 2026 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771841130;
	bh=3ie0ZA5pNHuuMYiqJBlO4R/ou5Qo8K0jXmdQW6jxKo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLVNTJz33HW02gai2XloM51iY8aNpquMiGbGon0HtIrMA0OVN/fDX4Y/JevS6X3km
	 G85U6iWSb7deim+x5LCT0eb36Y2LoLGJ8KdXolY8htbVpcUzn9w6DaX1rmhsbsFROA
	 Z4DSN93HSGm21SZuiS4yUBKjSQ0NblRjgd3bdPsMR8ye5qGICZ6L9mDa0OmG1wmskY
	 mqOqBHWW+RAj4cCi6PO8JKm8lqQ8AsiiFnvDFG06IT1m9UgMVFMosTuBCfPzkMWyRp
	 f6QBltvjZSwE2qoPisFxuYADO1A3zhmM4dgU2zgXNefiTWdZhAsCcQIbj+tDIdVyR1
	 aGpA0hpEIZtNQ==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Srinivas Kandagatla <srini@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 6/8] Revert "dt-bindings: nvmem: sl28cpld: add sa67mcu compatible"
Date: Mon, 23 Feb 2026 11:04:51 +0100
Message-ID: <20260223100459.844967-7-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223100459.844967-1-mwalle@kernel.org>
References: <20260223100459.844967-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4a9b344e90c7ca654d7a469d0a467f90ef2add64.

I was just informed that this product is discontinued (without being
ever released to the market). Pull the plug and let's not waste any more
maintainers time.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../bindings/nvmem/layouts/kontron,sl28-vpd.yaml           | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
index afd1919c6b1c..c713e23819f1 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
@@ -19,12 +19,7 @@ select: false
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - enum:
-              - kontron,sa67-vpd
-          - const: kontron,sl28-vpd
-      - const: kontron,sl28-vpd
+    const: kontron,sl28-vpd
 
   serial-number:
     type: object
-- 
2.47.3

