Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CA34D39C;
	Mon, 23 Feb 2026 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841138; cv=none; b=jsb1itIBlZSnJuvCH/lYhB15rMrA/p8kP50Wl/5ZbT8F9aJCS/9b1Pyxi4NoLK9hfg6fdkx56dmVRvJUMu2WBMATP75Av/YbAuCT2Xvpn2sIz5HEFF0Xr0Zgd1u6KaN2ywENfjuLB9zWXp1rAlJpeymp33PWuCoCsroF86sSGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841138; c=relaxed/simple;
	bh=h4Fmnm9DvFB3jjLMnVgmIRJrmS+gvXG7HnQy50p7Cpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk9woHJD5qOVT8qi16O+HFaPb0dev6RgqfqYrFigSR3O4FlpJO2qZVApV8Z7jV7ciKQd3IsJSZoSud4ohobcmn7ksvPsgGz2mEW9IpfjiKtNv0n74lftQLL71AbtVY4CAWj/Tt1aOFUK/iY5ysbLHHYpUNE83dakgtGUZH1bvUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk2Wwfz2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk2Wwfz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9752AC116C6;
	Mon, 23 Feb 2026 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771841138;
	bh=h4Fmnm9DvFB3jjLMnVgmIRJrmS+gvXG7HnQy50p7Cpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mk2Wwfz2FCtMm7F+LirBqE0NRbtFtvMCWndhwc39OSeMgt3Hv1MnkHOfMVPAEc5m4
	 vsxqDd2kkiJhRZDr6TJd0nbwWnaX5qoEyiiVd5ZHSYutcAiWGBTTo4AB5xD/HTI665
	 ndKBJNYr30dt2+Y5l0TzB9oAm9ZUAaEsoAeCvTfmt36oFffDgtCabaOEugwyrN95+3
	 IS4nR+3pqnbuP48TTcNRgHP28Un1IU8b6xMkX4hVQvcIweWHf+E3o+VC9Pl8dHqV5k
	 axgwwqptV+31zb3HwEth//CmW0lvTUJFGpCkcXerlQopUgqZmvoeYTizdnMcT8r3om
	 RUgZor/b4RwTQ==
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
Subject: [PATCH 8/8] Revert "dt-bindings: hwmon: sl28cpld: add sa67mcu compatible"
Date: Mon, 23 Feb 2026 11:04:53 +0100
Message-ID: <20260223100459.844967-9-mwalle@kernel.org>
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

This reverts commit 0f6eae86e626e0561d2f545a3183be2e12108410.

I was just informed that this product is discontinued (without being
ever released to the market). Pull the plug and let's not waste any more
maintainers time.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml        | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
index 966b221b6caa..5803a1770cad 100644
--- a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
+++ b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
@@ -16,7 +16,6 @@ description: |
 properties:
   compatible:
     enum:
-      - kontron,sa67mcu-hwmon
       - kontron,sl28cpld-fan
 
   reg:
-- 
2.47.3

