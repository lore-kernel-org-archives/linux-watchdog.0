Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CE3BB9ED
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988118; cv=none; b=CldBbeBos9uajqcUrvBlQKYapEdlwyRWRK/tirgoNA7QwyaKe/0gxlsriE1EQwsIcXU6MnSuGpNe6f67l++mrccRX2c5vQ8jWEIeAq7dAzaAS1ivNjgs3RvrodCJUWZUZFVUY/K2rINyFlqc7VRMw+npVWtbvTHG48pKc5XdF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988118; c=relaxed/simple;
	bh=Gajsr1kiLHqQCQ9SqWmRz8Vv502++7s2iR3vCVPs+KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCRBFQfedAuSQXV0gyyMeRmzYGdWb70CSHWVTaWaHoe+VXvtOFGFhTu5oi5SgaVefJYXGJXCYTQAkj31vYgOnNV/loJeBhZv7pkFVpRkisGWpjF03FFuripQo7QeWS6rjetxTb9U9l4m81Mfr8VNgVsHaIF1eM4XKs9cAKTvvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYAvu2PS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYAvu2PS"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d6f9e2f681so71795865ad.3
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988116; x=1789592916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UEK5sBdqDEjQeev2uIIR4l83OCeaIGTj3CDKY7Pw4J8=;
        b=rYAvu2PSoGHzDIP4wVJdKWIpRX+vtswYW802CsIbMIxuhNml2C4dLqE3DLFBK9SNNa
         QTpAvGOpTuWljLZsBDdDJNBGPPYBEBuvdSWMd9gzw4KK4+sMhPUFPTs5O/J0P/Yhzdn/
         mAs2qRPYVh6KJked+j5xTlAoLYbwzBz/hLWG5Y0ekNE/661xL7y94uSokxHZcU/Prsss
         G2yfIAZ2YqCBTfqYcQeiBm20R64QVb3Avp0VaOAS5f5gaG9uEieew4wKvy1R4TG7yhR8
         DwaqnsSKg+sopQjKx+cWfadcelhf2hHsqDBmas46984wfDIQHYDGPEmAvMXIcMgnV2Fh
         HEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988116; x=1789592916;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UEK5sBdqDEjQeev2uIIR4l83OCeaIGTj3CDKY7Pw4J8=;
        b=enMDtuGp2mZrWR6M/OJCuQ3dLGbc7RIRHMzID1kGKuG378CqvULBzUqqpWnEH/MgXz
         dMpNPx4DI4rBoUSNNawUS7fN8rkycwILkk7063dvn/p7I3mQcJuY06ONSWVIeniolBUI
         OAa+5Fn1pB0ZOCdf96ydYOypXqAwHjLE6+S5pmq5zLo2y6ocmTGNzxLG/xiShCsT0kK9
         TnwDIVoLbSXLnsb/dvdGQEsbXnsatfQmoQYbZOTK2thag2BpzQmU7zx3d7BCikCYJpnB
         UHH+JlbtI2GoTucqCbeX8mxf2y0YoZrS3hXf21mcJPPfzaWwubc6pBdJMKEMcFDABj/r
         MhYA==
X-Forwarded-Encrypted: i=1; AKwUvBzefUeuCle5DVoiw2oksRRd2njoeyriJ8JmoDA+K5c2xK7iEZBSu5tAr9MqPQ8cKMLG12yy4EHAAdi2k/kVxA==@vger.kernel.org
X-Gm-Message-State: AFuF++ngdNbOzMccEMAlvn7Im1mh0ZB1I+CNVR1FhVqLQaIc3geZo3TH
	I4DfzxE+qmKvxsRx8685YMEgaX1a0PELs1AnMyeae+FNIJSlz6UbR0uL
X-Gm-Gg: AYBFou1WTaikLwvB4FTzdF2QzQu8p5Zji7lJuXv6ec0DPi93S7mjck8ZxpWg7gk1vu8
	ENUqIICc4gLcPonY7+LGspOQp9eF+TvAHluE3S9CKz8M3JN7ZwQqjJ/24GduNWV5AG6xPcqqg6g
	W8O6/mm+HoPnSyuTz5l5suzaIYOajVmsCQYBKgOON4JcUSlAPnpibxdh0UslzbzQ3xilofi1rL+
	gAk0BfcUxl625YKJckgTEhS+H+kWLO+/ooShGN4YUGoqa42Rgglfq69HqNLnQCZwV+PrPMfN8wE
	pwAFpROuwVirL+nvTgCpccVMahR9Sg9KBanmL0sOpUfYQ6d1G4Xoa8sFhx3z3IeCQCeJ7m2dQO1
	XA9g6U1wB+8PfqUQisB3aPLX1oaqSgOwFhwj/4XDasbE7gEp1vlmEps+PS8s57qA83V27/ew4NM
	AKE1FsMitfap7xI6REZHZpIsfQ8TxPfA06ttEiDGRh9dzPticAyAt+bRR9aZQorYP4etcmmgGwc
	Z0J+Gqpjag8FsAG1Zypc98=
X-Received: by 2002:a17:90b:1a8f:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-39b2612ed35mr52904411a91.7.1788988116308;
        Wed, 09 Sep 2026 14:08:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d770a010dsm1359550a91.3.2026.09.09.14.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:08:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 14:08:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] watchdog: msc313e: Avoid division by zero
Message-ID: <2c0b963e-6379-46a4-bae8-92ec2d76f8da@roeck-us.net>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-3-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828161348.13212-3-tzungbi@kernel.org>

On Sat, Aug 29, 2026 at 12:13:41AM +0800, Tzung-Bi Shih wrote:
> clk_get_rate() could return 0.  Avoid a division by zero panic.
> 
> Fixes: e9800b799464 ("watchdog: Add Mstar MSC313e WDT driver")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

> ---
> Simply browsed code under drivers/watchdog/, the following drivers also
> use clk_get_rate() as a denominator directly:
> - drivers/watchdog/digicolor_wdt.c
> - drivers/watchdog/rtd119x_wdt.c
> - drivers/watchdog/rzv2h_wdt.c
> 
> Let me know if you think we should fix them as well.

Yes, we should.

Thanks,
Guenter
