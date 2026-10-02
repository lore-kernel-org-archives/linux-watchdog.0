Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F8488DB6
	for <linux-watchdog@vger.kernel.org>; Fri,  2 Oct 2026 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940304; cv=pass; b=cELfc6AWDK5H4V/7RidFDVlLaXDbN0MpBYAUEN0xDijf0A5F0UJaLBJuXQZrTv3VXznM1lvBxctTQ/L/MSgH70zG5bVnTPpWvSq6Jf8FzFptlo/AUH8RI2wFPqfe7aFFfJuifgfBwPZrb6JnCo/H5EYqLUKSqJnnWFcRdjZqdZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940304; c=relaxed/simple;
	bh=keMbtcyNVQxdC0ctP+ZhAmBIOPGSUadXPIE/fKO00rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezvv0eKuLRtGfT8yho2ofdQF8fRxsMU0kFuU2nc9yolPT9kOFmXEh/Fw6YAVnm9RY9Vv+dfpQnftyCK8yZI1vGNxcyyGGvvvEduB5oQ+eYn4MYPIpiD8efN2hyxqurpg2mwuwUrjYvbVkyrRxAyGitts3HiPWDMrc8qHF/LGa7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=efqCTgDg; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efqCTgDg"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1d00daaaso13045355a12.1
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 04:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790940300; cv=none;
        d=google.com; s=arc-20260327;
        b=b3bmiv/pme3A7X4dBS9XoOOJ8s9LQZy3ShpZtZ9/VQLkFeIuarnQvyZ7MASzQZVdS+
         ji86tXNvUFzoxP/+3vP0ehNiILpsDrdGUFbiJ8TVntLPXEsmtX+qO20APm72CgPIaxUm
         DxDOTMdgPKLZbObGxEl082Fzj0tflCy8J60q+IhXMafxdzPbKCfUtdjOoBW6cKSxoFws
         EZYFMNqMPYkSQbNDDES6w5nZ+ckUYPrXgZeqyFHUfoYmr4AL0z/UEMwx3rVFpa1hkyVD
         4lkVVTDsSqXyWbjh+IDyxKgdL7hiPUx+lpMmq6tNi8fs8MkSTxqiZTO9UU3tNnpmbD/B
         QWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=keMbtcyNVQxdC0ctP+ZhAmBIOPGSUadXPIE/fKO00rU=;
        fh=xf8XozchR5aJwg7qxOatHrNxce3hOuCvyhHy6CDgpw0=;
        b=AqKCsZaUPTnnYK/VuDzGrw13N01GQvLlOdan70b5YryXc1mJffjr3u/q/N2/eUo7Vr
         O97mYxCJ8+Wlcapi307wSrOsvTuR86UyVmTOwpxQfXih3IZ65drzK7yRXYFcXYigL4PT
         A+XIDb7cwSEVa6IB3OtjqpZrhVHDidhvkRas4j1i/1eGpzaDIHdH7yF5f1DUGGVOsWpo
         GxZmjThNTlIKlTRFFKPYWH9QxDLUpScuUUHuH259N8vY/ziwKV3qEzv6Lm4WuiOnK3Sc
         7GLTcjYE2knhwiprPeMc3mRDr/rHpGWTTF8r9bPL4Ryt1onmu7fTYReQ93ARurV/uxRK
         Adqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790940300; x=1791545100; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=keMbtcyNVQxdC0ctP+ZhAmBIOPGSUadXPIE/fKO00rU=;
        b=efqCTgDg+rP7HorfXfAh2CddbMB3IpZ3nM2eASkyu88plQ/Icbem6nxQxZ8g8Nmis/
         O3bQuprgqMODpxzcmS+8Q06gJB5ALqDCKv/W8YlhhtPv1FimY7f/u1b4Lrj3401BQa9J
         y4uJB4tof9Axdt9wD6bD4ORqh6EsUjBvfU5Y1AenE60iB8ri7iibPNnrozPrTVEKQqdk
         4dPbKKBkT507HvuE7BeJDisxLIiIOxm71GCWLYFu141ESNal2XIbkd3U9p5tplw3VrEa
         Ni5lghwXSK7j0aOP4lbsgVBoOxDLiYb02QfpiK/K03IlSQUYsH6m4FKD3IWN/oSvXIaN
         keyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790940300; x=1791545100;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=keMbtcyNVQxdC0ctP+ZhAmBIOPGSUadXPIE/fKO00rU=;
        b=R63p9aR4n4eRJn+ASv3mrJe06x7swKgZY1eXFknO613E/ivYgWFf1wicbHFO+Nt1PN
         mPXEl+/blpNR7+OVMAzFxlUu6DyrUSJitqXXMvVQbL0UW4T1/rUX5hRKr2/QYYLeQK67
         f4+GlT2i6R4Sum2OU7OVi2rLmaapRO9ewo/2s4UhbDB8Yz9G2NMXT/CxCVmaOoisTsI6
         EHs+tDvBAbAqMq22BklALaLJciE1UMtHlbjOWNbH5Ve9n2i54//8IP4aRCfjdDVFCOuq
         X+Twy33122F0OBFbYoKPdRfu5EiNpjktQESwXtfi40/Oz0AWGxDHTDbxD2htF4zIYzlJ
         dphQ==
X-Forwarded-Encrypted: i=1; AKwUvByaVwFtNsnbgqr+IyCPkDuoBd/LW54fDWU3tyG0NS5nmT/hzpUR4Qk51zftxiyaMc5mxBpUDsLRf6sZBPImPg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIaRlZGJ6nY5wGThiTILXS24iFuzctXU39Cl6jB5VfQUlrJTANS
	kJl0gkJev8vRghKouLTCCPy6JRQ41JaDC2LDOQdBbEucRVTPzCnqUM8EFwGIGlL0c1TV0CP73+t
	4P0b+9NqTIz79esy+l2NQbqU6RmZjb8bluy3TIfUMLw==
X-Gm-Gg: AYBFou1yASqclgXurC9rL0ux0AUsKBV805bLdOooisSzW0fc3i0lV9AI1aPP/N+Dyvn
	S0PJGj1fXSd3BJZ1DJoK4YCILDmfaaLW1RaxbS6XdkRVpMxxwDRrjsGYMOfPgp4fBicNI+JddD8
	x+gF9Tj3F21wbJmYwJ5TdHovdpBwVB/1Q2zc8xghBHNICnZk6JRR6VO0rufyp9QB2nGn22GR1MY
	8B7nYvHAyQRP6mSgcLZFLEiHsXsrIqf83U2S5MG4Q0QohKTOeRxCSydjPfb0iBdv1cjxOI6J5Ek
	/9I8PGHVY0kN7G0OaGHfxl7A+YGqrJBEu9wcokweTvLKxy/XMx9ercU39d/S/OU6z6oDsuAMqC7
	ktuUqbKV97NoNtZiY5kLry6S2
X-Received: by 2002:a05:6402:13cd:b0:6ac:8dce:5a86 with SMTP id
 4fb4d7f45d1cf-6af9e322b6cmr1463693a12.23.1790940300400; Fri, 02 Oct 2026
 04:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260927150938epcas5p33b7d0495f8d9a8e84bf5f09c66e757fb@epcas5p3.samsung.com>
 <20260927152738.3673504-1-alim.akhtar@samsung.com>
In-Reply-To: <20260927152738.3673504-1-alim.akhtar@samsung.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 2 Oct 2026 12:24:46 +0100
X-Gm-Features: AclHuK9DpXDu6p9otQ-T72J8vLpAXoibGWPs5vMvpbKJgOwvaV2nsGKYn1-NIrU
Message-ID: <CADrjBPpG1nJ0Dg1jXhqLoR_dnRP+N+=QbYeyW8GJV4Xr=od1CQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add Exynos8855 watchdog
 compatible string
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: krzk@kernel.org, robh@kernel.org, conor+dt@kernel.org, linusw@kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux@roeck-us.net, hajun.sung@samsung.com, wim@linux-watchdog.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Sept 2026 at 16:09, Alim Akhtar <alim.akhtar@samsung.com> wrote:
>
> Add the 'samsung,exynos8855-wdt' compatible string to the Samsung
> watchdog device tree binding documentation. The Exynos8855 watchdog
> nodes use two clocks (bus clock and source clock), require
> samsung,cluster-index and samsung,syscon-phandle properties, similar
> to Exynos850 watchdog implementation.
>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---

With Krzysztof's feedback addressed

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
