Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795158044;
	b=mRSqE4v3JUHVoLRLdKR2e16oHlgZXvwRtTmCPK+d4lmFtL81t9FWJod/XhJxRwmUWhZ7
	 8K7NGQyVN1moc9pXTOpuIJPPDMeAtng6oxeY3C42L9v9PQztaLoYVEawQYVAQJsLrsGI9
	 eEp+B0jiY6JJhSm990ahcEROVWDe3tM9jLbC/a2ehjY4tkqFDq3eJw5Hgl7GSseMvB1G2
	 ZD9bAedWNvMNteBqUy7vpMnDEml8y1FV81JQbgUq43OPKEQq1MfJk+vFOUqkBlwc+csmn
	 ywWLNQ6VchIZMou/aEaB03feuKNYGIrp84gIde+rICx9cIZo3M6Er6d+huY2lxFLWRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=hX95mcjQTa/LIj5MH/7eOalSZrQGrb1tQtrKrDQJf2Y=;
	b=0iSGbvTouOR7YxjGsTOcb5KkbzduyiU1lj+UwJRgoerBbc9FFrl6LnSyoXQOgWjfIidt
	 w1AIM6h4EHG4CcdQMEP9oBMNEHnokLpfsfcGYTKsFX9MTg6PUn5jgQutMESoQY/38UX2c
	 L4zsf9eIWTT4iukeJTSZDnlepbTHznH4n865C6DOOw5srZuzAZ2Buh2/3+g4hjRoCUJji
	 aA3ZcUZz39wYnCFMVJAM2RN9tQsAifUTlEpNYFy/p1rQPJPteA8GUe56F1dg09zrKqAMg
	 vX8OPM+72uPmu6wAs4OmddsFWph4EiIPzFCFjwWaM930PDLdKrQed8ANBIVFTaKSTMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zn1EEfLC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4090606A33F
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Nov 2026 07:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4090606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zn1EEfLC
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab30d04674so648341fa.2
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 23:00:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795158042; cv=none;
        d=google.com; s=arc-20260327;
        b=Hck6DB1o9vOKqyPROGzIRy6vAPTX+lLuousViCCqU+/GoIebqIWmVzd+FIQD4tX/3J
         gOPOW/XKamcwqmyVRo5H7eVHBb6DBBhwxg6o9XA8aK58xvK8dX1AqA/0p0pimJQA5ojS
         4R34zF5XxjnCf6Vq9gXBJFUrBwi72S82lE/YnEZNIMhaCI4x6JeOiVCr1rH2hgKUh9Ml
         uehRdanSu0iNs07CUAtCOyoBD/EyGOUknr8D1rr8PZ0bR3yt8PwjCmPUOro4TpJtr0x9
         tyzSjGnRBM/utNa5cjLnNTnOFdH4WASoqiUz8Y74+WG5kWp8MOl9ddfhlbnRETNVrVTw
         I6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hX95mcjQTa/LIj5MH/7eOalSZrQGrb1tQtrKrDQJf2Y=;
        fh=UdNDKZhOw2FoxeKgliRnDfW4Y/UnpMHaKdLdgNar1UI=;
        b=O6TK8lsg9RkOasjiRKFkmbLpAI5RN8wPtzbLHvkIEfreucKuvyRBupTFVc8z6ji0n0
         BCKtlXP6rAG2et6hbumjAgGCCpz93rdyRECMrpYOJB5sMSp2oq8EC/wsfVEEarSB+Y/q
         roa+2u8kW7Or4BeGHRJZY5JzGwAbAyye9BBchadcQ2eAcuikSftWodmWHnGMKhtqjbGB
         uCBygojfxOMyKIt5HZ7+dUr19UiZKjo5PiiGQSktQ8L4Lux3vCHLzNUrp7Gk5kHn46rK
         VbRGtTy3OgGUHRLWon0BMR3qtT+V6uXLn5IE1+hVnBBcSzyRixnFRqxyRhHxc5/GKm8K
         k9Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795158042; x=1795762842; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hX95mcjQTa/LIj5MH/7eOalSZrQGrb1tQtrKrDQJf2Y=;
        b=Zn1EEfLC3m3kPC+umVVBpJBCFAIwZj/Km0qZuXA53QHJT6ImEy8JE6Xa54cz7x3AQJ
         MlYsajf2OChfPJgxNKGinzo7G31EKb3GeQrcWn/hQmiXjQ29hoA0IWqTl49E78a2CY3V
         SNvDrM19qwPCLldUJT+Ubpby2gbNos4cN41dAsRVJKvqryLmiyyyZbcIIuqgzncbQz/s
         k3RzQzQCQKyfroyJ3o8O+5YDdPsMTYXavamoyCsA2yf+wyalK1RCttWSiyplHIcqOKCs
         CJB2wIchdSDfaEJeIPU6D6OEW3XjiWnQqss+miCAWdW3uA8DBgDLTAGk1Xcumlbyjnjo
         3b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795158042; x=1795762842;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hX95mcjQTa/LIj5MH/7eOalSZrQGrb1tQtrKrDQJf2Y=;
        b=E/lD9YlLEZxKKw5KGsOTizZGeLUQy5bG1mXNXwBN7dAYXbdKSRw85ZtrRzNeUGHFvm
         L4vDVLXkoOzS4ohEk2/cR+uMiWCYx8sF07hl6v4LtHdY0p/IDx/Z13QnRn9/7HGcrpbq
         imo+EwUC63xye6B1f4UTX8V4nn77kxCB6wGM+B59hEpYpsR86SNAJpGQEOPZX0f5zYCG
         wkG7oYpO7WJ9MR9jpJkQ31eVGVHsWi0ekGBhRMA1zg1DzfnpGJi8TtzIO7F5VTurhwbq
         vRX8oRAdmqRXQnemLoQdYZEuE15LgHWpthOPjYPA0FAmEyyqEq1L7MW/czjAPj0AM/SH
         jwgQ==
X-Forwarded-Encrypted: i=1; AL+hErGWqq1Pa808fyapQFssSgUKMBhut6uV2ua19P4knVsIk3QYrBQntcdQh8F7bwUzSm2Cdkq8+d8VN2IqwAtIjQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/t4gJ3zWrMgmWVZIwm74UdnTVhMlyiIRI0BY0jsptnOt+GEp1v
	2yruCohrmkH61gmiy0FAE+A6eoHiLsnilyX3BUb5Ba6+5Nl0wsPIjo1CgO+WyyunB5BMpMA36px
	a+72yP0/NrqMyG7H2nHqN7MEZVhtm59o=
X-Gm-Gg: AZFdTZdCIt+zV9Nn/O/BhCv/acpQSTAmd+JqkSAg/eusQ0J0HXBUjW86YziIed6GxjD
	3Sn8l1EpOwwii2EjdUDqJbUXcbhm8jfxUtt0/rOq2hIlOfMI7Ac7RGTvY29vi8ddJ7MqYGxLMC+
	Sr/UNMc6RNWJ9XDvhyr/W+GXtGr6+eXGCY8azcXq2DxPuUu6jAzZlqoVySta+irLuAVStgCEk7G
	AJ6PKcjRkL1+Ftv2lrRyLjdAs0zDb8ODTXlvSQ1kQpcxvRPAwjnTarumGdM/WMrqnHHBaRlmZcu
	6aWJaTcyk1FzN4tPjtCQOo5dMGK10/FsK1S2ij6wuDX1QpORwfGxR+UWO4cVAcM1t0GtuWwgvV/
	Pv0E47r+nuA0K1MJ8lF20n5pPYToky+FTyPKRhfTOobH/2IkIcVW+zNzQBX6didz1N2hNsBs=
X-Received: by 2002:ac2:5692:0:b0:5c0:ca1:46c6 with SMTP id
 2adb3069b0e04-5c1bc7b71b0mr788664e87.4.1795158041586; Thu, 19 Nov 2026
 23:00:41 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-watchdog-reboot-keepalive-v1-1-c5902d959796@gmail.com> <b11f910f-c687-4d11-8a39-879e9db82cc4@roeck-us.net>
In-Reply-To: <b11f910f-c687-4d11-8a39-879e9db82cc4@roeck-us.net>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 19 Nov 2026 23:00:30 -0800
X-Gm-Features: Aa3M54pzX3CB86K7Yr9LDSIkgZF5zLBiqn38AJwWsDjpbNhuep4mRSlRPeGttX8
Message-ID: <CAEy9hNX9+pLn7bCXvxYjKeV3Xrg5nh9w6zprdQYXuyyO=5bYuA@mail.gmail.com>
Subject: Re: [PATCH RFC] watchdog: core: Ignore userspace keepalives once the
 system goes down
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Primoz Fiser <primoz.fiser@norik.com>
Content-Type: text/plain; charset="UTF-8"

On 11/19/26 09:10, Guenter Roeck wrote:
> I don't know what problem you are actually trying to solve, but in
> its current form this is a NACK.

Thank you for your review!
The case was a driver that oopsed in probe while holding its
device lock: device_shutdown() then blocked forever during "systemctl
reboot -ff" while systemd kept pinging. I take the point that a slow
shutdown must not turn into a reset, so I'll drop this.
