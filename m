Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8781A01BE;
	Sat,  4 Jul 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178008; cv=none; b=C49UGzi54QWxobhvkDF/obKRTgnrSU8XUNtHDdxu7f86JMsab0QlsIEnnG1e7DxzrS1IIGKZhCBqXjlA9fe8OEod6+ZGzyE4FkpwuY1VAsdGUCxFwg1z76dUEyxAB20o3vyMwHjhgrMtTGDfecQ9WZB58rpCchEkbsZENXkdgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178008; c=relaxed/simple;
	bh=Lg3iiDCzVEKNBuHejjdoSD9V3ubYmTrnl99RPY3hy3A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=denBUyMBkoEL4F2Lb3xIJxx7uYDrvK39YvG0HeLDxuVkzjf4gBgg9kPpguo48JPnX25nRHNprLwxPkD1JivPcHU1uS96x5Oz99d7fXR19bxlH7VDm8xqj5uDBA4VkGRks5rrancycjxdCKZ8wyatlpan7+udC1VEVjivfbKCehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=djuiTsjh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="djuiTsjh"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DF1C684AD4;
	Sat, 04 Jul 2026 17:13:16 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGJmkEpHmV4m; Sat,  4 Jul 2026 17:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1783177996; bh=Lg3iiDCzVEKNBuHejjdoSD9V3ubYmTrnl99RPY3hy3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=djuiTsjh64GroDVpMhzKHnhYzPfrWN/HBOn3hn2TBZ/sNdB5VB0l7YK6bN7kiDaI5
	 a7BJ4ndVL96GBwK6nWcLnyExtK1tPxT5x2ctyCnSz/+CMQbOMUXlzcacsw/F+rxtal
	 iBQIiMEZ2z8v7zQcgx8hfhgPyhCcmLhEAIeXCucpMyU7BBtjw1pjIJUI91ZrQwCLvO
	 Jvu6XDLah8C4Y2LgPdM5jot5zFpScyG9dg38TGR8KHBPkummlvlGxrH3vnwCQQT8L2
	 Z2RLDTBEkKbsYnPG9+Ta0WzpQv6DpgcI3E7qlalcJWFw9Q5kqty12xnzAeFXxnZ2Nh
	 GFe5S1+HfMvxQ==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Jul 2026 15:13:15 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] watchdog: realtek-otto: Make use of regmap API
In-Reply-To: <6cb55a3e4876ec7955c99f1ea29862b38448491a.camel@svanheule.net>
References: <20260519182329.24472-1-adilov@disroot.org>
 <05dd2b1d95985e303af332ec81cd830f@disroot.org>
 <ce37814e-d275-4b0c-a50b-7b164aebd262@roeck-us.net>
 <e99623185ad106498c6d86232e0e72e41a3495d4.camel@svanheule.net>
 <61291b61ae4bfcc6c257dc02f12bdeaf@disroot.org>
 <6cb55a3e4876ec7955c99f1ea29862b38448491a.camel@svanheule.net>
Message-ID: <9362a24cca55f60f89157ca9537a5eab@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2026-07-04 14:00, Sander Vanheule wrote:
> On Wed, 2026-07-01 at 18:48 +0000, Rustam Adilov wrote:
>> Hello,
>> On 2026-06-23 20:44, Sander Vanheule wrote:
>> > Given the reason is endianess issues, does the GPIO driver (gpio-realtek-
>> > otto.c)
>> > using ioread32()/iowrite32() still work correctly? If you have the wrong
>> > endianess there, you would only really see issues with the GPIO interrupt
>> > handling.
>> > 
>> > If GPIO works correctly with CONFIG_SWAP_IO_SPACE enabled, then I suppose
>> > the
>> > watchdog driver needs to be amended. Otherwise perhaps the USB peripheral
>> > driver
>> > should be compensating for its endianess?
>> 
>> Actually, it is other way around. GPIO works correctly when
>> CONFIG_SWAP_IO_SPACE
>> is not enabled. When i do enable it, i need to patch the driver to make it
>> work.
>> The dirty patch is here [1], which simply changes ioread32()/iowrite32() to
>> their __raw variants inside gpio_bank_read and gpio_bank_write the and what is
>> also important, the GPIO_GENERIC_BIG_ENDIAN_BYTE_ORDER flag needs to be set.
>> And also, i can't simply use the compatibles without GPIO_PORTS_REVERSED
>> because
>> the realtek_gpio_line_imr_pos is required for correct functionality.
>> 
>> This patch obviously won't cut as it is going to break rtl9300 without
>> SWAP_IO_SPACE.
>> Maybe we could make of gpio-regmap to handle swapping and stuff? I don't know
>> of
>> any other elegant solutions to this problem.
>> 
>> [1] -
>> https://github.com/jameywine/openwrt/blob/bb94712cb6faccf082c5a9fcebfabddf837a16bb/target/linux/realtek/patches-6.18/814-gpio-realtek-otto-change-read-write-functions.patch
> 
> Looking at the full patch (*), I see you're not only modifying the GPIO,
> watchdog and timer drivers, but also some very basic reset and pinctrl code to
> have a functional system with SWAP_IO_SPACE. If SWAP_IO_SPACE requires you to
> avoid byte-swapping in so many drivers, then you're just working around
> SWAP_IO_SPACE. In other words, AFAICT it shouldn't be selected.
>
> (*) https://github.com/jameywine/openwrt/commit/053aba620b12c6215e6760d8a613b4ebe05d452b

I would say it is more of working around limitation of big endian MIPS with little
endian USB controller but more on that in the message below.

> If there is a single new USB peripheral driver that only works with
> SWAP_IO_SPACE, then I suggest you update that driver instead of enabling and
> bypassing the effects of SWAP_IO_SPACE everywhere else.

Sadly it is not much to do with a single USB driver (technically yes if you count
ohci-platform and ehci-platform) but everything to do with the reads and writes
functions in ehci.h and ohci.h files. If we don't select SWAP_IO_SPACE, we have to
basically change them to perform a byte swap as we can't use readl nor readl_be
functions for that. You can check how that would look like in [1] but that would
not be acceptable by upstream nor any other similar modifications to those header
files i don't think.

And that is a crux of the problem. That same can be seen with rtl930x and rtl931x
in [2]. SWAP_IO_SPACE as far as i can see, is the only solution to be upstreamable.

[1] https://github.com/openwrt/openwrt/commit/ba48e61e9da58b38d69fc58f90f9fcd93c11862b
[2] https://github.com/openwrt/openwrt/pull/23508

Best,
Rustam
