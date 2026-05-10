Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FF64A23
	for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436782; cv=none; b=aqwivZBN8LLqaIP/6mC5/VxUUa/iQ/rdwq6MZ9tTRt5Mgs1sXZ8irIKQ43OjRezt83ug/rd9jSHloSMU8ogrStJ8gPZgX3OUo877zIhrC/IleZ6cxpOTtdRvY0rOdpQR3Q6mzxOAM+q3RzCqmGOYU++aonAdu66TYa6WvZdUyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436782; c=relaxed/simple;
	bh=qsyD3I6m0aYHwlbpWVtGkgGX/TkgLNlICdUUhmBiUGY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTPaFDpKZpGk0dRPaNHfdAi4aCVt7QIKIuqzSqRrVIHA0MiR4COxdJSTR7nkNvSVfBvGn2axShZkbuvuH7sCCrqCDu9WEzN7nRfBCnxUlH7n/UwAKScnLL21x7pOav4H+GVA08q0sHXI3m/bqrk1pNeROySVuLUSzkW0bwJCK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=T29cU3w/; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="T29cU3w/"
Received: from [IPv6:2a02:1812:162d:3d00:649f:659d:f6c1:d42] (2a02-1812-162d-3d00-649f-659d-f6c1-d42.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:649f:659d:f6c1:d42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 57FDC77CBCB;
	Sun, 10 May 2026 20:12:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778436777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPDSwDWYGFC4ZvqTJL7L1M9W/nS9QedFSnGeXH+buYo=;
	b=T29cU3w/ivCu6KMnlDb+v9KZHaCb5K6iKlxQaRcNu7ur8ieQWZpKShnHNL12+vml7g34aj
	qfVyiFppFFhhHuqVNQUdxlWlhR0pUG22FgKUhIHub2Qh76bPHJkfdKmXm0+vAynQ06c/kM
	HQeLZFiJcuWstC3bUi4s+cLewW51I0MyWblAkMqs9cFSxA+fMz6RISlZpDYZUvjlfdvCD+
	SYCXCL8ur7IfMajWtVaTC2v8LfE5QY6X/vGBrYGUbZH7SnMD/uDZfdMaR1MTcj/fh+NjDO
	ZkPNU96QpVTmnyfpgCWy/p9LdUR2uTG9EYtQsJm7+up4VfkEfDYFFac8rINvqQ==
Message-ID: <fdc1a60dcde1cf8c36877be062badbf2a7f72835.camel@svanheule.net>
Subject: Re: [PATCH 3/3] watchdog: realtek-otto: add RTL9607C support
From: Sander Vanheule <sander@svanheule.net>
To: sashiko@lists.linux.dev, Rustam Adilov <adilov@disroot.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 10 May 2026 20:12:56 +0200
In-Reply-To: <20260509172748.54B33C2BCB2@smtp.kernel.org>
References: <20260509163101.722793-4-adilov@disroot.org>
	 <20260509172748.54B33C2BCB2@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

As a general remark, it would be good if this bot could use the original To=
/Cc
list of the message this was sent in reply to.


On Sat, 2026-05-09 at 17:27 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s)
> to consider:
> - [High] Registers accessed before peripheral clock is enabled
> - [High] Sleeping function `disable_irq()` called in atomic restart handl=
er
> - [High] Integer underflow in timeout calculation causes massively delaye=
d
> watchdog reset
> --
>=20
> commit be1a33571f33f241ada324d2648ec90cdf1e9b91
> Author: Rustam Adilov <adilov@disroot.org>
>=20
> watchdog: realtek-otto: add RTL9607C support
>=20
> The RTL9607C SoC has a watchdog timer identical to the already
> supported SoCs. The peripheral is memory mapped at 0x18003260
> and driven by the Lexra bus clock.
>=20
> > diff --git a/drivers/watchdog/realtek_otto_wdt.c
> > b/drivers/watchdog/realtek_otto_wdt.c
> > index e5e9cb480f4f9..7ad196802eeb5 100644
> > --- a/drivers/watchdog/realtek_otto_wdt.c
> > +++ b/drivers/watchdog/realtek_otto_wdt.c
> > @@ -355,6 +355,7 @@ static const struct of_device_id otto_wdt_ids[] =3D=
 {
> > =C2=A0	{ .compatible =3D "realtek,rtl8390-wdt" },
> > =C2=A0	{ .compatible =3D "realtek,rtl9300-wdt" },
> > =C2=A0	{ .compatible =3D "realtek,rtl9310-wdt" },
> > +	{ .compatible =3D "realtek,rtl9607-wdt" },
>=20
> This isn't a bug introduced by this patch, but enabling this driver for t=
he
> new SoC exposes a few existing regressions in the code.
>=20
> For example, can the driver safely access the peripheral's memory-mapped
> registers before its clock domain is enabled?
>=20
> otto_wdt_probe() {
> [ ... ]
> 	/* Clear any old interrupts and reset initial state */
> 	regmap_write(ctrl->regmap, OTTO_WDT_REG_INTR,
> 		=C2=A0=C2=A0=C2=A0=C2=A0 OTTO_WDT_INTR_PHASE_1 | OTTO_WDT_INTR_PHASE_2)=
;
> 	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, OTTO_WDT_CTRL_DEFAULT);
>=20
> 	ret =3D otto_wdt_probe_clk(ctrl);
> [ ... ]
> }
>=20
> Writing to OTTO_WDT_REG_INTR and OTTO_WDT_REG_CTRL before calling
> otto_wdt_probe_clk() might violate hardware access requirements and could
> cause a synchronous external bus abort or system hang during driver probe=
.

otto_wdt_probe_clk() can be moved up to come before the first bus accesses.

This would not cause issues on real hardware, as the bootloader will have
ensured the watchdog's bus is up since it is shared with the UART=C2=A0cons=
ole.



> Also, does the system restart handler sleep in an atomic context?
>=20
> otto_wdt_restart() {
> [ ... ]
> 	disable_irq(ctrl->irq_phase1);
> [ ... ]
> }
>=20
> The otto_wdt_restart() function is a system restart handler executed in a=
n
> atomic context with local interrupts disabled. Since disable_irq() intern=
ally
> invokes synchronize_irq(), which uses wait_event() to wait for executing
> interrupt handlers to finish, it can sleep.
>=20
> Calling a sleeping function with local interrupts disabled triggers a ker=
nel
> panic, and waiting for an IRQ handler to complete while other CPUs are st=
opped
> during a machine restart can result in a hard deadlock. Should this use
> disable_irq_nosync() instead?

I don't see why it couldn't use disable_irq_nosync().


> Finally, is there an integer underflow in the timeout calculation?
>=20
> otto_wdt_determine_timeouts() {
> [ ... ]
> 		total_ticks =3D div_round_ticks(timeout_ms, tick_ms, 2);
> 		phase1_ticks =3D div_round_ticks(timeout_ms - pretimeout_ms,
> tick_ms, 1);
> 		phase2_ticks =3D total_ticks - phase1_ticks;
> [ ... ]
> 	val |=3D FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
> [ ... ]
> }
>=20
> If the pretimeout is configured to 0 (or a value small enough that it map=
s to
> the same tick interval), total_ticks and phase1_ticks evaluate to the exa=
ct
> same value, resulting in phase2_ticks =3D 0.
>=20
> Since phase2_ticks is an unsigned integer, 0 - 1 underflows to 0xFFFFFFFF=
,
> which FIELD_PREP masks to the maximum field value of 31. Does this config=
ure
> the hardware to delay the system reset by 32 ticks (over 5 seconds) inste=
ad
> of the intended minimum of 1 tick?

While this does indeed delay the system reset to the maximum time, the
pretimeout interrupt (end of PHASE1) would still occur at the intended time=
.
During PHASE2, the watchdog cannot be pinged anymore and system reset remai=
ns
inevitable.

I'll send a set of patches to resolve these issues, as they don't really re=
late
to adding RTL9706C support.

Best,
Sander
