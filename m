Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAE40B0E7
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372108; cv=none; b=hV3BTMhFUEuoyzWblTyIzoOiUj3/5w9YM4wlF/Dx2l2XkjSdvAFEaeSN8yP4A1T3R7zNhAwqkcLIZx/5noKpQ4H8KEsEKNxqcOXEKixd5nDgMmW7pdxP5hUaU6NHk/qW40jdjIJZodEFKHbLfHY+S4JtHouxU0fU5PdBPRm33c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372108; c=relaxed/simple;
	bh=lShNwzDajuraG+khY2GVtiROBl6Iq+vHJAbI4C5dB/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqdkjZkJF9nGhtTduQuwWVOdWic4MvUzTUzlHfesvW+EXfSO8Or493130E7Km3y35OhpSTAW+2C0P5pH8FLH6p9kkz7ubFubWBO1Lk/zKZVAcwjAZpJXufSG17pOSYMT+fKRHiy5fwQybCy2Ay9+F0NOSiW1QBzX3DwnfCrQbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbSzG7hl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbSzG7hl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceaf8a1265so30551425ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786372103; x=1786976903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YPUW5eq17gaHdscg2/3j8ixRAadt7Xlo8DfyOTiW6hc=;
        b=kbSzG7hl5MNzPWWek6+yS53QdM0OAfy7sUV5fwfjya6L+CAHMjtMXGagaBa/eUgYxl
         XWcjC2QsvNN8LqkYVadT36DmindA+MpbCRuZjq9TosYZ3y/iJ11fDtKfreo3bFuBHOJq
         1lrBcWT2IREnFYqYfm0Gey9Gqy2qJ7Q7jj/yjKK2UuyOCbF1GIUeQiVHajDztXG8pJQU
         d+wRBKroJagGBOKK1WPjy6O4xfKRFmDI/pX9WSHXHics5Y9g8Po7o/S8gJh13q9fpZTF
         bgOSfHD7lflOsA3p/LBQvdmSfjfxTXTonLCUFEbjcmHu2neMRGrBs8YrtgiYl78WgAkK
         yvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372103; x=1786976903;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YPUW5eq17gaHdscg2/3j8ixRAadt7Xlo8DfyOTiW6hc=;
        b=ngrWpnlJK0k4AyYJ1CrEEfjnBPhV7Sm3dKb20JpHYOx/TkDWOgrFJke9QADnx/lCeO
         gcq/pDbOzG9qR9GJmyLIx/sCSMDYKxPatfIZzWYDTRQbJuZdfgJCKU4ytFzDBvF1s4AA
         ueSYzlzYjeySICfYjFVG/3eeltZgc9o2rY6wd6aUN0LVIr6yUs3hQKpxTwj6v2P811Ei
         t7iSNN50S22G3XkklmIAse5E1RpupRDZzR/19fd5z2CMCpuFXbb8ssbtoLfCNaqM9T7V
         3C5Hixr69DzaIQHRHFUPriaIdSynn307ZwRHXuefRxGmt51m4/TPfxZGINzXP6Hj6Cfl
         yfug==
X-Forwarded-Encrypted: i=1; AHgh+RoW8lb+5JlBmFgPfdU9KuR3HH9HznOjfemcpPiNfW5zYiE0JmiScD8STkXt+TGR8PFA2bVE97XEJ0dPwd5M0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIhz1+vj/DgoUW61z6/OPW8pHRJ3VjXuRjo8/ywQDcTXNt7XCE
	/aIQwexIU4TJG14Y0Ti4Pcm3TGUxQbnHHauA2drV3TAc0Ibao5nT7K+U
X-Gm-Gg: AR+sD12cDLiHVuWca6QXP912qJs9Qwvy92KxXuiwsOnLyniSChdPS3Q5Q1t3BUi502n
	kR0C2N8XdXG8XLylNNs/HlxpcJXDNVexu2tbzBYGXFaMIDay/6q35NGKKf7uvMOPNSIqwIGqjBT
	n6W/VUXft1SYm6nLgm3uQ+Jx6hjp2o6nV3KmPt7I9B4YfB7RxXaiHNnOHVFMdHYq/RpwwIdi8vL
	lm4jZSJlQeHLoMT/rD0P9psGd8XI67iasQfAUfVzjAkaXDd4vZ0cJ9K6PIiB/R3h7EjNnv4hgSC
	aMhovasnVaXBojS6/9XUs/WQfUPncQUbBB+UG6zw0cPwKNmxv6UCOovt+bUBV3nUWYysHq3y8t9
	8KmJUqRuIIWYulGD8yLPrkfYzPcvb3dyfQwiOnHRbE7yzQ5PxnDtJQmiq6Lpj23LBurCTzf1Y9H
	ByCjSrkAc2gIAH3PgBxbY44yrEPB/EQICV8c+u7PFK1r2HybnRcJWoFP/wQyM8EcmNqKywoEkmy
	86GyYb+R2mD
X-Received: by 2002:a17:903:166e:b0:2d1:1d3d:97b2 with SMTP id d9443c01a7336-2d300342870mr20218535ad.11.1786372103302;
        Mon, 10 Aug 2026 07:28:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88473sm40465421eec.17.2026.08.10.07.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:28:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 10 Aug 2026 07:28:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: sashiko-reviews@lists.linux.dev
Cc: phucduc.bui@gmail.com, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: orion_wdt: Propagate errors from optional
 IRQ lookup
Message-ID: <d20da173-3afc-4ebe-a89f-fac6f89c8b73@roeck-us.net>
References: <20260810082606.42623-1-phucduc.bui@gmail.com>
 <20260810083632.3B29D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810083632.3B29D1F000E9@smtp.kernel.org>

On Mon, Aug 10, 2026 at 08:36:31AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Probe deferral of optional IRQs causes a running watchdog to reset the system.
> - [High] Race condition in driver removal and error paths allows IRQ handler to access unclocked registers.

The first problem can't be addressed without somehow selectively
postponing IRQ handler registration, or in other words re-implementing
probe deferral handling in the driver. We are not going to do that.

Fixing the second problem will require using devm_clk_get_enabled()
and is out of scope for this patch.

Guenter
