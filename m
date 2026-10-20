Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461022;
	b=Se1YVnPonYft2QGa8JqN5Jby1li77X0Q9fsHfPA5U/rtRq8iD91S3JTHzkiRFbaSd2mK
	 RWNL347Ls2j4LZO0a+98o+Bv52uKV80172h5Vqpw5553pToi+VxJIpsy2SG2IpDa06t78
	 jfhS8Gfta86/00f6iP814Z3TJw8X82WCdRmXbQdZ4P1DakrNzKdJsTos7uYTu8l4fYG8I
	 3y0HEGtYiizdsk03Y5cXYt2YskhWIXxpYgbUk4ANzfxCEhcpDPm13wuOQXU5/FnC7ElWt
	 2Ys9tfDaAzoOBz9GhSKMDJoVZebnnMhRMtQwTA+E44nhFJcoEQvjUshErT5Hc6T1ckQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iDWovBO5t1R7cL/YqgMZtu04YVJnGP0rNvIJ0GRt0YA=;
	b=m1CV9arESsdJhb4uT0IHA7xo87FFAisjGgPduJB4oQzYK6KkTbjgT9qfs042/y5ngpTY
	 JhAYNvTHAEdLqGdgiwSkZikKoAVnQUeP788k/7KpbjZXxXKTDrpJzmKyVyXxqr+pfxaRw
	 c49BC0LNiJM/mgGiXDsjO1NpDHrUerWsGHdnAAlW2D6tPHUahFg+W6zX5HfcMBkrJWY1h
	 KmIHb2f/PSfmd9y0sTskXvKER65DRMla0dG/5AIwD7L5EEn8NBjceyhEkTNNpLcKf7X49
	 NJxQN5NVzdLbgDVpptIZLwgOzJjq7Xw+r3/BDaoicbtTcFU9R5CyQb8AYmQTHQJPGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WZqDWUAv;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F1606A31D
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E03F1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WZqDWUAv
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-366421dc8ebso121536eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792461021; x=1793065821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iDWovBO5t1R7cL/YqgMZtu04YVJnGP0rNvIJ0GRt0YA=;
        b=WZqDWUAvz1D2uFUD5vVpwK390WzmGPECmRzCwK+eaSpdniyU0CEzgt7iVMjKMZOFr/
         j+fqL/KXeDdBKDWyKb+WDLjEMDh3KxIs856Httdzk+UZ/fBSVbsUOH/r/4W/tWs6FVZn
         hg18PtV+W6n+gnXMMXOBjGPV+GUv6sjngGF1XqsR8VTDOzKNgANt03zRik6Tg14euxSa
         pPUVhbHl02K3hQrCS8N4YadYBpwaF38wUN41zsmHoNaWKEAzE3Cfz1u0X0u+MRsNd+vD
         Cedywr1wTJYH7AgjHKJynk8Sqfy96SwXR8k2cz6Iq3ZfppX5FMr3kmlsYiX6NwjFF5CG
         dXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792461021; x=1793065821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDWovBO5t1R7cL/YqgMZtu04YVJnGP0rNvIJ0GRt0YA=;
        b=2iz9QaiAmJCc8fgCWQvWYTVtg0slJPhEzDdMNVrIDXDXFXBYfeNIsIfJ3EJki/aUbE
         XcNj2OfPBtrGcKkT6r7W0EOILmRxeI87kQMaHwj/F+awyuUzlF7xj2+cBGynVZHDXLig
         oTWdaQaNmCjep6SE2D+VKG/HCY6+PXSvDSOl2yo30phHLFKWf04XmeSQnsfATfz/xA6i
         hym7nAqhEUg9LnfE5+s8F+DVg489nScdNi0S190+l29ZjSNi3Clx0IF2K/6emGg/3mLY
         cCJpcwv511dQkT+DfQ+7yBT46lHJ8xPvgz2dkMvOVbON+ALVTjQBn+FJol/rDxyZvzie
         Ekgw==
X-Forwarded-Encrypted: i=1; AKwUvBzUDTp5zBhk+dBh/+oqHS3BWovxNd6Y1b6X7FKor+RmKumJEwrDJ/Wv/0DvH5EpgX8Kq4MmqXzF48y+k4EUHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLo7y3l02HzBd9ovKGm2IUc0dqyGUj+R8gbmWvIz/nrDqNqc5Ll
	eWF/J5XyQnMu1Hzj1xnzQiiN2cK29bPyQuwwVyvLlt6h4OAgC+xK+3vx
X-Gm-Gg: AYBFou10b/aTkNfOFn4zXK+Bmvl8eEZ6YXElZoa5FPiYy/ncKtyBM7z6yadn3Lsnq1y
	1z19sVHdXPmGAtFh2OsM7RzXn35b68wqfezPFr87XKC8yNd6WF1T7oorv3sETEM/acJJPCmKD45
	82bKac9K6a7zQIXjQQomKtoPF6UM/gbuYT2S/gbNeJBrxkuFUReHNowo4q9D6DMNmuNDnuXQ74q
	KbEx7RdijYnaqLh5BdSXqu5cnFuv+H+icjtSPR3nCACq6yMWqAii8JgleLCpH+CfKc9rKZX5Nrc
	TyYvjq9KzVPQliJvQyuum+PR023hIFb7fSodIZK1C2m42+DuVhRen5/ExaK7t/P8hWvyfyt7RsF
	0Oy1It7Z6L12jzbDBB6n4Rv5Bb++00IZZH+8g2HLfWJGvQwcPvmbY/2RHGDRlEwvoa/d6yOGZdS
	ZwEw/GYSlDHQ3qhsU4zMxNggTHX6P2L/setl3djWr5eDCJyYCK4P9+rUTRJLh7dg53GUEZdMDQR
	5PmaU/ai0u5
X-Received: by 2002:a05:7300:e7a4:b0:353:5d7a:cabe with SMTP id 5a478bee46e88-365fad8dd2dmr1501089eec.13.1792461020849;
        Mon, 19 Oct 2026 18:50:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b792bsm37187697eec.5.2026.10.19.18.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:50:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:50:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 09/11] dt-bindings: watchdog: sun4i-a10-wdt: add
 Allwinner B288
Message-ID: <b1f2e857-134f-4bd9-84cd-fa05f43a62a5@roeck-us.net>
References: <20261012100816.331033-1-pmazzini@gmail.com>
 <20261012100816.331033-10-pmazzini@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012100816.331033-10-pmazzini@gmail.com>

On Mon, Oct 12, 2026 at 11:08:14AM +0100, Pablo Mazzini wrote:
> Same watchdog as the A31, which it falls back to.
> 
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter
