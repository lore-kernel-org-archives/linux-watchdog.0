Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958258;
	b=OUhTFS3VhgM0V9H8DSleppGaJBzkkN2hb8CYfF+MH1uRnIDGhG4W9CbfR0eolyCv4oSc
	 j5PUs3ido+h82O3hbgxyObcSQfKUTdtjXV4GGnkHObOl7a/U65JNVbLhcfOgmjm4GPoJG
	 9S+geHqNsusHCr5OOltS/aXrIlHzFRbDfGf2Ta07W4SKrdRBBaFQk+ptSNRxtfJvmRB9E
	 etmlFUyzJxqjrA9OQi5DhZr6gOAyV3dP3bG3dNHblqTbyQKJFnc/Yv50jnNua7gqEjLjT
	 sSgqcRMAMFXmE24FfAX17r3wassg5lxKrFd4MXGTZkJIMY0jk9ujwBz3ews0zIyvtUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958258;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k/B0v4ZKFTMYn7uuqyANnYN0nteQ0y0bMIFLQuE39Ck=;
	b=ss9JlVeZfKau5j2DHKOBMPOPw+Nn3cYNUlLG/UHGwldN6IrMFIqe88xvd+xuFkbweu0r
	 jdDCAFGOBX13syE/xNp29BEwPEFheWlhoVsFRatsctPqYSOxMn2WOwJMAxKbYceaWXNgE
	 N8Cd7+NLHZOcAE0Mk+2VzV33VFh4YIXE7wcK5uwIqeHvG1a1xBzhNoVAKIUml/nDxdoew
	 mRMz8oobG4qWEJbCFihp7303K9tiHPW9URMc1KBhh0msxgmutAyfnCBMw6MbRxEV4dm3e
	 TqDGBcsitNgYYShw6cLwu9Dk1Fp0heSMp+OZNGyeXh31K3md44iUnnTBwlmS0wSIeew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KwC/LQpb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB9606A326;
	Fri,  6 Nov 2026 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwC/LQpb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A641F0089F;
	Fri,  6 Nov 2026 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958257;
	bh=k/B0v4ZKFTMYn7uuqyANnYN0nteQ0y0bMIFLQuE39Ck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KwC/LQpb8grt7sA2bfP5+IvDHwxcSlZgHMNYngV5PKxoqnzPfYbq6uMFbZR1tHiIu
	 XDJXR13och6Ape8ytrjFOpP5288cS6pL3AFMBAcKhfAlCFWUsgrvAhziht5898WEF4
	 2r5uWDSrofDee9ZHk1FmA3mSgwoj2Esln+umFWktOSj2HRhy8PZ9wLQJBsMGUn/nfN
	 hbNClzjJeAlycL788xKw5PT8fpYvi4Ed/oR/aYwGwVl8LZ3Ozmv9CzinxD6sXa+Xat
	 jtxOzvAJqoRgPmLJ47g8YJGxU9AK3b1LzaWhkXhHvSqXrXShnQpy2M6zhATJKNZu+b
	 UMMmYlX5Z1NyA==
Message-ID: <sashiko-outbox-201147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/25] dt-bindings: power: reset: add Metanoia MT2824
 reboot
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261106-mt2824-v1-4-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-4-86087eaf5af4@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:44:15 +0000
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
- [Low] dt-bindings: power: reset: strict style errors in
  metanoia,reboot.yaml
- [Low] dt-bindings: power: reset: metanoia,reboot splits single
  register into node
--

commit 07f8018b51cb794baf4c572ad7951597d891f410
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

dt-bindings: power: reset: add Metanoia MT2824 reboot

This commit adds a Devicetree binding schema for the Metanoia MT2824 warm
reboot controller register used by machine-mode firmware.

> diff --git a/Documentation/devicetree/bindings/power/reset/metanoia,reboo=
t.yaml b/Documentation/devicetree/bindings/power/reset/metanoia,reboot.yaml
> new file mode 100644
> index 0000000000000..2670fe7ab93f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/metanoia,reboot.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/metanoia,reboot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Metanoia MT2824 Reboot Controller
> +
> +maintainers:
> +  - Jun Chang <jun.chang@metanoia-comm.com>
> +
> +description:
> +  The Metanoia MT2824 reboot controller provides a system warm reboot th=
rough
> +  a memory-mapped register. It is used by the firmware in machine mode.
> +
> +properties:
> +  compatible:
> +    const: metanoia,mt2824-reboot
> +
> +  reg:
> +    maxItems: 1

[Severity: Low]
Should this warm-reboot register and the adjacent reset controller
register be described as a single hardware block instead of separate
Devicetree nodes?

This binding models an 8-byte register range at 0x10000004 for
machine-mode firmware, while
Documentation/devicetree/bindings/reset/metanoia,reset.yaml models the
immediately adjacent 4-byte register at 0x1000000c for the OS reset
driver:

Documentation/devicetree/bindings/reset/metanoia,reset.yaml:
    rst: rst-controller@1000000c {
        compatible =3D "metanoia,mt2824-reset";
        reg =3D <0x1000000c 0x4>;
        #reset-cells =3D <1>;
    };

Carving individual registers of the same IP block into separate nodes
encodes software driver boundaries into the Devicetree ABI.

[ ... ]

> +examples:
> +  - |
> +    reboot: reboot@10000004 {
> +      compatible =3D "metanoia,mt2824-reboot";
> +      reg =3D <0x10000004 0x8>;
> +    };

[Severity: Low]
Does this example pass scripts/dtc/dt-check-style --mode=3Dstrict?

The example defines an unreferenced label (reboot:) and indents the node
properties by 2 spaces instead of 4, which triggers unused-labels and
indent-unit-strict warnings.  Also, should the schema filename and $id be
metanoia,mt2824-reboot.yaml to match the sole compatible string?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-mt2824-v1-=
0-86087eaf5af4@bootlin.com?part=3D4
