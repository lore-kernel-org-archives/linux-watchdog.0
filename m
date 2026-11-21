Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257018;
	b=MwSVX7Xw/GKaP0TfyBOr8MtkVz6AV17urdpeY3qCtXu9DlZbxFBhLAVQDpmkDb+MTMKx
	 uY4keqf+F8kqV8z1VGIMMccAHceW3dIiCf8sB5Ri/11KpuoRoZyUHK1mbHkFozjgZvOD3
	 DSrvC5TnPg/3Evewy2TCI27XvBUj3H70IAIx8snaJRN4TGVnObHdEeFVft0Aergvzyv5V
	 mNAw0no5mRCKUEWzq8sKO/KqPy9EfdP2k3ItflvBTODWDP7WbDoE7zuPJz5FaJCAABQSZ
	 WT6R2OoToD+JFcISJKX3MI4p+4gzKC7YcECmxonKrRNNhOuBNP/vQDqNqlBCO6dGWVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Transfer-Encoding:MIME-Version:Content-Type;
	bh=kVw6GMeWVHtwp4C/YrzbIL6SlnpGcWp+X6aGpcy0sFQ=;
	b=TSjn+J4CG6yGFFrdhBdcYxo0KgzoRGmFLGwnJEXhOUcUR+tAF6RvnIOzZsXhipbGH/Cn
	 vJ4w/ktPpnPPNrlLdMvg0Vl67qQ/XzVL4yN3NigF5Z0hllyb/W9bzlcXyUXjTiUHKGeS7
	 9Hrz1z6mw1Wve4rzyCncFDtZ0DwLuTYJ9PrB7Ojzc8tqdaTV+XTzl+BzSYFnjG+2lD6Iw
	 S4dYaV9u14BEEO/zsrbn0B3S/4XMn886ZNsxGoxStkZ+4jDlnCuDkA6olhd6g3CF/78ch
	 pnIDgKXnX/99Vx3J6ucJGW9TCeFbZHZiuA6yWzevwUowwJPW/KuGd7M4sOsACe8IBuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gZ3YnkHi;
	arc=none smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA898606A325
	for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 10:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA898606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gZ3YnkHi
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ae1fd4252fso16680841fa.0
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 02:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795257016; x=1795861816; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVw6GMeWVHtwp4C/YrzbIL6SlnpGcWp+X6aGpcy0sFQ=;
        b=gZ3YnkHiT9lxYM+2ddCCC0t6F4DWz/Nk5WhlpF8hVe1VWHKVz0cgGp/+qgjQt41LMA
         3N0cREWCdp4bZSWnnbVihOw2PpGFBVAUrSg4IaaGiiqO74Q1J0wfUDEdYUeL1M+gNBU7
         LvnmmKZYs53lGmT5U3N9MuMEqkMKUze4viuIqFQ8bAUZ9lsiuDffu4f9LI+MOJ5BxkKB
         pfZ3jqcdVDTk6QmW4xJ3V52i3YSJ7bN4xRhTxrvw/wp8Cgrp27FtudSk6Fxt/XrRWcCA
         oE5nlhG/uB3GedMgZyoE8NfSZzZtmPEQ3qU6rh7DJt8Rar2ozmo74WjiE1v4PfQ1PYSj
         2s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795257016; x=1795861816;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVw6GMeWVHtwp4C/YrzbIL6SlnpGcWp+X6aGpcy0sFQ=;
        b=ZQ3N3iCQ+xYiF8/9zZ2FBMWOsD46rcqlWNo+xQICMcwpRyPnibRf4Nt/Xu0eyhyHR4
         51ztUpU/VFWaj24fLEIwMx/qJ1vBGPVLhHa+0Y3dEm83PeoA4NmvuxvoPy/n+x9Rk3n0
         9sURT/zrLU0RCo8UPAzg4TxHq6pk5/IjAr/x/bYUpliOgHex1SescvfDo36suwSs9PWL
         1e7zSeEdyokxDkNdCR6C+2BZ+FejKgtNYdXZjyzYGcgfER7DFhkwfHC/cqGsIWgpwqmY
         Fwv8PgPDQR9sLsvSxxhNL7bXzLXokjJcvrOCAeojapKCA8eF9FAL8G2x39bIW2c/wSkc
         OYdA==
X-Forwarded-Encrypted: i=1; AL+hErHmcH1ejRkyfTy9MvpYbRP3Y2bZp/+2Et9b+NdQQz62h0HSnbpZowgGsAdd7qD2ro1ZdAMvwQXq30SkdMMN9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HLXDKTVmeV73QHjSybZzF5X5t4kLy2lgPOvaRIk3V8Z5jofmM
	j1cioFEfn794PPjW/5IjhROWYvBG+HRdMRmMTx6pELO1eTcWZcb2f6uv
X-Gm-Gg: AZFdTZeT3K9HmAKx9I2dGwG0BbxDEYnG9HXVyT7IW5K7xbtYNWXFCRUSlh/g6qdnoPR
	B0aH0VQc08NjtrWzcia1YTW2h2IgmNVg5Ls/k4VnU7jj9WyCqAKo++8gftnKfo0+sM+h8IsAjq6
	ItdR+dwIBUIm4OAy1mPVb8YrmqkRPyumqlvzhwbjqLp+hljPCgPzhJOvYBfvgN5yyZTekEBor3m
	i3Bx1557L7rxbkrLKxntdsaVLkY1NGsxwG+yajKWmOabMkjwIFCzrNVpNpLoyQUyo6n4UVcD885
	COz2txmbGkC7tgk9wTEefciyFVkjemVWevcMee0mOxtJhiHuc3uxL5vdkARt5gO1t1KuoAIyojv
	+CiiFK7KfrRMqPkR8e/Ud3tR5cro80ff1DnEBwrfJEWWL27+ntvFb6UG9cJxI1r0SGeksu62eP0
	HSi9tePc/aF7vb3Ow3KOURvdoo0P/q/FybnFbLzMPM/odnDiwl4/Io41Km31B6LPmU6cxObGTBk
	Rex95CHziskaR3y4Cew6ioEwVB5NvJagnJiZQ7puBqk/9CHV/zkV2S52512voqQBrXrHrFfQW7s
	pxh6bkUvlazIMRccg4b1huvw2RP856ym/0YF5N63vzxEFOlqYhYnsXo=
X-Received: by 2002:ac2:4f08:0:b0:5bf:db9e:426d with SMTP id 2adb3069b0e04-5c1bc8217ddmr1883998e87.34.1795257015698;
        Sat, 21 Nov 2026 02:30:15 -0800 (PST)
Received: from [127.0.1.1] (ip-024-180.users.dtel.ru. [91.210.24.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0171d7sm1257891e87.30.2026.11.21.02.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:30:15 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6] watchdog: Add ARM TWD (MPCore private) watchdog driver
In-Reply-To: <377b89b7-90a3-41c9-88c4-fd3393055f91@roeck-us.net>
References: <20261118-arm-twd-wdt-v6-1-ce5c85b45c63@gmail.com>
 <377b89b7-90a3-41c9-88c4-fd3393055f91@roeck-us.net>
Date: Sat, 21 Nov 2026 13:29:42 +0300
Message-ID: <179525698278.4.12784611811620173233@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Fri, Nov 20, 2026 at 08:35:52PM -0800, Guenter Roeck wrote:
> One possibility might be to try cpufreq
> functions (cpufreq_get / cpufreq_register_notifier) as fallback.

Thanks, I implemented this for v7. Since the CPU and PERIPHCLK rates
need not be equal, the fallback first measures the watchdog counter
against monotonic time on CPU0, then uses cpufreq transition notifications
to scale that fixed calibration reference. Calibration only reads an
already enabled counter; an inactive counter is temporarily used in timer
mode, with its original registers restored afterwards.

The fallback assumes the PERIPHCLK/CPU ratio stays constant. Platforms
with an independently changing divider still need a clock provider.
Actual clock provider errors, including deferred probe, are preserved;
the fallback is used only when no clock is supplied. It requires CPU_FREQ
and an available CPU0 policy, deferring probe while the policy is absent.

Frequency changes reload the counter against the existing deadline, and
the maximum timeout is bounded at the maximum hardware CPU frequency.

> A MAINTAINERS entry would be preferred, but is not mandatory.

Kept the separate entry.

> I think we can call that on purpose. Maybe add a comment along that line
> into the code to clarify that.

Added the comment and corrected the commit/cover description: the device
PM callbacks retain the deadline, while the watchdog core's explicit
keepalives before suspend and after resume refresh it normally.

Full ARM GCC and Clang builds, module/modpost checks, and a GCC built-in
build with CPU_FREQ=n pass, along with the host regressions. I also
retested the exact v7 driver on Almond+ with PROVE_LOCKING: takeover,
CPU1 ioctls, timeout reduction, keepalives followed by expiration/reset,
and restart from CPU1 all passed. Those hardware runs use the DT-supplied
clock; the clock-less fallback and DVFS are covered by model tests only.

Sending v7 separately.

Thanks,
Fil

