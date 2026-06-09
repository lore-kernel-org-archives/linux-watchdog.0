Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B0231842
	for <linux-watchdog@vger.kernel.org>; Tue,  9 Jun 2026 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974556; cv=none; b=QtMYr3gsxCzr7D2Syy5u0RMWHzlns3+rpei7ypAevvIIydqrMOZm0npXTG81/JTzOEcPgrBOsiOwTwNte9cX/CVsG5eodWCJYnDlzTo075fT0cnMtHiYokRoJHyVk/Vbp3zJUp2C8QWkkUPRt8OGH6ErLiw99ohCZv2194xlL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974556; c=relaxed/simple;
	bh=RWA8KG3ziPf4xjpFtPaytUXMIp4+4F6bKb0VKk2wlb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3fvccYS+Fr6n1A4JNs+ywZdMeYpVuAXXtjLKwtiYd3YN+C8xjZ0HMqZinIzySrgaVj1oqWOQZVhEgjXEpaRlYgFLqRLLJex3+YwXPafXom478ZYFmDtiUAQfRZv8pV7irOh46ZJTIlkFQb6xut3COMbZJndkWD5KAJjrCtaghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2VnNlQu; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2VnNlQu"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304e83724bfso6083521eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 20:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780974554; x=1781579354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RMMUhin4/FxMkfSKkZQtK4sSB4oDaAJn+B+MPQPQPKo=;
        b=a2VnNlQuzIIIotOlC+2/bbojj4zah2j9xRVKT7xhikhTpXgIkGAgbvlKj0yY8KFr3R
         HVJi5YsmZ9aWhhVumdjWcYBA7bCYWaZ0UMZmJ0qxyACDnwlmB/s3/pjY3DqXJ+F0CiPB
         L39L1+uJpu+6TRYA9mYHh3HuhIMztVqg1Yil+sELBrsSR6MC9sfigAUazEQ3BEaDKVZu
         u7Fs44XRqV7r8XHx31s7S8kSsGszsxZkYP2fKYnB9vDUvMUBSfRFsGkqVtyBR1UoIF3U
         7m98cMMJyeosmCVFslFmd013XMVpV+nqUrm1qwkYF3lJI9YieEYU6DB07cWVJp652uWp
         VOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780974554; x=1781579354;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMMUhin4/FxMkfSKkZQtK4sSB4oDaAJn+B+MPQPQPKo=;
        b=B25RtyrkHAaqhfSRT3g5JZcLGjKTVFoR+Cd2Myx/us3GMr7nXROiFkPbuXgqrCCBYc
         BOdKq4I6TQCy46YkAvYj6KQWGcmFSazkInYc1owIwnsNRCznYfxmgSJcBiAWoXYyVxRO
         2dXM22RcQrvvOwF9CIcFsjD2UMjM1y5s2jHnGeV+S2pvIcTVBUdDXVDYEvsOLlR3ZFkv
         yHMRTaPbAL9ulaf2S5JyXkOPDVFJwkFdSnx4AAih5DyA2TIjFREnLv2c6oca1rf8aNwI
         djSJIxY6vtjxqLWTiSKA+zvVVuXaPyfLt964+120QzNhi/hedUP59DXUo4yGhhYUWn6J
         0knA==
X-Forwarded-Encrypted: i=1; AFNElJ9JkcTqZGmgafczuO3UlaRlXd3d3hgPRiySwByJ4BP4Avfmt0S/YqESE2BPPScntkdnkQ0WyQKI4K6pgMZ+/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr31Dun7+J1XHeoBlHqXLBI+Yb6iRZP05AhluYr7Ns5EAkPia+
	Hwbo0oIohYeEADyYHgwQgu+IngpM0UqAsSJlCJqWGYk0uXFtIutG1aJi
X-Gm-Gg: Acq92OHyqKjczy2HCUI1cfwcgm6G2Pgn6orafi8p0ZTl6PsuW46dFiX4UesaiTlkhYf
	hIcsTpp5QIMkiI+mZ0SbPRD4rBv/JqpTOs2dpPZcmGXqGbXu8KIdzO+v8FAGsZEk2idwALPLy/q
	6ahS0gzvJzeZLnUB53HvCU4VJYsYJQQl0B7ewI3Ig/sDmE/ZQco213O8xTA1oJEA709WslxIU4l
	WZUaQ/F7na8zLlMJewTRbparu/ErVMPhoXNy4/aBgb468hH8acFk2jzyKhA+cy5vyRq6nNq37eg
	5c2zS3xh9faqg2Q8wFiiMYxlDlTqUCBT5Z/GL39ooEzbOQnvwslHx0IWTZR+xlgSqM04ZA1bc/i
	An+yZPt0U9Tcgk4h6uj3hHEAApVzLNM/RWYmi8VltJiRvDrEa8o/9OXKAIYZcNM7GYVj+Yaaqmv
	8WryacntEXyNkYsCBIg3Ef/rQsxQemeQjFkEoyxmoKDjcTQHrxOZMiYWPj+Uf2yFx02yRhdvbh3
	segsrCP6Ic=
X-Received: by 2002:a05:7300:ec15:b0:304:997c:d47a with SMTP id 5a478bee46e88-3077b2ddf0fmr10227025eec.10.1780974553961;
        Mon, 08 Jun 2026 20:09:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8708sm20593483eec.15.2026.06.08.20.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 20:09:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fc12d7b1-e736-492f-bfa0-da17897ae58a@roeck-us.net>
Date: Mon, 8 Jun 2026 20:09:12 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/2] watchdog: pika_wdt: enable COMPILE_TEST builds
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260608210402.31545-1-rosenp@gmail.com>
 <20260608210402.31545-3-rosenp@gmail.com>
 <235a947c-b95c-4de6-8ca6-5656b5358149@roeck-us.net>
 <DJ42HFIUK9CW.3KNNGNAFFJMCW@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <DJ42HFIUK9CW.3KNNGNAFFJMCW@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 16:46, Rosen Penev wrote:
> On Mon Jun 8, 2026 at 3:55 PM PDT, Guenter Roeck wrote:
>> On 6/8/26 14:04, Rosen Penev wrote:
>>> Replace powerpc-specific I/O accessors (in_be32/out_be32) with
>>> generic ones (ioread32be/iowrite32be) so the driver can be
>>> compile-tested on other architectures.  Relax the Kconfig
>>> dependency accordingly and add the required HAS_IOMEM.
>>>
>>> Assisted-by: opencode:big-pickle
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>
>>
>> I really don't think this is worth the trouble just to be able
>> to support COMPILE_TEST on all architectures. This is an old watchdog
>> driver. It should not be touched except to fix bugs.
>>
>> Didn't I say that before ?
> Sounds like this driver should be left alone then.

Very much so. The driver is for a FPGA based system from around 2007,
and the company behind it went bankrupt in 2022. I would be surprised
if the current Linux kernel even boots on it.

Guenter

