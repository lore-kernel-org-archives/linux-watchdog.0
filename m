Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535332FC037
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838846; cv=none; b=XBG19S6Rc7oRQz3lHoTn2uS5j9pY1UkYaAK7sxZ+17ECFGRStOG7gUhsptz/GFa2nL37nUiV95JHolpZ+CdNHLth0xvpzeFoN9b4sABv9rmnbV0AlrySd52rCxDZrwT5deuvZpWAS8JTJncwQKrXW32WXoTaR4CU16KJFkSodiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838846; c=relaxed/simple;
	bh=QcnsRvBS8HwkR+O6VJHcSxjceTtwS1oZqvuyeAOVQBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svgvZdbjMKijwZAWlkJ+T/UMJQD6fgUsF0JmT+d+pDqpLiD5lp51p2kLmcFXCcz1JzYRncEhdcrS22XDnlcZG/wYkhudgKtk821TzW4YLp929Cxpvtd1L38xTxHdPXQD3hA4H6Ze3/AI4OVweISr7WH4eRf9cesfaZa3TTe+adE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W47rpLKp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W47rpLKp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce98cb8165so12137395ad.1
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787838845; x=1788443645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RngKn1qeN4IMu4W20K5F024kPlBdyKuXJtbP/ZBjLVg=;
        b=W47rpLKpxgprzgm84JHNcrrstIUk3eh6n9RocLXhVaM0VIvRTXaGG2/kt5crpbzyM8
         SIKhN8Wy2LW5RJY/2lrcoAO92616v/Fo2m8UhJrpD9U0D7+2U3A6I3gPqZXReITyHBXK
         TnttMSziSVwRJLmzpYS9nauDh25ydtZNSRKPSl3IZiQ1ZlF3wV4zAE9W8ILqEPonWT1g
         350Q1dKuLG8pb6xt6Hs1eT4thY75vSqIUDG6fMW/Uw0kOw30ub4t4dEk/DlW26y7sRTw
         bGVLGbnVyI+qGPUCFh0iCE06lmeus+zHXCpLbaTgE0+AKMydVyg/ToVIvXgmtJwwhzys
         G2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838845; x=1788443645;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RngKn1qeN4IMu4W20K5F024kPlBdyKuXJtbP/ZBjLVg=;
        b=nfdEXmSfFfpVf+P0SaJ7ww1paG4ef6jk7wt4Dus92TeDPV4Zjrx+9kLtQAcJ+Sm4qu
         3F3BtBQ4QShAD+AwOYAvkDH9Lopmia6gAhhmTI95fEzWgxR6DyRVkCfV7+IXVjOmz2tK
         w+CUiB7BMiVLN9uW1xBdjajt4vIhCFx1Otb9dR4Dln0DgTFvTXXfis8trd2ip8cY68fD
         CtcTpruTpwPBanulNDX2PGbP7MtPZOXNoEMr+6MFLZxA1bLQYc9fdAMY6VEc4tNMHN0o
         bOJXVxhwpPzkntA6iflXYGwM58E5yV3THu3zOBtMyBxJT6yDrSNZCDk7/cJrqgvELzUe
         blFQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3EOprW9iCLwI6xnY/TIHLbGy1oqDJ1ClakaUHU3YpUgWKx6VoudWfQHxnq4yZXbRxUriRKqhGLpq5Q3OgVA==@vger.kernel.org
X-Gm-Message-State: AFuF++mbFVHC420mMZmxRyB5nlSbgHh2BtNWxWOXqxpbFv7zmKOSZ7hN
	SE1EtYzSiKwr7/8Qsf0ppjpQt0g2uW69Pj0jqp+tzTtNLf7jEO3Yi3a7
X-Gm-Gg: AR+sD12346ZjGLcX0BbIzI3sVp3Jt4GCFN31zRm5KGSsth7ZaaRG7jQWMIP7aSikCj2
	ZbE+GuLNm820RBvG4PVfQSlc+zP8A3BhX7kDHKKYtTyV9QbFWiaGFHWCYZr88qCDJIg61zMrGfp
	l/PCALcFNHWOlLuW4JugyKaj1rw7TZBrYCtMo3oZOX4idFDUhRbPpMDXwCXCC4nmzLOQCditTCh
	XyoEB6GpPc7vYlplOKCVdKUHtLsxzoIH0NW2RhNh7nZIfwQwu0/aB4fpjWrJ+y6TRmUyeGOdKPC
	vw1+Fva54rq6YvXx5sLEinTmqpkLY9+dhv5+jL22wPErRCDBFqndYwbJvIMMffh7h+FMxp5YN+K
	rgetCHN60zwS7Fd1zhuOy6QSmfMWQKd3zRKqkjvSPFRpO7X3xN2CyypgKmGhF2waNtlSTPVOoIk
	NgvMk0+4oJZtepFqS7KJLCsBgCuG/SnJj/dooxGjoKrOLbLPV1L+huD1YgUT7GCWNl7EolYgQuh
	rpRyhGPE3PT5A==
X-Received: by 2002:a17:902:e74e:b0:2cf:7db9:e13e with SMTP id d9443c01a7336-2d72600b801mr85038015ad.3.1787838844476;
        Thu, 27 Aug 2026 06:54:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704c34ac6sm17479885ad.73.2026.08.27.06.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:54:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 27 Aug 2026 06:54:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wanming Gao <wanming.gao@mediatek.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wallace.yu@mediatek.com,
	Jarried.Lin@mediatek.com, vince-wl.liu@mediatek.com
Subject: Re: [PATCH v2] watchdog: mediatek: acknowledge pretimeout interrupt
Message-ID: <5e1793d5-6c78-4372-872a-069fcd99a07a@roeck-us.net>
References: <20260827092616.2724197-1-wanming.gao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827092616.2724197-1-wanming.gao@mediatek.com>

On Thu, Aug 27, 2026 at 05:26:12PM +0800, Wanming Gao wrote:
> The MediaTek watchdog pretimeout interrupt is level-triggered and does
> not have a separate acknowledge register. The interrupt is cleared by
> changing WDT_MODE_IRQ_LEVEL_EN and then restoring it to its original
> state. Without this transition, the interrupt may remain asserted and
> cause an interrupt storm.
> 
> After changing WDT_MODE_IRQ_LEVEL_EN, wait 70 us before restoring it.
> This is longer than two 32 kHz watchdog clock cycles, allowing the
> level change to propagate across the clock domain.
> 
> WDT_MODE is also updated by the watchdog start, stop, and pretimeout
> operations. Protect its read-modify-write sequences and the complete
> IRQ acknowledge sequence with the watchdog spinlock so that concurrent
> updates cannot overwrite the temporary IRQ level state.
> 
> Signed-off-by: Wanming Gao <wanming.gao@mediatek.com>

Applied.

Thanks,
Guenter
