Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C18449A3B4
	for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837185; cv=none; b=hcz7uIdHhHuPDoaz4tW2N7eMw6u8XnbAlxiCrKR2COvj3CONhbYYtGoGeKcnGZIFoWj6RLq/rUCnH0g5Nltqr/XQap5mg2KAx4S6ETjjzaK2p92NHVJKODrej3FICs2dWPHpdQhWUgvxgroXFBaESLNShC9P9Wh4RrCdL3sUiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837185; c=relaxed/simple;
	bh=3dDzxAe3v4K6bmvY5Sku2I2OCIIKOOmdO2oWSS/8r5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnFk8JHKcf0RUzCuE3Q/L5bOGuOZ4F2uKhuLFqrgiTLxY94uKoudvNDf/nVBmobjF8y3qn6CWwPjMvTiRGJKYHGRBBqdRjiVpoWn8vJ654ysRQZgH4IjYhA9pielz1n6bR1r/zX4E1ahsuzyf4DyKvuP3nxDl6JLzC1HoVg1H5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=C2J23s9U; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="C2J23s9U"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b060ec084so1404164f8f.0
        for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791837182; x=1792441982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3dDzxAe3v4K6bmvY5Sku2I2OCIIKOOmdO2oWSS/8r5Q=;
        b=C2J23s9UubyCJcxmDzteye4q+6hArWUjeY0by9D4HK7rJ4tJ/yjt80Sn3eH2Y8Mugf
         C+0VLmpl8CluoBNrRVGZgQ+9RyJ2KUX+4CzGVPjYQ64se1W7VwXcF/mA9f1TwZFIllat
         uk2BrLSFFGedsU9cHS4U77FDx1AkQ4r1HA+wXXjWVWUHNb+kFiGaz3gsQiVCpELiipin
         GbETdX2vsCCOn4yAfFBvh6A3V8yfWpasbWNCNTQ8uRZR1xKJQ1fsoYBoigTPR7ov1AqD
         eZ7JIvALkWE86DjAepB7yvbJEOgRpvPFOdrpdXAMdD8BRGqKJQkQ9qYR3Bxrxnqlpt69
         RpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791837182; x=1792441982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dDzxAe3v4K6bmvY5Sku2I2OCIIKOOmdO2oWSS/8r5Q=;
        b=zeaQY2Pxp9TRlA8c8HmN2FTh7yz3rS0LImojvj8kFvQb+aI9B562rB1pDlsZZF/hsR
         nOMossbdPtjJQopBJVLmHbhWt1SoU3TwjLwix7/tKpMu9YG5HZDAGlmCzDAfFovorMoU
         wL7YdAaFNgtChRwyzSCyMwNioLgt7hxYOrSrzTdydvdkHbDMalpq9/o9+4Qgz1M/eJVT
         J7IVR11xw11YSx22qmt+4vaYc9fbVYie6mVrMfUP9rhaG8k7VTqQHqjGbDjcbuafL0gh
         HFDSEOt8Q9SxQxsZoKeW7CdebygcydFl08+pkQmipmwclLcACIIwlVj8QSCv0X1ZY4FE
         hyyw==
X-Forwarded-Encrypted: i=1; AKwUvBxHctLe2POHSNVPVfQiXM1J10Mb8XM9kB7Ho43jfd7sMwnYchaa/QhBqGe8HDerCyl1Y8JQTf1ogRESF0jMSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKNMQdGNcI3hh62bfx5lbpkbv8lsz1GPwy0tMatECtlETEYQBE
	hPTpWqea9ZvT6lw3V3tPfm4D66CLDOJiAGsJIdHr4F3YugGqXD5Tl8QqBbBlcJVczMs=
X-Gm-Gg: AYBFou0VJqNjeDr3ZarAs/DiJhNGj75eTs2CfHAqR07rr3/K4kb/WivqYpcfUmj3eE5
	tKj1gE7nzupV91SLLg/+AxLntIfWCI9wV82y9f/nFn4ifFBr1bHPrzhSZOUyE+s+KbCGAsDzXy2
	3+6WSUhO7UtjqHomnvvlrw8nG26k991ByLFysq4P9kVfMA7vhVH4mGLdY1f2guIkZW9MK+CBwE8
	DyHnrVNhc3+QL3GbvGz229EWSZ+qoWWWKYIKE8miBL4lpGDFwMIChsWVxLT+o/ghey2aE+x+i/m
	UOSauBQD/vWRv71bZAlAgKSWcHsL04Mur3/Pj7MF/DY0XXtvImpHBpGU8nHYfu6YcSBfv82gbtS
	xd8mh04gTc/zt7qZBUsypfvOXrnuD+iVDjKCCpzh3QDH57dDh0+k85fqXyw9G4X40mh0M6BcB9x
	q09KvAb4d9z7IoMJWLH100hTwAc3PBOdx58g9D0W3+Cx5Os01NKkV1d+NVvFe8AGgLF6lmm1EaX
	YQ=
X-Received: by 2002:a05:6000:2610:b0:48b:60a:760c with SMTP id ffacd0b85a97d-48dbacdbca4mr19746116f8f.31.1791837181259;
        Mon, 12 Oct 2026 13:33:01 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48de0967bf5sm1211973f8f.5.2026.10.12.13.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:33:00 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:32:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 04/11] gpio: Add Cortina Systems CS75xx GPIO driver
Message-ID: <as1Dl08DwxOu-boF@monoceros>
References: <20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com>
 <20261012-b4-cs75xx-s2-v1-4-8a7641b7b79c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rf3tmjyx6r53tpru"
Content-Disposition: inline
In-Reply-To: <20261012-b4-cs75xx-s2-v1-4-8a7641b7b79c@gmail.com>


--rf3tmjyx6r53tpru
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 04/11] gpio: Add Cortina Systems CS75xx GPIO driver
MIME-Version: 1.0

Hello,

On Mon, Oct 12, 2026 at 08:32:59PM +0300, Fil Dunsky wrote:
> +#include <linux/mod_devicetable.h>

Please don't include this file. It contains a plethora of defines for
subsystems not in use here.

> [...]
> +#include <linux/platform_device.h>

You can rely on <linux/platform_device.h> to yield definitions for
of_device_id and so drop <linux/mod_devicetable.h> without a
replacement.

The same applies to patches 6 and 7.

Best regards
Uwe

--rf3tmjyx6r53tpru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrNQ/cACgkQj4D7WH0S
/k6KYQgAgMQZQqqATk7u8/7+zLh1eyfjz96I/KQyBnZbLC753ncNp95vppbzeXYB
/6Xnb+1PMj4yifoVS9rR2GPW2P4F2cVCiv4ys86vtgjDRRS9qfpvIqAGD5bdkjpR
AfIu4ZintCl+3dtuqg2yWsp/Njn0OkGzE115dAhtJMsZGrpiAbpkStIsB8lUqPSl
H5jFp9iVNDnb+9rZe0ckSQeZwDR5JuTFUJq72G71eY2jfDyzjH02v8EejbZDDjqp
vF/L57mOl847cYmA78hOqMnQrXpBaqqNs+uY6m8YLPt5Jgq+OkWhvGGit0ts5Mlt
rdJZC0MMQbclAkv16e9nS/twKH5mPQ==
=4pay
-----END PGP SIGNATURE-----

--rf3tmjyx6r53tpru--
