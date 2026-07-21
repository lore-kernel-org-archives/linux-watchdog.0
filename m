Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D740096A;
	Tue, 21 Jul 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654196; cv=none; b=Qwaoy76zGosa5VjIGVugoe4gDSlPW19taK5NZ231pmujdnBz+R90H8S5ksP8NcreizdIGCBtFyR4AMt74afCpQhd+sVzcImI9fca6rwVDAVB2r8rDKP6FwyNCj+lA+hgdy3zovn/9VwLBSi9bFnRjyOIIQwmKmdRMm7s/9RK5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654196; c=relaxed/simple;
	bh=F4G0/DcjYcXxAIfyxGrK2b4rNPlszrnq2Mg/2VCQxI0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nHtpqKdgxAUDGPByD/DSF8bxWv3nl91ws6D8/Mfgj0nMfkBbzRUGrOsk5oT43U2N3Jdb5uSjw2zQ9cYFcdz1Aeg0MmlKQ8PVke6Q5aCGP2ObFS0vosK6JKnc+5EEE+gLM6ecSZBVpHkiG7bNYVq27G9h1i8Fnb5WQzgrNwNJu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dA8y3DTW; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dA8y3DTW"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0BE4A84C10;
	Tue, 21 Jul 2026 19:16:24 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JEfM8_paFuoM; Tue, 21 Jul 2026 19:16:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784654183; bh=F4G0/DcjYcXxAIfyxGrK2b4rNPlszrnq2Mg/2VCQxI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dA8y3DTWW63S7eMVVDM/RJ3DJwsJCHF7V3CE4W8rHuG78H8cI5k9Yjy1v7emeklRR
	 pGLvaXwxjMml54uLpEStcnpsSeeUvn10VGDCh4pvJrxTwN9nE4avCXLcK5K6JHEcse
	 yyoDQ4+VfgqgTA2EUlr6KZRtJCsqz6lH59ql97GVlaMLBiuK/L9Gj2pecwDrx+4v7B
	 zfp5sDNAQU3XB6F7awLu2sYQcx3852klVeLvY5uT5gDKNQTy5MDAPFwzzsd0IZdHRY
	 Iwfx5gsEOrqdGjD4ItQmU6ad7pUtk2r3Zz0Ikj9lPTD419saXL1u3ckzFTXAEPs03K
	 BMz0fowU4Or4Q==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Jul 2026 17:16:22 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-watchdog@vger.kernel.org, Guenter Roeck
 <linux@roeck-us.net>, markus.stockhausen@gmx.de, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 1/2] gpio: realtek-otto: use __raw_readl/writel in
 realtek_gpio_update_line_imr()
In-Reply-To: <d27c366d6e28a5f50ddcdfe456bf844cbaab9d0a.camel@svanheule.net>
References: <20260710183439.996923-1-adilov@disroot.org>
 <20260710183439.996923-2-adilov@disroot.org>
 <d27c366d6e28a5f50ddcdfe456bf844cbaab9d0a.camel@svanheule.net>
Message-ID: <67b04e0f531c3d7a295cc5fc37b62a21@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,
On 2026-07-20 16:32, Sander Vanheule wrote:
> Hi,
> 
> Adding linux-mips as SWAP_IO_SPACE is mostly a MIPS thing, and some lists/people
> for your other pending patches.

I think linux-mips would have been enough but that's fine.

> On Fri, 2026-07-10 at 23:34 +0500, Rustam Adilov wrote:
>> In preparation for upcoming changes to how bank reads and writes
>> are defined in this driver, change the ioread32 and iowrite32 to
>> their __raw variants. The realtek_gpio_update_line_imr() function
>> is used by all devices regardless of GPIO_PORTS_REVERSED flag and
>> thus this is the only place where there shouldn't be any byte
>> swapping whether SWAP_IO_SPACE config is enabled or not and that
>> is only possible with __raw_readl and __raw_writel.
>> 
>> Signed-off-by: Rustam Adilov <adilov@disroot.org>
>> ---
>>  drivers/gpio/gpio-realtek-otto.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-
>> otto.c
>> index 4a606bad5848..491fde846d46 100644
>> --- a/drivers/gpio/gpio-realtek-otto.c
>> +++ b/drivers/gpio/gpio-realtek-otto.c
>> @@ -176,10 +176,10 @@ static void realtek_gpio_update_line_imr(struct
>> realtek_gpio_ctrl *ctrl, unsigne
>>  	u32 reg_val;
>>  
>>  	reg += 4 * (line_shift / 32);
>> -	reg_val = ioread32(reg);
>> +	reg_val = __raw_readl(reg);
>>  	reg_val &= ~(REALTEK_GPIO_IMR_LINE_MASK << shift);
>>  	reg_val |= (irq_type & irq_mask & REALTEK_GPIO_IMR_LINE_MASK) <<
>> shift;
>> -	iowrite32(reg_val, reg);
>> +	__raw_writel(reg_val, reg);
>>  }
>>  
>>  static void realtek_gpio_irq_ack(struct irq_data *data)
> 
> As per my earlier message on your watchdog patch [1], I'm still not convinced
> converting all existing drivers [2, 3] to work around an issue with the USB
> framework is the right thing to do. You claim the required USB changes are not
> upstreamable, but I have not seen you make an attempt at doing so.

Yes, i did claim it and the lack of attempt is my fault which i should have done
right away when i sent out the patches to phy-rtk-usb2.c [5] back in March.
I've just set the expectations that to me seem very logical but didn't get to
check them in practice. Though really my reasoning comes down to "We are trying
to recreate what readl() and writel() should supposedly do and SWAP_IO_SPACE is
only way to make them work".

I don't think it is necessary specific to USB as the same would have happened if
some other peripheral were to be in "little endian" mode. That is because our
realtek chips are big endian MIPS and kernel has an interesting ways of going
about their io.

There is however an ongoing patch series in linux-usb [6] that could be of use
if SWAP_IO_SPACE turns out to be a wrong approach after all.

[5] https://lore.kernel.org/linux-phy/20260326193419.48419-1-adilov@disroot.org/
[6] https://lore.kernel.org/linux-usb/20260713122205.1350933-1-daniel@thingy.jp/

> Can the people from linux-mips shine their light on whether using __raw_*() to
> work around the effects of SWAP_IO_SPACE is reasonable? My gut feeling is this
> indicates SWAP_IO_SPACE shouldn't be enabled. Markus has apparently made the
> same remark [4].
> 
> [1] https://lore.kernel.org/all/ebdcb8c5563ceff723f3e4a3c4fdfe9bf87d42fa.camel@svanheule.net/
> [2] https://lore.kernel.org/linux-watchdog/20260710074316.46643-1-adilov@disroot.org/
> [3] https://lore.kernel.org/all/20260511131520.98420-1-adilov@disroot.org/
> [4] https://lore.kernel.org/all/016d01dce49a$36b7bd60$a4273820$@gmx.de/
> Best,
> Sander

Best,
Rustam
