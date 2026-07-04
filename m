Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DC21770B
	for <linux-watchdog@vger.kernel.org>; Sat,  4 Jul 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181128; cv=none; b=Uyw1HecvuMhkYs817JJH6RXTjb8tC/z8kWzbuivGlS+pZf1+KTLHtmmkf+jfMXVCjrQ4UkLhHY6aACwwqrVWubAERxpoBkuuIPkDnz1VnLtOSbMug9bfQu3dFKJPrgdljE1BAspB1PoUPbqI7PYh2T9cbZDxLn8MeSFSkGIyTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181128; c=relaxed/simple;
	bh=fzT4QJNMj7NXM1rQNa+racxQPhGkez7mlfXUinhWKDA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOGajRIoP/GCrgjTuowF5g+CtH5d3YID5VbQeHR/4cHp8/pAVpnnOkN0f6dEsQaneJuNfJozOWfJuVjUx4cCUXFZ2BxSel4oZ91uLb/gAkvKRDk2UwoyI3C+rIoHHbc9uqNony3fJarnsNoVc76t65wsjIDKUiFfNflA5iGWmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=PxD85tT1; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="PxD85tT1"
Received: from [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d] (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 179057BE3C1;
	Sat,  4 Jul 2026 18:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1783181124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzT4QJNMj7NXM1rQNa+racxQPhGkez7mlfXUinhWKDA=;
	b=PxD85tT1r2qHsY1YUxgcCvn5O2UNfnfiI4sY3xcrUCLnTmSnZk4GHeYpAN6/ANCAEitcHl
	EKxDMp4j/ALm+QfAtXc66uHJ+gyuePIH492z22EJkkWAHJ+SdXUybkDerHe6WfM1C1aWYK
	Nrek2lEBnpSBnYm+g/OxdGgBeCPW7EDM9FpX5tUqBlFzSUIel9Ib4uV86Hnigpv0Oisjv3
	RkZydMOnTfNYw0Yv+KKGJ/zInHVtKvCwgHSXT6Y5a3y69wVuqGwhZ/G8KWOgoQjS+MV4LF
	raJVS/gHdEYnfCrTEbsDmliYaVkod5LF9kz4oqLCkD1mOc8RjMVTzPiWy3sXIA==
Message-ID: <ebdcb8c5563ceff723f3e4a3c4fdfe9bf87d42fa.camel@svanheule.net>
Subject: Re: [PATCH v2 0/1] watchdog: realtek-otto: Make use of regmap API
From: Sander Vanheule <sander@svanheule.net>
To: Rustam Adilov <adilov@disroot.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck
	 <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 04 Jul 2026 18:05:23 +0200
In-Reply-To: <9362a24cca55f60f89157ca9537a5eab@disroot.org>
References: <20260519182329.24472-1-adilov@disroot.org>
	 <05dd2b1d95985e303af332ec81cd830f@disroot.org>
	 <ce37814e-d275-4b0c-a50b-7b164aebd262@roeck-us.net>
	 <e99623185ad106498c6d86232e0e72e41a3495d4.camel@svanheule.net>
	 <61291b61ae4bfcc6c257dc02f12bdeaf@disroot.org>
	 <6cb55a3e4876ec7955c99f1ea29862b38448491a.camel@svanheule.net>
	 <9362a24cca55f60f89157ca9537a5eab@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rustam,

On Sat, 2026-07-04 at 15:13 +0000, Rustam Adilov wrote:
> On 2026-07-04 14:00, Sander Vanheule wrote:
> > Looking at the full patch (*), I see you're not only modifying the GPIO=
,
> > watchdog and timer drivers, but also some very basic reset and pinctrl =
code
> > to
> > have a functional system with SWAP_IO_SPACE. If SWAP_IO_SPACE requires =
you
> > to
> > avoid byte-swapping in so many drivers, then you're just working around
> > SWAP_IO_SPACE. In other words, AFAICT it shouldn't be selected.
> >=20
> > (*)
> > https://github.com/jameywine/openwrt/commit/053aba620b12c6215e6760d8a61=
3b4ebe05d452b
>=20
> I would say it is more of working around limitation of big endian MIPS wi=
th
> little
> endian USB controller but more on that in the message below.
>=20
> > If there is a single new USB peripheral driver that only works with
> > SWAP_IO_SPACE, then I suggest you update that driver instead of enablin=
g and
> > bypassing the effects of SWAP_IO_SPACE everywhere else.
>=20
> Sadly it is not much to do with a single USB driver (technically yes if y=
ou
> count
> ohci-platform and ehci-platform) but everything to do with the reads and
> writes
> functions in ehci.h and ohci.h files. If we don't select SWAP_IO_SPACE, w=
e
> have to
> basically change them to perform a byte swap as we can't use readl nor
> readl_be
> functions for that. You can check how that would look like in [1] but tha=
t
> would
> not be acceptable by upstream nor any other similar modifications to thos=
e
> header
> files i don't think.
>=20
> And that is a crux of the problem. That same can be seen with rtl930x and
> rtl931x
> in [2]. SWAP_IO_SPACE as far as i can see, is the only solution to be
> upstreamable.
>=20
> [1]
> https://github.com/openwrt/openwrt/commit/ba48e61e9da58b38d69fc58f90f9fcd=
93c11862b
> [2] https://github.com/openwrt/openwrt/pull/23508

Thanks for the extra details. From a quick glance, I have to say that the e=
xtra
OHCI/EHCI quirks from [1] don't look too offensive, but I'm not familiar wi=
th
the USB subsystem.

Those USB frameworks already have quirks for mixed-endian systems, so maybe=
 the
issue is more that nobody has had the need to support your situation yet. I=
f you
(or Carlo) are not sure how to clean that up, you can submit those changes =
as an
RFC to get some feedback without a full blown review. Maybe also involve li=
nux-
mips then.

Best,
Sander
