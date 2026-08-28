Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA935C69E
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928128; cv=none; b=tHf1RNtvmZjqSKKxgtsGTEE1cHL1keDTM/a0WuHvOV1VqqhQDEYrkns3tLdwvHwBc3KSWU0T0GrkKAF/MHTfmi8X5aE1wZd3OhE574GsKlTt5EV243psKtTbD7xmUCgqmqufszpSo7ce3VwbKf/Qcbmh8Opznez60wBrCJNKKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928128; c=relaxed/simple;
	bh=GN2uy6iphrRPt9umv93rau235m28F43BO7lg6PkfF8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5srZHPnbEW0jpEFsZ7+/E+dv9bdZYMFg8jc5F36QNJ+FOU2CiaB/92uEBcmbWV3lAGSOXPAsgkDVBgd4ShM/ZRIYvoSq/0HpRP1dEGHSbWeJZV+NE5S5Ov8136QMBHvDBbmasY+eryQo8qEofm58KgASZ/LanCiPRgqDxBz9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLVHD6tr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLVHD6tr"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so838597a12.3
        for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787928126; x=1788532926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J7+8WQoYJgQnu5rmrwx2XwchVjnUqtezY6UYgVCUmKM=;
        b=JLVHD6trOZ7/nMAs2It1yK+5GCO8GT4JkPOPS3jxB6U+Du5/EegWAV1QOkzUDawemS
         FlFHI4DRG0FtWG3Aa1ViVwv0IJwX+F+E4bwVUrsJemLgDdOyCRx66228jfNket8MCg5z
         XOBUGp/bp6WehdpyrKbjbATPDhtRkG71s9ocGO/TGS8QZyPrDwLEo25f/3Tjt7SWXJlF
         o13OlZl1bsNIovP8clohDJ4Eh1xD2p+YO0mbCN1pZJNdTpsVR/IykOvMlh+0fhHNQu41
         BR3ljZ8QobPRo9vewp4w4NlxXNRVCRna/yFwgpvpe6DEULpRRecAOor08uo/3y+sojqs
         sMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787928126; x=1788532926;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7+8WQoYJgQnu5rmrwx2XwchVjnUqtezY6UYgVCUmKM=;
        b=d3sjdkYDonMpk73IQL+ywnbXgWtkMChvFB7QzvVmxXsTcRMnblIXkl2FPdJTyVLS9V
         E86vQ6VeP+5rFddVOK361qCvoqds+LU3DiiZC5oYzfBzuIrAuKpEMUgw0gCNXY1BuPrb
         dNg+FX7e9i6oq8Vyq84dotGQp/TSQ68yeohq6Mj/j/8IZdDjavH2HqAA04HJa/2M+41O
         RTtDS/PnmCRv1zj4Xy5xC1APwBGNMFPfMu+J1VXB7L42X+firXQKf0Ih/omY5EtqXhVi
         0bG6nTn2UUZaSOeYyu3wmwhf4Z9Hz3ZTV5xre4RvnBMqA8bpWnV46J79QCtvUW2xE8xP
         YcRQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8ak9Xeu6FlUbzJm8LJHwiHGP/zdvdXfFehepFi4lEDNJT0UqS4kfnvwIGwHONRir11B7PLlkdhk2qiooBRA==@vger.kernel.org
X-Gm-Message-State: AFuF++mpuUXmL8ipa6LyRS2/6TEsDyE167zd7U7cn+DBefqivS4tkoML
	b8bqm2W1Z7qs8xfJoNO7vSP4jhesO34NLaGxWOIPdT5+7lclc4Ib8j6Y
X-Gm-Gg: AR+sD12ZkV3PMfT40yopEXUEipw4Y6vCg3Ku8qJ73DCGJ+TXiPKb2nPlfe45MUQaP0h
	CvB37U1uTFAfyWQs46hOrgaJ2oOCm/t7vgmMQLwGQ8W44Q7QK7HM2+n22KY83JfnWGcFe4F8nbk
	22yLYDA3XaidmGZnqLuyJCJEbnUvkK04lOEtxt3fktU54IwKV9HoBNDCT724b2uHVds21Pqbq47
	Lmtp5F4PT2eGgq1I5YFHsZj92e+qZ4y+BI3P9wP0j3Bd/4seFevcP6YJND7pmoPTg7JrXTo/6Tq
	6s6wT6pKJEW7iBOQJVwkSYS6pDDmph6MzilqPvGrZJPmteYgh9iXMRGq53YPahZ57yeyQzf+5Q2
	CTmSDqDc9YuyawCwWP22wn6peFPeMQ3z/1eKIr+7+OArAhYrM2Mo7Geyj4SNRgNhn/ko2QzQnF1
	9y6tbtSV5mWUNqf1kZ+Rz6ai7vS3UvVbb2TVZDkBTKuY3FH92n1JFzbe1cuC1Qqcq+/SD6EN1Vr
	Q==
X-Received: by 2002:a17:90b:184d:b0:398:9c00:29ed with SMTP id 98e67ed59e1d1-3989c003c3cmr564861a91.21.1787928126303;
        Fri, 28 Aug 2026 07:42:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm6766462eec.24.2026.08.28.07.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:42:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 28 Aug 2026 07:42:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: msc313e: Fix NULL pointer dereference in
 PM callbacks
Message-ID: <666397f1-ac63-4644-9de1-9f675d2a7f3a@roeck-us.net>
References: <20260827044700.554333-1-tzungbi@kernel.org>
 <20260827044700.554333-2-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827044700.554333-2-tzungbi@kernel.org>

On Thu, Aug 27, 2026 at 04:46:59AM +0000, Tzung-Bi Shih wrote:
> msc313e_wdt_probe() doesn't set the driver data for the platform device.
> As a result, dev_get_drvdata() in msc313e_wdt_suspend() and
> msc313e_wdt_resume() will return NULL, leading to a NULL pointer
> dereference afterward.
> 
> Set the platform device driver data in msc313e_wdt_probe().
> 
> Fixes: e9800b799464 ("watchdog: Add Mstar MSC313e WDT driver")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/watchdog/msc313e_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
> index d962589e2c55..f69d66971c41 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -124,6 +124,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
>  		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
>  
>  	watchdog_set_drvdata(&priv->wdev, priv);
> +	platform_set_drvdata(pdev, priv);
>  
>  	watchdog_init_timeout(&priv->wdev, timeout, dev);
>  	watchdog_stop_on_reboot(&priv->wdev);
