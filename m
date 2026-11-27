Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769384;
	b=q0m6s2i6TNwdSFoNdlZXnw5kX0MegIzh9vwHTQV+ldLN3mtjuCydyae/0MYmZQfNcwnE
	 kDWrrQpXQT5UwfNsf4u2PNA/7K38EDvJ2qFtl/g1zYYhj680DuXHGoqxCsTOZ2rtrfCKT
	 6NrpuH1SnI/ZbGd/3vwajm1TRm84IhW3gf6zBE0kH37Gkzth4hqbgOLGLkyhDZhcd1B+6
	 H1d6Zi8YVjf8ccrSa6D8GEH2CPjXkTIrb1Mfhb2pEw/SYpABF1U4aGrZyN35eIgnRmvQs
	 aq0lFJy/XnJcERlrWYTkV7RPNcpuwRgMK0TF2UFLOxTPnayBD/R1ntKIcyObCiFolgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=l5H/fPkMrIgjbqbAa16bsfhUN41gPrGnMmr6FVXi4LA=;
	b=SHH6+SRcrpOxGHroBEO/UPA57DzsPmsJg1U3vWZOIGdky+p+5W/se1mIFX0LvqzMNlc1
	 GAsx6f3QNcxZC2WQt3y4qDoCPOyeSzJMFvh6BolUHPfwc0/JAYkEEQwE4zzciOaIBPFwb
	 En7/0fdJd/DE5nNKiJl7UXK/LaFhapU1UvGBQajVEFIksC9hV8PMfPxom3/et5O81xkcj
	 zC7Pko0jR/OPR4Xh2J/pykp4Vsl1dfw5XyzFwbelu4MoLieBwOrqbt7tTs+hz9lEDUca9
	 0AILt1yVAOdYsXEHNhIlUqkeUJbe9SVAjFG5HNbkUKEeDsTtHoXfTcnIfEzCfN+HsnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lMtduL23;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BF606A6B6
	for <linux-watchdog@vger.kernel.org>; Fri, 27 Nov 2026 08:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 957BF606A6B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lMtduL23
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a358881793so4110011f8f.0
        for <linux-watchdog@vger.kernel.org>; Fri, 27 Nov 2026 00:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795769383; x=1796374183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l5H/fPkMrIgjbqbAa16bsfhUN41gPrGnMmr6FVXi4LA=;
        b=lMtduL23oty35ecI++RAvCDDqiwnc4Ak+6dpQwXYAlrNx/WsKXzEzr5BaFbdfWGv0o
         MIdxQNlD99ZB3a8pdZlPzsq/4KUpCXSeNscu1C8qklmN3X0MyZyu4smG76KD/bG+zgKN
         a5t5Os6EnPqekAKT3BU784FH51GJONaBlPWvdb5hG5vVq62a5HRLgpmnLGMi6YcnoS7y
         qvGHwnA/+1VBekixkj+vGN89hIxMcptLrPhwi9kCSzPZ5+eJkd3ljI+vBaZ2ii5tpxFc
         LEwVTIzesRkK1aagdCm3Sz9dhOlgaNyOYbdqFMjJ/Rv5/L3luL0uNMhbxT/KTNBR5HLm
         K2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769383; x=1796374183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5H/fPkMrIgjbqbAa16bsfhUN41gPrGnMmr6FVXi4LA=;
        b=E/7nqN7S5mi+7Aqz3qyUm/zaZBMwEwvt2RIVjfqTVfvld+ydepohXXbLl/bGPfYRSk
         tc3LwfOX19ejMSkbNmWpxZQIX5tdnjuzONHgsLc0kXpVbuFHfTrlyRf0H93kxe/jMJe6
         aKPwboOCPP+ekj6xhGIXq4vTufc7dNgOH10PGjWqVS+EkYk/VGXjN9TnIanabHnZkyZV
         VHfHHqoZwLzb0Lv4ad7Y0f1djspL617V6xaDSacV3MSvL7YL9nC39A0sLPIcRJCA73jY
         5/rK7+0CJ8H9xhJ7HLZQQUk13kiLu2TtCzLLsRNRni0P299E8LKcFY/sazJdcCWMuP6W
         21CA==
X-Forwarded-Encrypted: i=1; AL+hErFJTTn1+QCbnJgl6nXqtmtJ+kFz+9a9PS6BmdfxCaYJ//qmoyXWzYxq6EYd5EsVq818rXWbAntDEDOukZclcQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2nu4z1sBaAboZx5gczedlSyoUzZFSJMnqa6mGuYjKv2H+x8nx
	czcrn1GuaNJhAmSKfdEJILMeB0tw9VfCWJnMM8MOHLdUCegBntQMzPEmlwoT7juFuJk=
X-Gm-Gg: AZFdTZepEB51MvrEGRqRoQCmyn3lw4QBzvNr6XSpZpddwFzZwiStyztdFX+bVSN92m1
	9EHrXnZZ/MMliPszcj1mjVAbZQ1MPFf9QjZsEa2pn+cHllwPAwOPiBAW+kU1m5cPTTze2nKXNa1
	GvBGAK1E0RBeiCvpJc9tVGFRlmbZVOGZBNDDRTmU6BXg89WCXmghpXZiZU4u6xVods3sTbJHLVt
	p7cSVeq3OoU395ryCRvTlozSERsuul5BKMSDEGLsCH1/r93ZZthwW8IN5gIU8Nu4gn5cplRzkjP
	9M3AXRHjIJEfLaQadHNB0vmsK3BoHLCQEVQGqKCXl9uQ7ft53uLHcyXGGhvTkhddFesqXWfpyLp
	13AszujjFAoaQuXxu4LOX/xiV3zL6+XrClX8mImNEHSCaQyuMCcbpdNVkVJfVjLvClp9pjmdg3C
	PBtBacUfOnfNUk6wOY++BEbGFjozQzvGvGOOUkh9q9xjmWCMwmjl4wY8c2DKh7mV77TKffsAxdD
	2+YUVUAwxe2LWJuEyvMLISsFqMSobgUuHUjpyVX3MM0qQq10BbR/5hR2M4u6CmE2iEw22o+FavN
	Wi/+nFYiXNLp4sO6sYgpFD9BVJIdO/+eOzDT+ogR/IX0xzUOEUmp8gVz+0lPKdT8dGfWpyi4DFD
	Z+bZLfnD6Q2QrCgXy
X-Received: by 2002:a05:600d:18:b0:4bb:abe2:bbce with SMTP id 5b1f17b1804b1-4bbabe2bcc5mr70018825e9.29.1795769382993;
        Fri, 27 Nov 2026 00:49:42 -0800 (PST)
Received: from localhost (p200300f65f19a90496f529fbcf0b312d.dip0.t-ipconnect.de. [2003:f6:5f19:a904:96f5:29fb:cf0b:312d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884b7515sm923694825e9.13.2026.11.27.00.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:49:42 -0800 (PST)
Date: Fri, 27 Nov 2026 09:49:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux@roeck-us.net, wim@linux-watchdog.org, vikash.bansal@nxp.com, 
	priyanka.jain@nxp.com, lakshay.piplani@nxp.com
Subject: Re: [PATCH v5 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Message-ID: <awlDvq6KT4HxGNDA@monoceros>
References: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
 <20261126071124.2383368-3-shivprakash.gupta@nxp.com>
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
	protocol="application/pgp-signature"; boundary="gv5nh37x244s5vos"
Content-Disposition: inline
In-Reply-To: <20261126071124.2383368-3-shivprakash.gupta@nxp.com>


--gv5nh37x244s5vos
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
MIME-Version: 1.0

Hello,

On Thu, Nov 26, 2026 at 12:41:22PM +0530, Shiv Prakash Gupta wrote:
> +#include <linux/i2c.h>
> [...]
> +#include <linux/mod_devicetable.h>

Please rely on <linux/i2c.h> to provide i2c_device_id and of_device_id
and drop the include for <linux/mod_devicetable.h>. The latter pulls in
several headers transitively that are not needed and that thus create
unneeded build dependencies for your driver.

Best regards
Uwe

--gv5nh37x244s5vos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsJRCEACgkQj4D7WH0S
/k4y8Af/YPMv6+VfabvAg6sjAP1iYCrA9X9sWU9HEzF33ikGj2zaSOQAbmelYcKU
MkYOqadm4ftAn3wh1m+RGl1mnfy1GNluJIXTI9zNZYGx1pj3U8dJqh1/XL74jj8A
xgaOrHFNOPOBUNkjSWBYaj0jo6IcppLUcPbLI6QT0lkZsww+UNLIAAdTGy3bKvJQ
zQELEUsrss+cgFYfjeZ40PKOh/wFEqPemnatDmeoUoMCItb7iPp3LZX0szasTHR0
Y0MOy7nJemFgnBUeFliuIZMWsjW0gTCXFOfwAA/AU9iZ6LoYjQ13w1baDZLxOSsA
hwUFXsoIF6f/koYvawaOx3iNSkWDag==
=uvjs
-----END PGP SIGNATURE-----

--gv5nh37x244s5vos--
