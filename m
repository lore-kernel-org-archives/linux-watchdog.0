Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B683B9DB7;
	Mon, 23 Mar 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289410; cv=none; b=Yf4O4WHDQv/WWaNXCBfMupA49A54jawCDAyigRsgxPHErgGQ7fzTjQpnVf4ISkP8Ftm3FHqcI0t/BmhDzhBxMepgZJGTPP2XOsEe2PhcPeYFTY0dFK1YqLtjtyvniVusJGVw4dbgwyn17l5cF3fxCwZMVHIHmL+dhiGjPK+1nDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289410; c=relaxed/simple;
	bh=uklW9RFr6BYjn6wm/JQpUmhU5aMurNfLbOV16eYldHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXpE9/Mq2tvt2Gn5PJh4T4/dw9f+CbzjycCTUeWB4hxA4lRDgLc+yMzUhMqJWd2/05b9fmWPmCMSL7/UdR8354fLFLHMY+1pNTWVlu4FMMtrAH3qH4zGQs7V87Fjdeu/Noo0IyFo3q9h3Rh894zIwVFSxyg5YIx4+AF19ErHxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2e8B3c5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2e8B3c5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B84BC4CEF7;
	Mon, 23 Mar 2026 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774289409;
	bh=uklW9RFr6BYjn6wm/JQpUmhU5aMurNfLbOV16eYldHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2e8B3c5Aznp84RxbaTuWUcfASpJ7HuYQYEFpVz6zqnkEzkmS+nRH0bUf3G2IdoxA
	 QK96J8OM0RHAGM7XCO/06Z+JQ7astlcSz6iwDPMw26jA5dulMDml1bmqr0ib9cW4ic
	 b78xq3yyBbqpuOyVzWz2HI8RkVvJgnm4E0qbhb7FKfujOeaDtdge9GMP0gopdy4WUc
	 +QXFaIW79WZvFoKtetnEYU8FMD+yS4tKRLhnMzvS7b2zFVOyvIVw4dyjSSCwQFINWT
	 L/ojs9wgmTq/tMLFA42i3mgS94wuMPmDeqXulT0+ulJZgPz3aVel9cNQozDIXvfzZY
	 f9St0ZvuVp9zg==
Date: Mon, 23 Mar 2026 13:10:08 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Eduard Bostina <egbostina@gmail.com>, daniel.baluta@nxp.com,
	simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Convert TS-4800 to DT schema
Message-ID: <20260323181008.GA864363-robh@kernel.org>
References: <20260323084616.10469-1-egbostina@gmail.com>
 <20260323084616.10469-2-egbostina@gmail.com>
 <acFxdiHYjlSOESf_@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acFxdiHYjlSOESf_@lizhi-Precision-Tower-5810>

On Mon, Mar 23, 2026 at 12:59:34PM -0400, Frank Li wrote:
> On Mon, Mar 23, 2026 at 10:46:12AM +0200, Eduard Bostina wrote:
> > Convert the Technologic Systems TS-4800 watchdog timer bindings
> > to DT schema.
> >
> > Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> > ---
> > Note:
> > * This patch is part of the GSoC2026 application process for device tree bindings conversions
> > * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> >
> >  .../watchdog/technologic,ts4800-wdt.yaml      | 46 +++++++++++++++++++
> >  .../bindings/watchdog/ts4800-wdt.txt          | 25 ----------
> >  2 files changed, 46 insertions(+), 25 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml b/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
> > new file mode 100644
> > index 000000000..cb2066b4b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/technologic,ts4800-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Technologic Systems TS-4800 Watchdog
> > +
> > +maintainers:
> > +  - Eduard Bostina <egbostina@gmail.com>
> > +
> > +allOf:
> > +  - $ref: watchdog.yaml#
> 
> Move allOf after required incase add if-else branch later.
> 
> > +
> > +properties:
> > +  compatible:
> > +    const: technologic,ts4800-wdt
> > +
> > +  syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: Phandle to the FPGA's syscon
> > +          - description: Offset to the watchdog register
> > +    description: Phandle / integers array that points to the syscon node which
> > +      describes the FPGA's syscon registers.
> > +
> > +required:
> > +  - compatible
> > +  - syscon
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    syscon: syscon@b0010000 {
> > +      compatible = "syscon", "simple-mfd";
> > +      reg = <0xb0010000 0x3d>;
> > +      reg-io-width = <2>;
> > +
> 
> Needn't this part. just keep below watchdog node should be enough.

Well, the next thing to fix is going to be that this node needs a 
specific compatible. It doesn't look like there's any other child nodes, 
so probably want just one schema that defines both nodes.

Rob
