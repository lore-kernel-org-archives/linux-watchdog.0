Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A4397B1D
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779631205; cv=none; b=QjzO06GgVVxtMa4ijehrRS7cZbuoj8mlxHBH15yYlaK7bPPNvbGxAsCt1QEJodD94ODeWp+o1o+sazj44puVTJrRjZzmOxi20gr4Lg8mUuRrCTUOWUz47rruZoxM6CTKR/Xs2wX8syJZzT2AAgU4XOHM7JwNvmU4JIQKVuX62vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779631205; c=relaxed/simple;
	bh=O3pZI9WiYCNWVCZqNJiA/bx/FMbtTcu9/0CsrmN0U4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAqn8IHEPYrahypTIQinnpvnbHbwtJ90keNbY0iA8bpf5Tts6H0aCzDEeX97oCJO7HdNH82Hywh1WIIp6sluX5wim32A0ViZAWhf8ZernrkT1VQRBrw6m91tep1R2X3vGKCR83WSG0ohVVrIcxKG5M5mxjBt5bAUGeXrMEPp6BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooJZGQMx; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooJZGQMx"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3044857f09aso3726230eec.1
        for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779631204; x=1780236004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jdFBhvV4nAlKzH3X/7AVNjX1nuSw2ET8G9iaj7FJx7s=;
        b=ooJZGQMx8OVqyA9exSe58T9xm3EEIEFZTQbovj+wCfb5kvep/FEcxuqxN20PFohYzu
         GQEC+iv8niGH8KQXGH4HJip0rQr9+J0glUiY9iGnplKQhF1ujlWAx/XbTbZ93RrDdIPR
         IPZoKQz+jykd+fwf/NjyFZ65N8P3INPZUI3qJ3JRcDyX9o1KOMFZ6qx+w2fskfKlPHb6
         1o1NDCHZspsPfOmIQhdbuPtIcqM6xXtaJAOsOHeXMT1anGPiuLU/jWGOttKaDhSm3CsX
         UzQi/L2uLIinSF1m6nJuA4icR9yccLcFVIJj+ECot104igu7Ys8ppjozzpdZAJm1165D
         HTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779631204; x=1780236004;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdFBhvV4nAlKzH3X/7AVNjX1nuSw2ET8G9iaj7FJx7s=;
        b=fLs3gtY1dQH7CtJ+JusD73NxXuzCNIqbvrLN43BmUiUW0lSh6T3lMftMP63FkhId4J
         JkvxR/ezEmbPNkT9Yw9F5EK+oJfw5YsApIwNBqJuQBFHgQaWeN98fKprdfHFrqim2olN
         0b5uRDILQDLi3RsQZ3EQxXmMR9l5aFNV8rxahkoynp4zp27tgCbOld6hsHseBAOax6zM
         2B0vEFHrMb+FBfA0ryz2WpXuDdtHhO/cgDZAJ0Zfxz+K3r1q0q492Gm7sJOXUJnTJZdN
         W3kUxh7f0N5NHkKV+MForx9ZSxhfFUDH3K08DHJIMT2C1DfY/sHAfUc5ltc8meY2ATKB
         51Jw==
X-Forwarded-Encrypted: i=1; AFNElJ+fR/a8ouk5hkrZUTUkk37PTANURfY6kAqaiIhXgXKFOLS+yXntnmminpYsHCCiAk3kt5WD+gk2lEyg6j07Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9bRSEbaMdIFSJAA71t/g7UCh2PTSRO4FzFQUtIfgNejSVPnN
	YfxeRWog5AyFgUlfDBJk7hxhXNNnFCYInR1Du10b9QvwRwQ7MROpS74I+gDQ1Ipr
X-Gm-Gg: Acq92OEouCi0zj0BzIFkpFCtjY3cHJyywAdRhlf7OIj29F3B/T/LEl0HCG2RVXlhKyZ
	CaV9A1BUiiH5YZp7WGsXJL/09NM6ouLG8CNLUOfdCcOhtXwfmr/ei7pea8LYrfkRQ69sg1EfBaU
	Ilw2aLUV985G591Tr3tOpDbH6RTWEtjoGE3/MSpPZ/qOd1lsCGllXPM2DwAZPtY7ZgOXgOofxwi
	oRSjRk7LPC3kElnFa3DIy7CBBMG6nWLOLG4wgqZiNbcqoHD5AFZXU/W8lOXRTUBcTdHHgzCxWNv
	q77PBhlc5dFOXs51h812WaX9PZXV6SJPTcArZEaPms9ifCRCT8ykErGDjcTTPkcl1gnHRGTTRFh
	ZrYP16PnosW4S9gaGjroraohAyWpUEXG3sp2rBVKP3peDtglyx4dBMzUa+0Nra9sWjki+mNv+8V
	ZzBep+HAW3KRf4zhm+OrLorKnugvdK4nS4Co/mFUD+52qpe6POya3pZekCOkQifn5GmgznLrYS
X-Received: by 2002:a05:7301:198a:b0:2d8:7302:d3d with SMTP id 5a478bee46e88-30448f4b600mr5297889eec.8.1779631203454;
        Sun, 24 May 2026 07:00:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm7240569eec.13.2026.05.24.07.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 07:00:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c619ebd2-c9ad-49d7-a9be-7b3290605b88@roeck-us.net>
Date: Sun, 24 May 2026 07:00:00 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: sprd_wdt: Remove redundant sprd_wdt_disable()
 on register failure
To: Felix Gu <ustc.gu@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260223-sprd_wdt-v1-1-2e71f9a76ecb@gmail.com>
 <5ec9bd47-4c58-485a-bc20-1a74cbdef40b@linux.alibaba.com>
 <CAN4SLj09_mAPxR+k-qnOc6LWwh3je4-DJ9-BrfGR_FoEefjfVg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAN4SLj09_mAPxR+k-qnOc6LWwh3je4-DJ9-BrfGR_FoEefjfVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/26 23:04, Felix Gu wrote:
> Hi Guenter,
> Gentle ping.
> Is it good to merge?
> 
> Best Felix

I checked. The patch is queued in my watchdog-next, and I just confirmed
that it is in linux-next (next-20260522). What else are you looking for ?

Guenter

