Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308ED3AE1A8;
	Mon, 20 Jul 2026 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784526916; cv=none; b=ZQdl7jI+L3083P/3Nac0P/eQeUTv8zKmckg8IEgGCUcPpp78leaozc8CS6ufgvr7Vq92mqNIRHRPLRk3cFqYoJXXemERl2A0J/CisQqQAvZzFGyWLoeCRFlCT+ELcf4zRHoCGbL2aVt+d0cb+y2yK1NRDaFliNvSSnJEpQwUnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784526916; c=relaxed/simple;
	bh=u4joJfRVnEQCt3N5bW2IOB87dV+XIL4S5WBrB5ViYG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9ALwVMbFxO8B1X25H7el49Hazkshi0o9D3mcD1+SSy0BXcqsjxY0onyKI64JpSTgdoHYDVxDZMpf6We7vjPmEX9e7NszJ7GyQjhESRLO9OHd8po4C5hYzDID+UuzNULUlkU8jEfs17brRaHmF8R5kc3Hzb9pOMpL5Z6evnKYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4Zpp0df; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4Zpp0df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB301F00A3A;
	Mon, 20 Jul 2026 05:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784526899;
	bh=qu9ZKrwiA59LhaMT7q49o5s5QNop0Qq0S2uxY0qp5SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A4Zpp0dfUx9OMXBql/6MG8+Vwjs7316TPXHV70GB6+imTGXpTnixbTER/7lAR0Oxr
	 Qf7RYzI/w3iHTYCvUKF+N9fZqfcjqhJ+B1zQWPqlnRwyf+6CGuhU5LDD2P2oDdUb1x
	 4QWkZYNdcZ3LblLLm+wRRrbXPLNbo8gDmP0X85N1V2C45R9LN+QZJty8N6wmt+L6j/
	 3KIHkoRQhoHwrToTD9nFr0n3V+8wY2ccH956zoYoUskdQik/i5OJeR3/WnNXFLoMgO
	 rHr02jrhl1ifzc+j/AVQgQuJOSWPCeEGwfHnfcstG0ze08XfMCed2ype1mTYiUmQH2
	 s0SStXwrcfguw==
Date: Mon, 20 Jul 2026 07:54:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: renesas: Split out RZ/T2H CPG
 binding
Message-ID: <20260720-fractal-prodigious-spoonbill-86f534@quoll>
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260716123434.2576253-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716123434.2576253-2-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Thu, Jul 16, 2026 at 01:34:27PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Move the RZ/T2H and RZ/N2H clock controller bindings from the generic
> renesas,cpg-mssr.yaml schema into a dedicated binding.
> 
> Unlike the traditional Renesas CPG/MSSR block, the RZ/T2H and RZ/N2H
> system controller integrates additional functionality beyond clock and
> module-stop control, including reset control, clock monitor support,
> write-protection registers and other system management features.

Nothing of above differences got reflected in the code, so I do not
understand this reasoning. Binding is exactly the same as the old one.

Best regards,
Krzysztof

