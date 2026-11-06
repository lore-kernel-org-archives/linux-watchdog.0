Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978440;
	b=OjMAw36lXxz+FMhIl47j5+A/czk4NdxlC+clcJT0glR3TFPn5Lklf5rhvvPHoKCjrwpL
	 3xkfpo6p71HigcvKb3ETj+gjC7UuzRIZHTpDWVuNU3fi3eRTqaaIVmCAebCpBCRBH1aT8
	 KAvlFOAACcU0Ux+HJ4qtqZe4Zl3HCIsrRKazOk1TG0MO7c3h5A5Tc2b+7TuUvvF1qzuiM
	 DdxLd+x7z6J9UySvS7qxjLpCuBPC0NWkFblQC1RnSf3grm1qCN6PY8cuEHdPD+IKA/+lk
	 Q9FgBkiJD9XHf56xMlj+hcQ+gDR4bd2xAUM5dgokrw7TdtwFdnCEdG/wzRt9uHv1ueQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978440;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=++vyU1+Md5kIusDLyvD/w9s4csiRkDpjajz2lP+/fz8=;
	b=DRYqgj5lekPeVq4RjqEoBVWD62qfknKvuyikSJt3mw8OwGImFcxtVLMY9TGSp4i0D4TA
	 vI2sE+jKqX9ZuwT+VoHg2Bd3m4iZy8ed14TNtMtp26IPWnig9+9Q0MleRu1c2Cg0dq0WC
	 T3iI4P0fEe2AceLpoHrpMQcBVzr0qBff1DbhRn+dFq+m9UI+3Jb6KFJD04qFxjMUQZopP
	 abjbUV+n+VJAHfnB4KIsF/kxTwDNwzdgTwjRzh/vWHMz4UU7xxRk7nW5PLR0lNDrcBsTN
	 8fpnqgThGNjhI4ga1KP8ISePGOfX+0GDeFkZwlfRowMiMhd6LBc0CUzS1iltCI6p3Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=aW7wLH07;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B39606A334
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 15:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B39606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=aW7wLH07
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id PIc0xgwMwVK9UPLk2xYiUG; Fri, 06 Nov 2026 15:20:34 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id PLk1xxjMxuJrPPLk1xIdgQ; Fri, 06 Nov 2026 15:20:34 +0000
X-Authority-Analysis: v=2.4 cv=WLZ/XmsR c=1 sm=1 tr=0 ts=6aedf042
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=VhhfJ6JjuyRaun_vA7wA:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=++vyU1+Md5kIusDLyvD/w9s4csiRkDpjajz2lP+/fz8=; b=aW7wLH073ZRF
	tI41L8ifbocopIxyNA/kZ9uDJYEIKFZ8urdDV9oAjNoopMc18sunuEUnKCc0TItOlPky4ECd9b3jF
	tD52QLyRixFDE5IbZjfBs8jw3RVY1B24NohfpS2vxI2J8Z5Pe9Hiu0p5lEqM0seEI1UatOgnQdYbX
	hCRuQRmtHsykCtAN3YpyWFpX67XguCz5DGCoJUBmPEfvtpgZkUKyS13ZWDp1dMax61MFpH1bWnhIl
	1FB33KkDe5F+OdDGtx//GAFxJsuSUn31lDiouozE4+2H4t1sHjjpPaJr8tYlU65KMIjhr/B4URA62
	hq0czlz+5SYJDF/AZY/JKA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57440)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xPLk1-00000004O4D-1pld;
	Fri, 06 Nov 2026 20:50:33 +0530
Message-ID: <43513761-1e49-4fa0-af2f-fcbffddb4ded@roeck-us.net>
Date: Fri, 6 Nov 2026 07:20:32 -0800
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
Subject: Re: [PATCH v2 8/8] watchdog: starfive-wdt: Avoid unclocked MMIO
 access in starfive_wdt_set_timeout()
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
 Ziv Xu <ziv.xu@starfivetech.com>
References: <20261105190530.2371854-1-linux@roeck-us.net>
 <20261105190530.2371854-9-linux@roeck-us.net> <au3ibSdPUIKvUWNa@google.com>
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
In-Reply-To: <au3ibSdPUIKvUWNa@google.com>
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
X-Exim-ID: 1xPLk1-00000004O4D-1pld
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:57440
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOdFxt4bj+oGV2Hnw9LtP4JkvF0WJfbA2gH9NBcpO8/Q/RsRiVKp0k0A5fi2wD2e0G/BWlSykHW8TVoANePtVvtWSCkYrh8qBpDIy1kgE/70/uYkVdhl
 9v88JilfPWx7JDPhYUfE2RxCq7B97p6z5teLZzQsH86oN+IbIVoXnUUvNs5O8+8+CevER74dKSMFoR77t4tXzYkfKX+ZASUxXUCjLF9qbhw7LuqqKjoAp2Ik

On 11/6/26 06:21, Tzung-Bi Shih wrote:
> On Thu, Nov 05, 2026 at 11:05:29AM -0800, Guenter Roeck wrote:
>> Only program the hardware registers in starfive_wdt_set_timeout() when
>> watchdog_hw_running() is set. In addition, reload the initial counter value
>> via starfive_wdt_set_reload_count() in starfive_wdt_start() (preserving
> 
> Is the additional change relevant to this patch (i.e., avoid unclocked
> MMIO access)?

I think so, since reload_count is no longer set in starfive_wdt_set_timeout()
if the watchdog is not running.

> 
>> wdt->reload on resume) so JH7100 loads the configured timeout into the
>> counter when started from probe or after WDIOS_DISABLECARD.
> 
> Is it really JH7100 specific (not for JH7110)?
> 

Yes, the other chip doesn't have a reload count register.
See "if (wdt->variant->reload)" in starfive_wdt_set_reload_count().

Thanks,
Guenter

>> @@ -344,7 +344,7 @@ static int starfive_wdt_keepalive(struct watchdog_device *wdd)
>>   	return ret;
>>   }
>>   
>> -static int starfive_wdt_start(struct starfive_wdt *wdt)
>> +static int starfive_wdt_start(struct starfive_wdt *wdt, u32 count)
>>   {
>>   	int ret;
>>   
>> @@ -357,7 +357,9 @@ static int starfive_wdt_start(struct starfive_wdt *wdt)
>>   	if (ret)
>>   		goto exit;
>>   
>> -	starfive_wdt_set_count(wdt, wdt->count);
>> +	starfive_wdt_set_reload_count(wdt, count);
>> +	if (count != wdt->count)
>> +		starfive_wdt_set_count(wdt, wdt->count);
>>   	starfive_wdt_enable(wdt);
>>   
>>   exit:
>> @@ -381,7 +383,7 @@ static int starfive_wdt_pm_start(struct watchdog_device *wdd)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	ret = starfive_wdt_start(wdt);
>> +	ret = starfive_wdt_start(wdt, wdt->count);
>>   	if (ret)
>>   		pm_runtime_put_sync(wdd->parent);
>>   
>> @@ -412,11 +414,13 @@ static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
>>   	wdt->count = count;
>>   	wdd->timeout = timeout;
>>   
>> -	starfive_wdt_unlock(wdt);
>> -	starfive_wdt_disable(wdt);
>> -	starfive_wdt_set_reload_count(wdt, wdt->count);
>> -	starfive_wdt_enable(wdt);
>> -	starfive_wdt_lock(wdt);
>> +	if (watchdog_hw_running(wdd)) {
>> +		starfive_wdt_unlock(wdt);
>> +		starfive_wdt_disable(wdt);
>> +		starfive_wdt_set_reload_count(wdt, wdt->count);
>> +		starfive_wdt_enable(wdt);
>> +		starfive_wdt_lock(wdt);
>> +	}
>>   
>>   	return 0;
>>   }
>> @@ -497,7 +501,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>>   	watchdog_stop_ping_on_suspend(&wdt->wdd);
>>   
>>   	if (early_enable) {
>> -		ret = starfive_wdt_start(wdt);
>> +		ret = starfive_wdt_start(wdt, wdt->count);
>>   		if (ret)
>>   			goto err_exit;
>>   		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>> @@ -575,14 +579,8 @@ static int starfive_wdt_resume(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (watchdog_hw_running(&wdt->wdd)) {
>> -		starfive_wdt_unlock(wdt);
>> -		/* Restore watchdog state. */
>> -		starfive_wdt_set_reload_count(wdt, wdt->reload);
>> -		starfive_wdt_lock(wdt);
>> -
>> -		return starfive_wdt_start(wdt);
>> -	}
>> +	if (watchdog_hw_running(&wdt->wdd))
>> +		return starfive_wdt_start(wdt, wdt->reload);
>>   
>>   	return 0;
>>   }

