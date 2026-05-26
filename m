Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20713D503
	for <linux-watchdog@vger.kernel.org>; Tue, 26 May 2026 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755066; cv=pass; b=AxYuLq1KaOhudmWiQ+veVD8Ht8vd++m9cdV1wfTYjcgVBBTs6niihS7aqcw92M25tZschSqLipRkyjuKcg11UUajkbhOPhqZNXJZg/b1DPldcbbQSrjUKjYK1F7tOWA2I1KziJZED9ZNUl/BypEFXhECcdl6grozs2gowKpZfTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755066; c=relaxed/simple;
	bh=NQSMw3Vvv8eJ1+UHIh3MK/+HpaNM97XO5hlqHFibpi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/vtquyrHMmQHagH12EW/1JqBJfGr2CSY+paolp97kRnInZ1GadKPc7sgephcNMSUwUtrshC0BIiKyYZv0kea3BoKGt7ZSS9amXBJ1n1rfqsTOjI148Pggo8IaOG0DyjrZQkor72PfjNUvshePCUPa0zOOgwRCTxFFsLktvtP1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzvmnzjD; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzvmnzjD"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa0da74eaaso9908039e87.1
        for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2026 17:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779755063; cv=none;
        d=google.com; s=arc-20240605;
        b=lIqjlc3Z5FrypiE5KpDMRgh7Qxikb0QkZsAZgDYjbDDzDvvQ2nZB26omoNjKCTpJOm
         douMDEygFpiuALYW5TlUNSHDTe7I8GCVpcdbQTwkjJUiErOIzi2U5LmagPiyctFbRFXV
         4VB4CsAG2j4NJdK6lq2KuOvuh4P/S7/He7qM6jip8JRiR2URncLp9VdTRvRSuqa6s2yU
         mR2ujL2wv7sB/5SvcQ91ADb3V4Vp2R4Q2TAyYe5bPSVXCPlmh5+xyTE+Rwb7Xls9Uxtr
         UjsTthJDc4hviDJdBqmLlgeIMprn7bPJIDkOvD/LNiQookFvs2ETDnIVYIniAstvutUy
         dnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NQSMw3Vvv8eJ1+UHIh3MK/+HpaNM97XO5hlqHFibpi8=;
        fh=qZArU3K2pxfsJs+jemeslMsWJwzDZsaFfHq0u0+LNR0=;
        b=aBiqGHcNCU9m6TNY4PN17hTgS5Ljni7TKHMooToFyv8TjEysHwdEhM+a76SNol5Gy4
         6PwyXvkk1pXcIojoVHwhW2zliJlGqQH31zAEyIJutPBf5+RAQl+MOemhXlZE0iM818zc
         fbjd7T9hx4UyD/ciGGyWC/jvpckBOUWOt3y9u0Dr4YX9ZGjREJ5dnddkQ1zyd+NIdRWB
         As9AC7eWSm7w8ceaNcRgimI5mroIEZ/hM9HJX+sn/zi3/33n7jnteovGhD1+++SoCVu3
         LpBSHeNcB4Eeuo9ddi3Ds4hcfNvClRFXVP0mRvXxrRlExpGNRspSPJzg5miVybFdjFfn
         xiJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779755063; x=1780359863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQSMw3Vvv8eJ1+UHIh3MK/+HpaNM97XO5hlqHFibpi8=;
        b=GzvmnzjDN0gbqAG6iNGg0kVo3utziPgjF9MITIAS8+/eJOS4EqSWJOF/3o8Hap2p3Y
         Asx3fGENU/xqs5Qc1nGDliYNjC4xxQVLFuLrUy+6N96pkHX/8kJJ8ilm9RLbrMNx4A6S
         smtqvA6jey/g3uUU1ylMj5KWZw0HhY4kKS0BoWL0DMHhu7TYHa+ssOgA46anQoAw5sVb
         JOIguAtGFwqApfzUCi+qKS6vGhBvxGcSNbC8NPAdnuunWiIO/CkCO4UuTHH5tMcTk7m9
         Y39ob0grSnBBMF2JZaJgICUzAcqIcrbWaIcsR+dc9qU6uylU77k6Tz2CLTVK6BoC5Rfd
         Oyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779755063; x=1780359863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQSMw3Vvv8eJ1+UHIh3MK/+HpaNM97XO5hlqHFibpi8=;
        b=UOxDkAUbK/uddGNPFGSfdt/7KXaLkPB/s5J6/SbQp2zmpFyuHXG/3rm4nQqFUT9Cvl
         +bMKBXt+Mqxo8ycLZAIkJxTqPSsDuEMjA+pBDXBBiN0F32OmzAh70iomTZQ/Q4dXM3zI
         9Z93rSO5XXjL0UdBSvfL0cSfM9AewXbgOyGdfS4+yDVT92blAKKCNtaNGYxXolFwP8Ie
         dJUjLvbKzIqTcc+izyUqlGPOV0slZJ8UgpSOFEB01NOyvl80ElQkqcCR/quE/73hAbQM
         VkwZ/Zub0SMuYTf7wqPvBFrt9jAaHzfhX76tSfBdSQU2kmpcTQfDPenfIeVWM7v+AhaP
         TKRQ==
X-Forwarded-Encrypted: i=1; AFNElJ91aaz3T1u2EB7c3X13SEKQPFwNzTuaAuxVPAqtK3lR0xpo0CzswH9ObXuiM/RN4xULgLAPjwX4d3r1+yNzQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3pIdyecsigcIExAyoRdvucfy4x6gHSZZs/v3Mj7yX5Ytgesn
	HtDZ4L8tEpRFCxi730kCHbs/bFsQs13yUPAoiOeibcXY8XUw5s1mJhUmG9KRkc/0UN25jrfz3G1
	jKC6AjnQnbzQspPHQeEIKDDtoTkNd6Ho=
X-Gm-Gg: Acq92OH7Kj2eEdNMPFmQzhw+rThHm0AdraBKfxi5eTdjxa/fDhpD+A93LejEGSr7NOL
	/x0BDMaCzKNYeShUrdlVSBQc5q52zM2vK0hcDeBKAQwMBBPKge9lcOfBDdZT6Fcmy9kiel7AwH0
	WGztcJu45WNQofu+V/MSdTKbXvD413T0fYflEVmdeyGwREjBIoZkk4JQQ90tTcaXeC9LLx9bM37
	yKMlHUooluROcJpFwQOJiFzti54tdToN2RLzLa/Y9ojPRYf7R/IcWCRFhXMOh04YDpUO2eO9WRJ
	HIj/2wa2xiP6USvVL8Mv4IfVm6afBnX3zRvKzIBYOHqVSpS+WrkaSGy3xygD62a/wsp6UhN3
X-Received: by 2002:a05:6512:1599:b0:5a7:4699:9fd8 with SMTP id
 2adb3069b0e04-5aa2ba85b09mr7355408e87.16.1779755062403; Mon, 25 May 2026
 17:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AHK2FF1_wws3wQsJs5ofvjn2JpQmk3of+p1+ExL8h+ew@mail.gmail.com>
In-Reply-To: <CAOMZO5AHK2FF1_wws3wQsJs5ofvjn2JpQmk3of+p1+ExL8h+ew@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 25 May 2026 21:24:10 -0300
X-Gm-Features: AVHnY4JS4uosGBNNT0O2e2-uAlaBFEkB6tUSmGGzp3aw6DXRUG7IRPZ2XdoJxuA
Message-ID: <CAOMZO5AX8z-S6x7agjAs9qvyVL=Je9GBwtLc8Jhg=s=baerfgA@mail.gmail.com>
Subject: Re: sunxi: Watchdog reboot fails on Allwinner R40 after Linux boot
To: Guenter Roeck <linux@roeck-us.net>, wens@kernel.org, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Andre Przywara <andre.przywara@arm.com>
Cc: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-sunxi@lists.linux.dev, 
	linux-watchdog@vger.kernel.org, Otavio Salvador <otavio@ossystems.com.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 9:41=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi,
>
> I am seeing a reboot failure on an Allwinner R40-based board
> (Boardcon EMA40i) running mainline Linux v6.18 or also 7.1.0-rc4-next-202=
60522.
> This board hasn't been upstreamed yet, but I plan to do so soon.
>
> The board reboots correctly from U-Boot 2026.04 using the sunxi watchdog,
> but Linux fails to reboot even when programming the watchdog
> registers with the exact same values used by U-Boot.

This is solved now. The problem was that the X32KIN R40 pin was not
getting a 32kHz
from the external PCF8563 CLKOUT pin.
