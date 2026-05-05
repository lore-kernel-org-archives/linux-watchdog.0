Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB894418CE
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986314; cv=none; b=Tw4oSE3awgMm6smWAtenWJbKBqc2+NMxc7Sc+GvO4jpEHOTEtpifgiWJ5sdLtfaLP8k99rcU3vcWwGpKIAjNb5zAR+A030Zy/40MeF71VCF6t65Fkc7ZuRxFG+26r2A5wUdVjoOJUsqSgjErwLmCn2mEin4Hqq4glgk8nwPzPaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986314; c=relaxed/simple;
	bh=EOmlUoqN1M03pFuBHA59hJOLc7j2VRvhKeXiyDOv2WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcgXHtqjejqmaOUf50XjfFu1N3x76VhHtECnoIIAfFIpCCbo/0CXzQCZj5OdsK/xF5CQqIUXq58cV7KDuVmS9V8SjOrIe2q+9Cy0sMRL5CxVYS0czVwP1jz/8eAfZF/nZVQLzeB+B6/aD0+fSq1El9iCL4pg0u+2dvFwNgN8o98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeFKhwX8; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeFKhwX8"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3847751eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986309; x=1778591109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5ea3OBYxAhk3J4Y0N8Z40Ee8KbTHOIQem75bzbMpWoQ=;
        b=oeFKhwX8F8WrZ5hPz27t8ALD6SWSI1QnYNIdMqwC781Hck8nxNLrX52cQcJrOGjfK2
         lrqGHy4IW5S7v+ouNMGf5sO5BJjiGpiNEfxzJ7I5Q0DYJHPuoM3Oo37wCwvnLGcW4aNE
         0xIgogMO3/3YU3mKY2/jUsLZZTzqJcQn0bkrAAOXYWtydtCHi4XT5IdJ+soea+pkQFr0
         BHFPhQVwUWwhTB/K1xLuNAItJiRqppu9DqdwyTBz076XrdCYiX92ZCSogb6uTzCvw4nH
         JcF58MlTVP7e/ZBQf3TOc1da6rNJ0eJm1DhPhgcs6TVbrwT9DOr7K+Vi1bSAJe8wL/2u
         DJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986309; x=1778591109;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ea3OBYxAhk3J4Y0N8Z40Ee8KbTHOIQem75bzbMpWoQ=;
        b=juS4Npt/y1lRkEza1JNmV9NDZsGvd4f2vNdGzc7HoaQD6gbLKXOqr/zoeD/DiBvjVO
         ehWCvLN46WlLe1uSoGT4jPRJ/EuhgSyZC2ranAmSpqPN9ymfh6LM2fhgpdZPkSDmp3Yz
         M3Ox/AzI6AQ3xPbkMK9GypoCYQVw9uETnbMEPjNgipsPAx2fnx30h0ZEzjwdBpq0h69R
         vZDoevJCnhRuqbSuo3OwoOXIJ+8B6MAG8x7gwuKz0mcmRekJ+wqnsrQnDuvA7+ghIH8x
         LKee5gQbo6r2UoIz72gIqEemAUlzxg+9MvvCYgGSp7dwgnhsLbIF2FFRdZ6BqaUy3c5r
         F/Bg==
X-Gm-Message-State: AOJu0YziBkaMaEY+lG4GnxZ19x2i7XqJhgMcY4XQsp5zVW4BFLFEWka3
	ELUgeT4EsAXFaltr8tbm+aBwq5rcnDSCjxi3OpuYyuGsse6T6+b3GNtY
X-Gm-Gg: AeBDietLZmM4ckP52mgAG/y7aVcmB3bN8k0CaW5n2/Egu32aOImafORWronJLsFDjMq
	791iHMqi3KYL1KyZLRZgKfmDS8j2Xi1lnsA0Vtk8hnJHeRRmgqm3UeL3EUSwLta0b2fROIHaHLj
	48uVYKGjTUQcF5BwlSkEdvSlZsf9bhksXprghZBOqIrLM9T+3ddlaiZII8N9jQpFxPrfcWmWqqC
	UbGI10NK6ZMA9/CMlYOHRAiXdBrcGaQ2xRF3NLzmChkQBSgzaqo2wye3akBvzW3aAXqPecJG3l7
	QshZ9k5LlxQhdXHK4FLIKy/zBj2+uE6iCBtpaDOPMIibY/naZfbPPmPWl52xcuYg9ZIN+xflMOX
	wLv3R0XmCXvE9j8OrcqD6lS0RBFplzsSgKM0Wyp3xwgciizT664U60xLW5Lmqj+eW9UOhT8V6I0
	W3UPCw6Q9IBck+nQwxX1TgJWLZgcnT8y7t6Z6pgeAt0Iw+8QqgK8x/gFA8uhdaTUQk98ZctdBnY
	O7udrYMsz0=
X-Received: by 2002:a05:7300:dc14:b0:2be:88f2:3c98 with SMTP id 5a478bee46e88-2f3ce40df79mr1589022eec.1.1777986308830;
        Tue, 05 May 2026 06:05:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3537d300sm24481829eec.0.2026.05.05.06.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:05:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5718f557-394c-404d-ae23-5c07c733b268@roeck-us.net>
Date: Tue, 5 May 2026 06:05:06 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: remove drivers for discrete ISA WDT cards
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20260505023007.58175-1-enelsonmoore@gmail.com>
 <9d134dfa-76be-4242-bae4-c4a02036f53e@roeck-us.net>
 <CADkSEUhJnA0d6hh8vfa8ZBpUDi2GyH9pHYSbRmrRuRNjXcPRig@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CADkSEUhJnA0d6hh8vfa8ZBpUDi2GyH9pHYSbRmrRuRNjXcPRig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/4/26 22:39, Ethan Nelson-Moore wrote:
> Hi, Guenter,
> 
> On Mon, May 4, 2026 at 9:59 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> Umm ... no. Declare them deprecated and announce that they will be removed
>> in a later kernel version unless someone speaks up. Do a Google search for
>> "How to deprecate Linux kernel code" and follow the guidance.
> 
> In my personal opinion, that isn't necessary and probably wouldn't help.
> 
> The kernel tried doing official deprecation anouncements a long time
> ago via feature-removal-schedule.txt, but they turned out to be
> useless because no one was reading the file. It was removed in commit
> 9c0ece069b32e8e122aea71aa47181c10eb85ba7 (which I will refrain from
> quoting here because it was written in classic Linus style).
> 
> Other subsystems have been removing drivers without notification and
> only restoring them if someone complains.
> For example, see:
> - git log drivers/net/ethernet/Makefile (note how fealnx was removed
> and restored because someone was using it)
> - commit c0fef45dbab0 ("char/mwave: drop it")
> - commit 9b12f050c76f ("char: pcmcia: remove all the drivers")
> 

Typically not without previous discussion, which did not happen here.

You are not the decider for this subsystem, much less one to make decisions
without even consulting maintainers first. I'll just ignore your removal
patches.

Guenter

