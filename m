Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285842;
	b=t4WOrwqDIp8FGFdNbTe8Vx7iTlYGb737ccnxDJo5yfMd9eIH02mBvijagWpQwUPIXk0K
	 NOcVd96lGxxaMu2katZYyxd1Lc+iAslNef3ZAhz25yqTKaei47KIiJGRU3g01pdQvfg+3
	 /92nCValjm3lIlxDATiaOKBD/GgvlvoMC2gi7Zt1oPhZ+BA8d5PhxZb+8QTqg6l2caJcZ
	 l7UHQ5FTqXgrUGEqQcJ9w9G5KRsZaLVYT2PTpj6E98LxZNIZjoJdqWDnCN6LRic/E0Zf+
	 4a0hzB1JHaZkzUWk0AHZIe9Q4E5gllvZBp4hj1SaZMxuQv2gburZ+dIBObK/sHPnL2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=so0KiMl0T6uTI+h/FQMZSM5hBiBM9URUiSLJ8TAThXE=;
	b=NUVKUK7fahAfS1S885w2mxA0tITc7XVnad0IcHpsk/qgn2hto1Q+ByOmCeETPI0O6Ycr
	 fg6kXKXOrCdqasuOSgKRxnWmpXXohYROGZ7DojHsPkBVHdaafwgV/EycHB25LaUGB0Rin
	 njM5cbpX9XMs1GnJoELoNtJp6wODIuYKILevzN2lAbRaGw4xxukpe2vcvX+Oe0JuL+KFN
	 /iro810SyB3iU2FLiq13ceiFB8EPJzdUcKk15QKKnkYSlkM8K/cmKUjLwdAr7HrrV0ob+
	 TCUbIWkJ0wYxdLLMqXDdSytNrOnZ+eU/VRG7Xl23KeY+AnKhMWkDupF09eI1VsnncTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFyXJH8i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E5606A32D;
	Thu, 29 Oct 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFyXJH8i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980A31F01829;
	Thu, 29 Oct 2026 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793285842;
	bh=so0KiMl0T6uTI+h/FQMZSM5hBiBM9URUiSLJ8TAThXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFyXJH8i2aJfT4xZI6X4GPxQ4bZR7YvpEzXraxcInnxylvcB6BCJ0s4feYkjLqnWr
	 KZyz8Rg3t8kcs6evSb9XUBofIiW1IXH7fRs0SjwhI2cxG5Ok4w851XHr+BISz6CT2m
	 Blkp0fSvtF17DSQkiUmZS9yoNy5OlLkMgphW+py1eRi73yBot1ys/WNusEbhULVWBx
	 Fm8e5gw7gc/mpqt1Qtxl/wVCEVnTQjRItqigpiAGr5eVtCFAWUJxBQJ5dx2zTfP+PW
	 h/wKA1BYmGhG1dDTm4cUk7SVvnHn3jXRInEOKEAQ9KWmJVfhB1yFNFKV4lvTCw9xc9
	 VsUTAFEVKlhYA==
Message-ID: <sashiko-outbox-189561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] dt-bindings: mfd: Add AAEON embedded controller
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFBlcnJvdCAoU2NobmVpZGVyIEVsZWN0cmljKQ==?= <thomas.perrot@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, imx@lists.linux.dev, linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, lee@kernel.org
In-Reply-To: <20261029-dev-b4-aaeon-mcu-driver-v9-1-f9b6d0cc180d@bootlin.com>
References: <20261029-dev-b4-aaeon-mcu-driver-v9-0-f9b6d0cc180d@bootlin.com>
 <20261029-dev-b4-aaeon-mcu-driver-v9-1-f9b6d0cc180d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:57:21 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: mfd: undocumented aaeon vendor prefix for aaeon,srg-im=
x8p-mcu
--

commit 803bf7ce3719e9dd00495c829416f770a3edc092
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

dt-bindings: mfd: Add AAEON embedded controller

This commit adds the device tree binding documentation and MAINTAINERS entry
for the I2C-connected AAEON embedded controller (MCU), which provides GPIO
control and a watchdog timer on AAEON boards.

> diff --git a/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.ya=
ml b/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
> new file mode 100644
> index 0000000000000..74dccee4310a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
> @@ -0,0 +1,69 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: aaeon,srg-imx8p-mcu

[Severity: Low]
Does the "aaeon" vendor prefix need to be documented in
Documentation/devicetree/bindings/vendor-prefixes.yaml as well?

In Documentation/devicetree/bindings/vendor-prefixes.yaml under
patternProperties:

  "^9tripod,.*":
    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
  "^abb,.*":
    description: ABB

there is no "^aaeon,.*" entry yet, which causes make dt_binding_check
(via dt-doc-validate) to fail on
Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml and
scripts/checkpatch.pl to report an undocumented DT compatible vendor prefix.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-dev-b4-aae=
on-mcu-driver-v9-0-f9b6d0cc180d@bootlin.com?part=3D1
