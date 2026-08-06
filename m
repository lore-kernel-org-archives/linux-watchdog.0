Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3F12FF69
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051636; cv=none; b=uhA5FiD/5oxK4PdVSzE6nLne4rvM2HolzXGtUI64hSRcD/fa47YQPjqWy9waySMJ0fofzG7LRslaiXCS0Bz5rzUp3ia6UJfR0GARqVKMcpqdj4tOtOrfjiK8A8pLVD/PNH8Ck9lJGNIPiq+4j3uQ1MT2Oh9UFXNf2ovoroJ9tRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051636; c=relaxed/simple;
	bh=JcPebaNwKGwj590y7zU20+OEmUXgRJyDw1tO3Tz65uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNqMxwbmwrPAJdRjrpHYhmUMKmc60KSgV9ewZ2g+jwUYrX0XmmkCgOxzLkyLlSTG/MeHynHg8JFH8KpKrMBopOXCTphebOhpL4oK/xT/PsTXd9QD5WEpQ37uK1xHLgd6B/n0WPvsYCTe8k9e2rnnGEFyCzN3hsslJlX6hrQGh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvCjdfUl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvCjdfUl"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3341033b3a.2
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051634; x=1786656434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bd2z9GcEZ/uvoqQVvAVbzq7TsQ7kddv+dnVqWHE72Q=;
        b=cvCjdfUl3Zvxt7pMIFNlFcRXblKk+TMqs0OoNlObbuytFVPT9HNySRGJx2tgF1dbdo
         RSKB6QoFJ93STMaT89eG/Z63eFQIhns+r4eOHRWOSqQ+oFHjm8BWxh3dshzmxcTLjTHJ
         q8hxSK3OawtkD/Moe916AvyT/8schwkyNHJsLcF4PV3R63jTQXKpWFxRx9O7soV2YpOh
         zwrnZIuVntd6pegKD+t8/DX66v4rajRtJIOkI65HdISAsqePDwkpkoRAe0ok2W8quSCA
         cuaEZXHJoeBT3RXR+5WZ6pbgH3LF1MsRK+Sf20bjGTkvuBqYrfMIjaEg/mm2rQulvNhS
         5OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051634; x=1786656434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bd2z9GcEZ/uvoqQVvAVbzq7TsQ7kddv+dnVqWHE72Q=;
        b=W9kWIepECeKzh0ch+59XCZEHAKOUyCqq35opQhPZuXbNC2Ht1t4DtWbS25YIUdhVGk
         DVtVoUZgX9PJ91veAa9V1D05747YHOT3Ce4ha8pDaRJKk7jK1+W3XSylDmudvo02vleC
         NA8TwYSo+tI52Uwq4BoYTEjFwZTIZG+tXK2IaDXhuPheaQAOkKGOgMHG2bJMuINauvDI
         4m/mtY1HCitzehi1n5aNYFtZXBr33kCnzhcbUiG+3npgQ3fybbM/IX0MHAHEu2mu9Thj
         F2u5fyDQVLNn/Fni0Ce9EJ1hxsfTkeyZSxPtIF3W1zREkopuXGN9W77XK38EIqHNY6On
         SWPA==
X-Forwarded-Encrypted: i=1; AHgh+RovISqjErd0uiz6am1iOJA1h15jnmsVYD6HF6d/RQKgfbqYUkzMY8KQhcD6uv5BOP01FujhT/pv6iZuvq4W3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fro6FcizAD4erSB2dA9yfnu5NW+e1gHiR1keHe/Rf07EsJwT
	q7W7Mp2W5FEeJOX15vhzQHRZ68k+zFevQwGuzVNki3pHlBi/nVd7/Gt2uF6AsQ==
X-Gm-Gg: AR+sD13qvgPZbiTEomTHoKvRCr8WOs81dYnAU/nz66wiQ+N+/FMKGgSRiCKfnPHRYWG
	p3kVoFweHxEgvCTk4aAbyUfYv8b1etiNWAAZysmgbgnx6c5AcXcyA/lQG4NFwHT7ilyr1i+K1ht
	JFjZwoJ9Ueu7Pa1fpvpTvbk7Fc5rjoe/RPu7UXpD6CJTdtiTe9Ab+jBs4n9yhdieiarho809/dj
	W4NeZ6I2dWXU52UW+RCmLlXOaVrOe1yG9m6V/f2fRdR8whBUAfhMjr+eHfuNUAbF3wzPDIaNn7L
	qocFjN5Si3mcLiBhQix2IvQB2ZB/9h+3fc8W/79D40jVtGx8mY88MsDiALgy8vGKdbnUgFVMjXF
	pM4ib1vkMmNnQHkC14QWEQp14DRli9cP5Vd+ST+YtfMm4iuESn/i7b6Ojh36FVirI9uu9froCAg
	KSkUay7QNF2pBFfKqPOzcKfb0IzqrOxENYm/u9SjGOCJmc4tDlig7RPHRP6Chdl38D+R3CrKcbc
	A==
X-Received: by 2002:a05:6a00:14d3:b0:848:63c9:ee38 with SMTP id d2e1a72fcca58-84f2e13adafmr19601523b3a.39.1786051634186;
        Thu, 06 Aug 2026 14:27:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a52060dsm1745b3a.38.2026.08.06.14.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:27:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:27:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?Ren=EA?= de Souza Pinto <rene@renesp.com.br>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: wdat_wdt: map registers that fall inside
 ACPI NVS
Message-ID: <671d52f2-c22f-46dd-84cd-95b2dc6d52cd@roeck-us.net>
References: <20260804092337.3556947-1-rene@renesp.com.br>
 <20260804103958.3684195-1-rene@renesp.com.br>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804103958.3684195-1-rene@renesp.com.br>

On Tue, Aug 04, 2026 at 12:39:57PM +0200, Renê de Souza Pinto wrote:
> Some firmwares describe WDAT registers inside memory ranges marked as
> ACPI NVS in the E820 map, failing with -EBUSY during probe, leaving the
> hardware watchdog unserviced and triggering periodic system resets.
> 
> This issue was observed on a OnLogic Karbon 524 device (when watchdog is
> enabled in BIOS):
> 
> wdat_wdt wdat_wdt: error -EBUSY: can't request region for resource [mem 0x63df7a98]
> wdat_wdt wdat_wdt: probe with driver wdat_wdt failed with error -16
> 
> Check whether the region falls inside ACPI NVS before requesting it and,
> if so, map it without reservation.
> 
> Signed-off-by: Renê de Souza Pinto <rene@renesp.com.br>

Applied.

Thanks,
Guenter
