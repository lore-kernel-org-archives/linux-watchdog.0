Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C603F4DE9
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372153; cv=none; b=uv9oQI5conrX/R+AcXO2YKywQuk7YbUb9CthgBNqjNfa8d7mKKdLzxlZZ/xhN751jt2V7EnfQt6OTsFg6zjNfazng9yWa9LtgjIV/QGSHHJ+gsK/ck3ghqv9g3BzqeWfT4DBrG6sBtbsJ/401Imf+UGjkIs7Odk2w5nvkisGSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372153; c=relaxed/simple;
	bh=ezI2NRYg4z5LS+1phGtWwqWBatsgQH1/R0Eh1Ih2Bjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bII4oo6PrMznMiy+yhvdI3VvR+AtUC2dlYywhFvzz5PYd9TpZ3BJRfg6LK866IT78cUnJSdpDbHivlrGTdNncSetcb38Kp1K+3Jmk8Vz5AFxxbG6vtmxS8wpJplRTfXtSZq8vUMIqEAR9A8GZ002ACADkxaWHOdAxksuFAT9zYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djOcoMYy; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djOcoMYy"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca88130e09aso1358910a12.3
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786372152; x=1786976952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gm4aTcjmUTHVq7OlHL9pds5wPkWyYsi47TB7jeHCEes=;
        b=djOcoMYy0w89rpg7t3NtcAfnMuFwrki8lItVj5DGr60eWRPGVi6/lg+77l9blVph92
         9TEvk35gGOdjzOIHdtGk1k/8ZpbWcu2BnFSRbymrVnAGs7CUT0xU7zcuFpsWkHlWGWpx
         iIIcZjfYtDVoDaNK1qUtSVyNsGlZucDbjQ6XPSlnXi7Dr6URF6nHekvtA5BtxrECrcfZ
         Y7Rpuf2CzI/UgQxyw9tE1MjUc1BSS1xeNL4wDKLKFs75oIYSvVdSTsgYbDJJoyh9x8m3
         3ztqLn4P0X8h/6wRK4yi9D6uDwfi/HjS0MlgXE63brcw565iJICfHvWmzZkj3h5/5gbt
         DNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372152; x=1786976952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gm4aTcjmUTHVq7OlHL9pds5wPkWyYsi47TB7jeHCEes=;
        b=DVnTCriwmfo3j0pMtKdqvAUq60GYDiVJI9CE73XCRQIGgl3/s82sxMNE5JVYNXZlDU
         HT+qjsC/IJbNcNF9BrlqI7ivby8Wi6rmS3MMdOwdkrjVw958NHv1yhpEfPebbYTVNfmv
         PDcDviqutiI/xHY250t2hHmfekr4IvBvAHCWe4CB6lYJ88/aKYv0YRByLhmVdkgXe37m
         BEnXSp6W7G1sp+i1d4sBDUqEAzRnPb7TOqRdNgMMvlPKIqF5hp/85QO84bE4BMQ4wNsD
         lLCWUr0XzAqgAuo8iQ70Se6zQcASxQ4/4bNQ1O0ZhyPSxeCnJDv6e2w696RjIctUjgvJ
         c1Wg==
X-Forwarded-Encrypted: i=1; AHgh+RpkBqT/1YRrCyRHk7w/fCiGsbsS5TKsqhsGPTlD1+Mw47T9PC6xcBdVQzQLW5YEraKPsF2S01mQR7swQsrilA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrZHxOOKKCeANZs+/elkjwn3sSw65fQaJ0EegzSvri5suVSq8r
	ENlYDkmUj0TH/xBEyoqOQwwuP6C+9h5ErVstIF/uMWnGb9qTbyCafJe+
X-Gm-Gg: AR+sD124Kqe2YMlH8WjXY6SlkrLr+GipxMLPzrImeJFIuMaU76lmpBrClckvFmrJr+a
	fVUPdYaltdQSKj/BN4R9UiRms/KbYAy7lq8a+YtpPTvbHKHWBXczObOGG72y1htbTxywOEk95l9
	Y2vrYabfJLniPXov7HuwpP+tmx28RLvRngSejeiPsYlsnnKPlQWJaibwJ6X387Kqg4Wf6Oz6OrR
	k/lHLBzSSTm3+ZoKWYzalvF5tY6Rrc8PtuL/MJEThpR507evTewhURtZg+oXWwbqar2xbyreSqE
	x003xCzxduyCfayAEcmYxiBNytn3QH+V4tP949CBjWq7GMFWWldLA6s/eVqtasOaDsTF24JkoXz
	EpIuRbHkRbIISJHc5fFZ/L7PdVpZoLmPYrgahRuACxenJkuO0a8+/n4CZiH5j2x3sVYnYxByaaI
	/RhEP56232XuGUmQoLchHj63CRibexUcqd0YXnARDK1y0nS+C8FVya1gbfj/1I7TGJkc4MmSRnK
	TRwjsLtRIhC
X-Received: by 2002:a05:6a20:72a4:b0:3bf:9142:ba3a with SMTP id adf61e73a8af0-3cb85ef7460mr50661430637.26.1786372151853;
        Mon, 10 Aug 2026 07:29:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86f98esm44146963eec.6.2026.08.10.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:29:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 10 Aug 2026 07:29:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: phucduc.bui@gmail.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: orion_wdt: Propagate errors from optional
 IRQ lookup
Message-ID: <2f0548fc-f165-4a58-a651-4f93e058bb26@roeck-us.net>
References: <20260810082606.42623-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082606.42623-1-phucduc.bui@gmail.com>

On Mon, Aug 10, 2026 at 03:26:05PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no IRQ is available, while other errors should be propagated.
> 
> Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
> probe without the IRQ.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Applied.

Thanks,
Guenter
