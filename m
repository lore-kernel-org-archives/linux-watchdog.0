Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815842;
	b=PeQW/n7V5NNFBSZpKyS6H5shH5siUqmq3FAEA6HBChydAnHyGmEtqFVXiXR8dwtpwTpU
	 RtQB2ieGEInYsSCMc/Wxka4/IyJleIITbVLWV47t+JlUPwvA1hBudo7KRPkJ13jnTezoi
	 tpiHYxm/yGj/UhbBeriBkcVa8HGNCNuMZ48fGsFOo0wNU8gqfvB2x8WoJScB6lb8hV+g9
	 JSruO6sEmZNHR3PYR5KXE0BAelVII4gqwv27kF5dSmuw8XPWj1w+Z8tU4TiYC7ltJ7M5T
	 yS4IAP5maDP8lti2R1U6sFUtb6sCKdwc9ve1eXnMhknvo9cvoXqu18vf8swE0NXWlNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:
	 Content-Transfer-Encoding;
	bh=9WkmYf7R4SGzBZAROx5aLx/oJoqChBMmnepUumVTYnk=;
	b=WzIjFrKvYceVqp/bXX4UnMYRA0Ij16PdrsAy3spH/QV9XNgbKUKWszl3g3V5EaYIIBky
	 6oh5BJ9mu+SOqEKwoIcQVzEKl/5UMtHi6R+jEh5gno88EU61cBTJdllqtm1Ikx1U8s8hF
	 5+3mLivexgLWO3WVTMWtSxrwq27l6rHcSIdTAToWhwK9lBabU2DQ4XOVh4RinVTV0fFU4
	 4dtpQle2fa4Nqe1OxNWicN0MmHrGYltY4EWZRw66keuJ04HVNCVFQNLPMWqAfEyyJP+Lj
	 XFhEZnRC/Sl+dxuoe0IMOXVWFOeQ4CdzNFzcWBUzfqy1nBkkFgAaDgqstOK9dOTjZcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=OF6qrx+w;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA0606A6A1
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 18:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDCA0606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=OF6qrx+w
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id AF597240108
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 19:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793815838;
	bh=9WkmYf7R4SGzBZAROx5aLx/oJoqChBMmnepUumVTYnk=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=OF6qrx+wODiEsY1kg24OzHlmcY2J44GmixT/URw+Uy5VIKGWpJNE4lPIzbf2cFLm/
	 Z+1wptDWDG9bE6XRM249mIGrFXML9cOMdFAAx0AXXY3XxqgOP1RIdYu+Bc5tlrkLA+
	 cRcIOgaXaKt6PIet5xGHw6S85D+Krwh7O8KvduIrzB6LTDDrt2XtN/QuAul5MHtMNy
	 aJKd/8671w5XeTM4zQ2/wbHVuivELjBqUK3IrFHClTuHTPGiN9sicwsomGJsD3tJz3
	 CwVYHTFXWzPaQ8KTarQkS8fEPViApMpgRdRNyCpZsGqJthE9UZzGc5oANGK5WpeHGb
	 au9fPBHkeuUMA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jKYQN2xfgz9rxN;
	Wed,  4 Nov 2026 19:10:36 +0100 (CET)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 04 Nov 2026 18:10:37 +0000
From: mateusz.nowicki@posteo.net
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, Julius Werner <jwerner@chromium.org>, Evan
 Benn <evanbenn@chromium.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Antonio Borneo <antonio.borneo@foss.st.com>,
 Marek Vasut <marex@nabladev.com>, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] watchdog: =?UTF-8?Q?arm=5Fsmc=5Fwdt=3A=20allo?=
 =?UTF-8?Q?w=20a=20list=20of=20SMC=20function=20ids?=
In-Reply-To: <c742c878-d4b2-48d8-972e-a09aa4d215c7@roeck-us.net>
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
 <c742c878-d4b2-48d8-972e-a09aa4d215c7@roeck-us.net>
Message-ID: <37f9e5e73070972f224583bc1581e400@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 Guenter Roeck wrote:
> On 11/4/26 08:16, Mateusz Nowicki wrote:
>> My earlier patch, commit ae4d08bbe3f4 ("arm64: dts: st: fix arm,smc-id
>> of the SMC watchdog on stm32mp2"), switched the dtsi to 0xbc000000. 
>> That
>> made the watchdog work with current OP-TEE, but it broke boards that 
>> run
>> the older firmware. So today 6.18.y uses one id and 7.4 the other. 
>> When
>> the kernel and the firmware disagree, nobody pets the watchdog that 
>> the
>> bootloader started, and the board resets after 32 seconds. Marek hit
>> this even with a recovery kernel, which is about the worst place for 
>> it.
>> 
> 
> So the DT on the board is updated to use the new ID but the firmware 
> itself
> isn't ? That seems a bit odd; I would have assumed that the DT on a 
> board
> is kept in sync with its firmware. Is that not the case here ?

Not necessarily. On these boards the DTB is built from the kernel tree
and installed with the kernel, U-Boot just loads it from the boot
partition. TF-A and OP-TEE sit in the FIP and are updated separately, so
updating the kernel alone changes the ID. That's how Marek got hit: he
updated OP-TEE, but his recovery kernel still had the old DTB.

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

Fine with me, and it avoids the binding issue. I'd just rather not try
the ST IDs on every platform, so how about making the list per
compatible:

   compatible = "st,stm32mp25-smc-wdt", "arm,smc-wdt";

with { 0xbc000000, 0xb200005a } as match data for it. arm,smc-id stays a
single u32 and, if present, is tried first. Older kernels just match
"arm,smc-wdt" and behave as today.

If that works for you and the DT folks, I'll send v2.

Thanks,
Mateusz

