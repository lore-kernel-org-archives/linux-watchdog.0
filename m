Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FE3769EF;
	Tue, 14 Jul 2026 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027303; cv=none; b=piNvbH4bGteO0hUMMM9eVo+7tgWowffsUiqeem8WHUsn+lzn0Le+hvu+ra74xx2bmSfkiFhXPxpo+KG3smX79+C0LrQAzoae7fxL9HL/C3APf9N61QZZm7nMqs4XThwqn3+0h2VbhFYkqrctvZhpMDpApcH4XkAublwI/CpHMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027303; c=relaxed/simple;
	bh=pEMEa6ZHooYUf3eIk9re8a8UNqdlIM2KDyDzRpQYfQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qVImZx6V6FnCQaAtXK1iZa2tHRCjc8PqufvRSHUvUpak3E8G8tmSKGqt63e/79LUK+KgRoPHx68u3PhfYKiHlickC4ssjfJXxt7DBZ4h/ELqxWbEPF8DFifuzD3QIoEFIW+WM+wqcgrhfCtYlA/tee5YIwM3Uh91fqqbOR4ShoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Vg65BYWZ; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Vg65BYWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
	s=protonmail; t=1784027294; x=1784286494;
	bh=XkTMUfWG7iVX8ytkSR769C/RlyHxtxctjpAceJbq3cU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Vg65BYWZ0BWuDqQaGCm01HUFI4Nw7L/jP6TgiRCiGb69eG4qEF2Zhuc4Vlv0yWyM8
	 5Aky10WN3lwOJG4+XoMGFTDExkIpgqzfAAW//u+ZbSsMqDXiR/X2gN4tD4bibfDEUT
	 SvN8Wo32dw4nb0Q0pq6u7hDt7qSfbSISAXGfyvSW1c/ZSl8grBNNYL/01LeLDm2WF4
	 CxnZMBcQu7EoCxva0XSxt3+zmOte1JANdvz1+XLrqKUjDRYcSG2n2nG+BtFNlts2RX
	 maT+I5yfEpMy/1DLwRmKOnTXEYrnCJj7cgNMtQRCknDt7/2PfPdQc05BpTlL2LLBrG
	 LerlJaDhEYYxg==
X-Pm-Submission-Id: 4gzxP81bybz1DDLC
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>,
  <linux-watchdog@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: take all OF aliases into account when
 assigning id
In-Reply-To: <cd80d204-5daf-44d6-9b02-f11919d3e3ae@roeck-us.net> (Guenter
	Roeck's message of "Mon, 13 Jul 2026 08:48:10 -0700")
References: <20260615145759.3142743-1-linux@rasmusvillemoes.dk>
	<XobowKxdtG0mvqTiTZwSy1NPXSqtqQ8RTLdptdSlr8eYOPRHb5vtY7LlqR2d1K52jmreEvSFNhVkmbyOAvW9JQ==@protonmail.internalid>
	<15a059c9-b922-4d10-9ee2-3f362b5b603c@roeck-us.net>
	<87se5nrm90.fsf@rasmusvillemoes.dk>
	<f_IVORX2zsJBbvPt1QAg03U7oam5jKIIXYXIvCOpcHKJh-JkcB_WsPlPeQEeDTdIhRXyT_veUhXNdRj0jIJ0PQ==@protonmail.internalid>
	<cd80d204-5daf-44d6-9b02-f11919d3e3ae@roeck-us.net>
Date: Tue, 14 Jul 2026 13:08:11 +0200
Message-ID: <87jyqxsuas.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 13 2026, "Guenter Roeck" <linux@roeck-us.net> wrote:

> On 7/13/26 07:35, Rasmus Villemoes wrote:
>> On Wed, Jul 08 2026, "Guenter Roeck" <linux@roeck-us.net> wrote:
>>
>>> On Mon, Jun 15, 2026 at 04:57:59PM +0200, Rasmus Villemoes wrote:
>>>> If some, but not all, watchdog devices have device tree aliases, those
>>>> without aliases might (depending on probe order) be assigned an id
>>>> which would otherwise be assigned to one of those with an alias.
>>>>
>>>> This is problematic when for example watchdog0 is an alias for an
>>>> always-running gpio watchdog that userspace must handle, but the SOC's
>>>> watchdog device(s) get probed first and thus one of those become
>>>> /dev/watchdog0.
>>>>
>>>> Ensure that ids for devices without a device tree alias are allocated
>>>> from above the highest numbered alias, if any.
>>>>
>>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>>> ---
>>>>
>>>> This is similar to how the mmc, i2c, i3c and spi subsystems handle
>>>> device tree aliases and avoid using an id that might be assigned to a
>>>> device/bus that is probed later.
>>>
>>> The patch makes sense. Unfortunately, there are systems with aliased
>>> watchdogs which do not enable "watchdog0" (e.g., several Nuvoton based
>>> boards). On such systems, if they do have an unaliased / auto-generated
>>> watchdog, /dev/watchdog0 and with it /dev/watchdog would no longer be
>>> created. This would result in a ABI break.
>>>
>>> On top of that, the patch only affects systems with both aliased and
>>> un-aliased watchdogs, which makes me even more concerned.
>>
>> Well, yes, the problem only occurs on exactly such systems.
>>
>> - If all enabled watchdog devices have DT aliases, they all get their
>> assigned id.
>>
>> - If no wathcdog device has a DT alias, they'll just get sequentially
>> assigned ids in probe order, and none of them will "accidentally" get an
>> id that should be assigned to a device with a DT alias.
>>
>>> To apply this or a similar patch, we would have to ensure that there
>>> is no enabled watchdog with ID == 0.
>>
>> I'm not sure I completely understand your concern(s), but I can see that
>> if there is any watchdog DT alias, we'll never use id 0 except if there
>> is a watchdog0 DT alias (and that device is actually enabled).
>>
> ... and if ID 0 is not used in that situaton, /dev/watchdog will not be
> created since it is tied to /dev/watchdog0.
>
>> What if instead of assigning dynamic ids from above the highest existing
>> alias, we assign a dynamic id as usual, but skip existing aliases? So if
>> there's a watchdog1 alias, but no watchdog0 alias, the first unaliased
>> watchdog device being probed would become /dev/watchdog0 and hence
>> /dev/watchdog. Would that work?
>>
>
> Yes, since that would not change existing behavior.
>
> Is this an problem that is actually observed on some system, or a theoretic
> one ?

Well, a little of both. I did observe it on a board I'm working on, but
as I'm authoring the .dts, I can/could just ensure that all watchdog
devices get aliases, and then they'll get exactly the ids I expect, and
userspace will know which watchdog device(s) it must handle.

It just caught me a little by surprise that when I only had watchdog0 =
&gpio_watchdog and watchdog1 = &soc_watchdog0 aliases (because those
were the only two I initially cared about, but the SOC has 5 instances
of its watchdog IP), I ended up with

  /dev/watchdog0 -> soc watchdog1
  /dev/watchdog1 -> soc watchdog0
  /dev/watchdog2 -> soc watchdog2
  /dev/watchdog3 -> soc watchdog3
  /dev/watchdog4 -> soc watchdog4
  /dev/watchdog5 -> the gpio watchdog

And that was only after I enabled the driver for the soc watchdogs,
before that I only had the gpio watchdog, which of course became
watchdog0 as it should.

So since I knew the mmc and i2c subsystems had this mechanism to avoid
using ids that exist as aliases, I went to look at the watchdog code and
see how it did the "use alias id if possible", and saw that there was no
handling of the "some with, some without" alias case. So while I don't
really need this for the board I'm doing bringup on right now (I've
added aliases for all), it's something that could

I've sent a v2 where I use any available and not "reserved by alias" id.

Thanks,
Rasmus
