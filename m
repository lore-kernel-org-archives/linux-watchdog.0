Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510953;
	b=GGSXiobgJvDYvawufLAM/s9fW7tlW8ERmWtgTwYMWFiHpbSO2wYCx42riAtwl5F9cNVr
	 E4F3X/GBnP3kQ6F1oT0G8A5qOjtWnwFdyIpBY8IG4/a6+Nq7MVNsILTLupdXEAggsdzCa
	 b2Kb0oxZj9mieXbanJhhLxSNmwxXZg8mCrFdsPrN4+0Zb90gBHenSBGivhH0Kz3dPo6Nn
	 3099sZgo4PAWtG1vR5ejnl/rfQT8ZllOsjst5ooNpibFcr0WsS26e2zQI9eNvAm9N4dCL
	 5lCMmh3ci3S9tLNwCT9goWgUwh91kodT0SVHw7g1DNUkxWD+PtD8CVNG+35oHMyPbLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ha92501mYo4eZ+6VzZrrZAGeSZLwhK583D+B3xN2u3Q=;
	b=NHqUqUNEh/2aJvJaS09j0IZzqM9Q4PP+cMfENOdTTAhvcYK/yjeJTUUqxnfcHQU2d0Ak
	 0C+tecLfn2BXvrhnCuh2uwdfGTWkHzblySfSEHSr0WJBfWB7FsLeXHe/PF9pEmnRw7Q7Z
	 j8h7AowTb8qO4gr2FQspa+YPBFYAH5V5ZnCU9mLTbIgT5cZEFID8QV2xcuQ/cNZQ2B9yP
	 vEmHAFCbKKkUBvg2/jEs4OYoygRriSZHAGmuZyDPXAE0qsV5gyBiTXo6h9zf/2yn0GR5d
	 WqCVAq44x+xkxRy4HlQIjYcIpPjrZ5GmcQM0Vfpj5AE9bntpjEVcmdyX3VjGFLAtaeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OvDR6hCD;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B3606A319
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 15:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B60B3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OvDR6hCD
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1438d9363fbso248749c88.0
        for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510952; x=1793115752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ha92501mYo4eZ+6VzZrrZAGeSZLwhK583D+B3xN2u3Q=;
        b=OvDR6hCD7KSUIrLTxwD+wM8ADil6OW4AxS5vuW6sWk0BvkMY3CMbwghhU43+BmgJhT
         DvimmAe5HljJSUwdraf6gsxC0dk24d3w6zGKH2G9zyPKlhF3K/QZ8XIHZdGU1hMIYYbG
         XnjDO3hNqVUht8VdY2o0iWPfe/9C7a76hs+Yqq1Qo0ZhHszVSa2FrbpIko0JctqaygrT
         MTeao5fBm0Z2sOKOBK/R275yKwdGt9f0LD9knr5o6nalLkEw5z+WhcihWBcq9vqclucA
         Rmg2aX0vPfydwDjnF6AVhExJc65Ocqy63jBVYV9aeY30z2W6Pze2QTtGLciAgNXdQJVN
         FQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510952; x=1793115752;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ha92501mYo4eZ+6VzZrrZAGeSZLwhK583D+B3xN2u3Q=;
        b=FQAl3KtqJOQ5XJ6Pvlpf0A8dsTcF9ldfzWwSd2nX4ISKrwe3/Q13y0Be+aim4L2wz2
         t4R5/Q4YCD3PYWJBQdk5yuOvVrEfx0kx5q1L7l5hUk2X2W6bZzSe9NCqbhQspuUN4XbQ
         vS0pNW/hJj6K1EeyrHckykF+ZWgme+0dS6B0pNIKAm05RfaEpU0V/VBKObHgUMJB48XG
         bF05E7sezyPj79lCyw9jLWdFR1AJZaod61nEqCzwONJHLt3CKwZsMENORqa4sDVPUK0v
         RoxpohidMGKvVcWwY619hbKvOGO+3nulNDZaOaI4X/yUPCWQwzdxwPa+VFkhCC7xWWL+
         5t9A==
X-Forwarded-Encrypted: i=1; AKwUvBy/8NBTGAaeD2pEkY7C3jMKHKJStek4ks37llNizxNq787OS23ttZwMIZ0wRcqPY2SHw9KmIEUTVqpPTcJ5WA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKycKGL3tYfiX+lSlCKBwSIxhihmD1jk4vX+tJAbGn02m6jgmsg
	V2R2haD0Bt5d+8yXzCs/fK8/ZlBTxTWRO7uajn18R+AzW2sw3alcICuzaUhDKg==
X-Gm-Gg: AYBFou2I4i5EjpvCimAxlEQ5ekqONpwE8NB78S27uB3F8M08zKJIufv2lULBlSniXNs
	EJvssGfc1BmAlZhyy+fDJ8I+//a8e2DXoUiKW0v8e0oJ9+ZHqU8Zj9j41ptBntWTpaH01BP1wem
	1dOyhSPKmzC2HGz3UW7qCYnF1G73PkYEJ4tF6aLO9WiZYTpeIaznPC3AlQk0m3OFvlc+EAsT/fE
	J4vl94ywNIDOXDOMjGf0xk8eU71bQMmzwjE4+dexZCdyd89u0nVd1UhO3RpSmAUYK1I7INDGBEU
	6+LCIPhbqg5Rcn5Bq5c1oEYGGrpysVraO1/8ngjW7Tc95Y4EifygriBBzqgJSnLrL/bbycT6e3L
	KFX7Q2RX5a26yd/RLGi4e9evEClRsH7Mr80L/TNjTf0U0ZmgqH2q8VwhBTvJqwjCMqAAdWWzRo/
	J0shfvr7r4oX49S7LXOdYDvSEeDgNsrgCn75EdLpaeJdXEudc6AUUhK1kSokq6Bf8N2G3TePZ1K
	Kyamcg823bkI8fF9Xb04fRr8v6mdso0/cESS9D1RUX8JKhT2Q+v4JG5NlqtzIgEmE+jC4X5BQbe
	9L3iZCxrXz4derVoq/LUPaLNB2wJLQ==
X-Received: by 2002:a05:7022:419e:b0:185:e68c:904c with SMTP id a92af1059eb24-18dbe2af64bmr5061788c88.7.1792510951564;
        Tue, 20 Oct 2026 08:42:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fdfesm38145624c88.7.2026.10.20.08.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:42:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e92d62d4-cd2f-40a0-a973-2f2a0e392bd1@roeck-us.net>
Date: Tue, 20 Oct 2026 08:42:29 -0700
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
Subject: Re: [PATCH v5 5/5] watchdog: w83627hf_wdt: Add minute mode counting
To: Tzung-Bi Shih <tzungbi@kernel.org>, Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
 <20261020-w83627hf_wdt-improvements-v5-5-90b226684fc7@bootlin.com>
 <atd1wP1cELjiwjXT@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <atd1wP1cELjiwjXT@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 07:08, Tzung-Bi Shih wrote:
> On Tue, Oct 20, 2026 at 10:11:58AM +0200, Paul Louvel wrote:
>> All of the chips supported by the driver can be set to minute mode,
>> allowing timeout value up to 255 minutes.
>> Add it to the driver.
> 
> I didn't review the patch carefully as I was thinking about a fundamental
> question: isn't 255 seconds already more than enough for a hardware
> watchdog?  Why does it need to support minute mode for timeouts larger than
> that?
> 

One would think so, but oddly enough there are people and even large
companies (like the one you and me work for) using such large timeouts.

Guenter

>> @@ -49,7 +50,8 @@ enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>>   static int timeout;			/* in seconds */
>>   module_param(timeout, int, 0);
>>   MODULE_PARM_DESC(timeout,
>> -		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
>> +		"Watchdog timeout in seconds. 1 <= timeout <= "
>> +				__MODULE_STRING(WATCHDOG_MAX_TIMEOUT) ", default="
>>   				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
> 
> The patch is obviously not based on the watchdog-next branch (see commit
> b152ca999c5f ("watchdog: Replace __MODULE_STRING() with __stringify()")).

