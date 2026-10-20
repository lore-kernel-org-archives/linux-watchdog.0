Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460319;
	b=j9fbAulHDZ2d45UshKOieHt3cIHBS9A6MBjOiwpy/L+GhmJaXhfrmDhGIPm3zi8NoHOj
	 5EIyNJkoc1WthE49ylyhtLdm13OoBsvHl73U7nPPNUjfrRKI51LklYhTnBd+GTyX4omqE
	 6sF9Yy4ezpcJ2n1yOYN68eLCXRDOlSV1vdLQY5FUXsefBFXjYhsawDRYqhGBs1p8vjMDH
	 D7XbvjjM3MdYAnX10n+ZswMrxF1HR+IcauuNPhC6M5ILS1tCG8C+YwwDFRq2IqQnBuphH
	 AYZhtSzk3KNlA5LXuJ3kG1fMZTwUqBZM/VfFiPrxLfxDKJ944wo2a4pR8ek/OhYjI8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LjwwN5Dzf8X1Yx08q6zZspcMWuK38LtYvZHShxnEiOc=;
	b=lZ4joC7efNE8Yum6KF2MmrlJ3moTiyggp7CtYoSOb/3M9yGlecvOvlWSt6XxtOYlwzXE
	 5yZVfQ2VEQqZnrr8QC/eHqDhV7Vl1T/kyG3MGLXUi0GGefm8swOdLcirLKcgMezFRASiF
	 TfwalK+JvJeq2/cyo8Cr5oO3RJv5M/KeAlhAIKYEEEWrlOn0eb9yHzxlO+RC8pzGji3e0
	 F9lkl4uU3amoUyqHwye9TIWayRxdhkeUcqBWWZBAT7j8g4r1gTLCjPrMoOiiQiXtougtB
	 VNh1rYbhb7EYFuyA4eXexKXF5Er////Oanc3JNS6dZiZKBwRFEq23ht5/4wEhMouStQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rhK27hUj;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A85606A31C
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A85606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rhK27hUj
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35ef6b49813so5120522eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460318; x=1793065118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LjwwN5Dzf8X1Yx08q6zZspcMWuK38LtYvZHShxnEiOc=;
        b=rhK27hUjeHRnkhbrVNJ2XwhZq7l4qeNjK188G/cQOCNGrllyZZrjFdmE7BBmC6PbZ0
         FqpQMmlLnaWvKqtvLwsP3VoeRu8uWRcYOA9ni1wMMT2H0G3ODy0x+IpphTIFPd3Yv0/I
         OiK8oGmEqGaMBBu1Yvhzln7e6Zgm2NH1kyRSgAGkThUXOFf4T9CG5Xg4Lb8dgNxQK1OY
         zGI7XFWCPwMcaI/ldYUB8ytRSo0huZB2FgurXz984M4tjKyRWOS8mLPdz+yFxO5kyzxO
         2AePlDfj0/lvRVnUnyQdoseg+5cRhVxFR/kx6i0QWz1eDRegxuSi8pCDH+bgI2hbVJQ8
         cXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460318; x=1793065118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LjwwN5Dzf8X1Yx08q6zZspcMWuK38LtYvZHShxnEiOc=;
        b=Wu1MPmHAYNVgfKZpAXIRGtngIQQwNhkR0P7N2q5tmGyYzeE6ui+1mhy3QNmDoKbmTh
         kL/hxjJZbEeI0iKSF1D9ODS/LhIfNT+9AGVMROvWa4US6XIc4xKubV3csgs4E8RJEOiU
         +zGrl2fITKC7tvaN65tQQXakqG8oqAtTSTAP7s6UcZZ3Nq42bSI6fEeQaUWUc16d/EMN
         PlipzbIGtKemod+bV9nnoLjEPylo4r1BSSMLnMUFSi+UsJ184kW4gzDtnna0ipmeGhty
         Ayyyp0O7LqRoeNVq9QhCuOQkSEkpPEbonFOHRgj+I/BdMj05hc8k9bi+5EvhptdQK6Wu
         69DQ==
X-Forwarded-Encrypted: i=1; AKwUvBxM0JH+Y4SMYRwCh/InG3m9pc1x7ahGmN4TvuuGhp4HzWuwBJY8ffCHtHL5VfkEhrHBWVd6pcFNGiNG3Ej7eQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJn/OWQW7jnvalMaC0Csw+p/jlqKGYZb7zXBNY3lbOmH3m/rHvB
	2c1cxtBjcz3GfpYc8oQRh5/36c5vdF3Lj22cMKbzdvs0JXqg1M41bzQK
X-Gm-Gg: AYBFou28+XGg6Po88ov3eBVO+QrDZIkzHfOwYIuryy/Pwela5WqZVlzmMtluWLT6lW6
	JBTrvkAYeqKSop5hPaE3w3Z2Q244dXVMOWyX+em500RNK9be1J1/Cj8iAVtwwzhLH3+bXAPs966
	pEbiMYAVPvJvLUXHSRZDiJeuHJvfQ3UM1RKfMyhI0S4GQ8JJpcLUPt7B+RgWrKXDWcIqMZTbS0L
	Rbyp+hai7bLMobQxDLr9vVZAGL7s+dIlPsTsP6BZe9xnpKcQnEsKO9z8giBSYhE5ZLgyP5uYyzj
	3a+lOT2Du3RlZHKdgrdk9hnbQJtC5+OGGsVsjpzvFYdIF03TGrBQgUDrJyJSTJT9q9c8Fq9zJkM
	ZaNrsMFJznXGErFXIAgYS3tghoS1wVF41fuGkQqnGH5mDmOKSQQq2Ui+HPhsTPYRwkiwnCkLAPm
	b4ivAleR52YtJYroSeR3M6QHrdKtuoBJOU5epYwzlxI0eBTds3/c0b2138Zj/g/TDIQyKjoGDSy
	TnN+zpD9dya
X-Received: by 2002:a05:693c:20c5:20b0:35c:2986:35ab with SMTP id 5a478bee46e88-361a1668b4dmr13507939eec.13.1792460318438;
        Mon, 19 Oct 2026 18:38:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm37720983eec.7.2026.10.19.18.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:38:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:38:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, manuel.lauss@gmail.com
Subject: Re: [PATCH 2/5] dt-bindings: watchdog: gpio: Describe minimum
 heartbeat intervals
Message-ID: <704e79be-3fa0-46fa-aaa9-d13fb9d933ac@roeck-us.net>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <20261016221617.2223004-3-f.fainelli@gmail.com>
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
In-Reply-To: <20261016221617.2223004-3-f.fainelli@gmail.com>

On Fri, Oct 16, 2026 at 03:16:14PM -0700, Florian Fainelli wrote:
> Some GPIO-controlled watchdogs require a minimum interval between input
> transitions. Add an optional hw-min-interval-ms property to describe this
> constraint, allowing the watchdog core to defer early keepalives.
> 
> Also remove the 16-bit limit on hw_margin_ms. The generic GPIO driver has
> no hardware register imposing this limit, and its heartbeat interval is
> stored in an unsigned int. The MTX-1 watchdog has a nominal 100-second
> hardware timeout and requires at least 1.6 seconds between transitions.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter
