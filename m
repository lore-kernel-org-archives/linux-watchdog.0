Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB31399369
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901820; cv=none; b=an242OqqmVM6Jq/D86bES1XTkU9JbrPE1Atmv6PIq0awAIW/K1ULvYD9fBP3pwPiyt/lJJ5QwkM08hNsdBcUP/XEMrDyefCZ0liMfIZMTjXnKjvPqd7qzeLz8XlbpQ/5a2rtaIG5DrbV0d1tA2IRDHytSR7IwjEbFnDx+T2LCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901820; c=relaxed/simple;
	bh=5bz5piu8m/nSrVS2BgRS08mkzhseF1K5be0rFdn+dx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzRNKl2GVOZmrMLCEJuZMaPae3RwS/BDQzX3v+9GztaraEtjzmnVT5c+tk4wL9PzzUUnkwH0jWgex7VZItyejKcKKH1onK/ndw58kZcZyMTxeF3zsv+GaPwF9rPciSbyZtekDz07abdC6Fdf0qt7X3hzlLPpzYrcSGtqM7v5SG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNp8mrTD; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNp8mrTD"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c565dd3a7so9113665c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777901818; x=1778506618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bjUbgw+njgftNCwKxoNuUVnKhfoLJ2EF2w8NxPQZwn0=;
        b=VNp8mrTD74WSAjZJjb35J2HE2e38dTe/zI6zXg2qDlg8WYknaC0OK2YNMGLlRbTdw8
         Hur+lZE2LcRXQMgtyHM+s9APwESe8fOaOmkKtZNNerjCY1fGO84O+tQWVetot4KvLF62
         Q4fNoBpL2d2xSZ/GfULkkF2+MESwYP+Q6zLLkUzemJwlrx/B3z2CVZK3ZNYmBDudSaCS
         eIHdYKS+/MP8AgWnjOIGGOLabY5oZEDcOT8nyjE5GjCBvKmlc3oUNB0A9wop2by31efG
         Ii9A9MsYdrloYPv7INbsxLnoz5zLjdXjqAf7V0nH//SLVnd7GI6eap8M6xr9A9JLxfOf
         t+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777901818; x=1778506618;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjUbgw+njgftNCwKxoNuUVnKhfoLJ2EF2w8NxPQZwn0=;
        b=gs4+L/NakR8fqA+uxM1KWzCxnX0tk8P5TD/5SqJoTnskcJVte6sUSw8hDJxaKuoDP8
         XALuqJ5SEvB7eTYF6Y/k5U070yRw6gevHPycgJ8f/azuLinGagqWy3ryhODfsXgGLp3V
         qFs8jGHZT+L5EQmRuNHR5VmrgtOuxUN/eSdPp3F19/XqiK2b2l8bfDFc1JNKkZwVzEZa
         KbswCbI1BV+coHtZS10jRBzys+s0r/Ii4mG+0sNHN13XbEgwb6XpnnMKTlm1M2vJqWwF
         godDkTdF2+ocJPrYYrcSD4eEdFV0JpgaVoh53hjnzPn/FJHcoWv6k6RFsOeLQgYu2WQm
         LxXg==
X-Forwarded-Encrypted: i=1; AFNElJ8zZXWnAzffGTBes1ltifq1pUdMupdvEmKIUrwD/yf2ui6h8CuhavQVRSfNKKOnYN5hWHf6EYiYpiGMJSlNmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSCyqoKifXVMV9Qb8dNwfI6jA6Do18Mi0jQOZ/+qqiGDPDKTJ
	nk5ikwyy8GdddNlUDkb05epkdAIrqcPQFfNwCx+Enxtrh9/Ac9CAz23Z
X-Gm-Gg: AeBDieuf/EET3SnQ/NUf6gBhrZWREQYAVX8L57AOnxXpjW1dH27681O5hSNs2ktluYJ
	9mfwKvrrZq2LKox21QZIJFmOnWNcSJbyUVes8R5od/hu36IFXw+9v0aAAKQvxI02CZP4Ud5v+ia
	S/8Q1Q1lTj6B88GcyhBHiqLTYw8O6wAjM4GTPDrPfeewC+hhR9F4cEm6/tpFY+hnfDksXgFayrE
	A8vRSfEJpdI4XZi/05wz/lr2p4diLR3tmj9eduOV/iYHNMrpaujVUuvB1oqvzDa4pyjZNYcK0fX
	YctzBJ5Y/Wbk+p+rhwiTbtTZg+aQb3CtSijRJJoevSv+2ffyO1Pcrk7mJpRPIA6uJ+TBIR+6jgu
	zHzr3IVge2LoNCPosGk1FIq3Ld9zD2WwvH36Syq+orSHGcTawXhlMIrt3e28goeqU977RdR3e/k
	5zjH+W8aqwB+oq7R7hMx6rSMZs4zWMntD3y/n3amhxlfZRHgBSLS7bwG6KphUalP2Tubf5oQsQM
	USD9btEAkk=
X-Received: by 2002:a05:7022:68e:b0:12d:cbce:5fb7 with SMTP id a92af1059eb24-12dfd7da8a6mr4214338c88.6.1777901818296;
        Mon, 04 May 2026 06:36:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b1a4sm15947252eec.18.2026.05.04.06.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 06:36:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1fc146d7-04e4-4dff-92b5-e6dcb81eabeb@roeck-us.net>
Date: Mon, 4 May 2026 06:36:56 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Picking up watchdog pull requests starting with the 7.2 commit
 window
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <2ca2a562-f9b6-4a68-a3a6-1fe4c03e7b40@roeck-us.net>
 <b1309b89-ffe6-4b6b-b257-bf7d7b8f5885@oss.qualcomm.com>
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
In-Reply-To: <b1309b89-ffe6-4b6b-b257-bf7d7b8f5885@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/26 02:58, Kathiravan Thirumoorthy wrote:
> 
> On 5/3/2026 10:10 PM, Guenter Roeck wrote:
>> Hi all,
>>
>> I have not heard from Wim recently, and he did not send a watchdog
>> pull request for the 7.1 commit window.
>>
>> Unless Wim informs me that this was an exception and that he will
>> continue sending pull requests going forward, I'll handle watchdog
>> subsystem pull requests starting with the 7.2 commit window.
> 
> Thanks Guenter. Curious to know - will your branch[1] be integrated into the linux-next as well?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next
> 
Yes, if I don't hear from Wim in a week or so.

Guenter

