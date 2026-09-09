Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F259B691
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988681; cv=none; b=mvIz13gNxqOoUkGyolnAyqlhbn766Z0I/3XtfLYXvqfEtnbzhKYR6zlqcgw90ySSsKq9K9pIoCTQ3eVb+LafHytWwHSOpDFH1AXB9HsVN/hpNZTcIo868U5MYmTr0saQSR1OrQszPW+zfG2U6lyl0W+fHY1x12UqqWIbjLCINCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988681; c=relaxed/simple;
	bh=FRnYJEsiRVcAghW9SPXvcOkf7xwF/0r7gkSGTEvoOTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnTph8eDxCLPnPe3CS/WHczsKBFbM0Yx3B6+zsKf6Z9tuhp7QYO3mUrLKorgSXIaN/AbYdwHH5F5ZkRTvZVLBCKPIKzAK8zVZ6/yYViaF+90laBVcqzGOdXOmrl6E287/9e41G6h2hg5AgVp+XePskQJZ0xyEZZcDSI1wB8aw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oA0zjE9i; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oA0zjE9i"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso7033290a91.2
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988679; x=1789593479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uEKeZ2TrQn0dt58Pw9u1wPw14oz0jOXcEhtf2kaaHgc=;
        b=oA0zjE9ieYvPlCLgtSGr8E10B057U/R14Qm7cxAYl2TB/uIWR1kOBbuMviYOc8q9c4
         N9A2oondZUgEFPV3bPemQpy9oLBhdrkhfu/EQ4tF7BkP0ni+WRw2OOZy5ACvKRvR/1Fu
         Xu82ohq/MIdvLeZw/O9P12AvtEtgy2pZNIfmluYNqLLuDvn+qUGZpFUCfngRzmATIzYZ
         O7sDbzL+8NdcXiAGvg5aiUoUFF11gmE7MCMr0cpZQvGvKAPESF4scflbJ+1pH49CRnG6
         gPKYbtLIenT2fIZRb6yQiq6OEmXxPQNy3d6XP8t0dAFK9QmqwV7ejEiqdnDOHgXMDfHP
         EYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988679; x=1789593479;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uEKeZ2TrQn0dt58Pw9u1wPw14oz0jOXcEhtf2kaaHgc=;
        b=R0y0YKHu43pjlI1VG73Cn0Jib4nUCLK5O6XnawPL33b6KElqm9tdOacnPOfN6VW6un
         7NNhqQw87d05rox/Xe2H5mlqzI753vfXKgbSc5RtdYqv9TiQ1N2IXxD5dlQ4fpxqUhdN
         +6NE+jjJbkh7KQSZFJr2X3SthFuHchrnqlXV+by0Lzg4C/Ped4ySsdeNLbW5cAuMyTQa
         hyeWgyrvkeFUGUZ1NvYnhle7VqWhytM27lfFtjA2HCuseXkb+s75T5oowjhfT7Xlz7RO
         2TlmoJ/zW3Lq1381ecJ1gOwXabcIRNpitV4s4HBttTMdmovajuvGZVgxmeKUMPnQ/4wq
         GDpg==
X-Forwarded-Encrypted: i=1; AKwUvBxW4tqr1N6HNhgWVyDEuh3Gqrj8N4MXG5yb2KevWHzhMpBmb5u8BZqR7S7yqPQYvAFw1MM+O1bo2vc7LAURZg==@vger.kernel.org
X-Gm-Message-State: AFuF++nDPnuwxR503mQ2rpflpStVZDF7wr0jLbQRMGejvk6CT+P8GB3e
	Hfkgl22BLo9YYXwTbcjlz1jI5gZOIQYjH6sVFW96tuXDkvWTP5a68tC4
X-Gm-Gg: AYBFou0V4WkHGaA7UTaKLUVZAxMNbLAK9Si3h2urjiV/0c3ZCrp43o8t+hz2sjrvAWN
	m7sRVRWUMN78xvyEU7LI7YlB1djn7DnVElCciqLVWddjf9/5SJt6tt8w9rcJ+CfY/TTZzIE4LUk
	k9VhwraBTmEdt1AsUyzStTG57Edmx5MWIHeUYS1RjY3MQqN/l1wnSv9gKEFhkqAaptIPs5yNPSi
	hsapXC5WeaRKPV+S3DjaHL5lRRqA79saD1eKAauSj1IO13IpAcDtJQjRwGYL4g8k61TWiQyFt/s
	kZwgKMfpvsE3sSfMD7AfzzaFM2G1BSu4x+2I5hEIGk9bXoQwE2wFXQg39+62XULe2JigdlZnr9p
	GdL8zKq5G34zDhqo9gMN/95p8rpnNkVDeUSqsYtOteiBAzzN5AiJhhomsPWP1LSoP37Neeh+3j2
	poLyL9cR/Ijj90sEMXwnRd6xhE7J3Qz+gWU8Bx4oyW++eNmeiiLvJCUrEuT6FnmeKAxBkYOW3G1
	29J123sTSiX
X-Received: by 2002:a17:90b:5790:b0:398:9bd5:4910 with SMTP id 98e67ed59e1d1-39b2624f0ffmr53766810a91.23.1788988674868;
        Wed, 09 Sep 2026 14:17:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bae5837d8sm2124986a91.0.2026.09.09.14.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:17:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 14:17:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] watchdog: msc313e: Fix undefined behavior
Message-ID: <dab384d4-97ef-49f9-8c67-331146d46147@roeck-us.net>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-7-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828161348.13212-7-tzungbi@kernel.org>

On Sat, Aug 29, 2026 at 12:13:45AM +0800, Tzung-Bi Shih wrote:
> readw() returns a u16.  Left shifting a u16 by 16 bits yields undefined
> behavior.
> 
> Cast to u32 explicitly before the shift.
> 
> Fixes: ffd264bd152c ("watchdog: msc313e: Check if the WDT was running at boot")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,
Guenter
