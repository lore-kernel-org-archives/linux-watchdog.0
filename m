Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795852799;
	b=0VZrpZXXZvtW/m7an2Gfmh36jZ+0DY+D/P5mWIaRukQzXz6coOx+wvtrSfEOgEsyBgJE
	 1g8DmWtPmlLWx/b8ZuaOaPyzcODiN7uZYyRNQdPI0rvYbHJhC+TNHwZB4zPo572kItak7
	 o9q1rcZ2AfJ1xkrN89PxZRvwikp/ryCeSetE94u7ExlDFZxhZXyBP4xQliaZoM+CSXsr4
	 v0dQKsz+EwUc1Mv9nkGnmdoCPTsTfxd1424eLlezfiaPZpmBzTI3HbQLF/d75N2iK87z1
	 zikAxqQv4O9fftfr3XVCZzJy4JSKxr4dJm2z4ASr4ARxHQvJO+TRASu9Rqfx0PWP7aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795852799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rECzFDCKo4XXlZnw/34prSvNBZQ0YYwmq2ei4FG0uow=;
	b=lkeEjtuwrd5cfYW6e+uEEYwv8z1EG8OGLFuCWw0iRkEzCwHYeOIolFjQAIF33U9C8Ocu
	 zpAcOdywySRZ0STmYoOGMfWc3XFP3zjXG/X16hQebS0AB47xdgfZlLibGlcEQe1fPxinI
	 D5mLGZ1prESbNLjFf39KWpuiAmuL9eZ6SZS/SbBb5lYI3DcliVbpnQNLmvOMxzawHyp6b
	 MILths7O8OerMedviks/h16F1yO1eznv/B57UZvoOrI/J8udC0e1CqN1a2fKnXHPRIXCw
	 jhqW/ddKtHS4UEEIA3Vnmb6aAL3bBXrXGOSaCzgf8V06BnD7Cw5nvoNSqvUxC+iTKTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="i/U/to+v";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC2606A321
	for <linux-watchdog@vger.kernel.org>; Sat, 28 Nov 2026 07:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDAC2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=i/U/to+v
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a42b34e930so7725046f8f.2
        for <linux-watchdog@vger.kernel.org>; Fri, 27 Nov 2026 23:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795852797; x=1796457597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rECzFDCKo4XXlZnw/34prSvNBZQ0YYwmq2ei4FG0uow=;
        b=i/U/to+vCmL1lcMOCEc3owu39hWkCjDpqJ213buTkVu7MoriXmrx+7OGqlR5mKjN0K
         HJznAwo3QdHX+mccxMSx8rXVqDLQlnkM3P4KKsZD+//BlVONCBDPn8pZ4yevOzRiXp/I
         gJxK0s6juwE0bQ5bE/7yzG82cu1twxYL71VfcfhRCV7DMYxDCXh5JSCk5HmLwiBDbGcK
         /3LWwAPMgikzdeET6ZLrmfguyXOEAu3q8eXawDWa1Mz3qgEI2CVV/tpVSCKAYuyGlmKD
         c7Nrf1KPWTMmTIelV6zqs20Kg89Kf0hmSLldDN2UR8QXyMgoiMgC0Yrgxd++VBF30AKW
         lUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795852797; x=1796457597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rECzFDCKo4XXlZnw/34prSvNBZQ0YYwmq2ei4FG0uow=;
        b=dDPRu/m/woNzW/PPWzDMqnlRTPMxhL6Y9lRkmxV/WxKlMajf+XhQx2ibdZY5wcLgpk
         C/0AGWinpmhhzPSuXesgyDtRX1h1qUgleih1H7HY7N11/ZMcbA+ei/OQ9zcbOeYfx2CP
         ZLaRAV48PkOdUDbBWZ5rS3fsgwapC8pPtxUiVHwzsdX7PhemF3jTatWG5TWeA4z+nEzi
         QeKn1AljNi7sHqTBQeFcJPq2RnMsuYrlniilAML0V8gr2J9feRvyHyLZdgX/ayGDqB/6
         rn+ooKq//mwcSAnPLcitNfsK9HOTAFiqzb6FgE8p9EOzCrpWBnRxyLOaUXRMDaq5+41z
         HYaA==
X-Forwarded-Encrypted: i=1; AL+hErELoxeiAsNqvU7IO4rD+ysj/NbR7x8SqieaYjVoZ/p1WFydRsgYpJ/EZv5w6vhz0oVS90bOscpVE8indSPEfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZIOBvqL6cj+3EfHWRPOJEpufCphX34IRl7imJTtUV7sU9PZLy
	oXnc45T6o3bL5XXXSScmASTRvyL1TYa1CDUwCNDle9eD91vMYUhYsJ6C5I5e60NXBb8=
X-Gm-Gg: AZFdTZddrDbYjuHD0m/DU95lWAq/kY0/LIgICRZYAxuJvr7JZd3r0KlLxfH4svNxmkc
	3v9v3igQ3txlDD6YYDW2vgrPdyigTJJQWPeSaWk5blr2FFlY7SITyszSiwFmURNslEpoj9MiYbX
	x28EumyCaK6/uHpyTz/rkuDKXoUkIrYKgtylmgxAzUz6gBmygs8h5ssHUMhAkZ+F0T7KTdQpVKj
	CkA5MESxVeRfuUpMUP9Y7Jm0TLt+l9agmbrgvMMLqnh/PzWgtbp6TtzUQkxD2gSQXZGO9uLVOP7
	sDHOyNH8LCQ2PZRrHUM4XKLwim5yDzzBhpS7ToFwVCJ7NLLGzq42VxjwTUu89Vl/NFRddpcFHvH
	qwKHumB7fU7mn3elG9mf/hRr8Yu3eQwcRTgbk0roZ0XsCwNvYFjlQ+le2jo98zQvNmnqy9o4rji
	Z0HGIMbfVFbEYitkSFrBzOpxqxrH0T/gBAFuZg/a/d880i22WUr6llg+lB3b93uRI2iHShL/6rc
	5ZTor/cm/OUtLKNK4ATEG3qgSblHZAgQdrko+PrNhpBwuyZgkH6eKePk1kIFujQsPKDZ+2ptx3w
	DfJPUNbvLQoST3nYwFcjLh8/j8p73gZxnzzGAliPiyj2xTTKjwILZ6remkHcXtSSjZs7t9VTsMq
	n
X-Received: by 2002:a05:6000:2893:b0:493:f3f2:2241 with SMTP id ffacd0b85a97d-4abb272746fmr52992473f8f.23.1795852797142;
        Fri, 27 Nov 2026 23:59:57 -0800 (PST)
Received: from localhost (ip-005-146-085-079.um05.pools.vodafone-ip.de. [5.146.85.79])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6b110ba3sm42679550f8f.35.2026.11.27.23.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 23:59:55 -0800 (PST)
Date: Sat, 28 Nov 2026 08:59:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux@roeck-us.net, wim@linux-watchdog.org, vikash.bansal@nxp.com, 
	priyanka.jain@nxp.com, lakshay.piplani@nxp.com
Subject: Re: [PATCH v6 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Message-ID: <awqJkqQ_8tXGIqo9@monoceros>
References: <20261127083807.2844507-1-shivprakash.gupta@nxp.com>
 <20261127083807.2844507-3-shivprakash.gupta@nxp.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5kez4omv4kntvob6"
Content-Disposition: inline
In-Reply-To: <20261127083807.2844507-3-shivprakash.gupta@nxp.com>


--5kez4omv4kntvob6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
MIME-Version: 1.0

Hello,

On Fri, Nov 27, 2026 at 02:08:05PM +0530, Shiv Prakash Gupta wrote:
> +#include <linux/i2c.h>
> [...]
> +#include <linux/mod_devicetable.h>

Both of_device_id and i2c_device_id are provided by <linux/i2c.h>
without additional build dependencies as are introduced by
<linux/mod_devicetable.h>. So please drop the latter.

Best regards
Uwe

--5kez4omv4kntvob6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsKifYACgkQj4D7WH0S
/k7agQf/dUy7wCorcL/I4owilXhYjnsXPrSYVFuZTI3zBHYDbdxpHZa80WwZlBG7
E4SFU0OwJbEJe6jfB4zfEAJno76UQtmfOsPNrRBjhVwTHfHa+eurWy0zb9D/2CE3
T9IHil5xV6MLLjEsteKu/ubZ5uOQpl/GemFXCbkkgQnOoNk3fu9vTRW3m81xJ9bm
uNWYCMXorvZ4Wx7PB2OLQd5RwRNUormhf1E7zoUUE4ilF3XfUbBOvueHDCr0dCy2
b/wJgjIiQzRLVsEcMQ1QhPUbCxlrMuzkchAgFdHqygmuxVmNh8Sz3yBHvjK4aG4Y
MLYKgxWCCTBVfnXialkv/zpFTTAkgg==
=jkpr
-----END PGP SIGNATURE-----

--5kez4omv4kntvob6--
