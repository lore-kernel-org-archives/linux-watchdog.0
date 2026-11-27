Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771505;
	b=vFenThhNCDMFmBm3r75+vq8sF1YJyoT97l2tlg+YVSKmBFeMcu/j9aYs8DpTcUWLVbU9
	 2oDcmWsPmEMALF+1BZ3GVWlahuMLR+MPfOkMU2jsfY8io4NIO8iC4BVFqQ/MZDR1zF9OI
	 AlGDFGz5riM+pKmSoiENkyia96rF7kgxCeJj8HbGV7EsJS39jHUCZvS8G0WHQsWkwBg8d
	 UPioop9jIUGrmnceWgFwz9bashe0+ssUyaDbhAwtbFs2lq5NcuiQGgSVJMnKJfS6mGl3v
	 aqT3A6mkwCqJZAz75dsB5uOIL0XkWGHh/mnw4yPSERWzUTCVXbyHdHVLV9Cb53Be5gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771505;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=KNCW80EKkgkub+KVtT9hArODSp8/RAIXlPuXxJ4OBRA=;
	b=AdREuejncT8RZsxyOCNVjahd5CTyAeCScgu6N4CHgvi+T4FsbBC9yexmB5jrWNywg9uw
	 7Nd/5TCVPkNiAufuPtOM7jqjwTbI83lY0dIlccIXnbZzztUkhhQ9XzTuKbCj0LAOQSGnt
	 r1wzERaNzCyd+DRDYMpHUlgpJo1TOX+pSy6azc/LAYOCxMbcTw7taIU/zyh7SlKzXSQTm
	 wD6bqoutFxYtxSrPEWCgAxaCZnyLT86C3NseeuWqYoT0rgh7eqgws8U5+jDrM3z7E6NFJ
	 R2Ty/pTYFgSb0Oxlax1uC/fj6TMMbUGNHKU+BX4rj9Q7tj+3Af7kWFJ5GAoCjUkpFLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlUtTJFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5C606A31C;
	Fri, 27 Nov 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlUtTJFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBA71F00897;
	Fri, 27 Nov 2026 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795771504;
	bh=KNCW80EKkgkub+KVtT9hArODSp8/RAIXlPuXxJ4OBRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OlUtTJFdtNqo7bfs/0hvDfkw1m3FMg5ZIMMYbahEh/4dsBc72y3jfWgaerA6VOnKQ
	 lt5ackU7cWPKRs1oO9sDT8vPTSOkkSVObb2st0mS3brQLMwyK7cXhPqRlWxt5djiVe
	 VkpUxbuCrrMAhdmkEcO5RdRldDZ41rTNiSCXjbGKn7bg++02yrdF0BZ8iNveXHphff
	 +4hDPe5FI/2tRy+6p9lpAxH3mHorWUuqkzxOIJlhzwWzEF3Gxm8BuJwJjLlHqXPWMB
	 1kluh2kZuzNXIoyJM4LS0FL07yPU9LMY6P1kj2gIo8/smVVqUQyI6JN1S2zfgdrmSX
	 t6BMwNop2JamA==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, mfd@lists.linux.dev, 
 linux-doc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
References: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
Subject: Re: [PATCH v10 0/5] Add support for AAEON SRG-IMX8P MCU
Message-Id: <179577149953.44397.11685484329530619531.b4-ty@b4>
Date: Fri, 27 Nov 2026 09:24:59 +0000
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
X-Mailer: b4 0.16-dev-ad80c

On Fri, 20 Nov 2026 08:23:52 +0100, Thomas Perrot (Schneider Electric) wrote:
> This patch series introduces support for the AAEON SRG-IMX8P embedded
> controller (MCU). The MCU is connected via I2C and provides GPIO and
> watchdog functionality for the SRG-IMX8P board.
> 
> The series includes:
> - Device tree binding for the MFD driver
> - MFD driver that serves as the core driver for the MCU
> - GPIO driver implementing the GPIO functionality
> - Watchdog driver for system monitoring
> - MAINTAINERS entry for the new drivers
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: vendor-prefixes: Add AAEON vendor prefix
      commit: 8754d4912daa776faa2525f5e6277a18d40fd939
[2/5] dt-bindings: mfd: Add AAEON embedded controller
      commit: 62eb7223813ba41684a22494de046e240f20240a
[3/5] mfd: aaeon: Add SRG-IMX8P MCU driver
      commit: 001731afc45c1d8b2724346cd806c02064032ed5
[4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
      commit: 10237675f88d8b90eb958ab123f2cdd2c61705d4
[5/5] watchdog: aaeon: Add watchdog driver for SRG-IMX8P MCU
      commit: 7f99cacfe2793d19acdea392b46592b0c605845c

--
Lee Jones [李琼斯]

