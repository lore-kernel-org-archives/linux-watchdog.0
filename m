Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A033B14B8
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197393; cv=none; b=VJKfg8qABkPG4YbQcrljt1FyNZClk9sO/8o/qQpaprf4QzWmVxgMynBz4APBBTHYLl3wGVlVshNwJT9/s6alerI9hZy6nqM83UMQ7QMDzpitl404tz/oJ51ef4Kzys4sy6EDjELgcsVj3KpJFYK86uQjgWTRHchlurgf/+BnUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197393; c=relaxed/simple;
	bh=V8xcOFGWQPMTSprDRa3yYxi8wSmB7wiOFbJrnC+xVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsJdSNuxPfilWtgh5mtrI5BmSgJ6Yl9QI4znUHY6+NZK4n6E4Cq7z+Jk5CSK3G2ZalX6dAVqK/LOgWEZpwjSmSngDR8+G49GBZ2iRc6F5NdiKDg698SPY/08h2+8Zk1LgN3QQ0HAZWRG8bW6d+m3YNhVvSr4zIeeg6dWm+BhhjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJPDRPe+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJPDRPe+"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db22383fe8so6594845ad.2
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790197386; x=1790802186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=urjJV9cwlFxNv7KbCDA3FefKThqBp2XiJBexrbouUOU=;
        b=gJPDRPe+qvka6cj7HYwLKP0tiG3MevGU8mCw7NPojuSFFb5/6YEvSoOlrYUOaWVEDC
         tGr1hUtBPtJk9AsroEZwOwgRchfdS+ysXmUM1bJfgmr4x1lgfb6/ZeTh3mwGrN3CL9mu
         nxb1TJUYonK0RKjcnxE0B3zwIVBx7JfwWxPbgJ7bwvc7ZHkgpEcTCLsR5biecKuy5iKS
         wdODEByDMGsZGQQi1zjDQASzQ3M7qDWQhRpbmIpzK39mjTdVHFK15TEukXcHeYtNeaz0
         W5iQ5ATx7K/lpiIbsSYStYoYM3b2leiC2YDLFMELY/XUp+9fCAIMdR4WQkLs74WIYubP
         vktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197386; x=1790802186;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=urjJV9cwlFxNv7KbCDA3FefKThqBp2XiJBexrbouUOU=;
        b=FWzKwJgxpTB+FMuUWPIBmoXrNVo98GM8E6AJrMdMULD3w47EN3ea1x/RdD9WdpDPOE
         5Ht2QwHQnto+3KQV9Dnz/SWES+KpWvqe0f1tQMbe/G3OdAe3amVpJy0RTuang/IAANhk
         oUuYSNYKo6/hwCPWc4CDjQ4nOU5KPwAK6iwKTTOv1+sODySAQghjTcu/4COpN2LOwW5P
         l3FqXx9lXL1JVL2Gyo/MqlyWrEWmZiMUhBZI/sautdgNefcnoxsSwIDYjRSPVYYpwyFh
         UZmbMuFgBf3QAyW2nGPR7asnyWnsCS1yQNuJDZenSMTNH+GiWW4BaOzlkRl0VLhKOojc
         Ki7w==
X-Forwarded-Encrypted: i=1; AKwUvBzHN+Yfx/r++Q5OA5oERP+GyJtblw83IYn8rQdcKpVde4H3vi/bYyNZFPaco8Y6ADg8b9zn1uaD17si6Td66g==@vger.kernel.org
X-Gm-Message-State: AFuF++ki8PxRnWyLq3n1hsPTmXsxoUgaKHCU+R70QdVP6NdlaD9hx5Xv
	TtuVRk+M7n9jBBILMLywxaIsS4xpjFnRX9M3/yzvJCAzyLfBi6EVwwXF
X-Gm-Gg: AYBFou0WhYoKIzxukJChyUL0qwgXbHkomAA+8v9DSmK8SPeksC9QBvlnMt38eeQ7sZa
	7e1cCNdbmYbYqdxya+WVn53/f5x53PpUhbqN/FE2cooXi9FsocEXqe4Z8MGYr1jMiI5kMIzbKHh
	5vtO5LyuAZ4Ogru6b55amhlr63TLbemYHkV6VbORK42aagxbTBfoGS7xp/t36J1K0KctUE8wpTp
	Jnq30tGZbHd0XaxXby2oz/esP8Jq/pGE3AIj7L/svC1pMn7uVXHF6GdiTD7hQN+vVPZowgVMJ8R
	3/+kumLdd2eSEaZC1REV6Faj6j4uPOPddXDcUkxlOLIBkz+gkTI03GlC9h+y0/ZDZD8xTiIm7ze
	h7vbbp91CwXzpMnN1EnhZzH02xUrjJzosvX7aNTA/0x4JMLqBcRMoj7+1aie0A9cz7FnXl9CAHn
	AyxoLUH30b20SXEaYVdmnNwu31kQ0HfsjpaPV3BN2ayyTMLI0kwzgENfSR4TyLR4DSbRF45m+xT
	2ioFJ3Upozi
X-Received: by 2002:a17:90b:4c82:b0:39e:6c68:1552 with SMTP id 98e67ed59e1d1-3a09896ee0fmr243012a91.26.1790197385901;
        Wed, 23 Sep 2026 14:03:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972b15f1sm848270a91.2.2026.09.23.14.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:03:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 23 Sep 2026 14:03:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev, linux-watchdog@vger.kernel.org,
	upstream@lists.phytec.de, andrej.picej@norik.com
Subject: Re: [PATCH 3/4] watchdog: da9062: reset board on watchdog timeout
Message-ID: <10de1304-577b-494b-b8d6-3792ebd1bbf3@roeck-us.net>
References: <20260923111719.2032012-1-primoz.fiser@norik.com>
 <20260923111719.2032012-4-primoz.fiser@norik.com>
 <146c3502-3205-43ce-9d1c-c58b936d160e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146c3502-3205-43ce-9d1c-c58b936d160e@roeck-us.net>

On Wed, Sep 23, 2026 at 02:01:03PM -0700, Guenter Roeck wrote:
> On Wed, Sep 23, 2026 at 01:17:18PM +0200, Primoz Fiser wrote:
> > From: Andrej Picej <andrej.picej@norik.com>
> > 
> > Implement a method to change watchdog timeout configuration based on DT
> > binding ("dlg,wdt-sd"). There is a possibility to change the behaviour
> > of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
> > clearing it enables POWERDOWN mode on watchdog timeout.
> > 
> > If no DT binding is specified the WATCHDOG_SD bit stays in default
> > configuration, not breaking behaviour of devices which might depend on
> > default fuse configuration.
> > 
> > Note: This patch requires that the config register CONFIG_I is
> > configured as writable in the da9061/2 multi function device.
> > 
> 
> Please reword to something like:
> 
> Implement a method to change watchdog timeout configuration based on the
> "dlg,wdt-sd" devicetree property. Setting the WATCHDOG_SD bit enables
> SHUTDOWN mode, and clearing it enables POWERDOWN mode on watchdog timeout.
> 
> If no devicetree property is specified, the WATCHDOG_SD bit stays in default
> configuration, not breaking behaviour of devices which might depend on
> default fuse configuration.
> 
> Specifically, "There is a possibility ..." should not be part of the
> description at all, and "Note:" should not be part of the description
> and be moved below "---".
> 
Also, the subject is wrong. The patch does not "reset board on watchdog
timeout", it implements support for "dlg,wdt-sd".

Guenter
