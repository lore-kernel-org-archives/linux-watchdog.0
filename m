Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A5288BA
	for <linux-watchdog@vger.kernel.org>; Sat,  4 Jul 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783174004; cv=none; b=hQ3+Xi3KE52V6y/0fGAC38CR7e4N6U5Hy1uspmClOxonuG4QQDCjZWVE3uns7kPUtOuyYFzXsGyCxzyW6MtRAIC4BXdwAf/pTzwRoaj5pMPTfHUu5TYyMbg4zSEzN54vmTi7tW08vKvpvzeyOZj6SzduziAaGlDe2xyKZGyK1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783174004; c=relaxed/simple;
	bh=GOvqkn4CW0yZLwsgre/Rg6N8VQPTRY86MRwiRWdZbSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cov+2Rb3AP36I+6jXyd/04j53NFq3sotsRJxXfFywKsxR5DrWb8HrOO8SoG0yf23iOMRmCIBywfTKLUX4M4AVOVUFOT0PfoASZIbgm+TE8a8Mg0u3mZCoO1DX1I32giJv3Q2J4HtyH8w7+tAsB93ZBwocM+PCQ7ZnMdMraV7aBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=HgDxwSlw; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="HgDxwSlw"
Received: from [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d] (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 4B51F7BE31B;
	Sat,  4 Jul 2026 16:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1783173655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOvqkn4CW0yZLwsgre/Rg6N8VQPTRY86MRwiRWdZbSM=;
	b=HgDxwSlw6es3wxvOUoN5v0tUKrYUSOvHsF4xVojVnQhAo1Q4EGu9Xw+EViwvvt9ouUmzio
	fzjFMbtPwqiUHhEPiZXd3CZ6Ao3rX5t6ATklCqoHqFvWSiRxC65CvpDiWQZWKVq7gB44JU
	gTaIK6aErOXSzE11q+u00ZGZwTR5j8aawQUNVOHnl15Pf9Q9joMFRzpbJ+LIH0UCd+fvlT
	ryiN0aRl5KKVRa4lwS3/l4ljyG870k9HnIS259HvpOy7XJUMK5OfPyiC/yV2IAFmFvSKs2
	pre8KYUv/vGPo62kGmJueV0BFaJFjjeZaVJ7/mTUzfeWK9WY/a4DsChu4kqj3A==
Message-ID: <6cb55a3e4876ec7955c99f1ea29862b38448491a.camel@svanheule.net>
Subject: Re: [PATCH v2 0/1] watchdog: realtek-otto: Make use of regmap API
From: Sander Vanheule <sander@svanheule.net>
To: Rustam Adilov <adilov@disroot.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck
	 <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 04 Jul 2026 16:00:54 +0200
In-Reply-To: <61291b61ae4bfcc6c257dc02f12bdeaf@disroot.org>
References: <20260519182329.24472-1-adilov@disroot.org>
	 <05dd2b1d95985e303af332ec81cd830f@disroot.org>
	 <ce37814e-d275-4b0c-a50b-7b164aebd262@roeck-us.net>
	 <e99623185ad106498c6d86232e0e72e41a3495d4.camel@svanheule.net>
	 <61291b61ae4bfcc6c257dc02f12bdeaf@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-01 at 18:48 +0000, Rustam Adilov wrote:
> Hello,
> On 2026-06-23 20:44, Sander Vanheule wrote:
> > Given the reason is endianess issues, does the GPIO driver (gpio-realte=
k-
> > otto.c)
> > using ioread32()/iowrite32() still work correctly? If you have the wron=
g
> > endianess there, you would only really see issues with the GPIO interru=
pt
> > handling.
> >=20
> > If GPIO works correctly with CONFIG_SWAP_IO_SPACE enabled, then I suppo=
se
> > the
> > watchdog driver needs to be amended. Otherwise perhaps the USB peripher=
al
> > driver
> > should be compensating for its endianess?
>=20
> Actually, it is other way around. GPIO works correctly when
> CONFIG_SWAP_IO_SPACE
> is not enabled. When i do enable it, i need to patch the driver to make i=
t
> work.
> The dirty patch is here [1], which simply changes ioread32()/iowrite32() =
to
> their __raw variants inside gpio_bank_read and gpio_bank_write the and wh=
at is
> also important, the GPIO_GENERIC_BIG_ENDIAN_BYTE_ORDER flag needs to be s=
et.
> And also, i can't simply use the compatibles without GPIO_PORTS_REVERSED
> because
> the realtek_gpio_line_imr_pos is required for correct functionality.
>=20
> This patch obviously won't cut as it is going to break rtl9300 without
> SWAP_IO_SPACE.
> Maybe we could make of gpio-regmap to handle swapping and stuff? I don't =
know
> of
> any other elegant solutions to this problem.
>=20
> [1] -
> https://github.com/jameywine/openwrt/blob/bb94712cb6faccf082c5a9fcebfabdd=
f837a16bb/target/linux/realtek/patches-6.18/814-gpio-realtek-otto-change-re=
ad-write-functions.patch

Looking at the full patch (*), I see you're not only modifying the GPIO,
watchdog and timer drivers, but also some very basic reset and pinctrl code=
 to
have a functional system with SWAP_IO_SPACE. If SWAP_IO_SPACE requires you =
to
avoid byte-swapping in so many drivers, then you're just working around
SWAP_IO_SPACE. In other words, AFAICT it shouldn't be selected.

(*) https://github.com/jameywine/openwrt/commit/053aba620b12c6215e6760d8a61=
3b4ebe05d452b

If there is a single new USB peripheral driver that only works with
SWAP_IO_SPACE, then I suggest you update that driver instead of enabling an=
d
bypassing the effects of SWAP_IO_SPACE everywhere else.

Best,
Sander
