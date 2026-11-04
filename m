Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810375;
	b=C+6A2IX7nLI8EBuX6ZaQATWHomHPrp401KWccNBVMeaoBmsdiO5wWRAdD0HDWQBYjGl2
	 eWWJlRZy/wleT69FgBe2BJn5railOTbzkjYnPV158L1KtiW22OW4wPYfIo0OSV/KyXgwj
	 3xYUbLySuDzmrmtqs4a012wb/ggkOkLdt2ve3gkMDJwdpqpUKDCDCuPS91uLDQOjRDzIE
	 0KMOBcyJttlrpfstG/iZ6iS82ddCFqe30eU4HMiYtJtTyJ7Os4JOBIs+0N8TNM0iSVwnm
	 jXe6h8OJJRH64sAWaehvkf+cickJ5KlbrvnoJn3itqLWsSOHSaCF0olf2jVy+fcqawA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810375;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=j/qonkLTfSJS6fOcfIBVACKrRZK2oHEhnPOu7N9/zz8=;
	b=Sp+IUpnQRgmkk3cBDE6pbqrKodYWwZPXqaJylD95sE0orH53tIZIW94ISuqlahAyOO8h
	 7w9gyFYXLH3I16CjHkdKdy1xo8ymaeJlU95Q3zeUbaXypfGGyO7JqqVwce4HXC0SVofn3
	 2bDCRXGoVCmPL9LGgNQhzYH78bryRjAalelMW0FOvk44SwY6ShLdOFBjexPeJgT1+ZU3F
	 guIoHiB1S4rmBjErbsKyi4l8VYrwXcMlF+bAR4AD0mzNFHoCPRNhwh3mQr7/XmoArtRRC
	 OptRMgePZ18+8WBcTKzbw31nHVK5IBtYcDC2zWk4QPoZS4yppQyzcHqw7HiP5gk5wDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=rP2S6qUD;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9E606A31B
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 16:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE9E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=rP2S6qUD
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id OdKRxCZJcJFmFOe1NxSBRM; Wed, 04 Nov 2026 16:39:33 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Oe1LxxnTS0w3mOe1LxunUL; Wed, 04 Nov 2026 16:39:31 +0000
X-Authority-Analysis: v=2.4 cv=ZtntK87G c=1 sm=1 tr=0 ts=6aeb5fc4
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=p-LfKV-GAAAA:8 a=14k-HqQmNQMTK8QvfVQA:9 a=QEXdDO2ut3YA:10
 a=97BuGM4RKn6GwmfqMd6i:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=j/qonkLTfSJS6fOcfIBVACKrRZK2oHEhnPOu7N9/zz8=; b=rP2S6qUD2i+9
	HPp78wilmv51lPsJeYeSL2+Q992YgG8wmyBV8UHhCQaaCj+XNlWTLP49bOIFZlJxpMJQqskrNV1cI
	PnTqxVJwwABcrId1lVrr/DIfCTfHBeaYZBbzneINJzlpbM++M9QyYMRYTTe77kBfZlZUCGiW6h3T8
	pp7jO8yQ2iIZ4KouhqodhcjpbtQqWeWdXPDNUaOspyXHA0WeCD4sVWY5dvra1xuVF3+2KohwcuLWA
	1qnlbIlhrbog65pGimvDtWupyLt3sdpY8Q/WySQSASpiHIzybLVSuQHa+8QjB5ZHN0k5V9BHb14eA
	EW8CJ9wtFqUJa++7UoaqDg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44006)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOe1K-00000002Xpu-1SC1;
	Wed, 04 Nov 2026 22:09:30 +0530
Message-ID: <c742c878-d4b2-48d8-972e-a09aa4d215c7@roeck-us.net>
Date: Wed, 4 Nov 2026 08:39:28 -0800
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
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org
Cc: Julius Werner <jwerner@chromium.org>, Evan Benn <evanbenn@chromium.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Marek Vasut
 <marex@nabladev.com>, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xOe1K-00000002Xpu-1SC1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:44006
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 24
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK/HsW31knB6dved7fNBxCFjgJHoUr/4W4T+iT1AXj465CQlpLwUeGuaSxOS4cMNkFpKnG4xd7YJeHuhc3Rr4kEmPEyN+v21YLzX05IjJgfR9y3EVyw1
 dkDrE/U2C/hcqa39V0Lhls/rzqfwsmm6X9q8wVwzYx6yKX8C26ZyLpe9KM8peBJdr9bJAHmLwHGq3YC8MYIqdpAq8lOyOAdX3rNdOgftMgo8eqtYzXtWZvn2

On 11/4/26 08:16, Mateusz Nowicki wrote:
> Hi all,
> 
> this follows up on Marek's report about the stm32mp2 watchdog [1].
> 
> A quick recap: the arm,smc-wdt driver talks to the firmware through one
> SMC function id that it reads from the device tree, and there is no way
> to ask the firmware which id it uses. On the STM32MP2 SoCs that id
> changed over time. ST's OP-TEE from ecosystem v5 expects 0xb200005a,
> their 4.0.0 fork accepts both, and the 4.8.0 fork as well as upstream
> OP-TEE only accept 0xbc000000.
> 
> My earlier patch, commit ae4d08bbe3f4 ("arm64: dts: st: fix arm,smc-id
> of the SMC watchdog on stm32mp2"), switched the dtsi to 0xbc000000. That
> made the watchdog work with current OP-TEE, but it broke boards that run
> the older firmware. So today 6.18.y uses one id and 7.4 the other. When
> the kernel and the firmware disagree, nobody pets the watchdog that the
> bootloader started, and the board resets after 32 seconds. Marek hit
> this even with a recovery kernel, which is about the worst place for it.
> 

So the DT on the board is updated to use the new ID but the firmware itself
isn't ? That seems a bit odd; I would have assumed that the DT on a board
is kept in sync with its firmware. Is that not the case here ?

> The idea from that thread: let arm,smc-id be a list. The driver tries
> the ids one by one and keeps the first one the firmware accepts. Older
> kernels only read the first cell, so they behave exactly as they do
> now. For stm32mp2 the list is <0xbc000000 0xb200005a>. Calling an id
> that belongs to some other firmware service would be bad, so the
> binding says the list may only hold ids known to be this watchdog.
> 

Would it possibly make sense to check keep a list of known IDs in the
driver ? It already checks 0x82003D06, so it might as well check a sequence.

Thanks,
Guenter

> Why RFC: arm,smc-id already exists in firmware/arm,scmi.yaml as a plain
> uint32, and dt_binding_check complains when another binding turns it
> into an array:
> 
>    arm-smc-wdt.yaml: arm,smc-id: multiple incompatible types: uint32-array
>    arm,scmi.yaml: arm,smc-id: multiple incompatible types: uint32
> 
> DT folks, is there a way to keep the list in arm,smc-id that you would
> be fine with? If not, I can move the extra ids into a new property,
> something like:
> 
>    arm,smc-id = <0xbc000000>;
>    arm,smc-alt-ids = <0xb200005a>;
> 
> The driver side would stay the same, it would just read the fallback
> ids from the other property.
> 
> One more question: should patches 2 and 3 go to stable as well? Then
> 6.18.y would also work with both firmware generations. The 6.18.y
> version of patch 3 would turn its 0xb200005a into the same list.
> 
> [1] https://lore.kernel.org/all/1b14e1e4-962f-4391-91fd-b09143641643@nabladev.com/
> 
> Mateusz Nowicki (3):
>    dt-bindings: watchdog: arm-smc-wdt: allow a list of SMC ids
>    watchdog: arm_smc_wdt: try every id of arm,smc-id
>    arm64: dts: st: list both watchdog SMC ids on stm32mp23 and stm32mp25
> 
>   .../bindings/watchdog/arm-smc-wdt.yaml         |  9 +++++++--
>   arch/arm64/boot/dts/st/stm32mp231.dtsi         |  2 +-
>   arch/arm64/boot/dts/st/stm32mp251.dtsi         |  2 +-
>   drivers/watchdog/arm_smc_wdt.c                 | 18 ++++++++++++------
>   4 files changed, 21 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

