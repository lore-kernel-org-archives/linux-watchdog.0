Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958133;
	b=ywwoSP8bLRBMO6YrDGO+loihuXWenS0bqrjeM6GU2h9J7EFPeVD0eExVieaUOA06MaP9
	 t2p/Ref7Px5GQ001+gTRmH+nrmE+YatWftJB0EHglsTrVC/NmeJfrb6qP/oKTj/vVl3hk
	 dZMBhekllyQG4utAZV0viJ7q46C8wbWdlHnjVRWdLWlSXyZ+9QDoBwXHPH1m94awZOBgv
	 vmDmYKBOLFzuDxyabv41guMzzhh5562rSdS3VXmFy2uzBJmshT//iboZwRO0g8r9e04E/
	 IyZqQPwu+TqAxwdeM/gJKy32+v21+eXKqg0oeqBt8dQKF9r1ajXDM27QPA2TSKJwItg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HNto22eJkDbszb/3JWYefc2jHbqBtKmYFjQghf+dX9U=;
	b=M5BdwNf/1m53AAUlmAeCQhrBot1NrqF/BdP4DtGyt/qagILf8sG/vwy49np/X38BFTPg
	 pqchHuH66Jrl8yuQCNA6JZtLE2dgcNFJ2SDvvv0dZa0rKc9jKGSlqJdMJYqSbMT4M2JCd
	 bw5Hls6UD3CtmKiZCkc8cRllQjqM2reKHhoqisdB8gReVSHYlbEKx+Y2kH6aspoJVTONB
	 hti6sY0hldet+RXCrHWU5XjN5sncIbDfq7tcMBy+G5RY8W/+AMVn9YPs3zTnRqYo5ldgB
	 4McFp/Et24bd3En0qqxlevKzxtGgzzyrckGeOcHEdnk/+SOzPnFjigyzX7cm2QTqXlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPqQRQjO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2B606A903;
	Fri,  6 Nov 2026 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPqQRQjO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934291F0089F;
	Fri,  6 Nov 2026 09:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958133;
	bh=HNto22eJkDbszb/3JWYefc2jHbqBtKmYFjQghf+dX9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jPqQRQjOpWSyz0qcmb2pHUUczqYnTF7NIsxuvm72qO11Fjg09l0pgBUfc9AOkBB/6
	 8iblkrKX43/ll9cKwlkTZJrmNoXivAYUtyVk71RGOpKK3IDrevlBVspkgywgQeC0iY
	 sV07cxZUJVuyuUqduXO4Hw9KZau2x8Do6wwJRgXwKVsERkO+4v3/4ej+c5TW91qIfh
	 9crPEgktcCuuUn/bOgGHUbDTtb4+DAUSuOK0exLb1+VSRpi+khd/ZXBKnB4Xu7+Lb2
	 C5KpwuRm+TKr+vJYMwNU4UEJExFoZMi+SfIN998udS+9A3QVK4R8lJ494AgXm6e8zY
	 yMnwrTjMIJfog==
Message-ID: <sashiko-outbox-201143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/25] dt-bindings: phy: add Metanoia USB2 PHY
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261106-mt2824-v1-5-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-5-86087eaf5af4@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:42:12 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] dt-bindings: phy: metanoia: invalid example node name and unused
  label
- [Low] dt-bindings: phy: metanoia: reset-only node, reset-names, and
  filename
--

commit 1ecf2c434e4f801fa49e7ae94a833a554c762ead
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

dt-bindings: phy: add Metanoia USB2 PHY

This commit adds the devicetree binding schema for the USB2 PHY on the
Metanoia MT2824 SoC.

> diff --git a/Documentation/devicetree/bindings/phy/metanoia,usb2-phy.yaml=
 b/Documentation/devicetree/bindings/phy/metanoia,usb2-phy.yaml
> new file mode 100644
> index 0000000000000..0605e6d0f67da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/metanoia,usb2-phy.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/metanoia,usb2-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Metanoia USB2 PHY
> +
> +description: |
> +  The Metanoia MT2824 USB2 PHY is controlled solely through a reset line.
> +
> +maintainers:
> +  - Jun Chang <jun.chang@metanoia-comm.com>
> +
> +properties:
> +  compatible:
> +    const: metanoia,mt2824-usb2-phy
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: usb2-phy

[Severity: Low]
Should this binding describe the full PHY hardware block (such as its
registers, clocks, or power supplies), or if the interface is only a single
reset line, should that reset be referenced directly by the USB controller
node rather than wrapped in a standalone virtual node?

Also, per Documentation/devicetree/bindings/example-schema.yaml,
reset-names should be omitted when there is only a single reset entry that
repeats the block name, and the schema filename and $id should match the
sole compatible string (metanoia,mt2824-usb2-phy.yaml).

> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - resets
> +  - reset-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb2phy: usb2-phy-reset {
> +        compatible =3D "metanoia,mt2824-usb2-phy";
> +        #phy-cells =3D <0>;
> +        resets =3D <&rst 18>;
> +        reset-names =3D "usb2-phy";
> +    };

[Severity: Low]
Does the example node name usb2-phy-reset fail dt_binding_check?

Because the node defines #phy-cells, phy-provider.yaml requires $nodename
to match ^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$ (for
example, phy or usb2-phy).  In addition, the unreferenced usb2phy: label
triggers an unused-labels warning under scripts/dtc/dt-check-style
--mode=3Dstrict and should be dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-mt2824-v1-=
0-86087eaf5af4@bootlin.com?part=3D5
