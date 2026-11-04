Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853651;
	b=XU5oTwwyyM+DzV4MEg3y4vfVRANIu1mWzqINpoLQiXwPQeo+j/DUKkWZk6D4N1Evt05/
	 Wg/Oz/FPdkZKhkri2PN3aXAb8Nj5/LHcgXDY8b1o497kMYXhZTXNKrG2TX5DkcLDmleVo
	 rMxy99FPBryLfoi+1HEX/fSGxpKj0U4YDarKq0PK+aIsKOY3s4AgMkBtC8LLpFwDl80Ib
	 Mugu/0jyPnzvFOBNUDDqIgXxkMw3foU8K9ichtpo0QlChNx8gPsqVNImbMxwAaQnvBgIP
	 8glBot16HbGuGioHZHa+DudTfqH9EKKFrpi/Cl3B7+LHYef/s25ss23zHL/sON2PF+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853651;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=5OwW+SfjYYUJ0QH9yKR4JOcy3/2WNa736ug8KBYjC3w=;
	b=OIIb0s8ciIYtQA9twzuP/aILD8UMOrdH0nWrszu2OZMLlJbgaM7Upcj46drCW4/ZM3z3
	 Pe4SwuzlO4dCojNM13d8q6QVs/lvjPIEfHSs9Pig27hGbz3lufR6qVN+L4u6VhXd4oryn
	 qI58M3rwD/KJkSF2uVm0WelNIZ1JV3o2fVJLpWhyo90vyfL2wfnCDJdygrbPGOruRgbZj
	 9lvNM3/pgGN/Bzz8+mxqmjjs6G9RdteoTcD7psuMYHOapEMqekJ5PnxoBARPvb+AXYG8x
	 rSSXn+wiZkfeM5cUahrGo12NLE1lZAw1O62M/y7O2Z9vL+ThCBPXlKyDkAUeONhNdZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b="J5/mxXhh";
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133D606A328;
	Thu,  5 Nov 2026 04:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1133D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=J5/mxXhh
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E85C108F80;
	Thu, 05 Nov 2026 05:40:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793853638;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=5OwW+SfjYYUJ0QH9yKR4JOcy3/2WNa736ug8KBYjC3w=;
	b=J5/mxXhhDH5mkybAcMGCNjxsdyk3bX4hRAXXnSF4YQDcHTnHBs0vEtw/Ose/80IkaQRvNK
	7/NutXm+nhU8ut5+MbW7br2rgqiqCVL+V+OnjOKY9KxrXGXGpZvCnOLqv6JfdEsq17tplX
	EIK7fkMvTGaHHBTohnRbYaiY+42ACbokya+DEl682O8XaRnMTScmT+Z1zbLRl2lRmGqNqD
	Gjl4I/JRPTxGV4s/JJ4PoUQQ/wG7/2owL85e7aTJ6qF3ES7DPONafp4xHEDATCy2bereZf
	JIbF+kjggqjacSgcyKRpin5KocQj7ii7VrzbGdEo0fvPXlbOMRQLT4dg4ck76Q==
Message-ID: <43352a45-1f0e-4d16-8846-63861e4ebda9@nabladev.com>
Date: Wed, 4 Nov 2026 17:46:44 +0100
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] watchdog: arm_smc_wdt: allow a list of SMC
 function ids
To: Guenter Roeck <linux@roeck-us.net>,
 Mateusz Nowicki <mateusz.nowicki@posteo.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org
Cc: Julius Werner <jwerner@chromium.org>, Evan Benn <evanbenn@chromium.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Antonio Borneo <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
 <c742c878-d4b2-48d8-972e-a09aa4d215c7@roeck-us.net>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <c742c878-d4b2-48d8-972e-a09aa4d215c7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/4/26 5:39 PM, Guenter Roeck wrote:
> On 11/4/26 08:16, Mateusz Nowicki wrote:
>> Hi all,
>>
>> this follows up on Marek's report about the stm32mp2 watchdog [1].
>>
>> A quick recap: the arm,smc-wdt driver talks to the firmware through one
>> SMC function id that it reads from the device tree, and there is no way
>> to ask the firmware which id it uses. On the STM32MP2 SoCs that id
>> changed over time. ST's OP-TEE from ecosystem v5 expects 0xb200005a,
>> their 4.0.0 fork accepts both, and the 4.8.0 fork as well as upstream
>> OP-TEE only accept 0xbc000000.
>>
>> My earlier patch, commit ae4d08bbe3f4 ("arm64: dts: st: fix arm,smc-id
>> of the SMC watchdog on stm32mp2"), switched the dtsi to 0xbc000000. That
>> made the watchdog work with current OP-TEE, but it broke boards that run
>> the older firmware. So today 6.18.y uses one id and 7.4 the other. When
>> the kernel and the firmware disagree, nobody pets the watchdog that the
>> bootloader started, and the board resets after 32 seconds. Marek hit
>> this even with a recovery kernel, which is about the worst place for it.
>>
> 
> So the DT on the board is updated to use the new ID but the firmware itself
> isn't ? That seems a bit odd; I would have assumed that the DT on a board
> is kept in sync with its firmware. Is that not the case here ?

That is not necessarily the case, no. Consider a scenario where the 
firmware is old, kernel is new. Bootloader is not always updated in 
devices deployed in field.

>> The idea from that thread: let arm,smc-id be a list. The driver tries
>> the ids one by one and keeps the first one the firmware accepts. Older
>> kernels only read the first cell, so they behave exactly as they do
>> now. For stm32mp2 the list is <0xbc000000 0xb200005a>. Calling an id
>> that belongs to some other firmware service would be bad, so the
>> binding says the list may only hold ids known to be this watchdog.
>>
> 
> Would it possibly make sense to check keep a list of known IDs in the
> driver ? It already checks 0x82003D06, so it might as well check a 
> sequence.
I am unsure whether there are any standardized IDs, but yes, this would 
be good.
