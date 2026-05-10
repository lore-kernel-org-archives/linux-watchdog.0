Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5819D093
	for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428169; cv=none; b=K90nqtQjkwwNUwCVYO8qNEdhPeVWItMEf7VsOCo5TaUEPunhFpakDQA6zDdDXjZvbXqH9tAI/w24+vWhswAUC1Cw9hDog+9Sd2frxTxD1eiHPCrA3PZdMWGJaSKup+56eOPu0xvymZR4JFvY5g/kMX2c+ZTUq3b7Y+KYN6GxgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428169; c=relaxed/simple;
	bh=i4nIwC50yW11Bf3kqmIlqbp1sABFpoNiNQUVMBq0wug=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=g6fADmzlRk6rcoric5DVBI43rdBRSTV7tBrUelkbpFiInws5Kjh527sQVdkoHrf5HYyaUy0mx6uHoRAaein/IQX+OwDMVNC2z5s9UlWCBTj11gr3S0Fr8qAjP0fElaU3qJtKBYMNxxphoj8GCugmVnn+GAq+KOdmvuBeZUegjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2xMSzhT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2xMSzhT"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-362e30526f8so1657180a91.3
        for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778428167; x=1779032967; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCJDu9K5PaNt8B9atgBnwdhBqFLBGIuWh0q/TUAudRU=;
        b=J2xMSzhToSuuQ405k6i54LGKHR0yeU5vR7Lm4P3kg165aoKKoMEIOBwhyTMq/rYXUL
         X9QscFG6M46ykPf9JsjMUru4gUz5tIg8nAJyY1HVUnUObMmWA+pKE/lWuh1FW8DAJDRw
         ewyLHxOiMkyo/uiOsveDiUQbsPAANa1ckKmjuL3Mj0BjouprAMFcNHLHfUn1YwiT+tIW
         n4yoXfwhXmqzOMTOUx72pwZHf+OT4HWab0tJ00vp9O4xFP5nnsXJc5Gze16KvcOmEozh
         q4WM0b/TU7AKvhS0/St7O0D7aiRxNcjS+E21zmZZfXUE6r4LyqOxdpoY7cu0auq2kGXg
         3L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778428167; x=1779032967;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCJDu9K5PaNt8B9atgBnwdhBqFLBGIuWh0q/TUAudRU=;
        b=aZEQZSb/VZUqXIihHcUw8kqCBeYTuTJIPuNv2ZMwFVFn7n7p4MWMi0BXWYuupXr1j/
         nenFgiXmiWftQGOW+Tdc47i8YI0UFdHqkOw5rhXYEVx0XtM8bzW4+rmxZBDC4E0EBYYL
         MmYXhXgLq5yFhFTQLS1trH9sqbBqBgigIaYy6KWovzim75mQYf5qhjDhASlbzNfyslKS
         1/AStfV3/gTphNPb0SNdpXCc5d1sPxXB7/3Asazm9Iu++cTucUf4/KRUiggydMqFV7aK
         +5HsCSyRxz1T//RxjwdC1jWlbXn4AIsnxAAbahO3FdhorjfXxZSE85+WrWDMIpgfqKH2
         le5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9BxGPVOPiUpWb2u3qV0atcy1+cfF/HQXOsNsqGcyzxhgvl0ZMlF2zHZfiKmSg3zOxPD+NyRG9XoGaAfxx90g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcrVjxC3ml8xviVi4XN1p8o7y2XhEjTEpL8YDl9pzUgdnivQe
	xogtKiqWdJh+YuhswhTLd4wDKknHtMmQFeoB9Rr5gyZ6BfylMVk3gCwN
X-Gm-Gg: Acq92OF1hXpRAVlX4k+8xfJn1h8jHnAZzLThmHcY8TU1eWCS9TyQ/AaLA2L9Kx7c8NH
	ehIm7kw89gqxONPgJZ536jOX06idYvbPb99GIM6shsl4Pq7GPrnp4UXhCFB1ADsZg7P3qHgQDX2
	a9qE8VZMJAC4IZZLnq/ic5NbpEh1iGrGMRnYMsr4Pc9rDqbvcRDrTqjjfnPVj8KuYexUlKzHu7k
	trrpTzxOlTAlGvsl5VX5Y6fEZ+XKTeCibSnB4ac8UeTEcpOTnliw3Dq68eDnW+3adVR5/VMy1lx
	mDploe+6yzc0HxFIhQKVR7sxSHBFONl8eDM5udTdK3mHYiA1OdYsz11xaQdDT1tdZefKjw1O67F
	Dj4sGGDEEJ83aY2SjPgwobtlW9Ci096m9R1pFDsYCzw2Td1r566bqIYpk2Yelg6LOVLJqiWn4/Z
	6DEVlAEQAP8NfoPTtnpiIpMrzIzFZhCdXT5+QymTVLVI4odGKGpy8U03qvFwyMEqXb+QgA7xIZ
X-Received: by 2002:a17:90a:d88d:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-365abcf2382mr22669024a91.12.1778428167319;
        Sun, 10 May 2026 08:49:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d625cee7sm4898799a91.2.2026.05.10.08.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 08:49:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d6b1c417-1e3b-4d5f-ad3a-6de1ec23a8f2@roeck-us.net>
Date: Sun, 10 May 2026 08:49:25 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, "wim@iguana.be" <wim@iguana.be>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Please update watchdog and watchdog-next branch references
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

As announced last week, I will handle watchdog subsystem pull requests going forward.

Please update the watchdog branch references as follows.

watchdog (fixes):
	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
		branch "watchdog"

watchdog (commit window pull requests):
	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
		branch "watchdog-next"

Thanks,
Guenter

