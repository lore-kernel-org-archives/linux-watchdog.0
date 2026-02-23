Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47843502B5;
	Mon, 23 Feb 2026 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841126; cv=none; b=chrVjGK9Gj7Qg3LHZRFHVJOLrAbD5MyGWNhZc7+qhEgU8kMsAunoTFDTP+zBRN/ywutGhA7OD3qOnSi0a2e/vG1k2pIYznt4VFnB9gE4xE4acBo/mhlbkZqJxBsf/eYCBvwdev4mMmRMJEAX2I7+c+3QCONWi+EFEXs6rhAsMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841126; c=relaxed/simple;
	bh=smh9yZMUJkt/Wi3TicLVRTK4f1RCg3ErSTma3qR4fog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qB6488TVS34qwCrJ0ShpC9xRxKZDjuGWJd7dOQuCUoso9rQumMJoJqbbgN2n9guj1jxvs1FXSW3zRjH70amWFFmK/qIdEi+YiN+74MMBFUidsPMTJq/Uzp8Xak7HX1p26qJ01eGx0woA8XNdPw1Gv2ZfaZGX9IiMU7VwTzC98oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie14nbv5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie14nbv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF87CC19424;
	Mon, 23 Feb 2026 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771841126;
	bh=smh9yZMUJkt/Wi3TicLVRTK4f1RCg3ErSTma3qR4fog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ie14nbv5gEt2VRioIZT5LtMd/v4HgyukOacbvTotXq2uGVsrZH2ZOVaXq/F15TUjl
	 TvPlkSCgKh74EgqLo9C35UhQdLOEQhi/jUCJw8bjxXQ0O3QF+jlc+94KybQiImOea/
	 wxyeBW3BpkZ3zhdhLaFc+Z1LAYk55ABwjcv5EfIcVxI/6fEnu4X7MocsQ1HI96aDRc
	 PAHcNo2w/OCa1kZGaxej9iipS6ABanZMn0MvQZFj/5nlWay+BG0546CTNQoPUQbI6T
	 nDDsKlsWoS5u/ormr3bCcTKmiCtE4SvOjNE3aYs3P/xkDE7y64wObw5q/CMLZGXch6
	 DiNZg88EdcdWQ==
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
Subject: [PATCH 5/8] Revert "dt-bindings: arm: ti: Add Kontron SMARC-sAM67 module"
Date: Mon, 23 Feb 2026 11:04:50 +0100
Message-ID: <20260223100459.844967-6-mwalle@kernel.org>
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

This reverts commit 22e1d0d8cda783bee95de578cbda3ad0da8a3eb4.

I was just informed that this product is discontinued (without being
ever released to the market). Pull the plug and let's not waste any more
maintainers time.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 85deda6d4292..adda61e06173 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -208,7 +208,6 @@ properties:
         items:
           - enum:
               - beagle,am67a-beagley-ai
-              - kontron,sa67             # Kontron SMARC-sAM67 board
               - ti,j722s-evm
           - const: ti,j722s
 
-- 
2.47.3

