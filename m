Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794160587;
	b=IHVyQzK2E8q6MsmIZF5sL6HWz467AwdwSTROXsKs+HnYEbDJKpXhy0IpS+IXgIvemXte
	 ZpGgQPjITGiO0Z9N/2/lWlhJxKjfBnaAqnP7SeiU9x9m8snI7/0e4CSBOjZBGoOy1TJQe
	 59OYoQ2Ts+6D/U8lETzRHtZimKvglTNXZyKdkcMPuZzdzjKDbE41RI6HX4iDDg7ynvIxH
	 bSvdhcuBgEgTsuN6/wRftPXEOIAjfaICCXQv0WQKISzBv7R7t6d87j0UZJRQX30Mc++uF
	 /YP8EXrhz0PlvHDck2UYPJf++ZH93Wv4BINNDneMYH0EUYi44JkkRCPStD1iUHVFH8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794160587;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=E4ws0ipHUP39KmaqfV+8bszyUiNRG8BNvzIQTxXOAwA=;
	b=iiJqIMqtTW/h5HbSzAH66UjFKCAS27kt99KCt/kCWf0ujlg8VDdXlN1IirMMl7cxk84b
	 kasZ0+coxpO6BcUDf5Hsmq8jdl2DM9Xwmy7eRa5j9HfmmMh8RgIuIrQ6C0EHz1PZJxtb4
	 zv/yJkLGdg34L3H/tP3n1qMRLNEX99MZLaof8o6r5RJ4F6jr3AdRokIi5SJp2USWCvXOj
	 VRLrQIeCBgdJnSoioYla9EvIYfLRE+bAKkbhdvv/P2nWUEHU8bh603mbb3lJkc3eUEHi9
	 KHuFtEwCrxW1R4WqXGUQKLwek8jIuXYiccl8FlikSoYAtYRM9q7rFFDFDeNlV0Hcesw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=kyG8tr04;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B1606A31C
	for <linux-watchdog@vger.kernel.org>; Sun,  8 Nov 2026 17:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 380B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=kyG8tr04
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id Q4NIxlXHv4vCDQ77yx1l6t; Sun, 08 Nov 2026 17:56:26 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Q77xxRVzQlaNKQ77xxPCK1; Sun, 08 Nov 2026 17:56:26 +0000
X-Authority-Analysis: v=2.4 cv=UbpRSLSN c=1 sm=1 tr=0 ts=6af0b7ca
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=8b9GpE9nAAAA:8 a=ZdWTtX0RdJLCUevRbrYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=E4ws0ipHUP39KmaqfV+8bszyUiNRG8BNvzIQTxXOAwA=; b=kyG8tr04BsGk
	9hIkCP5sZ5ifCDsJQeTdkRoVhaOyiQFY3GYePKlgAOWBDYVlqTtIqFydpU8e0xglfQLaCuUSxyCau
	EVpFtU4hvji4ygWVximV7fEw1zorkO0rrmVui49F9BzbfemD86cjVVW5v7CDwwL1ZOxZZzgSihaw8
	g1IR/ZbIRxrlXNyBVvwET9rS2VJw1XPMkUktsKY6Q0Jrj+9bd3R+N3NiZ7kcoPXeLp43ReV5xJMKW
	SwB9vArOspLR5rPs1DW9QPpReeZqpxN7RivdldeJcBFKuN9jZhmiahCC6oBdHHdcwHNn78FLKbFD7
	P6FlyJpzvP78wRKoyBT7Uw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52810)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xQ77x-00000002C9A-1fbi;
	Sun, 08 Nov 2026 23:26:25 +0530
Message-ID: <a6460db0-8df6-4427-9ecc-277f2f575d39@roeck-us.net>
Date: Sun, 8 Nov 2026 09:56:24 -0800
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
Subject: Re: [PATCH v3 02/13] watchdog: stm32_iwdg: detect whether the
 watchdog is running
To: sashiko-reviews@lists.linux.dev,
 Antonio Borneo <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-3-antonio.borneo@foss.st.com>
 <sashiko-outbox-201895@kernel.org>
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
In-Reply-To: <sashiko-outbox-201895@kernel.org>
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
X-Exim-ID: 1xQ77x-00000002C9A-1fbi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:52810
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAG+gLImt+7nK/xeLwX8W034lXeA3gnxJtzSm0jYSLSIW8j+PnKNcHHOLp8Qrd5UgvawCPmnd946hnrOGja9MT/WzyES+XGJJQ6auwktnzjxIwgwkv2c
 WjrgTveMmVMLgo+pubz3eXlasvi1A08RwEpVpG3lUuIYK5lrx25iIQ2adtWfrMqlxAaw49E/+eZuL9lZdPCVPs/lwS61PK8n+Z0KRx8Mkr5VonojyMuOnr2O

On 11/6/26 09:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] watchdog: stm32_iwdg: unconfigured timeout in
>    stm32_iwdg_probe()
> - [Medium] watchdog: stm32_iwdg: WDOG_HW_RUNNING gated on Kconfig in
>    stm32_iwdg_probe()
> --
> 
> commit 7c2acc17f93336becc29a7a139de848c3db25624
> Author: Clément Le Goffic <clement.legoffic@foss.st.com>
> 
> watchdog: stm32_iwdg: detect whether the watchdog is running
> 
> This commit adds stm32_iwdg_is_running() to detect whether the watchdog
> was already started by an earlier boot stage and sets WDOG_HW_RUNNING in
> stm32_iwdg_probe() only when it is running.
> 
> [Severity: High]
> In drivers/watchdog/stm32_iwdg.c at line 394 in stm32_iwdg_probe(), does
> removing the call to stm32_iwdg_start(wdd) leave the hardware prescaler
> (IWDG_PR), reload value (IWDG_RLR), and early-wakeup interrupt
> (IWDG_EWCR) registers out of sync with wdd->timeout and wdd->pretimeout?
> 
> When stm32_iwdg_is_running(wdt) returns true, stm32_iwdg_probe() now sets
> WDOG_HW_RUNNING without programming wdd->timeout into the hardware or
> reading the bootloader's configured timeout back into wdd->timeout.
> Because stm32_iwdg_ops provides stm32_iwdg_ping() (line 162), which only
> writes KR_KEY_RELOAD to IWDG_KR, the watchdog core's keepalive worker
> schedules pings at half of wdd->timeout while reloading the bootloader's
> counter value. If the bootloader configured a hardware timeout shorter
> than wdd->timeout / 2, the watchdog expires and resets the system before
> the next keepalive ping. Even after userspace opens /dev/watchdog,
> watchdog_start() in drivers/watchdog/watchdog_dev.c (line 261) sees both
> WDOG_HW_RUNNING and wdd->ops->ping set and calls __watchdog_ping(wdd)
> instead of wdd->ops->start(wdd), leaving IWDG_PR, IWDG_RLR, and IWDG_EWCR
> unconfigured.
> 
> [Severity: Medium]
> In drivers/watchdog/stm32_iwdg.c at line 394 in stm32_iwdg_probe(),
> should setting WDOG_HW_RUNNING be unconditional when
> stm32_iwdg_is_running(wdt) is true, rather than gated on
> IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)?
> 
> In drivers/watchdog/watchdog_dev.c at line 1099 in
> watchdog_cdev_register(), the watchdog core checks watchdog_hw_running()
> to pin the module and device references and to evaluate the runtime
> watchdog.handle_boot_enabled parameter. Gating the check on
> IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED) in the driver prevents
> the core from knowing the hardware is active when
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=n, breaking the
> watchdog.handle_boot_enabled=1 kernel command-line override and skipping
> the module/device reference pinning.
> 

Sashiko has a point. CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is supposed to be
handled in the watchdog core, not in watchdog drivers, and it is supposed
to be a default value that can be overwritten with a boot parameter.

Having said that, please let me know if this is intentional. If so,
I'll apply the patch anyway.

Thanks,
Guenter

