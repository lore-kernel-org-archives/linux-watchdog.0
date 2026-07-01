Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84609257845;
	Wed,  1 Jul 2026 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931693; cv=none; b=QpnZHvMAdmiVUXmZOSCYVebZ86Cm+aiZFZC9VUALhwA3pcraCvB4uhwXPh07gd3Cl4LTsRVSF1VcYvpT+HWAKVzYdR9BS+LuMkGgMvBnsilxsZUN9b2FzhPeviAbpl3mdWZXZqMOiho5cnbYX83RWy/sc4Jvo50Ivz9a9sxwEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931693; c=relaxed/simple;
	bh=EBYhBzU40/KAB+3ZX9XeQEHOBu/YbKwtBPmFJsqFliw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rKcyeQhPbFTt4sEGy6BSnVZ8yPaRsXZzR4A/5f6iN9KVHahYBbLoxPROdLonUSmC3gOBZugEBGFIKX4twBga4LqO9YDwGEMxtwYLpS2mEzn9nVQkAJoaq34qFpuroByfho7buiipQjtOEndX/Ql4WRABFiCn+LqZS2hZ9mgWwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=U3iEfO3C; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="U3iEfO3C"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9F4FA84146;
	Wed, 01 Jul 2026 20:48:08 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwuLvSeedy9q; Wed,  1 Jul 2026 20:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782931687; bh=EBYhBzU40/KAB+3ZX9XeQEHOBu/YbKwtBPmFJsqFliw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U3iEfO3C7GA5600PNf41KW/iwrAKnWSeFXFYkPU/ueiElEzcY2FotIY+exjy8BDJ7
	 V44WSlpuj8y/0Z9KeOK+aPENuML+6tEGmTL2ybZKlH0UV2t1omH5B9KYNSFsdZJYSh
	 PChva9coSpPIIGwOGdNosL8+t6ECqp0FdA97R3vo7/KQflSOmr0MLVmGr7/PpzKUE5
	 1sxP54+P0phFUtJknoroCag7JjCD3CG5m7vHrOOP4qk9Mqs8oP5AUDa7JBu+uW4E3m
	 mhllZNZchs/W3w0I389PoONXe+9bNyfK/GlUIlVMSloOkoFbkJtfQZmw+Dgr7dP3ko
	 k7S+6XU2vyaSA==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Jul 2026 18:48:06 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] watchdog: realtek-otto: Make use of regmap API
In-Reply-To: <e99623185ad106498c6d86232e0e72e41a3495d4.camel@svanheule.net>
References: <20260519182329.24472-1-adilov@disroot.org>
 <05dd2b1d95985e303af332ec81cd830f@disroot.org>
 <ce37814e-d275-4b0c-a50b-7b164aebd262@roeck-us.net>
 <e99623185ad106498c6d86232e0e72e41a3495d4.camel@svanheule.net>
Message-ID: <61291b61ae4bfcc6c257dc02f12bdeaf@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,
On 2026-06-23 20:44, Sander Vanheule wrote:
> On Tue, 2026-06-23 at 11:44 -0700, Guenter Roeck wrote:
>> On 6/20/26 04:23, Rustam Adilov wrote:
>> > Hello,
>> > 
>> > I have noticed the status for this patch series is "Changes Requested"
>> > in the patchwork site but the maintainer opposes the requested changes
>> > by Sander in [1], so what do i do here? It is just one the roadblocks
>> > to get USB stuff supported for Realtek chips.
>> > 
>> > I have already sent a reply week later in [2] but didn't get a response
>> > back. Maybe this email could be served as a gentle remainder.
>> > 
>> 
>> I said:
>> 	So this is now a NACK if unnecessary error handling is indeed added,
>> 	unless someone convinces me that this would add some benefits that I
>> 	am unable to see.
>> 
>> Your response did not explain the benefits of adding the unnecessary error
>> handling. I did not see a rationale from Sander either.
> 
> I mainly brought it up because I have been asked elsewhere [1] to check the
> regmap return codes. Although that was for a device on an MDIO bus, which I
> suppose is more likely to actually generate errors.
> 
> [1] https://lore.kernel.org/linux-leds/CAMRc=Mdb7CWB9PmzXJyfvGjvG0iwuwUgfLuKJuMweRFvAhAoHg@mail.gmail.com/

Thanks for clarification. I will take it as i don't need to add the error
handling.

As for why my response didn't explain it. I didn't want to speak for Sander so
i decided to just wait on it.

>> On top of that, your patch did not explain the real reason for the patch,
>> as stated in your reply. This means that, for me, it was just a patch making
>> no functional changes for no good reason other than to potentially _increase_
>> code complexity by adding unnecessary error handling while at the same time
>> claiming that code complexity would be reduced.

I can change the commit message to mention this main reason in the next patch
version.

> Given the reason is endianess issues, does the GPIO driver (gpio-realtek-otto.c)
> using ioread32()/iowrite32() still work correctly? If you have the wrong
> endianess there, you would only really see issues with the GPIO interrupt
> handling.
> 
> If GPIO works correctly with CONFIG_SWAP_IO_SPACE enabled, then I suppose the
> watchdog driver needs to be amended. Otherwise perhaps the USB peripheral driver
> should be compensating for its endianess?

Actually, it is other way around. GPIO works correctly when CONFIG_SWAP_IO_SPACE
is not enabled. When i do enable it, i need to patch the driver to make it work.
The dirty patch is here [1], which simply changes ioread32()/iowrite32() to
their __raw variants inside gpio_bank_read and gpio_bank_write the and what is
also important, the GPIO_GENERIC_BIG_ENDIAN_BYTE_ORDER flag needs to be set.
And also, i can't simply use the compatibles without GPIO_PORTS_REVERSED because
the realtek_gpio_line_imr_pos is required for correct functionality.

This patch obviously won't cut as it is going to break rtl9300 without SWAP_IO_SPACE.
Maybe we could make of gpio-regmap to handle swapping and stuff? I don't know of
any other elegant solutions to this problem.

[1] - https://github.com/jameywine/openwrt/blob/bb94712cb6faccf082c5a9fcebfabddf837a16bb/target/linux/realtek/patches-6.18/814-gpio-realtek-otto-change-read-write-functions.patch

>> Also, I do not recall even an attempt to address (or even comment on) the
>> actual problem with the driver as reported by Sashiko.
> 
> I did have a look at this report [2], but I didn't manage to figure out if the
> behavior I see matches the reasoning by the bot. Since I didn't get any
> feedback, I left it as is.
> 
> [2] https://lore.kernel.org/linux-watchdog/d0b159eefa6bc5abf0d1531acde568396f480500.camel@svanheule.net/

Oh yes, thanks for bumping it back. I'll leave it to Guenter Roeck to leave a
feedback as i am not even nearly qualified to understand it.

> Best,
> Sander

Best,
Rustam
