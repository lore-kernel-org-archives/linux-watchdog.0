Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340F3B71C6;
	Fri, 25 Sep 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370270; cv=none; b=fWUuMyfF2iFCcvkw2SF8MVBZwRxJPoD8bqMxWg+F3KoySKthjbwTMlpvXadApMhSfYoBjwL2Xeh00PXd6upi5YVorLRwKS0dvBnj2qMDOJyMH4lp7s09BKWNBUEWkNYBJG5UVsfJwtCOCl+Ejc/KsPgzWb/MlniFRGkZ3ZC9XV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370270; c=relaxed/simple;
	bh=8OZln4xl1G0DvkU/QUDhzZUlHdsJZ4OIkxVTE2N405g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llu8s8mTWLeeqEPwyCBf6megKOmWu5Ty27DMhhIRpoZ5dzfz9Ruh+Y6MQNY0+Bz5xlZGbP6K8Q/05mqZTE77p17R73denrYDOzk5tVkotMhCcueykmun8VGYy7Z8R20dR/5PpRpgURQ4UnxiRoztOwlnPCQmJZPS6ptuRbCqA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfSfEEKh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfSfEEKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B94C1F000FF;
	Fri, 25 Sep 2026 21:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790370259;
	bh=f/7V9ZWZkMokG7CJ9aBSYknLa+Ei+QcS2Lclf77fH7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfSfEEKhUZk9XSt5q+z3lsaqtaersmxd+9WaBNJCoZzvYFEmCewDa8ufauCzlsDSH
	 iNhV+KSUPfBmtgobpItQthF4nvB1Qddw8OAV/Z9gelXDRP5NrpuUzm+78wAB5eFrd4
	 grAV7C2hg8B3kRW4YZa2eWgLu3rwPUofkEvktGHPMP6aXoCWKcst2UrKTEIDo9jbm6
	 YO50RNqD7IvfH9shdDMIcA8X2m5B7ZN7utJuwueDHt7FCI6bZDIvGNzRDQutd9YdRa
	 rJsu3OUMvIc0Jj4iPH89Af9NgarTBh+rnoNt125SZAsDNRd1Y8xxsrzUpgy9B0Udaw
	 jqRP2C2CMoofQ==
From: Sven Peter <sven@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/7] Initial Apple Silicon A18 Pro device trees and dt-bindings
Date: Fri, 25 Sep 2026 23:04:00 +0200
Message-ID: <179037002764.105455.15409082344174622046.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924-apple-a18-pro-initial-devicetrees-v3-0-94f7ea52cc64@cyberchaos.dev>
References: <20260924-apple-a18-pro-initial-devicetrees-v3-0-94f7ea52cc64@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 16:17:04 +0200, Yureka Lilian wrote:
> This series adds initial device trees and dt-bindings for the A18 Pro
> (t8140) SoC and the MacBook Neo (the only Mac using this SoC).
> It only covers a minimal amount of hardware, but is nontheless useful
> for further development work. The hardware added here has remained
> largely unchanged from the earlier generation Apple Silicon Macs.
> 
> Similar to the M4 devices, changes to the m1n1 bootloader are required
> to boot Linux on the MacBook Neo.
> Also, SMP boot depends on further patches to avoid WFI and WFIT
> instructions [1][2].
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/dt-7.4), thanks!

[1/7] dt-bindings: arm: cpus: Add Apple A18 Pro CPU core compatibles
      https://github.com/AsahiLinux/linux/commit/9e70c02c5536
[2/7] dt-bindings: arm: apple: apple,pmgr: Add t8140 compatible
      https://github.com/AsahiLinux/linux/commit/4eb4d9efe290
[3/7] dt-bindings: arm: power: apple,pmgr-pwrstate: Add t8140 compatible
      https://github.com/AsahiLinux/linux/commit/16c4ea7772d1
[4/7] dt-bindings: interrupt-controller: apple,aic2: Add t8140 compatible
      https://github.com/AsahiLinux/linux/commit/c47142fd192f
[6/7] dt-bindings: arm: apple: Add A18 Pro based devices
      https://github.com/AsahiLinux/linux/commit/a1baa6329a3d
[7/7] arm64: dts: apple: Add minimal MacBook Neo device tree
      https://github.com/AsahiLinux/linux/commit/ccf16d328c35

Best regards,
-- 
Sven Peter <sven@kernel.org>

