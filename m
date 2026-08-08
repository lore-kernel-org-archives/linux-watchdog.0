Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244E3BF69A
	for <linux-watchdog@vger.kernel.org>; Sat,  8 Aug 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786180701; cv=pass; b=p2ML9MxtWtN4FX3QiU1BNmALTLjlQ2qBgfeRbFaC5CmxwKFSA2qKLKCRSJoZ591XrL2ETy8UB7KdMW4Y4WJ3mBkvY+sGrxYvv1Ib4o8XncuZ6ZNFi6Yymj8qwjM7CZ4Wte9KYZcB+o7cK1ZVY/fC7xSnQWCrNonXttHbb1fpKGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786180701; c=relaxed/simple;
	bh=v2Gm0lydBXMGnjaYHnDwmar3OPX3zd9bqOVMn0dSuwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jukR0lWhGm6aZkhJCWDqzYqvgm/SFhyaY0lBNO+InFldZvS6e72WuIGfrtbQst0K8EZAmKD+MGBmyi/SLH+i2Qyet8gxo0Q2grMFoSwpVokRHPTP7t3SRoZrNEkqnjPU+8O0T2oGWcT3yf6E4YcrtZMQ91OlkAkMK7PckzwQzyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMICmk/g; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMICmk/g"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3900e39d935so298693a91.0
        for <linux-watchdog@vger.kernel.org>; Sat, 08 Aug 2026 02:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786180699; cv=none;
        d=google.com; s=arc-20260327;
        b=Nd/s7XTK3tz8yFRPf2k2ZeGnZ6IJDtd33VuBA7LBd6zsh8akRj8ddq4+f70ToFsmzb
         AQcLp1WeZy1lRrP6fmBuHg7YTst+kTyYLAneUpuAD/XGFCFwpsgIaxoe4YdW3T2nbhvq
         8D4sy42zdSYytrDJCFRTOCY0MAOBBod79iWASlWtinTy4bdYdPj/Ut8CKNMvJEjF3L3D
         Uv9yTI48ctTJKgDZbUCsCOj3DoxpMuDEb2P5PnwJ2ROibxTVLrWMViLvWbzo7xSRQP9Y
         xLph+bHrdJYi8+jdsEuozBA0iWNmmDGJyLdds5a9Ml3865k0Yd6jmEZy7KOGxWEUPs8z
         NFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v2Gm0lydBXMGnjaYHnDwmar3OPX3zd9bqOVMn0dSuwQ=;
        fh=zt2hjtFWVrBSbexOnXx/digRN2O0tNSOK4/ceCsrIlE=;
        b=f44UmmmoGLl7zXSZcqM3N9L0FHmdhcpDBcc8lvZd9IA+sO2Fv2teoAijA1LCMt0tZ2
         Oj9QNYsdG2Zz2z2AY6bLN9HGPgMR9MpxH+GTf4nxZmm9Ksgp0J9XlWWUQ/BBvaviRuL5
         FphiVNlOhXtYcqyobXBwm1aErp6ir+hcArZezzpNCGi47nTfqgPtGLTsyiJOj2E/SUtx
         SZ87un6eA6r4jfkvTSRVptR/Sqe4CE8PKd/Es2mmudBYmsvp6AJGmFKoasM9Sl3HlWcn
         MHs5V4DySRGJwb2hrI9l46qvNWv6j/iqoUo30UJFqCcvfG9S8N0ysevbgHI8/QRxUYsb
         4++Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786180699; x=1786785499; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2Gm0lydBXMGnjaYHnDwmar3OPX3zd9bqOVMn0dSuwQ=;
        b=RMICmk/gRjsza1EbQNwUpKkH7I2UTLAZBqbxpeAV3T2nO9gIv5NN5+rZM3lS6W7DOh
         y1vioqRoLmuVn3e5ytrsIGuhC2f4Kxg8dGDauvzeK+Eswm8rqk80ly3J2eUDTJHfqt2W
         LBtCtS6Zlmv/F9ba1r5ECN5kY7ybnszLYG91g0mUrRiy4ldjcsFAxM0Fsf4RbpeFne7J
         KfALlNKO/SRK9Os7eFc7iAm5R0BEAxVQU+9j7ZrrmquuaQl26Kqo3V8yJ8KDuBwi/tHC
         NTB39GjIGwiK8FNhabB6qjXZTrxoz54XHyyjacQuIHDnV5PdpLcR7BbBsH3/WVlds9ZH
         5B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786180699; x=1786785499;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v2Gm0lydBXMGnjaYHnDwmar3OPX3zd9bqOVMn0dSuwQ=;
        b=TlSEqFOMdT9wM1Mc6rvf9QI5My89LRcYBmN2qpCLnFYKyeiKU0D815tg7E+RR14Nq6
         O4/hqKh7EOiD1hEoPfjK5KxnXJaduKy8lkoFTHYz5+3cSd1Kn0c8++I6/LfJK2QQCTmN
         h7ocOtYPbKaP+1R1829Ey+EQ7yNvEqo8kzGg59zxXGabI/gE1J1EsycWEAvfP4NEPCn/
         S6PUMuRqqS05v42rCPvRpogiW2GV/+r21nZYNYFHN4joYJsieEDOqItx4LbWV7PNpyGi
         Z1f0lSMMgtTihhs7CJk4iAI+/I3gtePW8heZJEIaGSEkwg4jk77xCxeYYzJ56B+YvjMt
         wSvA==
X-Gm-Message-State: AOJu0Yx8pgHkRZu5r9RlPCpbB0t/PPvSEbi/xXSwu3zS9LKtJOKZidAN
	i+dggs1paNqE9Jzgl9EstteXAej4fcbzX+VZ+nHpGhg/C3ZTrUV3qCH4eH3QK64zY3McPtHHDcR
	IvFDhFogD36w7k6LF7pX4hGGN3RQjacVmRx3W
X-Gm-Gg: AR+sD10N6J5V9QEfBPydFGBnIzvzxg05AY7l0Y9Luin3UM1fQaWY6UsWKV3OBwxXJnr
	eYhwhJuotdC4lnoWJo4AS0sSdfFWo4YMGExIQ1eXzZ5zFIIYJWHjUUq+YxaClrt0RwjLsqJLd1d
	k7bUpcp7m+O0k9buhUKlOqfb1Vsmfp0TCkWvIm3sNhkQksHUFSL+fKAFcaBdglscordXRnFZdi2
	5HBV+inJROaguJE4MW4DyEpzjzxkjOBC+Z7PjoGLXT5t2OpqeuW5Pl5dFqdQ16w3XMawvID2jmw
	fItCQSjcREYVTDAQv7ErPfYsSLg3vrenSpKK5RuuBaW2Xvdo+Dud38+tV947inbzCAX3MDMKXFP
	zgln3/ZblvzydFJJNPTjMZBLyTRkZY3HiOOmQUYcKGXBXQ2NdkKoZPT35OlhcWriDyYaDL+eaYu
	NhJghXgBW2G1xd/LI=
X-Received: by 2002:a17:90b:498b:b0:38e:7268:220d with SMTP id
 98e67ed59e1d1-3903c628176mr32041661a91.20.1786180699216; Sat, 08 Aug 2026
 02:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807080447.35479-1-phucduc.bui@gmail.com> <20260807081108.B61881F000E9@smtp.kernel.org>
In-Reply-To: <20260807081108.B61881F000E9@smtp.kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 8 Aug 2026 16:18:05 +0700
X-Gm-Features: AUfX_mxfRZ37adEsr__Kei-3RDXP-Ih44Ezf0uyFTi5c3Qi7vZxT0rKFB3jsFYA
Message-ID: <CAABR9nH9w=q4cqokrGOE53ZaZhx4=AFyXrup4CdgF9LZyV=QaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] watchdog: orion_wdt: Propagate errors from
 optional IRQ lookup
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> [Severity: High]
> Does this early return bypass the clock cleanup?
>
> Earlier in orion_wdt_probe(), the hardware clock is initialized and enabled by
> dev->data->clock_init(pdev, dev). The other error paths in this function jump
> to the disable_clk label to clean it up.
>
> If we return directly here when an error like -EPROBE_DEFER occurs, it appears
> we might leak the hardware clock reference and its enablement state because we
> bypass clk_disable_unprepare() and clk_put() in the disable_clk error path.
> This could lead to repeated resource leaks if probe deferral happens multiple
> times.
>
> Should this use goto disable_clk instead of returning directly?
>

I agree that this makes sense. I'll make the change and send v3.
