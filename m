Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA99282F0C
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785462870; cv=none; b=YarouGrSrS21SDYa+2XHa5BTUsIrKeP6pbNg4pYs4FfrRVL5OawzU4vOXaZZfNDPO8rny0HMi/TD11JLnYcEzhQT7Xkq2z1mUDfebvGo2H6y0E1ABzGJ5SokuRYnDGMcmKCej/uMaXD18KknECDXwU1CsJZvgDO0Kn+mklYbK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785462870; c=relaxed/simple;
	bh=+HFK9tmZGfy1/s/lmeYCkqJNwSlvShZR9bbeiEBftEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hS2s1w4Dsb8j2C2Lx1V21YvfJJUWP2da5SWthwgdWreOVRjCOeDcXPnC//B7TY3ayNw2yi1tASRSGiB2yZ5q8q7SEefpTdlt61KKTQsPyjrTn8iFmVKMANxxGooQVVtIUkAzTJk6mpG3QnM5M2xgiDO79yxcKXq6tIcvk8a7iJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lVHbAt6C; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lVHbAt6C"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bfb5e20a90so391285e0c.2
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785462868; x=1786067668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Z8FGKUlDFzcasJZ046FBGl/M48AdMIQ6YWPUk4pFK0=;
        b=lVHbAt6CenOZoOCpQERveL5QzrM2U0UU/FugsqEFpB3AWmaAswx4EBkiz14wUNVlwi
         wou93kkwFv+Mg0xRuuLkBqBcwx0Usb3ctH8doQ84/5XMPHDpeqIvxexjHIw5MYzJVlNk
         q1p72J4uQoQFCUEyH2zyCDPEtSxL8DduP1LVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785462868; x=1786067668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Z8FGKUlDFzcasJZ046FBGl/M48AdMIQ6YWPUk4pFK0=;
        b=Y9AQX2GmgFzMkivHFfuWui7bQi/EkSTU8NufzlxMqCyJzdfJOwBm38CkX9Cbbz9wZh
         C+X367OHeXWSASmIsbRmKs+2bLHM02RuhmD03N9FGUKn1erNW5s6mSE4izfhNcZapvC1
         xjxUVuPMvnEbViL6yzmt22W12ehr3b3CjQodFL5BbVczQLim173LhgMLd1XO79AXZkYt
         aHBeXGco3aIdvJSFtUguVCb8mjK/k1O4AbjKSqj3n2tkxueinxWluX1x1crqghxGKa6F
         bLO3FvJ+no4yP2cidLxMLx9zAsfMGw/2HY2jBtpDX7C5FuE+ZawCoW3sx5zLggLI+k4j
         N/+g==
X-Forwarded-Encrypted: i=1; AHgh+RqtF5bbPkTKd76C1UyfAyvVIyaqrx3oq8JBg432JFDMc38ri/drQ0Z/+0Qt3P8OVVf3bOxEW6X+l0HBRhbbng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmf5aH9FQsO4gZUpqcyYvxinaaD4JrTPBk0FJCIwBgblDCR5no
	D13hztE2qXJYeByK0eb0IICErq74hB1aQ8foV//Nc1CFgJOsHJde61F2k8TGSqh/dRre8DP4Xt3
	D9co=
X-Gm-Gg: AR+sD129bse5eqdvFu2iV05PUn5YX2d0mKvtllgmZebmWGRgm1Wgn9SxayurWmCPP1f
	QPJVqElEmoAkQyKV7epZByoUxK+iXlvaWKI0Pc/EK0Vk7EQJ/E9OIVC4NGoNwPgEi6FfghDxnGP
	H7AQsWA7aph7C8CvhDLgMa45VObqbg+hpBHCx0CvvGN0W4j4/HQVUuEStgAEu2fWlt367IX0c5U
	QzfncLwnRA27rCIc/gDDRrmST28oqkcnd3S2mdZKhhoW0g8rSt/xfV/ALNqfOwvgFuJ+CzHy74W
	FbU1wP+jUocYnBvRyhX7aQLIjZvB125pmQYylqX1nwHSydgF7pGFSCpyFdpn7LziQqmrUpwC1Ky
	i7MUyua0JhWTX48D35dh20Whbs+DD8pNHaSBLW6e07a0eM5Yn4mE9U4Y/imzZp0lPJR4iOz0gb/
	yUHTmoCdqW/g0FjGGymAenRz5v/hda/RH+QLzirNMMZ6n4eLRP0rmqzBxZEQkoBm8dFhbarbmXE
	9QIQ1wb9LImZV4q1W/u1M9R0YIYDJQ=
X-Received: by 2002:a05:6122:490a:b0:5bd:ecad:8f80 with SMTP id 71dfb90a1353d-5c37e3f4aecmr16573e0c.2.1785462867767;
        Thu, 30 Jul 2026 18:54:27 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c366568458sm2867666e0c.7.2026.07.30.18.54.25
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 18:54:26 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c11362f67eso382474e0c.1
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 18:54:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoCmCPdTFaJIexjF3eF0xH+bHUnTP3WZpjwNCJ5Jn0UxsqIj3eqIv1hjQNsjpH3B6igr9Qogvqm4baRfGR5dw==@vger.kernel.org
X-Received: by 2002:a05:6122:1c07:b0:5bd:ea6e:52f4 with SMTP id
 71dfb90a1353d-5c37e733753mr10810e0c.10.1785462864173; Thu, 30 Jul 2026
 18:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com> <20260730-export-cpu-backtrace-apis-v1-1-bace8e1cb817@google.com>
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-1-bace8e1cb817@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 18:54:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VXC7LQOERckkZJfcSDuDiGALaG8Z7RcfOZQOsGYFCaWQ@mail.gmail.com>
X-Gm-Features: AUfX_mzfhs0aSx_36NvYH7YfZbdE_m-MV-1yBw8lHTHE26Ac3OMOFvHoW9UOT_Q
Message-ID: <CAD=FV=VXC7LQOERckkZJfcSDuDiGALaG8Z7RcfOZQOsGYFCaWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] nmi: Export CPU backtrace APIs for loadable modules
To: mrungta@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2026 at 3:00=E2=80=AFPM Mayank Rungta via B4 Relay
<devnull+mrungta.google.com@kernel.org> wrote:
>
> From: Mayank Rungta <mrungta@google.com>
>
> Currently, CPU backtrace functions cannot be called from loadable
> modules because the underlying helper arch_trigger_cpumask_backtrace()
> is not exported.
>
> Instead of exporting arch_trigger_cpumask_backtrace() individually
> across every supported architecture, introduce and export a common
> helper, cpumask_backtrace(), in lib/nmi_backtrace.c. Update the four
> inline CPU backtrace macros in include/linux/nmi.h to route through this
> centralized helper.
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  include/linux/nmi.h | 10 ++++++----
>  lib/nmi_backtrace.c |  7 +++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
