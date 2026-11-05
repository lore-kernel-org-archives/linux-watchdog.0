Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873062;
	b=J0kMA711rZo+DKQYWvFq0kEgWJdMs5/bSjlA9vp5HAWBWvOrvO5pZG/bW6cgBrO8Tysy
	 RVTNls44ShJ9OzyCIDYn0O1Bs0htYg6aDDxYyg0e48ctAoC1HOZFUhVWMRo8DMHoPyUjh
	 LSieW1AfcWTpYb9v+V7pmGSsiIazZhJ5IcJbKg9X1iXknUh65nVUKUI56w+sAOygT9fnn
	 ixqhoDFvMODcu5Nn/abTk9sGrj8UogxPysHE9r/7LnODrh/qScp6tt/9fBFg/sOAUeams
	 iydAWVwJBR0SsWo1C4xWzONWUG45SBa9RK6gF1zyMsfm9xxHNKtxzhlLx1pISkkCepA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873062;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:
	 Content-Transfer-Encoding;
	bh=zg6+H10dxRDg4A+l8T0eI4KPj0H19Zt2rNXESQze/4g=;
	b=qJZwfw9jldnrmuILn/PtNQ53UrANejzse1cN35qG2PbveB+64KoB5MTNZqOVxYJRguBX
	 0LuO683VEuFoZuKmJJl7sK6kuI4wxthOLV994eDttoKZWHVZ/b47893k79Q4cuUDSQZJO
	 2jEyHLJYAYn8wrHvXlfojwDUW/fYBBl7vk+Clqyh13m3RUAEG/JOE2RlMJjuLu+xNryrd
	 4/dpU7cQVpViyYbUDXWDUzeK9MxjNCno4m/I3Ngev9VT7Dn6gxZBnvdlhOBoNO2Zz+jVf
	 gpgblgvKu7eT/vbpac0NAJkB25267p0FQDGBuEWP/k5O18TrHTkTinkJfQa8OFIK3RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C5606A32C
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 10:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B8C5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 27A06240101
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 11:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793873048;
	bh=zg6+H10dxRDg4A+l8T0eI4KPj0H19Zt2rNXESQze/4g=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Jjb2O8GYpTYYWRwR1kQMvIcE8GUqbbz8XCykAxTyHnJoenzA5Ynd+muQPUdFLP2J6
	 njVQKNOZjKmmpCw2grhHbCndfdXxZZYZ3A7uYSiJwpTMtJCyRm/V57ZVRFA4FtgUzd
	 GeV2vX38jOkhMyXvZQ+4LiY38NSOUgB74M3GH4WjTcG5DpJErvY/E56IxJXCCyjV/k
	 Qg5vNTV/oqi0ZpMchpYHqnWf9XWMBTNTM4Y87oHqztVH8eR3rPkRopSohwMc1AVUpe
	 89K4Ogn8NuNFxG8r+c06Dtsu1eDp+zNXGU/CRnTi4YrbZS97RNfFZHNxMpUtRX7R/H
	 vriSCnd0dXbvg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jKyZY4ftxz9rxR;
	Thu,  5 Nov 2026 11:04:05 +0100 (CET)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 05 Nov 2026 10:04:07 +0000
From: mateusz.nowicki@posteo.net
To: Julius Werner <jwerner@chromium.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Evan Benn
 <evanbenn@chromium.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Antonio Borneo <antonio.borneo@foss.st.com>,
 Marek Vasut <marex@nabladev.com>, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] watchdog: =?UTF-8?Q?arm=5Fsmc=5Fwdt=3A=20allo?=
 =?UTF-8?Q?w=20a=20list=20of=20SMC=20function=20ids?=
In-Reply-To: <CAODwPW992ncQNo1yxrOrAKKZ62TB_U1eYWstZuTKDKqFCFGRSA@mail.gmail.com>
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
 <CAODwPW992ncQNo1yxrOrAKKZ62TB_U1eYWstZuTKDKqFCFGRSA@mail.gmail.com>
Message-ID: <2e1ea7a743552f7a9f5aef91e0d8d1c6@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 Julius Werner wrote:
> What happens if you simply define two watchdog nodes in your DTS, one
> for each SMC ID? Both of them would independently try to probe, one of
> them would die from getting an SMC_UNK, and the other would continue
> working to pet your watchdog?

I thought about that, but there is firmware where both of them probe.
ST's 4.0.0 OP-TEE fork accepts both IDs, so you end up with watchdog0
and watchdog1 on the same IWDG. The bootloader has already started it,
so both register with WDOG_HW_RUNNING. Userspace opens one of them and
the watchdog core keeps pinging the other one forever (open_timeout is
0 by default). If userspace hangs, the board never resets.

> I would be fine
> with the array solution but I don't know about the validation checker
> and whether people care about reusing the same prop name with
> different types. (FWIW, in the device tree a 32-bit integer is
> basically a 1-element array anyway, so we might just say it's always
> an array and for SCMI only one element is allowed.)

I tried that. With arm,smc-id as a uint32-array with maxItems: 1 in
arm,scmi.yaml the "multiple incompatible types" error is gone.
dt_binding_check is clean, and so is dtbs_check on stm32mp257f-dk,
stm32mp235f-dk and a few boards that use SCMI over SMC (imx8ulp-evk,
rk3528-armsom-sige1, amlogic-c3, blaize-blzp1600). The SCMI driver
reads the property with of_property_read_u32(), so nothing changes
there.

Guenter, you suggested keeping the IDs in the driver and I have a v2
like that ready (st,stm32mp25-smc-wdt with the IDs as match data).
Julius would rather keep them in DT. I'm fine with either, just tell me
which one you'd take. If it's the array, v2 is the RFC plus the
arm,scmi.yaml change, and maxItems: 2 as Marek asked.

Thanks,
Mateusz
