Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE572F8E91
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607430; cv=none; b=f2eXhKbmoUHmFsTCws8pEEMuzDmHn5Ef26hv7CIlYaUsuRyb3cGaPgwsAmEnRjEifQYRYiId0WIofklpg8saI9MPvJEvUBt6lwue6vvBAkdR9GeNe+oUIhmVbECBtvqzE4MT/PnWEE2tPG5TQ6uo1ApXQq6yTNE51fwb7nc6eJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607430; c=relaxed/simple;
	bh=d89DZbU6qSxHVFReirp4z+F8nAR1vhudlk9+d6a3WxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUNqM9cM2IMvQQachPiY7u8mKGe5QcZll/vwNXNHZfaUjZntLOaLXcwl0S6lbFV+Hxz0PlwUHyrTHvxvzycOMi2tQI6qDB6kaaRQSRb2xmbDi/u1IEbpfFGpTHMT8iwYhzsADPVFEW7TLfs58YTZ1vZ1ZpcwyOM/ARa0B3lJvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYwxpOdN; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYwxpOdN"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398c066106cso209257a91.1
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789607428; x=1790212228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dq2fKZpF2ZHXoWdO/QCS/aYMwaYmBqIaG3WsHfdgCQk=;
        b=dYwxpOdNsllifx6zKm9MJTKYrX8DCV3QiSvcQp2dm9zavIWqYWfkAJtITq5Cd6BW1R
         yqVXjWWgZi4mOdnBnF38XhgY2Awia7PhuLfR/a7C1FYSDOKAoErp1sh7k+HWJ8hgPq+H
         PuPETgVS/4HiBtoWZBtzCKeCya8UuKRXDqFKIiZEBgBJPF6GfjzFzMTLcMLD7MY3wBUO
         jmB2WdezzRTrs8JEdbx80VAw39Sn/8REm18oGZqsVhai12QgMjfxX0LnrhdfERqeqHR3
         HYfmU3VIUqR/2KxaJfLv2fz74BXmcugYto4SQgwVpN62IMdgMdLzNgKN1zKCRJwOBlmC
         0GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789607428; x=1790212228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dq2fKZpF2ZHXoWdO/QCS/aYMwaYmBqIaG3WsHfdgCQk=;
        b=ab73QJZyfHDEnJCJGIxczWgpbeH9WXU4oMw1HY05Vb3yzkp7mzm1gccgT0kLgyuJeX
         qd/PVKx30S/xnWRBC6vJYmuqKmJl7eX8lxP+5AIIjZhYxp29dmvEMgSMelIPYuh5ErBo
         VjmeomcWq1LIPnRr0kf8pHcmPyw4PIlHaysA/Ftf3yREktcPHFI0XOsn4t+ha0HUPVVb
         62TE9H0gZv6o03xMR6LDpQGFtPFnE2h7zk9JF7gXAHvG1JcO00RJhJe2OxBd8RePOHcR
         QVequ6KcboojbDd+Z1LiNjnCeszk1PZbca6gn+NEjWZdQXgLn6KkTWPPhIbVmnSPWaiV
         f3LA==
X-Forwarded-Encrypted: i=1; AKwUvBw16UOZ7kQv5V4740l4dOa7yEYuhPJoWZ/Z74p14mFDcvd1JfngVxmcIL6ver42UE/Ol62djCqh8HOEDcAnpA==@vger.kernel.org
X-Gm-Message-State: AFuF++kMu56VaYkDwvJrsilZtHpvnlIq5Yh57MRjzNFzaYpLFXKNuehq
	gPFVHg3jRc7POEBVTMyNbJYTtDB0rdlCyP42e0Gs0kO2YUfdPpul0OCd
X-Gm-Gg: AYBFou2EhE9Lsk5LBlqj0j7KSPqkA2D/yzV6FcS800jTiR/ZVwcFXTWKWh2Bn/Lmh3P
	a4Xf/gxN3M3MFXOy3J4I0tRd2dUYSepljpGfUHzES4JTuiqi7UH+jnJtX6JgNXDy+EfxyFY9dQR
	yxv3ivEH7rto7Pwa3UUnwMVFD88k2e4JZOFleUHdFmFJy7w2pbsRj5ykF32PNZHVxX3Cb3uG1Mv
	IB3nCCLl3QemGI7r1THL5gC9AEHOo2eVg/x/cJiB1uBSrM5jLZaEOb7stdDLVZkgCRfRYvAIQDS
	t4pvxdbOC3o6yiipLf2beQ/b5ws55ShvAUapeTNGFyV3yukoN9sv8QB7YWSNkNA+sIYBR/4HRz5
	db+gTNHayoNzmJOxJFFcseYV8IgyJtzPuNVWNHkWpyPRqALXnUNA8Fs5v/pHPfGMZcsWjQSELON
	tegtUbH93TBuQhriu5dMcCupP5Gx0rKSavNdM/ZNAmlV8cGax2lI9eLnvJMG4pfKXzkToDZt6vn
	KrtVC/9lUbu
X-Received: by 2002:a17:90b:5785:b0:39d:6f12:fd47 with SMTP id 98e67ed59e1d1-39e1e50f73cmr14917254a91.20.1789607428438;
        Wed, 16 Sep 2026 18:10:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3909d02asm353486a91.0.2026.09.16.18.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 18:10:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 18:10:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/8] watchdog: mediatek: Add support for mt8167
 toprgu/watchdog
Message-ID: <befea2ce-e4a5-4bc0-ba01-d18c4a236667@roeck-us.net>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
 <20260908174259.9009-5-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908174259.9009-5-l.scorcia@gmail.com>

On Tue, Sep 08, 2026 at 07:38:31PM +0200, Luca Leonardo Scorcia wrote:
> Add support for the Top Reset Generation Unit/Watchdog Timer found on
> mt8167.
> 
> Since according to its data sheet mt8167 toprgu reset bits are not
> contiguous, add support for a reset table to the driver. This lets us
> define reset identifiers as contiguous indexes in the binding headers.
> 
> Also address a preexisting Sashiko finding that noticed that the
> has_swsysrst_en configuration was set after the reset controller
> registration.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Applied.

Thanks,
Guenter
