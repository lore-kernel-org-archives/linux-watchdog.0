Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102063;
	b=UD9Whj53LcWpo/dz5EYCp2pLm5W6fSYlv7M7cvajeD4Pk8FCdGTALkEFcLFV0Go2sotV
	 iaKaGntgwlPex/rqfxZGBCtmif/xqFKLbrPYy8D31laNqUmI3FPqVYs+SNEzEYG2oI8BX
	 Ph0rYOeOl24z0vsTSxhFrQl93nTgBaQLkK8P8g5O1kYFJNBmsiHOnBfnt1MaV5E1WHEc/
	 I4fMkeyRUGwkEkSes+rTW9wnNvyptuWW4PGCxeQfhpvLyBQZuBkaP5nBZ115mpsHFCMul
	 hy0IKquBx4FQZbA5FUD3F1DMGhH07jdL15iSNSn+Jdrvj4XhN2yEQwV6yUUKA4AjPLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102063;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=8dhBqF+ImQqlLbq4kzeBiQsS0q4yocPVf6hddBwCahY=;
	b=lo/6MgX8SNiImO1C9rVBUS3b+yst1G6/3l1ASULpP3GmePXMYCp8xjjUViadchbane3H
	 dNrXxKf8+35eBcVxzW91n7ojktNXw0MUQ+TqmJtsu3QOVEooxMrC2XMj9fbes4QLEI4VE
	 GsL3hoB9N2sj+DHh/eKdeCxRvPdxPywSTnJTbeNCqb5SQ1Shj49TSrW4yP1MlX+TJ3Ycr
	 wzCXAZkP0qzO6ZZMp95wuRniz6X69uALXwZtfmI1AiUeHq7Xq9+rDWqCgYdPZ42BLbFqJ
	 0bQcToCduz5quuCrVYKyCNSf3XyliRtC3mhly3ltBhUGEIeFjegZ7aMhwZ9CDJHgfjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=kfa4kPQu;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7F606A324
	for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 15:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C7F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=kfa4kPQu
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id U1gfxcwpyV16IU42xxMcrH; Thu, 19 Nov 2026 15:27:35 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id U42wxYqxISgq1U42wxj05O; Thu, 19 Nov 2026 15:27:34 +0000
X-Authority-Analysis: v=2.4 cv=c8KrQQ9l c=1 sm=1 tr=0 ts=6aff1566
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=EUspDBNiAAAA:8
 a=nhoOZ0oBgXBQ0gkwPj4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=8dhBqF+ImQqlLbq4kzeBiQsS0q4yocPVf6hddBwCahY=; b=kfa4kPQuYaEi
	bkxAKRdQU+dumcftE5MLvti7K1UJ7LHNIGWdmgboPKnleT5jvZkWbqx00pm1bYof6xvAmdIhN9hPC
	iAvq57U/tB0uw3wIoSH5Uc3lfpMpqSgsTE8d3EWyPs9K5rQoLPvllHzi/LsPG6HZmcKqjn2pXrDcO
	CSvRVJIHRU5UjA7FAYRbIM5WoAfG1roXl0kfxVNUPcuNFUkoNT0x2nMv8mCLFWel13Pd9y2DuO/+Y
	0ZEzWnkmfCAtA1+EgxkZ+59lRHH92e05jJJyMCnvqNzIqB5xFmX6oEBSLcMUFlU/ru3/qP16OB9g+
	VkOWyIeSXHvO9SYG/QF+cA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:35428)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xU42v-00000002jcP-0paV;
	Thu, 19 Nov 2026 20:57:33 +0530
Message-ID: <10c7622c-4dc4-4ffd-89b1-0678e3553f53@roeck-us.net>
Date: Thu, 19 Nov 2026 07:27:30 -0800
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
Subject: Re: [RFC PATCH v3 2/2] drivers/watchdog: Add RISC-V SBI watchdog
 driver
To: Anup Patel <anup@brainfault.org>, Prajwal N <prajwal.n@oss.qualcomm.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 wim@linux-watchdog.org, radim.krcmar@oss.qualcomm.com,
 anup.patel@oss.qualcomm.com, linux-riscv@lists.infradead.org,
 linux-watchdog@vger.kernel.org, prajwal.n.oss@gmail.com
References: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
 <20261118092147.2017658-3-prajwal.n@oss.qualcomm.com>
 <CAAhSdy2ZKBc8A522viUWZbn418MC-C2cy7pQYLBFYn4gsTvJ8Q@mail.gmail.com>
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
In-Reply-To: <CAAhSdy2ZKBc8A522viUWZbn418MC-C2cy7pQYLBFYn4gsTvJ8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xU42v-00000002jcP-0paV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:35428
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJDXjsd6jyNqdlsixIWNRNURhosbnnPb6Jk/1xDJn0QI6M6dIHa+ZA0BJaTPErkFgpEPlWqqKlSwkHwqJ90vZq97XqS8ua6I93eLNfWzWMmVGbczncVN
 F8Ia4sJZMzSuZinjO2L4c6vWAhuKrpHlwUxYMbmry4za5gW06nk0R0fiCjr0mh6hJXbeRI+VqB4IXfYfvZNFPy+LIzJE5ZRstlqLF2a4I6FLcGAwB9B++k1/

On 11/19/26 07:04, Anup Patel wrote:
> On Wed, Nov 18, 2026 at 2:52 PM Prajwal N <prajwal.n@oss.qualcomm.com> wrote:
>>
>> Add the RISCV_SBI_WATCHDOG Kconfig option, which depends on
>> RISCV and RISCV_SBI support.
> 
> Kconfig option is always needed when adding new driver so
> there is not much value in having this statement in commit
> description.
> 
>>
>> Add a watchdog driver for the RISC-V SBI watchdog extension.
>> The driver integrates with the Linux watchdog framework to
>> configure and control the watchdog. The driver invokes the
>> SBI watchdog using the standard SBI calls.
>>
>> Support pretimeout event notifications using Message Signaled
>> Interrupts (MSIs).
>>
>> Signed-off-by: Prajwal N <prajwal.n@oss.qualcomm.com>
>> ---
>>   drivers/watchdog/Kconfig         |  10 +
>>   drivers/watchdog/Makefile        |   1 +
>>   drivers/watchdog/riscv_sbi_wdt.c | 436 +++++++++++++++++++++++++++++++
>>   3 files changed, 447 insertions(+)
>>   create mode 100644 drivers/watchdog/riscv_sbi_wdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index f7d0a0c2c0ef..d6b4e8ccd057 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -2164,6 +2164,16 @@ config STARFIVE_WATCHDOG
>>            Say Y here to support the watchdog of StarFive JH7100 and JH7110
>>            SoC. This driver can also be built as a module if choose M.
>>
>> +config RISCV_SBI_WATCHDOG
>> +       tristate "RISC-V SBI based Watchdog support"
>> +       depends on RISCV_SBI
>> +       default RISCV
>> +       select WATCHDOG_CORE
> 
> Drop "select WATCHDOG_CORE" instead extend "depends on"
> to include WATCHDOG_CORE (just like other watchdog drivers).
> 

Please explain what you are talking about here.
Literally every watchdog driver uses "select WATCHDOG_CORE".

> You will also need a separate third patch to enable WATCHDOG_CORE
> in arch/riscv/configs/defconfig.
> 

Why exactly ?

Guenter

