Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45339BFE7
	for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142263; cv=none; b=uwFUu9lT1h2+MwgvxfH1N9kdl3RHA1dEmdPOIf+7UnphLdoZQ6/0/o42TAe7BNLWAx9fmedVieYDe1XXOUstkBw5lJvEcuSKyqB1f3i1rHCfoLh8O13hTzFWV1CB0o5+o143efngIE+jUOEQJI5d9O04gYMchZPHXh2F4rCW27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142263; c=relaxed/simple;
	bh=n+7FvY02K3+HOctBXU9nno9PxOTC/ebzpE0fXScO094=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjrVq4/AwcPQ0EnSPj6TGvHxJFCW5jL0R2Rl0A983XOBqsoNpEaLfO4Vir+DdXTGvN5ZR+DsBLWj8tB3NRbbC5GBDG1X8j1vXdmTA7KqF85jz4D+bpQ3YvwyAD9xqyCuQWxXH6LMiEMUINyOv2CU/N6ADK5tK556KCzEMjDIxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB3ySO2z; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB3ySO2z"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso1430496eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 15:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779142261; x=1779747061; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HXTPu1Jw4KjI8iz6nm8y1/UZUSAvRU/5XuDIcVF26Y=;
        b=HB3ySO2zfF/8+0tMqMQ6gvA5eL8la25SFvWfLJnVar57pc1V2xo195/HU3cPrIR7YV
         PAYUHDzhbezgtqkuig+1+plzmAgNt8pFAnc1NM65OPapynJUF8NSL7HFBZWFxajo2L3Z
         VBMgUUzUwg95uGZpTly82t3SCh50Ao0x4+lIH8Wq0/66iMRUIALW/P3IyhwAeL1ebxTi
         TRzBBU6v07rOGBsj7bDCl/cWeZofGcT2VheoojbIfILJhzzZIpZuU67+esgTE0c4DO9C
         gVoGCvjdTpjV+x+yRpKbAm7lsSLb/eKVqOxCSXKCf8nGH3RkjXZUWwEWuN9i48MxyZjC
         960g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779142261; x=1779747061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HXTPu1Jw4KjI8iz6nm8y1/UZUSAvRU/5XuDIcVF26Y=;
        b=EOmbibwLMgr3M27v0nhhADDM6moiDdW6+lZ48v3QvZc+u8GAcQo9nzqHOWUl6Tw9CC
         /neGytGo68Zu3iLtl8PYcWdlIhTXQfsr6F1BbD/XxjO+Sh4RVAqNj9IcSk9iIsyzFDqa
         3V5B5Ijc9xvANmjCbPfFIPNHzQzQHpYsuvmEp1389pVT1S07mnIwZYqIjpa5o0NLHk15
         pHViPOjxpcK0H9hgy4UjmDt4wVhqbGYLnP6TGIlYRotwEmAsKoNwjeKnw1LuMmj2wcZt
         yyReT3vRrTrwiIIPcoe3P9dEi6ZWZiyyF5lAunN0MjOm8vNFp7k7Gy3QCOoqaeNrne5q
         7TCw==
X-Forwarded-Encrypted: i=1; AFNElJ/EnxoPOdvYM7XhLhuPVyRa1oQFn09Yjyrg7ph45/Nww71OnqKc61qYXOZaTs4uRZdFimidBtdFg2zhrlXeKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCyzRnLrTyHV5RKUjSU24IOnf8ExmK9PnD1tPZI4QDROO6Qz4a
	sAqmgMslt5H5GTNQfBWOpmLYwg7EOz63pTKWL+9tIYKUKtwSfZHKoaDm
X-Gm-Gg: Acq92OHOkjBBeUOPdUq3fuiZmzVNPHicYkDaXdvjcz2iu8zbP9pkEpHlb+t5aF8xllj
	OQw3ABqPq1+pqP2S/BZH0q8OtMt8OlmW8cqC2X+zVf6wu6immXBvJR0x2NSdlOkYi6va+D10vx3
	pWHYtSH25Ao1MvzgcE02qfDZcZ13hpJV76l6FT5lBYabB/j3YbzroiWVIAG2lWzqP1YnPfRprof
	NPbarWFpGQFLrGDtur2ZuK5Qr42Wvi4xlimhjBQd0nNWlTEdud4vXOAYLDcoBXHVh7gZ85HSkB3
	bK0ke8YlvPvHY9L6PG52GL7QMRjFr/5k3O/cGvnXRt/gVKerp4KNi0/OR/IfhJj1Xyh4qwJS7Wz
	K3HRkZKFAwiXxCuWki4+Bf2B0uJuNV0W8CzgzVQ29mQvxGUeiCJQgU5+/cRXa1f11o4OhcvLetc
	gG9AXNMLclRd2mATrsha5y1JM6Txsq/CguKAYQqDAv34ppan4=
X-Received: by 2002:a05:7300:d511:b0:2f9:1004:b2cd with SMTP id 5a478bee46e88-30262f3895emr9944019eec.20.1779142261071;
        Mon, 18 May 2026 15:11:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302946f2149sm14176927eec.11.2026.05.18.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:11:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 18 May 2026 15:10:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: ziirave_wdt: Use named initializers for
 struct i2c_device_id
Message-ID: <cd2328be-9018-458e-bc60-087506e4ec41@roeck-us.net>
References: <20260518171901.904094-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518171901.904094-2-u.kleine-koenig@baylibre.com>

On Mon, May 18, 2026 at 07:19:01PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Applied.

Thanks,
Guenter
