Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686036;
	b=FtdPbgHPMflbR3q4BSNTMLdtJWg54Ahke0Xdc9zLgs5WqGBGlITuyQxHVqAkOxtPi3Nm
	 oPL/8Ua6mqLXznwJQhlPEoghDn4uwOEyLWZ/fVFZSwsgX/N/5MK0TKsKPd/6lxVWcV8Gw
	 zIAhHuk0GjXrLWij3jXVrB+7Uow59SfZ8mxGHAf+L3zoko/1QFxaYtjczIOIE1PWb8p6g
	 2BMK2h6kcWFX+NEYMGnt9Jdg5mJr2nP8lDXejUWCWnQ6VKptV40FlbpwF3/MTaR8FxHyn
	 mYZgp6vvtvsYG3w9W44JXU9sJxIfQ/7M3UlLV+i7FWDrkU2w5eS3/TXa3z4u0WRqzag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686036;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=M/fuZlWUlRDE0Lh3lUCBjyyP9KyWX72NdFXTO/NSKC4=;
	b=1zry1ky8+k1ahpYp1qGgJwUiNikIaa5VA6GA7D30EXta3NqB8CdWitPOtjBOHfvjsb6f
	 D2iQ5HE5BqHdQIPYkkgtjLB7qEihuYcOYtDsZ1+yJKfTVWoCvHEZj0qKuxZ7s+4tmyTSe
	 A4Wn4qyJ7Y24yTMZgHsOnW6quDIrH6HnMzkxiC9wM8/p1Tlg78Tm/SvoGOsAiJfbKyzOg
	 5RnY7gcHZmTfu6nI+TCdrE6aJCwOxpLMdnuFbKxEBjydUzKHUdyTaMquTMn5nW8HdpKYa
	 UdgTUuL7eP7zrf2W4EXQGZiyq+ISfalkkKGzBZhqWAL2f23oSLYoh6PkGtdaUOBC2gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2SEk8qa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F401606A324;
	Tue,  3 Nov 2026 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2SEk8qa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7EE1F000C1;
	Tue,  3 Nov 2026 06:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793686036;
	bh=M/fuZlWUlRDE0Lh3lUCBjyyP9KyWX72NdFXTO/NSKC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J2SEk8qam3sUllp8KGD+HYkKPSnQKHp1EtFfjmWb0A8axvMCR54+tpVStGeGlvrDs
	 xs2/ngRvEl63JW+mEm8SxGHPHdI6ftjJMCqZ5GYSqJkXLpcNnS+c+TEdibkmDUWYKf
	 m1s5j1XKxT2mZKS5fbBlGJsIZOnD6jM3MPuHpc/+/97elO6H5uAwofXNMaguTV0kO4
	 bX5eV9/L1+UqvwfO/U6O/7ogc5Xp83AbkSjidk0VH1CZCuxsiJSF7oDBwgH3mQnQ54
	 jHBf50KM6Y/3Ejb+rYraR3U93bonoiDFM7wZhoI7Fy6PovOGWH9lqLKe/BrTezKvXi
	 uy5OfTkjAkFxw==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Florian Klink <flokli@flokli.de>
Subject: Re: (subset) [PATCH v2 00/10] Initial Apple Silicon M4 Pro/Max device trees and dt-bindings
Date: Tue,  3 Nov 2026 07:06:43 +0100
Message-ID: <179368585832.109404.17974636706511087891.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
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
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2026 08:56:07 +0200, Yureka Lilian wrote:
> This series adds initial device trees and dt-bindings for the Apple
> Silicon devices using the M4 Pro/Max (t6040/t6041) SoCs.
> 
> This series covers only a minimal amount of hardware, which is useful
> as a basis for future developments. The hardware added here has remained
> largely unchanged between the M3 and M4 generations.
> 
> [...]

Applied to local tree (apple-soc/dt-7.5), thanks!

[02/10] dt-bindings: interrupt-controller: apple,aic2: Add t6041 compatible
        https://github.com/AsahiLinux/linux/commit/b462218dad8d
[03/10] dt-bindings: arm: cpus: Add Apple M4 Pro/Max CPU core compatibles
        https://github.com/AsahiLinux/linux/commit/cfebec7bef0c
[04/10] dt-bindings: arm: power: apple,pmgr-pwrstate: Add t6041 compatible
        https://github.com/AsahiLinux/linux/commit/821772c4bb68
[05/10] dt-bindings: arm: apple: apple,pmgr: Add t6041 compatible
        https://github.com/AsahiLinux/linux/commit/1f26b14c9411
[06/10] dt-bindings: pwm: apple,s5l-fpwm: Add t6041 compatible
        https://github.com/AsahiLinux/linux/commit/4a81348ca70a
[07/10] dt-bindings: pinctrl: apple,pinctrl: Add t6041 compatible
        https://github.com/AsahiLinux/linux/commit/a7ae8c716e00
[08/10] dt-bindings: i2c: apple,i2c: Add t6041 compatible
        https://github.com/AsahiLinux/linux/commit/4fb8e76b7f68
[09/10] dt-bindings: arm: apple: Add M4 Pro/Max based devices
        https://github.com/AsahiLinux/linux/commit/a35db2b38f77
[10/10] arm64: dts: apple: Add minimal t604x (M4 Pro/Max) device trees
        https://github.com/AsahiLinux/linux/commit/7b0c21fc2897

Best regards,
-- 
Sven Peter <sven@kernel.org>

