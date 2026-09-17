Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7A21A434
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605103; cv=none; b=lGK/raI4xr5Z5yySmvgVjDkouaT+TG06sm8GsO/go4yvj6u3iM/MSkptu86TLPuZfzqEIN6lYYF0YyjweA6MIbDDQkwVtQNI2z5PCCJg2qMcLYskmNbzRqbhVTcd76IakBs+u4CeIctqORKLxi3Cg02RVcI3Hfy/vqSvGpkeUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605103; c=relaxed/simple;
	bh=hupbK1XnlApWTnVAz57YeuBiy7hkg7A7oJqBQeRC+c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si0yWQ5THO9zo6WohC0RcI6VCs9cnDO7HBleXcj1LnOU+zl5oOG0+JVo7Pff3HgwnYe3xjE24KIPTxhcB2yPsH/v9/xx4rbFD/NzceimhjkI28utdfSeqbYKqP2ow5jmNpQqmsj9HKLtilXCAJDtN40TciAhw7nWuTYPY91u1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emzLdQBI; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emzLdQBI"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso235337a91.2
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789605102; x=1790209902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bUC5CPMfH9AfA+p2OpihFGYYkfQ1b4maiW4dfa+t4fs=;
        b=emzLdQBI0EZErePGHKhJcT4BR/Rlqr4VwbR5JpHITz6vMtq8o5EHD4OLFR8FFC+VsQ
         xi03X5fC7A2z2lex5g4FkmCmklvozhwuW+v2562U1fJLVrC87gU+/+yWAUECEvdaALHH
         lKUUHyuvTiGoiKLSAo8G2Uhw9e8vz6sYlAXfd9UQVg8rSFEw2pdc+Y3wE0qqIK5aHTXb
         0rV12EgvUJRwmTjnbgpsHhE//iSM3s+GnMft1LbOw0DqtL6dLYcUK/4v6ulIfoeHsMKu
         3k9P88CPPlPG+8MZ488q46q6VlPU9+xinFxLVTMe8C9RGg4GD3A6njpbV8aWBBsjbAuv
         U0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605102; x=1790209902;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bUC5CPMfH9AfA+p2OpihFGYYkfQ1b4maiW4dfa+t4fs=;
        b=IfPe51mNg4XjK3cr6wmOED4zmTHBgoZMoDTag/Aw2ouRsM/GX/yWBtr4pUQP7jzev3
         NMfeYVrAZMH6fLLFrGd6BvWcRSrk1D6KOe9EKvlBheImu/OX3A4EACmRLWD5JMQEUFfL
         TMDwsuXVJLI+vFoJ0bDRxE4OvF9SpFigewwGpdpI1dKtTpgVXuDQgnqj59PL9OX+A35y
         sWeYtijfd54oxag5I99SUHkIoBsQYFTkeiDOMptLBZlICzGwLP7Jd0dcrc3RB5uK2+96
         cKLU3dOTNVxYZizHUB+bfzRudSpRy11ceb5W9quVa+NnrCyeNAJRvovPHxBrYvk3r4sp
         5nJg==
X-Forwarded-Encrypted: i=1; AKwUvByCItNnlZSlGf6ItUMlpA+WkOUd5Jb3gMrxxZ36YdpW8+zcZ4RqboQuJgy90YvDXJbf9HVyP2xngFkWr7yHKQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m/8mhGonzVFzhmH3cj46K8hV8N0dXbz2NUVb6TuHer8jCG3wr+
	YlrXT1uL1PkeLQOG4n9QGZTOBrSPWohPBDSGKPoH+6LGuTG0BIaPll6N
X-Gm-Gg: AYBFou0h1yQYe+wWQQ94F4lrKLPUX3C54JN20Ylq0hKcrWX3S9N569Lf9ogLPWEdUx9
	nHbPt3sL8dsQtapu2+0OZXHWWY0/8CnIESgYRcZz0B5hBWWzjYwqVYdWTkhHIYtRbzWdXw6NI8C
	x7+6yp5or++LbL9W128RU+yCGCSYwN5XY3Y+Iao1O15XgRFapqMyfLgMDe+AUB5hxy4+cpHGD6v
	1TdCu5jO+KgxSz/N9o2MX+NNqeUXPYGyBsLa4pu3j2UOorRG3vZye2eHpewBeP4snbbCqHFdfTS
	wttiHiltCkPr7wl+zZ0sRb5Ynqz7Pxhs/mSoWbCOMJemkMGOCaQX3uHYB6YKXrYv1nJIOynMYQw
	dGZF+d9CPrZwxk3l46hpLm0NcPXSVvf1rZH9qTCs4KUBSI8FgJI9ecjA2KqrX1bw0iFAfE8CJye
	+ZXje5oiiTvXAoX8mymJ35I0WCpJ2ljPNdz4BQdxu8mPVYmJK8ul7fzbJF1ky/kKkHe8Zh9kGq/
	mTT8c6LqDus
X-Received: by 2002:a17:90b:5847:b0:39d:ec1b:9651 with SMTP id 98e67ed59e1d1-39e1e484b90mr10720814a91.13.1789605101674;
        Wed, 16 Sep 2026 17:31:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89e92ebdsm17931615ad.13.2026.09.16.17.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:31:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:31:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: msc313e: Fix premature reset during timeout
 update
Message-ID: <8c1b8c05-fb43-407d-bbd2-1d152ba63e94@roeck-us.net>
References: <20260913065126.8350-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913065126.8350-1-tzungbi@kernel.org>

On Sun, Sep 13, 2026 at 02:51:26PM +0800, Tzung-Bi Shih wrote:
> Updating the 32-bit hardware timeout requires writing to two 16-bit
> registers sequentially.  If the watchdog is actively running, this
> non-atomic update might trigger a premature system reset.
> 
> Clear the watchdog counter before updating the registers to prevent the
> timer from timing out prematurely against an intermediate threshold.
> 
> Fixes: e9800b799464 ("watchdog: Add Mstar MSC313e WDT driver")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,
Guenter
