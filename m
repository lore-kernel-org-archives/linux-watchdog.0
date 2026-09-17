Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79A286D60
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604846; cv=none; b=nMuKlgi8/aKcm8a5c+6pdJRILP6mVL0U8W2lSywrJ5PErCRCDQ9QA2v5nx1ce7tXFpziOkcGPP7eEQtbJizFwNIO3lhOG+8EXAfWiDZSkwfbUeOcjqwv6/bCr47eJzNeRoVplBcRDiVChtj/fZUFhywGoMCr/ek58ffaR+UI0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604846; c=relaxed/simple;
	bh=urNLt+MFcXo1zGxLLMXC6gh7qBMMOtWww0XawOrSdn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4/3+j4MW61n/2si1mouPOSsiY/dcEaLrwa6i1njYYWXYtHwah3JRLOPB6578NhvK6oRzzRiHUdGB1+Wfh4IIdi35r3bt8x5RjroDGQNrkqmhYZNCh9f6P+wIV90bjr4HPGAFaU3zC+fnAAtJuDVT75i2EcfctjqLABpmCu99F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI1T46P9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI1T46P9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2db710396ffso1660005ad.1
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789604844; x=1790209644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JUtBGOjWkr3LDSuw8nQ/LMjNHkzqLk7G9FmrmWa6kSg=;
        b=aI1T46P9ittCMDXf3Gz4wsUiD+zgPE/Ey19CQpVwmBvXeTkCYgkAhKoR/UM7lbyRlo
         mpcQTN/TF7S/iHWGZm4RrLQzB/FbSzQ0yrmw7xGNMODN863QJmw5uvvmjWEaQGD4f5OU
         EWIGYGX7aSs6wpOFquXvFx3L29Ze9/SIRpX6S97oiTJhMbAYCjmXgyw4ZtQtc6Ss1aWj
         YwuI45FahE2G97c0oaSPNMwaTiympNaL6LvmpKSB91xzBHNN6cGcHismMxPCRLn0ejYu
         p7odNL/e1tdegraNWWy5LVV12t9Fko78PepK/tSdaos38FsEkTR002zpQsWCe1hANmcm
         fKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789604844; x=1790209644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUtBGOjWkr3LDSuw8nQ/LMjNHkzqLk7G9FmrmWa6kSg=;
        b=edRqV6sJrGl3wnYJrUkGRXekZDonh/ZRV/c81kgKdN/Yvqxshh2mPFR1bRzNed5Fl3
         TIy1s8JnuC3DJ9LtRcATzEigphVZWp3+6vmxr06vkV2qbT/ZQhbT64cYcF8DeAxrMFx9
         5VJRXLikgJhuwslYCu3kt+ixEvrCSpybrXtLxBGtEkTyUplobglyQcJRV/OX0ioSswHm
         pjP7f9XnvmheIWHsktyCMo/ZHR8xxOUFg6hGDkrT5qBixSWTaiVn50DdBz9r45PlE185
         k9PaPURielL+ZaE2GEoayaYfDKpHOnf4Sz0VBaQ7wv4ONq+IoZLvm45GzFMx5eTBDKDV
         N+Iw==
X-Forwarded-Encrypted: i=1; AKwUvBz9FRNOZxO2EQDBMLnU/5r2wIWe9HYzQfndRkVvc9+JITCYU7b5q8LWfdtsBmz+UOX4d+hS+fIGjK/q+1iOYA==@vger.kernel.org
X-Gm-Message-State: AFuF++mKuZMMhRfjlgqXDGd5LsjWuntH0y9GhZqSdrT07HeylB21751v
	XeCqguwVEHdvgFtsSQL/tod6WmcwtBoh0cmmhEcj/IpWhSa3nBg8Hyn3
X-Gm-Gg: AYBFou0TuR+WpP7AC/uIhNOzfr1TrTNanGpyxtGt0F0g8KLLENDVML88R0q20g6wf0o
	QL2fvwh6k7WuYn4em5cwZzHzNeM7APp2i+W0VX9o0LbkYpfwSza3QXDq9Xvy/ivlGAIqwk7zih1
	GlaNJTGR80Fjvl04foQvh5NRx1gmeVjZQlTw/6mAYlrhUtZaJsD2vyLFnCju5UwgV1qUNeGedYR
	rXRQb2cCnGYU3EKL7rE/a1/ewd5HCv9DBOhq1DWlcJ+Pd1k5MUsdud3g6rDpgZ5vwyxk8HmpfuZ
	im9Ihkb/GfaCL5uuOCdFWpfXGt37x1OCXmc9eun/lEx+PH31IAORygeowEXEQyEcGBE4+uPkPEC
	CrfR2ahBBJEP/wZv96hvmMaoapEL54XVGMdNei15a8+eGD/JmYZO+P7QRW9OrUhdS22UAR47vYb
	GrnH3825Aw0NzBt1auIMuutjvodLDZXfUm4NgH6crxTAdasMtOkfpXZHIA/44JxgSUA0WFhz5Yk
	95hQOAFDG32
X-Received: by 2002:a17:903:2344:b0:2dd:6a63:4476 with SMTP id d9443c01a7336-2dd9c8c778cmr20583725ad.10.1789604844108;
        Wed, 16 Sep 2026 17:27:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f338a9sm18257635ad.83.2026.09.16.17.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:27:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:27:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Baruch Siach <baruch@tkos.co.il>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: digicolor: Avoid division by zero
Message-ID: <cbb9a732-dcda-4665-b714-13a3d36752c8@roeck-us.net>
References: <20260913064851.8239-1-tzungbi@kernel.org>
 <20260913064851.8239-2-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913064851.8239-2-tzungbi@kernel.org>

On Sun, Sep 13, 2026 at 02:48:49PM +0800, Tzung-Bi Shih wrote:
> clk_get_rate() could return 0.  Avoid a division by zero panic.
> 
> Since get_timeleft() cannot propagate errors, check the clock rate early
> in probe() and cache the rate in the driver data as it is unlikely to
> change at runtime.
> 
> Fixes: 336694a01dae ("watchdog: digicolor: driver for Conexant Digicolor CX92755 SoC")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Acked-by: Baruch Siach <baruch@tkos.co.il>

Applied.

Thanks,
Guenter
