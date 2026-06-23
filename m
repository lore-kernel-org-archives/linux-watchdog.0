Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5B3A874A
	for <linux-watchdog@vger.kernel.org>; Tue, 23 Jun 2026 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248083; cv=none; b=osN3PDSluiR4AWvSdDBSUJF2rCDXvbRmb3L2lF0yiRioxLMFX0Ub0OkuoKj/OV3ptIQRBDYQ2PPhGY1KI59kbykj3CJ/PKsUIX8V8GzSqTWHWK8kKv0boyIBu95aXtcbWjdD2+n5FalW6vt1ZrmX7QD0xf094UOqc/GpoYt1kjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248083; c=relaxed/simple;
	bh=5DbCHy/6r09DtaSVPBqWVpR1JBIh6ODVL+WEV//iL0M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBx3pvG7SbokB3dza1KUv74hzpltJaows6RWbqx5jVw3YdxbNKiehfsyusj90dCiwnxwQ4UiL2qhHXxcWGg1hyrjIKZGxdU0+7b6BQwOc2FuwkaggdCahTydZadEQwMy0QSQ7w+W1bLgAB22QbWMhWi2Lgnpxp/WN5j94Ps6YFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=FceYjO/f; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="FceYjO/f"
Received: from [IPv6:2a02:1812:162d:3d00:649f:659d:f6c1:d42] (2a02-1812-162d-3d00-649f-659d-f6c1-d42.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:649f:659d:f6c1:d42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 58A777B471A;
	Tue, 23 Jun 2026 22:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1782247511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqZlAwE7BzkFoE35oT7HwUab/5ynl4aW1uAG67NDLYc=;
	b=FceYjO/f1iSGU3YSYAPHpqD6cyDvakHr7GdZ8j4i9KYNnDqGyQX32b7NNc4Rak1+TOgo6v
	lHzdSaOmhql+N0eF4rIC1hPVL7U6TInMlwOzwJFUvTyRTYL1/gbrHZ/ixxeHIN1dOirAOc
	PiKGMo+oq0KBxEdCGOqPUUDzfeprAaB0pchNPov0ykKZi7S2GwyvPBc5ujlCueCoRcpGXo
	eH4i3cGJpucnsthjJhODnf6j6pVnNiqKPLD+6FO61o9AShoT9ngj97NnBBo/2gMQ9LyCGQ
	gyfiNdaaEeN+H5vzWLSL14IjD2/1P6rvJUhNQGHSLCGAdIbgkWDE9NpxTqY/qQ==
Message-ID: <e99623185ad106498c6d86232e0e72e41a3495d4.camel@svanheule.net>
Subject: Re: [PATCH v2 0/1] watchdog: realtek-otto: Make use of regmap API
From: Sander Vanheule <sander@svanheule.net>
To: Guenter Roeck <linux@roeck-us.net>, Rustam Adilov <adilov@disroot.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 23 Jun 2026 22:44:50 +0200
In-Reply-To: <ce37814e-d275-4b0c-a50b-7b164aebd262@roeck-us.net>
References: <20260519182329.24472-1-adilov@disroot.org>
	 <05dd2b1d95985e303af332ec81cd830f@disroot.org>
	 <ce37814e-d275-4b0c-a50b-7b164aebd262@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-23 at 11:44 -0700, Guenter Roeck wrote:
> On 6/20/26 04:23, Rustam Adilov wrote:
> > Hello,
> >=20
> > I have noticed the status for this patch series is "Changes Requested"
> > in the patchwork site but the maintainer opposes the requested changes
> > by Sander in [1], so what do i do here? It is just one the roadblocks
> > to get USB stuff supported for Realtek chips.
> >=20
> > I have already sent a reply week later in [2] but didn't get a response
> > back. Maybe this email could be served as a gentle remainder.
> >=20
>=20
> I said:
> 	So this is now a NACK if unnecessary error handling is indeed added,
> 	unless someone convinces me that this would add some benefits that I
> 	am unable to see.
>=20
> Your response did not explain the benefits of adding the unnecessary erro=
r
> handling. I did not see a rationale from Sander either.

I mainly brought it up because I have been asked elsewhere [1] to check the
regmap return codes. Although that was for a device on an MDIO bus, which I
suppose is more likely to actually generate errors.

[1] https://lore.kernel.org/linux-leds/CAMRc=3DMdb7CWB9PmzXJyfvGjvG0iwuwUgf=
LuKJuMweRFvAhAoHg@mail.gmail.com/

> On top of that, your patch did not explain the real reason for the patch,
> as stated in your reply. This means that, for me, it was just a patch mak=
ing
> no functional changes for no good reason other than to potentially _incre=
ase_
> code complexity by adding unnecessary error handling while at the same ti=
me
> claiming that code complexity would be reduced.

Given the reason is endianess issues, does the GPIO driver (gpio-realtek-ot=
to.c)
using ioread32()/iowrite32() still work correctly? If you have the wrong
endianess there, you would only really see issues with the GPIO interrupt
handling.

If GPIO works correctly with CONFIG_SWAP_IO_SPACE enabled, then I suppose t=
he
watchdog driver needs to be amended. Otherwise perhaps the USB peripheral d=
river
should be compensating for its endianess?

> Also, I do not recall even an attempt to address (or even comment on) the
> actual problem with the driver as reported by Sashiko.

I did have a look at this report [2], but I didn't manage to figure out if =
the
behavior I see matches the reasoning by the bot. Since I didn't get any
feedback, I left it as is.

[2] https://lore.kernel.org/linux-watchdog/d0b159eefa6bc5abf0d1531acde56839=
6f480500.camel@svanheule.net/

Best,
Sander
