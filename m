Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F733B8D40;
	Tue, 26 May 2026 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827038; cv=none; b=YOG2XJJcWYiscqh80AXZM+i6JSECfAdUcPJbT0LYHCL53Jy998Fz9pskiOHIf/wS442jftLEQt/DbqHLCeHiuKf7qkzMD9pjOBkOpGWmKrxf7J/3BjoSuSwiCtJy8H1VFcvuARe2LvB9Mevex8kC/y4kfpEOBWjUXcR0G26IvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827038; c=relaxed/simple;
	bh=K4WUr4jRjQjauMqgKe7OsAR7DtnPe9kBvJbGsr0uYV4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M1dqmKaVvrLW44ySonr7rC6nF+X4yAKe2GCXiL/Hs8ApoEI2lXFIte3r06JZNJFSiB19MgG0bvxG1sR/psfMSJeh0H+GePp8wWSZycWyLGCm4kqBizhZ6gfKgHmwh41yoEI81ma1RyQIfagYJNS9XoiYjUAjbgr2T3S3rrgkjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DfyIdIC+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DfyIdIC+"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 04FB8262BE;
	Tue, 26 May 2026 22:23:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44sUwlrjCxEb; Tue, 26 May 2026 22:23:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1779827033; bh=K4WUr4jRjQjauMqgKe7OsAR7DtnPe9kBvJbGsr0uYV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DfyIdIC+de6dUMqbDFzVwf26eSzsO7EOi6oxsnZ0Rx972eH1CTBNW+ROoDTabgLci
	 LcUvY2BXhdNmDgJEGRTCDEXzWed1yQJhyz1Sx33CuOTD7QHZ6Efx7xJ2l4QbTHDNfA
	 6n97JO7sYNtKEGPA+CYqnzokMHN87fUfz8NQaNb8WxZBCfFsF71iZVTtT294RupvCg
	 3ecrnlorlFZDPd3AVc1FmGeG6j70PjTMs+kwszcJuyowaDbOmo1+vT6e89VNoBkKP8
	 oDBqttXRxoqqXCNFNfH8B5V4lrZ5y/dDtUexgRs7N71FgQ3cFdX/TtJ8oJhXzMeYnf
	 H5MZQoKEHXX4Q==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 20:23:53 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sander Vanheule <sander@svanheule.net>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] watchdog: realtek-otto: Change to use regmap API
In-Reply-To: <1d5091ff-e497-4b5a-a906-7cc02c31c4c0@roeck-us.net>
References: <20260519182329.24472-1-adilov@disroot.org>
 <20260519182329.24472-2-adilov@disroot.org>
 <6ff773c9cf93167fbfcf5d9a40106121f9ac8238.camel@svanheule.net>
 <1d5091ff-e497-4b5a-a906-7cc02c31c4c0@roeck-us.net>
Message-ID: <b4b09be5ff456a23d15a5af3237b9b46@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026-05-19 19:25, Guenter Roeck wrote:
> On 5/19/26 12:00, Sander Vanheule wrote:
>> Hi Rustam,
>> 
>> On Tue, 2026-05-19 at 23:23 +0500, Rustam Adilov wrote:
>> [...]
>>> @@ -74,24 +75,17 @@ struct otto_wdt_ctrl {
>>>   static int otto_wdt_start(struct watchdog_device *wdev)
>>>   {
>>>   	struct otto_wdt_ctrl *ctrl = watchdog_get_drvdata(wdev);
>>> -	u32 v;
>>> -
>>> -	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
>>> -	v |= OTTO_WDT_CTRL_ENABLE;
>>> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>>>   +	regmap_set_bits(ctrl->regmap, OTTO_WDT_REG_CTRL,
>>> OTTO_WDT_CTRL_ENABLE);
>>>   	return 0;
>> 
>> iowrite32() doesn't return anything, but regmap_set_bits() does.
>> 
>> You can turn this into
>>      return regmap_set_bits(...);
>> 
>>>   }
>>>     static int otto_wdt_stop(struct watchdog_device *wdev)
>>>   {
>>>   	struct otto_wdt_ctrl *ctrl = watchdog_get_drvdata(wdev);
>>> -	u32 v;
>>> -
>>> -	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
>>> -	v &= ~OTTO_WDT_CTRL_ENABLE;
>>> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>>>   +	regmap_clear_bits(ctrl->regmap, OTTO_WDT_REG_CTRL,
>>> +			  OTTO_WDT_CTRL_ENABLE);
>>>   	return 0;
>> 
>> Same as above.
>> This is probably short enough to keep is on one line? (< 100 characters)
>> 
>>>   }
>>>   @@ -99,8 +93,7 @@ static int otto_wdt_ping(struct watchdog_device *wdev)
>>>   {
>>>   	struct otto_wdt_ctrl *ctrl = watchdog_get_drvdata(wdev);
>>>   -	iowrite32(OTTO_WDT_CNTR_PING, ctrl->base + OTTO_WDT_REG_CNTR);
>>> -
>>> +	regmap_write(ctrl->regmap, OTTO_WDT_REG_CNTR, OTTO_WDT_CNTR_PING);
>>>   	return 0;
>> 
>> Same as above.
>> 
>>>   }
>>>   @@ -126,7 +119,7 @@ static int otto_wdt_determine_timeouts(struct
>>> watchdog_device *wdev, unsigned in
>>>   	unsigned int total_ticks;
>>>   	unsigned int prescale;
>>>   	unsigned int tick_ms;
>>> -	u32 v;
>>> +	u32 mask, val;
>>>     	do {
>>>   		prescale = prescale_next;
>>> @@ -142,14 +135,11 @@ static int otto_wdt_determine_timeouts(struct
>>> watchdog_device *wdev, unsigned in
>>>   	} while (phase1_ticks > OTTO_WDT_PHASE_TICKS_MAX
>>>   		|| phase2_ticks > OTTO_WDT_PHASE_TICKS_MAX);
>>>   -	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
>>> -
>>> -	v &= ~(OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 |
>>> OTTO_WDT_CTRL_PHASE2);
>>> -	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
>>> -	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
>>> -	v |= FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
>>> -
>>> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>>> +	mask = OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 |
>>> OTTO_WDT_CTRL_PHASE2;
>>> +	val = FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
>>> +	val |= FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
>>> +	val |= FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
>>> +	regmap_update_bits(ctrl->regmap, OTTO_WDT_REG_CTRL, mask, val);
>> 
>> To be consistent, you would also need to propagate the result of
>> regmap_update_bits() if it's an error. Same for the other regmap_*() calls.
>> 
> 
> I am now inclined to reject this patch. regmap mmio never returns errors
> unless it is associated with clocks, and now useless error handling is
> requested. That defeats the idea of simplifying the code. Instead, its
> complexity is increased by adding unnecessary error handling.
> 
> So this is now a NACK if unnecessary error handling is indeed added,
> unless someone convinces me that this would add some benefits that I
> am unable to see.
> 
> Guenter

Hello,
Sorry for taking so long to reply.

Just to be clear, i didn't have a chance to do anything about the requested
error handling. Looking at the existing watchdog drivers that use regmap, some
implement the error handling and some don't and that's a bit confusing to me.
I would like to see if Sander has something more to say here.

While i am here, this whole patch is not specifically for simplifying the code.
It is also about fixing an issue where the CONFIG_SWAP_IO_SPACE is enabled. It
makes it so that ioread32 and iowrite32 perform byte swap and since this driver
expects them not to byte swap, things break. RTL9607C is expected to have it for
USB support.
Alternatively i could have used __raw_readl and __raw_writel instead of regmap but
i felt like regmap would be more accepted.

Best,
Rustam
